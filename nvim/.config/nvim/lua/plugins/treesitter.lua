return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
  },
  config = function(_, opts)
    local treesitter = require("nvim-treesitter")

    treesitter.install(opts.ensure_installed)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype

        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
          return
        end

        local ok_add = pcall(vim.treesitter.language.add, lang)
        if not ok_add then
          return
        end

        pcall(vim.treesitter.start, buf, lang)
      end,
    })
  end,
}
