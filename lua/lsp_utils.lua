-- Common LSP utilities to avoid code duplication

local M = {}

--- Reuse root directory from an existing LSP client if the file is in a library/cache
--- This is useful for files in standard library or package cache directories
--- @param fname string The file name to check
--- @param library_dirs table<string|nil> List of library directory paths to check
--- @param lsp_name string The name of the LSP server
--- @return string|nil The reused root directory, or nil if not applicable
function M.reuse_root_if_library(fname, library_dirs, lsp_name)
  for _, lib_dir in ipairs(library_dirs) do
    if lib_dir and fname:sub(1, #lib_dir) == lib_dir then
      local clients = vim.lsp.get_clients({ name = lsp_name })
      if #clients > 0 then
        return clients[#clients].config.root_dir
      end
    end
  end
  return nil
end

return M
