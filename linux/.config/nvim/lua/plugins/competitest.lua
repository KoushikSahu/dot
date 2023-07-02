map('n', '<leader>l', ':CompetiTestReceive <CR>')
map('n', '<leader>t', ':CompetiTestRun <CR>')

return {
  'xeluxee/competitest.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  config = function() require'competitest'.setup{
    compile_command = {
      cpp       = { exec = 'g++',           args = {'-O2', '-g', '-Wall', '-Wextra', '-Wno-unused-result', '-Wconversion', '-static', '-std=c++20', '$(FNAME)'} },
    },
    run_command = {
      cpp       = { exec = './a.out' },
    },
  } end
}
