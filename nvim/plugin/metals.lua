local function get_metals_main_cfg()
    local metals = require 'metals'

    vim.keymap.set('n', '<leader>ws', function()
        metals.hover_worksheet()
    end, { desc = '[w]orksheet' })

    local metals_config = metals.bare_config()

    -- Example of settings
    metals_config.settings = {
        showImplicitArguments = true,
        excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
    }

    -- Setting statusBarProvider to true is highly recommend.
    -- If it's set to true, then it's to have a setting to display this in
    -- the statusline or else no messages from metals will be seen. There is more
    -- info in the help docs about this
    -- metals_config.init_options.statusBarProvider = "on"

    -- Setup capabilites for `cmp` snippets
    metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

    return metals_config
end

-- Debug settings if you're using nvim-dap
local function setup_dap_cfg()
    local dap = require 'dap'

    dap.configurations.scala = {
        {
            type = 'scala',
            request = 'launch',
            name = 'RunOrTest',
            metals = {
                runType = 'runOrTestFile',
                --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
            },
        },
        {
            type = 'scala',
            request = 'launch',
            name = 'Test Target',
            metals = {
                runType = 'testTarget',
            },
        },
    }
end

local function compose_metals_cfg()
    local metals_config = get_metals_main_cfg()

    metals_config.on_attach = function()
        setup_dap_cfg()
        require('metals').setup_dap()
    end

    return metals_config
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    -- NOTE: Java might or might not need to be included. It's needed if
    -- basic Java support in a Scala-Java project is required but it may also conflict
    -- with nvim-jdtls which also works on a java filetype autocmd.
    -- pattern = { 'scala', 'sbt', 'java' },
    pattern = { 'scala', 'sbt' },
    callback = function()
        require('metals').initialize_or_attach(compose_metals_cfg())
    end,
    group = nvim_metals_group,
})
