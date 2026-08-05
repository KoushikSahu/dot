local normalized_clients = setmetatable({}, { __mode = "k" })

local function to_snake_case(str)
  return (str:gsub("%s*[- ]%s*", "_"))
end

local function normalize_token_names(token_names)
  if not token_names then
    return
  end

  for i, name in ipairs(token_names) do
    token_names[i] = to_snake_case(name)
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or client.name ~= "omnisharp" or normalized_clients[client] then
      return
    end

    local semantic_tokens = client.server_capabilities.semanticTokensProvider
    local legend = semantic_tokens and semantic_tokens.legend
    if not legend then
      return
    end

    normalize_token_names(legend.tokenModifiers)
    normalize_token_names(legend.tokenTypes)

    normalized_clients[client] = true
  end,
})
