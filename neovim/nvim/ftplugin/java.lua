local mason_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages")
local jdtls_dir = vim.fs.joinpath(mason_dir, "jdtls")
local jdtls_bin = vim.fs.joinpath(jdtls_dir, "bin")

-- Use the batch file on Windows systems
local is_windows = vim.fn.has('win32') == 1
local jdtls_cmd = is_windows and vim.fs.joinpath(jdtls_bin, "jdtls.bat") or vim.fs.joinpath(jdtls_bin, "jdtls")

local function find_root_dir()
	local markers = { 'gradlew', '.git', 'mvnw', 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle' }
	local root = vim.fs.find(markers, { upward = true })[1]
	if root then
		return vim.fs.dirname(root)
	else
		-- If no project marker found, fallback to the current buffer's directory
		return vim.fs.dirname(vim.api.nvim_buf_get_name(0))
	end
end

local config = {
	cmd = { jdtls_cmd },
	root_dir = find_root_dir(),
}

require('jdtls').start_or_attach(config)
