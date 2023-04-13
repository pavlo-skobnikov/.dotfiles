local M = {}

function M.create_description_options_fn(default_options)
  local default_options_or_add_description = function(description)
    if description == nil then
      return default_options
    else
      local new_options = {}

      for name, value in pairs(default_options) do
        new_options[name] = value
      end

      new_options.desc = description

      return new_options
    end
  end

  return default_options_or_add_description
end

function M.create_mapping_fn_with_options_fn(options_fn)
  return function(modes, mapping, action, description)
    vim.keymap.set(modes, mapping, action, options_fn(description))
  end
end

function M.create_mapping_fn_with_default_opts_and_desc(default_options)
  local options_fn = M.create_description_options_fn(default_options)

  return M.create_mapping_fn_with_options_fn(options_fn)
end

return M
-- TODO: maybe remove this and use nvim's api directly?
