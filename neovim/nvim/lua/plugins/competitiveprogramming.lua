return {
  {
    'xeluxee/competitest.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    cmd = 'CompetiTest',
    keys = {
      { '<leader>cpp', '<cmd>CompetiTest receive testcases<CR>', desc = 'Receive Test Cases' },
      { '<leader>cpr', '<cmd>CompetiTest run<CR>', desc = 'Run Competitive Program' },
      { '<leader>cpa', '<cmd>CompetiTest add_testcase<CR>', desc = 'Add Test Case' },
      { '<leader>cpd', '<cmd>CompetiTest delete_testcase<CR>', desc = 'Delete Test Case' },
      { '<leader>cpe', '<cmd>CompetiTest edit_testcase<CR>', desc = 'Edit Test Case' },
    },
    opts = {
      compile_command = {
        cpp = {
          exec = 'g++',
          args = {
            '-O2', '-g', '-Wall', '-Wextra', '-Wno-unused-result',
            '-Wconversion', '-static', '-std=c++20', '$(FNAME)',
          },
        },
        rust = {
          exec = 'rustc',
          args = {
            '--edition=2021', '-C', 'debug-assertions', '-O',
            '--out-dir', 'target', '$(FNAME)',
          },
        },
        kotlin = {
          exec = 'kotlinc',
          args = {
            '$(FNAME)', '-include-runtime', '-d', 'a.jar',
          },
        },
      },
      run_command = {
        cpp = { exec = './a.out' },
        rust = { exec = './target/$(FNOEXT)' },
        kotlin = { exec = 'java', args = { '-jar', 'a.jar' } },
      },
      testcases_directory = './.nvim',
      testcases_use_single_file = true,
    },
  },
  {
    'CRAG666/code_runner.nvim',
    cmd = { 'RunCode', 'RunFile', 'RunProject', 'RunClose', 'CRFiletype', 'CRProjects' },
    keys = {
      { '<leader>r', '<cmd>RunCode<CR>', desc = 'Run Code', silent = false },
      { '<leader>rf', '<cmd>RunFile<CR>', desc = 'Run File', silent = false },
      { '<leader>rft', '<cmd>RunFile tab<CR>', desc = 'Run File In Tab', silent = false },
      { '<leader>rp', '<cmd>RunProject<CR>', desc = 'Run Project', silent = false },
      { '<leader>rc', '<cmd>RunClose<CR>', desc = 'Close Runner', silent = false },
      { '<leader>crf', '<cmd>CRFiletype<CR>', desc = 'Select Runner Filetype', silent = false },
      { '<leader>crp', '<cmd>CRProjects<CR>', desc = 'Select Runner Project', silent = false },
    },
    opts = {
      filetypes = {
        rust = {
          'cd $dir',
          'rustc --edition=2021 -O --out-dir target $fileName',
          './target/$fileNameWithoutExt',
        },
      },
    },
  },
}