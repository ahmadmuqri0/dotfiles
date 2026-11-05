if vim.loader then
  vim.loader.enable()
end

_G.Artemis = require('artemis.utils')
require('artemis.config.options')
require('artemis.config.keymaps')
require('artemis.config.autocmds')
require('artemis.plugins')
