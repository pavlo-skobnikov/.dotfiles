-- .
-- ├── init.lua
-- ├── ...
-- └── lua
--     ├── plugins
--     │   ├── PLUGIN_MODULE_1.lua
--     │   ├── PLUGIN_MODULE_2.lua
--     │   ├── PLUGIN_MODULE_3.lua
--     │   └── PLUGIN_MODULE_N.lua
--     └── user
--         ├── autocmds.lua
--         ├── lazy_bootstrap.lua
--         ├── maps.lua
--         ├── options.lua
--         └── util.lua

----------------------------------------------[[ Bootstrap Lazy ]]

require 'user.lazy_bootstrap'

----------------------------------------------[[  User Settings ]]

require 'user.autocmds'
require 'user.options'
require 'user.maps'
require 'user.util'

----------------------------------------------[[  Load Plugins  ]]

require('lazy').setup 'plugins' -- Loads each lua/plugin/*
