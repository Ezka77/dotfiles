-- Plugins
lvim.plugins = {
  {
    "nvim-treesitter/playground",
    event = "BufRead",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin"
  },
  { "ilyachur/cmake4vim" },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup(
        {
          find_engine = {
            -- rg is map with finder_cmd
            ['rg'] = {
              cmd = "rg",
              -- default args
              args = {
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
              },
              options = {
                ['ignore-case'] = {
                  value = "--ignore-case",
                  icon = "[I]",
                  desc = "ignore case"
                },
                ['hidden'] = {
                  value = "--hidden",
                  desc = "hidden file",
                  icon = "[H]"
                },
                -- you can put any rg search option you want here it can toggle with
                -- show_option function
                ['pcre'] = {
                  value = "--pcre2",
                  desc = "enable pcre2",
                  icon = "[P]"
                }
              },
            },
          },
        }
      )
    end,
  },
  {
    "mrjones2014/nvim-ts-rainbow",
  },
  {
    "nvim-telescope/telescope-fzy-native.nvim",
    event = "BufRead",
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "ggandor/leap.nvim",
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      require('leap').add_default_mappings()
    end
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  -- {
  --   "AckslD/nvim-neoclip.lua",
  --   dependencies = {
  --     -- you'll need at least one of these
  --     { 'nvim-telescope/telescope.nvim' },
  --     -- {'ibhagwan/fzf-lua'},
  --   },
  --   config = function()
  --     require('neoclip').setup()
  --   end,
  -- },
  -- {
  --   "kylechui/nvim-surround",
  --   version = "*", -- Use for stability; omit to use `main` branch for the latest features
  --   event = "VeryLazy",
  --   config = function()
  --     require("nvim-surround").setup({
  --       -- Configuration here, or leave empty to use defaults
  --     })
  --   end
  -- },
  {
    "weilbith/nvim-code-action-menu",
  },
  -- {
  --   "f-person/git-blame.nvim",
  --   config = function()
  --     require('gitblame').setup {
  --       enabled = false,
  --     }
  --   end
  -- },
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        -- auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.expand(vim.fn.stdpath('config') .. "/sessions/"),
        -- auto_session_use_git_branch = true,
      }
    end
  },
  {
    'rmagatti/session-lens',
    dependencies = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('session-lens').setup({
        -- prompt_title = 'MY SESSIONS',
        -- path_display = { 'shorten' },
        -- theme = 'ivy',
        -- previewer = true
      })
    end
  },
  -- {
  --   "ecthelionvi/NeoComposer.nvim",
  --   dependencies = { "kkharji/sqlite.lua" },
  --   opts = {}
  -- },
  {
    -- ctags is nice & simple or maybe use stevearc/aerial.nvim
    "fcying/telescope-ctags-outline.nvim",
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  -- {
  --   'stevearc/oil.nvim',
  --   opts = {
  --     view_options = {
  --       show_hidden = true
  --     },
  --     keymaps = {
  --       ["<Leader>c"] = "actions.close" -- like lunarvim buffers
  --     }
  --   },
  --   -- Optional dependencies
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  -- }
  {
    'echasnovski/mini.files',
    version = false,
    event = { "BufEnter" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("mini.files").setup()
    end,
  },
  {
    "jonboh/nvim-dap-rr", dependencies = { "nvim-dap", "telescope.nvim" }
  },
  -- {
  --   'jpmcb/nvim-llama',
  --   config = function()
  --     require('nvim-llama').setup {}
  --   end,
  -- },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
    },
  }
}

-- enable plugins
lvim.builtin.treesitter.rainbow.enable = true

-- safely load telescope extensions
lvim.builtin.telescope.on_config_done = function(telescope)
  telescope.load_extension "fzy_native"
  telescope.load_extension "live_grep_args"
  -- telescope.load_extension "neoclip"
  telescope.load_extension "session-lens"
  telescope.load_extension "ctags_outline"
end

-- format on save
lvim.format_on_save = true
-- lvim.format_on_save.enabled = true
-- lvim.format_on_save.pattern = { "*.hpp", "*.cpp", "*.h", "*.py", "*.lua" }

-- to remind QtCreator
lvim.lsp.buffer_mappings.normal_mode["<F2>"] = lvim.lsp.buffer_mappings.normal_mode["gd"]
lvim.lsp.buffer_mappings.normal_mode["<S-F2>"] = lvim.lsp.buffer_mappings.normal_mode["gD"]
lvim.keys.normal_mode["<F4>"] = ":ClangdSwitchSourceHeader<CR>"
lvim.keys.normal_mode["<F5>"] = ":Telescope resume<CR>"

lvim.keys.normal_mode["<F7>"] = ":Telescope session-lens<CR>"

-- convenient mapping for ESC
lvim.keys.normal_mode["²"] = "<ESC>"
lvim.keys.insert_mode["²"] = "<ESC>"
lvim.keys.visual_mode["²"] = "<ESC>"
-- use tab to change buffers
lvim.keys.normal_mode["<TAB>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-TAB>"] = ":BufferLineCyclePrev<CR>"
-- move buffer order
-- lvim.keys.normal_mode["<PageUp>"] = ":BufferLineMoveNext<CR>"
-- lvim.keys.normal_mode["<PageDown>"] = ":BufferLineMovePrev<CR>"


-- which_key for trouble
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}
-- lvim.builtin.which_key.mappings["S"] = {
--   name = "Session",
--   c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
--   l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
--   Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
-- }
lvim.builtin.which_key.mappings["sg"] = {
  "<cmd>lua require'telescope'.extensions.live_grep_args.live_grep_args()<CR>", "live grep args"
}
lvim.builtin.which_key.mappings["lz"] = {
  "<cmd>CodeActionMenu<CR>", "Code Action Menu"
}
lvim.builtin.which_key.mappings.g["t"] = {
  "<cmd>GitBlameToggle<CR>", "Git Blame Toggle"
}
lvim.builtin.which_key.mappings["sj"] = {
  "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({case_mode='ignore_case'})<CR>", "buffer text search"
}
--sorter = require('telescope.sorters').get_substr_matcher({}),

lvim.builtin.terminal.open_mapping = [[<C-t>]]

-- disable nvimtree, use mini.files
lvim.builtin.nvimtree.active = false
lvim.builtin.which_key.mappings["e"] = { "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", "MiniFiles" }
-- or with Oil
-- lvim.builtin.which_key.mappings["e"] = { "<cmd>Oil<CR>", "Oil" }

-- lvim.builtin.bufferline.active = false

lvim.builtin.which_key.mappings["="] = { "<cmd>LvimToggleFormatOnSave<CR>", "Toggle format on save" }
-- some nice colors - ivy as telescope display
lvim.colorscheme = "catppuccin-mocha"
lvim.builtin.telescope.theme = "ivy"

-- call command to build rapidash site-editor
-- vim.api.nvim_create_user_command("Build",
--   "wall | 1TermExec cmd=\"ninja site-editor && site-editor --dev --log debug\" dir=/home/rosuser/build size=10 direction=horizontal go_back=1",
--   {})

-- line number relative to current position
vim.opt.relativenumber = true

-- disable log ; mine was about 1GiB -> enable it if needed
vim.lsp.set_log_level('off')

vim.diagnostic.config({ virtual_text = true })
lvim.builtin.treesitter.highlight.enable = true
-- load dap settings
require("user.lsp-settings")
require("user.dap-settings")
