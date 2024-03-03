local M = {}

M.key_table = function(mods, key, action)
  return {
    mods = mods,
    key = key,
    action = action,
  }
end

M.cmd_key = function(key, action)
  return M.key_table("CMD", key, action)
end

return M
