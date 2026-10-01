return {
  "neovim/nvim-lspconfig",
  config = function()
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          },
        },
      },
      nixd = {
        cmd = { "nixd" },
        settings = {
          nixd = {
            nixpkgs = {
              expr = "import <nixpkgs> { }",
            },
            formatting = {
              command = { "nixfmt" },
            },
            options = {
              nixos = {
                expr = '(builtins.getFlake "/home/muqri/Nix").nixosConfigurations.artemis.options',
              },
            },
          },
        },
      },
      vtsls = {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vim.fs.dirname(vim.fn.exepath("vue-language-server"))
                    .. "/../lib/language-tools/packages/language-server/node_modules/@vue/typescript-plugin",
                  languages = { "vue" },
                  configNamespace = "typescript",
                },
              },
            },
          },
        },
      },
      tailwindcss = {
        filetypes_exclude = { "markdown" },
        filetypes_include = {},
        settings = {
          tailwindCSS = {
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
            },
          },
        },
      },
      vue_ls = {},
      pyright = {},
    }

    for name, config in pairs(servers) do
      if not vim.tbl_isempty(config) then
        vim.lsp.config(name, config)
      end
    end

    vim.lsp.enable(vim.tbl_keys(servers))

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(args)
        local buf = args.buf

        local Snacks = require("snacks")
        local keymap = vim.keymap.set

        -- stylua: ignore start
        keymap("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "Hover" })
        keymap("n", "<leader>cr", vim.lsp.buf.rename, { buffer = buf, desc = "Rename" })
        keymap("n", "<leader>cR", Snacks.rename.rename_file, { buffer = buf, desc = "Rename file" })
        keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code action" })
        keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { buffer = buf, desc = "Prev diagnostic" })
        keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { buffer = buf, desc = "Next diagnostic" })
        -- stylua: ignore end
      end,
    })
  end,
}
