return {
  'nvim-lualine/lualine.nvim',
  event = { 'VimEnter', 'BufReadPost', 'BufNewFile' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function sanitize_name(name)
      if type(name) ~= 'string' or name == '' then
        return nil
      end
      name = name:gsub('^%.*/', ''):gsub('[\r\n]+', ' '):gsub('^%s+', ''):gsub('%s+$', '')
      return name ~= '' and name or nil
    end

    local function collect_unique(items)
      local names = {}
      for _, item in ipairs(items) do
        local name = sanitize_name(type(item) == 'table' and item.name or item)
        if name then
          names[#names + 1] = name
        end
      end
      return names
    end

    local Fg = {
      lsp = '#61AFEF',
      formatter = '#98C379',
      linter = '#E5C07B',
    }


    local provider_cache = {}

    local function clear_provider_cache(bufnr)
      if bufnr then
        provider_cache[bufnr] = nil
      else
        provider_cache = {}
      end
    end

    local function cached_names(provider, discover)
      local bufnr = vim.api.nvim_get_current_buf()
      local cache = provider_cache[bufnr]
      if not cache then
        cache = {}
        provider_cache[bufnr] = cache
      end
      if not cache[provider] then
        cache[provider] = discover(bufnr)
      end
      return cache[provider]
    end

    local function get_lsp_names()
      return cached_names('lsp', function(bufnr)
        local names = {}
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
          names[#names + 1] = client.name
        end
        return collect_unique(names)
      end)
    end

    local function get_linter_names()
      return cached_names('linter', function(bufnr)
        local ok, lint = pcall(require, 'lint')
        if not ok then
          return {}
        end
        local linters = lint.linters_by_ft[vim.bo[bufnr].filetype]
        if not linters then
          return {}
        end
        return collect_unique(type(linters) == 'string' and { linters } or linters)
      end)
    end

    local function get_formatter_names()
      return cached_names('formatter', function(bufnr)
        local ok, conform = pcall(require, 'conform')
        if not ok then
          return {}
        end
        return collect_unique(conform.list_formatters_for_buffer(bufnr))
      end)
    end

    local function has_names(getter)
      return function()
        return #getter() > 0
      end
    end

    local function format_names(icon, names)
      if #names == 0 then
        return ''
      end
      return string.format('%s  %s', icon, table.concat(names, ', '))
    end
    local function get_lsp_section()
      local names = get_lsp_names()
      if #names == 0 then
        return ''
      end
      return table.concat(names, ', ')
    end



    local group = vim.api.nvim_create_augroup('StatuslineProviderCache', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType', 'BufWritePost', 'LspAttach', 'LspDetach', 'BufWipeout' }, {
      group = group,
      callback = function(args)
        clear_provider_cache(args.buf)
      end,
    })
    vim.api.nvim_create_autocmd({ 'DirChanged', 'User' }, {
      group = group,
      pattern = { 'DirChanged', 'MasonToolsUpdateCompleted' },
      callback = function()
        clear_provider_cache()
      end,
    })

    require('lualine').setup {
      options = {
        theme = 'auto',
        globalstatus = true,
      },
      sections = {
        lualine_x = {
          'diagnostics',
          { function() return format_names('󰒋', { get_lsp_section() }) end,
            cond = function() return get_lsp_section() ~= '' end, color = { fg = Fg.lsp, gui = 'bold' } },
          { function() return format_names('󰉢', get_formatter_names()) end, cond = has_names(get_formatter_names), color = { fg = Fg.formatter } },
          { function() return format_names('󰁨', get_linter_names()) end, cond = has_names(get_linter_names), color = { fg = Fg.linter } },
          'encoding',
          'filetype',
        },
      },
    }
  end,
}