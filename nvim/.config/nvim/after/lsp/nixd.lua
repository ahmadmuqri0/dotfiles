---@type vim.lsp.Config
return {
  settings = {
    nixd = {
      nixpkgs = { expr = 'import <nixpkgs> { }' },
      formatting = { command = { 'nixfmt' } },
      options = {
        nixos = {
          expr = '(builtins.getFlake "/home/muqri/Nix").nixosConfigurations.artemis.options',
        },
      },
    },
  },
}
