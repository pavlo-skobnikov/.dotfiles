local java_cmds = vim.api.nvim_create_augroup('java_cmds', { clear = true })
local cache_vars = {}

local root_files = {
    '.git',
    'mvnw',
    'gradlew',
    'pom.xml',
    'build.gradle',
}

local features = {
    -- change this to `true` to enable codelens
    codelens = true,

    -- change this to `true` if you have `nvim-dap`,
    -- `java-test` and `java-debug-adapter` installed
    debugger = true,

    -- change this to `true` to enable decompiler capabilities
    decompiler = true,
}

local function get_jdtls_paths()
    if cache_vars.paths then
        return cache_vars.paths
    end

    local path = {}

    path.data_dir = vim.fn.stdpath 'cache' .. '/nvim-jdtls'

    local mason_registry = require 'mason-registry'

    local jdtls_install = mason_registry.get_package('jdtls'):get_install_path()

    path.java_agent = jdtls_install .. '/lombok.jar'
    path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

    if vim.fn.has 'mac' == 1 then
        path.platform_config = jdtls_install .. '/config_mac'
    elseif vim.fn.has 'unix' == 1 then
        path.platform_config = jdtls_install .. '/config_linux'
    elseif vim.fn.has 'win32' == 1 then
        path.platform_config = jdtls_install .. '/config_win'
    end

    path.bundles = {}

    ---
    -- Include java-test bundle if present
    ---
    if features.debugger then
        local java_test_path = mason_registry.get_package('java-test'):get_install_path()

        local java_test_bundle =
        vim.split(vim.fn.glob(java_test_path .. '/extension/server/*.jar'), '\n')

        if java_test_bundle[1] ~= '' then
            vim.list_extend(path.bundles, java_test_bundle)
        end
    end

    ---
    -- Include java-debug-adapter bundle if present
    ---
    local java_debug_path = mason_registry.get_package('java-debug-adapter'):get_install_path()

    local java_debug_bundle = vim.split(
    vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'),
    '\n'
    )

    if java_debug_bundle[1] ~= '' then
        vim.list_extend(path.bundles, java_debug_bundle)
    end

    ---
    -- Include java-decompiler bundle if present
    ---
    local java_decompiler_path =
    mason_registry.get_package('vscode-java-decompiler'):get_install_path()
    local java_decompiler_jars = vim.fn.glob(java_decompiler_path .. '/server/*.jar')

    local java_decompiler_bundle = vim.fn.split(java_decompiler_jars, '\n')

    if features.decompiler then
        vim.list_extend(path.bundles, java_decompiler_bundle)
    end

    ---
    -- Useful if you're starting jdtls with a Java version that's
    -- different from the one the project uses.
    ---
    path.runtimes = {
        -- Note: the field `name` must be a valid `ExecutionEnvironment`,
        -- you can find the list here:
        -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        --
        -- This example assume you are using sdkman: https://sdkman.io
        -- {
            --   name = 'JavaSE-17',
            --   path = vim.fn.expand('~/.sdkman/candidates/java/17.0.6-tem'),
            -- },
            -- {
                --   name = 'JavaSE-18',
                --   path = vim.fn.expand('~/.sdkman/candidates/java/18.0.2-amzn'),
                -- },
            }

            cache_vars.paths = path

            return path
end

local function enable_codelens(bufnr)
    pcall(vim.lsp.codelens.refresh)

    vim.api.nvim_create_autocmd('BufWritePost', {
        buffer = bufnr,
        group = java_cmds,
        desc = 'refresh codelens',
        callback = function()
            pcall(vim.lsp.codelens.refresh)
        end,
    })
end

local function attach_to_debug()
    local dap = require 'dap'

    dap.configurations.java = {
        {
            type = 'java',
            request = 'attach',
            name = 'Attach to the process',
            hostName = 'localhost',
            port = '5005',
        },
    }

    dap.continue()
end

local function enable_debugger(bufnr)
    local jdtls = require 'jdtls'

    jdtls.setup_dap { hotcodereplace = 'auto' }
    require('jdtls.dap').setup_dap_main_class_configs()

    vim.keymap.set('n', '<leader>dtc', jdtls.test_class, { buffer = bufnr, desc = '[c]lass' })
    vim.keymap.set(
        'n',
        '<leader>dtn',
        jdtls.test_nearest_method,
        { buffer = bufnr, desc = '[n]earest' }
    )
    vim.keymap.set('n', '<leader>da', attach_to_debug, { buffer = bufnr, desc = '[a]ttach' })
end

local function jdtls_on_attach(client, bufnr)
    if features.debugger then
        enable_debugger(bufnr)
    end

    if features.codelens then
        enable_codelens(bufnr)
    end

    -- The following mappings are based on the suggested usage of nvim-jdtls
    -- https://github.com/mfussenegger/nvim-jdtls#usage

    -- Add general LSP keybindings
    require('user.util').on_attach(client, bufnr)
end

local function jdtls_setup()
    local jdtls = require 'jdtls'

    local path = get_jdtls_paths()
    local data_dir = path.data_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

    if cache_vars.capabilities == nil then
        jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

        local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
        cache_vars.capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            ok_cmp and cmp_lsp.default_capabilities() or {}
        )
    end

    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    local cmd = {
        -- 💀
        'java',

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. path.java_agent,
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',

        -- 💀
        '-jar',
        path.launcher_jar,

        -- 💀
        '-configuration',
        path.platform_config,

        -- 💀
        '-data',
        data_dir,
    }

    local lsp_settings = {
        java = {
            -- jdt = {
            --   ls = {
            --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
            --   }
            -- },
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = 'interactive',
                runtimes = path.runtimes,
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = 'all', -- literals, all, none
                },
            },
            format = {
                enabled = true,
                -- settings = {
                --   profile = 'asdf'
                -- },
            },
        },
        signatureHelp = {
            enabled = true,
        },
        completion = {
            favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*',
            },
        },
        contentProvider = {
            preferred = 'fernflower',
        },
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            useBlocks = true,
        },
    }

    -- This starts a new client & server,
    -- or attaches to an existing client & server depending on the `root_dir`.
    jdtls.start_or_attach {
        cmd = cmd,
        settings = lsp_settings,
        on_attach = jdtls_on_attach,
        capabilities = cache_vars.capabilities,
        root_dir = jdtls.setup.find_root(root_files),
        flags = {
            allow_incremental_sync = true,
        },
        init_options = {
            bundles = path.bundles,
        },
    }
end

vim.api.nvim_create_autocmd('FileType', {
    group = java_cmds,
    pattern = { 'java' },
    desc = 'Setup JDTLS',
    callback = jdtls_setup,
})
