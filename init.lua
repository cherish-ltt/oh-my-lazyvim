-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 代码自动换行显示 软换行
vim.opt.wrap = true
vim.opt_local.wrap = true
vim.opt_local.linebreak = true -- 避免单词被拆开折叠
vim.opt_local.breakindent = true -- 为折叠行添加缩进
