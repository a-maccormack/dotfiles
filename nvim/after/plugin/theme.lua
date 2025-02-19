local ok, github_theme = pcall(require, 'github-theme')
if not ok then
	return
end

github_theme.setup({
   --...
})

vim.cmd('colorscheme github_dark_default')

