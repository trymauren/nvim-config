vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()


    -- Leader mapping: Quick print statement for debugging

    vim.keymap.set('n', '<leader>p', function()
      local var = vim.fn.input('Print variable: ')
      if var == '' then return end
      
      -- Get current line to preserve indentation
      local row = vim.api.nvim_win_get_cursor(0)[1]
      local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
      local indent = current_line:match('^%s*') or ''
      
      local line = indent .. 'print(f"{' .. var .. ' = }")'
      vim.api.nvim_buf_set_lines(0, row, row, false, {line})
      vim.api.nvim_win_set_cursor(0, {row + 1, 0})
    end, { buffer = true, desc = 'Insert print statement' })

    -- Command: Section comment with dashes

	vim.api.nvim_buf_create_user_command(0, 'Section', function(opts)
      local text = opts.args
      if text == '' then
        text = vim.fn.input('Section text: ')
        if text == '' then return end
      end
      
      local separator = string.rep('-', #text)
      local lines = {
        '# ' .. separator,
        '# ' .. text,
        '# ' .. separator,
      }
      
      local row = vim.api.nvim_win_get_cursor(0)[1]
      vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, lines)
      vim.api.nvim_win_set_cursor(0, {row + 3, 0})
    end, { nargs = '?', desc = 'Insert section comment' })


    -- Run Python with uv

    vim.keymap.set('n', '<leader>r', function()
      vim.cmd('write')
      vim.cmd('split | terminal uv run ' .. vim.fn.expand('%'))
      -- vim.cmd('startinsert')
      vim.cmd('wincmd J')  -- Move terminal to bottom (optional)
      vim.cmd('resize 15')  -- Set height to 15 lines (optional)
    end, { buffer = true })
  end,
})
