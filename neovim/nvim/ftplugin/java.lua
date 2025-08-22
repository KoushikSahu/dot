local mason_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages")
local jdtls_dir = vim.fs.joinpath(mason_dir, "jdtls")
local jdtls_bin = vim.fs.joinpath(jdtls_dir, "bin")
local java_home = vim.fs.joinpath(mason_dir, "openjdk-17")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

vim.uv.os_setenv("JAVA_HOME", java_home)

local status, jdtls = pcall(require, 'jdtls')
if not status then
	return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

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
	cmd = {
		jdtls_cmd,
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens',
		'java.base/java.util=ALL-UNNAMED',
		'--add-opens',
		'java.base/java.lang=ALL-UNNAMED',
		'-javaagent:' .. vim.fs.joinpath('/.local/share/nvim/mason/packages/jdtls/lombok.jar'),
		'-jar',
		vim.fn.glob(vim.fs.joinpath(mason_dir,
			'/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar')),
		'-configuration',
		vim.fs.joinpath(mason_dir, "config_win"),
		"-data", workspace_dir
	},
	root_dir = find_root_dir(),
	settings = {
		java = {
			signatureHelp = { enabled = true },
			extendedClientCapabilities = extendedClientCapabilities,
			maven = {
				downloadSources = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = 'all', -- literals, all, none
				},
			},
			format = {
				enabled = false,
			},
		},
	},
	flags = {
		allow_incremental_sync = true,
	},
	init_options = {
		bundles = {},
	},
}

require('jdtls').start_or_attach(config)
