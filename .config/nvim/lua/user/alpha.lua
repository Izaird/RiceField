local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require "user.icons"

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
[[     ...    .     ...                       ..                                                      ]],
[[  .~`"888x.!**h.-``888h.              x .d88"                                                       ]],
[[ dX   `8888   :X   48888>              5888R                    u.      ..    .     :               ]],
[['888x  8888  X88.  '8888>       .u     '888R         .    ...ue888b   .888: x888  x888.       .u    ]],
[['88888 8888X:8888:   )?""`   ud8888.    888R    .udR88N   888R Y888r ~`8888~'888X`?888f`   ud8888.  ]],
[[`8888>8888 '88888>.88h.   :888'8888.   888R   <888'888k  888R I888>   X888  888X '888>  :888'8888. ]],
[[  `8" 888f  `8888>X88888. d888 '88%"   888R   9888 'Y"   888R I888>   X888  888X '888>  d888 '88%" ]],
[[ -~` '8%"     88" `88888X 8888.+"      888R   9888       888R I888>   X888  888X '888>  8888.+"    ]],
[[ .H888n.      XHn.  `*88! 8888L        888R   9888      u8888cJ888    X888  888X '888>  8888L      ]],
[[:88888888x..x88888X.  `!  '8888c. .+  .888B . ?8888u../  "*888*P"    "*88%""*88" '888!` '8888c. .+ ]],
[[f  ^%888888% `*88888nx"    "88888%    ^*888%   "8888P'     'Y"         `~    "    `"`    "88888%   ]],
[[     `"**"`    `"**""        "YP'       "%       "P'                                       "YP'    ]],
[[]],
[[]],
[[                 ███▄ ▄███▓ ▒█████  ▄▄▄█████▓ ██░ ██ ▓█████  ██▓    ▓█████▄▄▄█████▓]],
[[                ▓██▒▀█▀ ██▒▒██▒  ██▒▓  ██▒ ▓▒▓██░ ██▒▓█   ▀ ▓██▒    ▓█   ▀▓  ██▒ ▓▒]],
[[                ▓██    ▓██░▒██░  ██▒▒ ▓██░ ▒░▒██▀▀██░▒███   ▒██░    ▒███  ▒ ▓██░ ▒░]],
[[                ▒██    ▒██ ▒██   ██░░ ▓██▓ ░ ░▓█ ░██ ▒▓█  ▄ ▒██░    ▒▓█  ▄░ ▓██▓ ░ ]],
[[                ▒██▒   ░██▒░ ████▓▒░  ▒██▒ ░ ░▓█▒░██▓░▒████▒░██████▒░▒████▒ ▒██▒ ░ ]],
[[                ░ ▒░   ░  ░░ ▒░▒░▒░   ▒ ░░    ▒ ░░▒░▒░░ ▒░ ░░ ▒░▓  ░░░ ▒░ ░ ▒ ░░   ]],
[[                ░  ░      ░  ░ ▒ ▒░     ░     ▒ ░▒░ ░ ░ ░  ░░ ░ ▒  ░ ░ ░  ░   ░    ]],
[[                ░      ░   ░ ░ ░ ▒    ░       ░  ░░ ░   ░     ░ ░      ░    ░      ]],
[[                       ░       ░ ░            ░  ░  ░   ░  ░    ░  ░   ░  ░        ]],
}
dashboard.section.buttons.val = {
  dashboard.button(
    "a",
    icons.ui.NewFile .. " 新シファイルを作成する",
    ":ene <BAR> startinsert <CR>"
  ),
  dashboard.button(
    "t", icons.ui.List .. " テキストを探す",
    ":Telescope live_grep <CR>"
  ),
  -- dashboard.button("s",
  --   icons.ui.SignIn .. " Find Session",
  --   ":Telescope sessions save_current=false <CR>"
  -- ),
  dashboard.button("f",
    icons.documents.Files .. " ファイルを探す",
    ":Telescope find_files <CR>"
  ),
  dashboard.button(
    "p",
    icons.git.Repo .. " プロジェクトを探す",
    ":lua require('telescope').extensions.projects.projects()<CR>"
  ),
  dashboard.button(
    "r",
    icons.ui.History .. " 最新ファイル", 
    ":Telescope oldfiles <CR>"),
  dashboard.button(
    "d",
    icons.ui.Code .. " 開発",
    ":e ~/Dev/ <CR>"
  ),
  dashboard.button(
    "c",
    icons.ui.Gear .. " 設定",
    ":e ~/.config/nvim/init.lua <CR>"
  ),
  dashboard.button(
    "q",
    icons.diagnostics.Error .. " 終了",
    ":qa<CR>"
  ),


}
local function footer()
  -- NOTE: requires the fortune-mod package to work
  -- local handle = io.popen("fortune")
  -- local fortune = handle:read("*a")
  -- handle:close()
  -- return fortune
  return "chrisatmachine.com"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
