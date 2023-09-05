local rainbow = require 'ts-rainbow'
require("nvim-treesitter.configs").setup {
  rainbow = {
    query = {
      'rainbow-parens',
    },
    strategy = rainbow.strategy.global,
    hlgroups = {
      'TSRainbowRed',
      'TSRainbowYellow',
      'TSRainbowBlue',
      'TSRainbowOrange',
      'TSRainbowGreen',
      'TSRainbowViolet',
      'TSRainbowCyan'
    },
  }
}
