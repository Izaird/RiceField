return {
  'chomosuke/typst-preview.nvim',
  lazy = false, -- or ft = 'typst'
  version = '1.*',
  opts = {
    host = '192.168.1.13',  -- your machine's LAN IP
    port = 8000,             -- fixed port so you always know the URL
  }, -- lazy.nvim will implicitly calls `setup {}`
}
