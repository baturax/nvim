-- Common LSP utilities to avoid code duplication

local M = {}

--- Reuse root directory from an existing LSP client if the file is in a library/cache
--- This is useful for files in standard library or package cache directories
--- @param fname string The file name to check
--- @param library_dirs table<string|nil> List of library directory paths to check
--- @param lsp_name string The name of the LSP server
--- @param use_relpath boolean? If true, uses vim.fs.relpath; otherwise uses string prefix check (default: false)
--- @return string|nil The reused root directory, or nil if not applicable
function M.reuse_root_if_library(fname, library_dirs, lsp_name, use_relpath)
  for _, lib_dir in ipairs(library_dirs) do
    local is_in_library = false
    
    if use_relpath then
      -- Use vim.fs.relpath for checking if fname is under lib_dir
      is_in_library = lib_dir and vim.fs.relpath(lib_dir, fname) ~= nil
    else
      -- Use string prefix check
      is_in_library = lib_dir and fname:sub(1, #lib_dir) == lib_dir
    end
    
    if is_in_library then
      local clients = vim.lsp.get_clients({ name = lsp_name })
      if #clients > 0 then
        return clients[#clients].config.root_dir
      end
    end
  end
  return nil
end

return M
