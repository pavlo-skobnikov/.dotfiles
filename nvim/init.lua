-- .
-- ├── init.lua
-- ├── ...
-- └── lua
--     ├── plugins
--     │   ├── init.lua
--     │   └── telescope.lua
--     └── user
--         ├── autocmds.lua
--         ├── lazy_bootstrap.lua
--         ├── maps.lua
--         └── options.lua

----------------------------------------------[[ Bootstrap Lazy ]]

require("user.lazy_bootstrap")

----------------------------------------------[[  User Settings ]]

require("user.autocmds")
require("user.options")
require("user.maps")

----------------------------------------------[[  Load Plugins  ]]

require("lazy").setup("plugins") -- Loads each lua/plugin/*

