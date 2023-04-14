-- Plugins
local jdtls = require 'jdtls'

-- Paths and files
local home = vim.fn.expand '$HOME'
local mason = home .. '/.local/share/nvim/mason/packages/jdtls'
local lombok = mason .. '/lombok.jar'
local jdtls_launcher = vim.fn.expand(mason .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local jdtls_config = mason .. '/config_mac'
local jdtls_extensions = home .. '/.local/source/java_lsp_extensions'
local workspace = home .. '/.cache/jdtls/workspace/'

-- Names
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

-- Mappings
local lsp_maps = require 'shared.lsp_maps'
local dap_maps = require 'shared.dap_maps'

-- LSP Extensions
-- Debugger
local bundles = {
  vim.fn.glob(
    jdtls_extensions
      .. '/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
    true
  ),
}

-- JUnit
vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(jdtls_extensions .. '/vscode-java-test/server/*.jar', true), '\n')
)
-- Source Code Decompiler
vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(jdtls_extensions .. '/vscode-java-decompiler/server/*.jar', true), '\n')
)

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    'java',

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-Xmx2G',
    '-javaagent:' .. lombok, -- Must point to the lombok.jar file
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    '-jar',
    jdtls_launcher, -- Must point to the eclipse.jdt.ls installation
    '-configuration',
    jdtls_config, -- Must point to the eclipse.jdt.ls configuration directory
    '-data',
    workspace .. project_name, -- `data directory configuration` @ https://github.com/mfussenegger/nvim-jdtls
  },
  on_attach = function(client, bufnr)
    require('jdtls.setup').add_commands()

    lsp_maps.on_startup() -- Add common LSP mappings

    lsp_maps.on_attach(client, bufnr)
    dap_maps.on_attach(client, bufnr)

    -- LSP mappings specific to nvim-jdtls
    vim.keymap.set(
      'n',
      '<space>ri',
      jdtls.organize_imports,
      { noremap = true, silent = true, desc = 'Organize Imports' }
    )
    vim.keymap.set(
      'n',
      '<space>rv',
      jdtls.extract_variable,
      { noremap = true, silent = true, desc = 'Extract Variable' }
    )
    vim.keymap.set('v', '<space>rv', function()
      jdtls.extract_variable(true)
    end, { noremap = true, silent = true, desc = 'Extract Variable' })
    vim.keymap.set(
      'n',
      '<space>rc',
      jdtls.extract_constant,
      { noremap = true, silent = true, desc = 'Extract Constant' }
    )
    vim.keymap.set('v', '<space>rc', function()
      jdtls.extract_constant(true)
    end, { noremap = true, silent = true, desc = 'Extract Constant' })
    vim.keymap.set(
      'n',
      '<space>rm',
      jdtls.extract_method,
      { noremap = true, silent = true, desc = 'Extract Method' }
    )
    vim.keymap.set('v', '<space>rm', function()
      jdtls.extract_constant(true)
    end, { noremap = true, silent = true, desc = 'Extract Method' })

    -- This requires java-debug and vscode-java-test bundles
    vim.keymap.set(
      'n',
      '<leader>df',
      require('jdtls').dap.test_class,
      { noremap = true, silent = true, desc = 'Test Class' }
    )
    -- Run nearest test method with test application configuration
    vim.keymap.set('n', '<leader>dn', function()
      require('jdtls').dap.test_nearest_method()
    end, { noremap = true, silent = true, desc = 'Test Nearest Method' })

    jdtls.setup_dap {
      hotcodereplace = 'auto',
    }

    -- Setup commands only after everyhing was loaded
    require('jdtls.setup').add_commands()
  end,
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      format = {
        enabled = true,
      },
    },
    signatureHelp = { enabled = true },
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
      },
      useBlocks = true,
    },
  },
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  --
  init_options = {
    bundles = bundles,
  },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
