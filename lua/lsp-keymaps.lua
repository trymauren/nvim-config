vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, desc = "LSP definition" }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "LSP declaration" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "LSP references" })
  end,
})
