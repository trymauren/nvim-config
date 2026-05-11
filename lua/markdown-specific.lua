local ok_ts, ts_configs = pcall(require, "nvim-treesitter.configs")
if ok_ts then
  ts_configs.setup({
    ensure_installed = {
      "markdown",
      "markdown_inline",
      "html",
      "typst",
      "yaml",
    },
    highlight = { enable = true },
  })
end

local ok_mv, markview = pcall(require, "markview")
if ok_mv then
  markview.setup({
    preview = {
      icon_provider = "internal",
      splitview_winopts = {
        split = "right",
      },
    },
  })
end

vim.keymap.set("n", "<leader>m", "<CMD>Markview<CR>", { desc = "Toggle markview globally" })
