local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers {
    -- This is a default handler that will be called for each installed server (also for new servers that are installed during a session)
    function (server_name)
       lspconfig[server_name].setup {}
   end,
   -- You can also override the default handler for specific servers by providing them as keys, like so:
   --["rust_analyzer"] = function ()
     --require("rust-tools").setup {}
   --end
}
