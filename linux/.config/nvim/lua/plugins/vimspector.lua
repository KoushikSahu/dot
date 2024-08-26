map("n", "<leader>de", ":VimspectorReset<CR>")
map("n", "<leader>db", "<Plug>VimspectorToggleBreakpoint")
map("n", "<leader>dB", "<Plug>VimspectorToggleConditionalBreakpoint")
map("n", "<leader>dj", "<Plug>VimspectorStepOver")
map("n", "<leader>dl", "<Plug>VimspectorStepInto")
map("n", "<leader>dk", "<Plug>VimspectorStepOut")
map("n", "<leader>dc", "<Plug>VimspectorContinue")
map("n", "<leader>dh", "<Plug>VimspectorRunToCursor")
map("n", "<leader>di", "<Plug>VimspectorBalloonEval")

return {
  'puremourning/vimspector',
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
}
