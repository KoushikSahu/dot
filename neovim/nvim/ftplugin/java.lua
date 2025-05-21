local mason_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages")
local jdtls_path = vim.fs.joinpath(mason_dir, "jdtls", "bin", "jdtls")
local config = {
	cmd = { jdtls_path },
	root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
