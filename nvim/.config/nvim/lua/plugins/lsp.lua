return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers.nixd = {
      settings = {
        nixd = {
          nixpkgs = { expr = "import <nixpkgs> { }" },
          formatting = { command = { "nixfmt" } },
          options = {
            nixos = {
              expr = '(builtins.getFlake "/home/muqri/Nix").nixosConfigurations.artemis.options',
            },
          },
        },
      },
    }
    opts.servers.vue_ls = {}

    -- vtsls + vue
    local vue_ts_plugin = vim.fs.dirname(vim.fn.resolve(vim.fn.exepath("vue-language-server")))
      .. "/../lib/language-tools/packages/language-server/node_modules/@vue/typescript-plugin"

    table.insert(opts.servers.vtsls.filetypes, "vue")
    LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
      {
        name = "@vue/typescript-plugin",
        location = vue_ts_plugin,
        languages = { "vue" },
        configNamespace = "typescript",
        enableForWorkspaceTypeScriptVersions = true,
      },
    })
  end,
}
