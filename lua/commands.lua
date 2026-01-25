vim.api.nvim_create_user_command("QQ", function() vim.cmd("qa!") end, {}) -- Q to quit all
