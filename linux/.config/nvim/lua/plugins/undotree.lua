map('n', '<leader>u', ':UndotreeToggle <CR>', {noremap = true, silent = true})

return {
  'mbbill/undotree',
  cmd = {'UndotreeToggle'},
}
