-- LaTeX configuration (vimtex)
vim.cmd [[filetype plugin indent on]]
vim.cmd [[syntax enable]]
vim.g.vimtex_view_method = 'skim'
vim.g.vimtex_view_skim_sync = 1  -- Enable forward search (nvim -> Skim)
vim.g.vimtex_view_skim_activate = 1  -- Open Skim when compiling
vim.g.vimtex_view_automatic = 0
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_indent_enabled = 0 -- keep Enter from adding extra LaTeX-specific indent
vim.g.tex_indent_items = 0 -- don't add extra indent for \\item lines
vim.g.vimtex_compiler_latexmk = {
    build_dir = '',
    callback = 1,
    continuous = 1,
    executable = 'latexmk',
    options = {
        '-pdf',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    },
}

-- Enable completion for citations (Ctrl-X Ctrl-O in insert mode)
vim.g.vimtex_complete_enabled = 1
-- Change leader from "\"
vim.g.maplocalleader = ","

-- Function to refocus terminal after viewing PDF
vim.cmd([[
	function! s:TexFocusVim() abort
	  silent execute "!open -a Terminal"
	  redraw!
	endfunction

	augroup vimtex_event_focus
  	  au!
  	  au User VimtexEventViewReverse call s:TexFocusVim()
	augroup END
]])

-- Line wrapping
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    -- vim.opt_local.showbreak = "↪ "    -- Shows a symbol at the start of wrapped lines
  end,
})
