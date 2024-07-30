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
  { "cmake-tools.nvim" },
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
    "monaqa/dial.nvim",
    event = "BufRead",
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
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
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require "lsp_signature".on_attach() end,
  -- },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  {
    "aznhe21/actions-preview.nvim",
    config = function()
      require("actions-preview").setup {
        telescope = vim.tbl_extend(
          "force",
          -- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
          require("telescope.themes").get_ivy(),
          -- a table for customizing content
          {
            -- a function to make a table containing the values to be displayed.
            -- fun(action: Action): { title: string, client_name: string|nil }
            make_value = nil,

            -- a function to make a function to be used in `display` of a entry.
            -- see also `:h telescope.make_entry` and `:h telescope.pickers.entry_display`.
            -- fun(values: { index: integer, action: Action, title: string, client_name: string }[]): function
            make_make_display = nil,
          }
        ) }
    end
  },
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
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup() --{ '*'; '!' }
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
        }
      })
    end
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end
  },
  -- it builds but never find how to instruct fzf-lua to use it !
  -- { "junegunn/fzf", build = "./install --bin" }
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
  telescope.load_extension "noice"
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

lvim.builtin.which_key.mappings["sg"] = {
  "<cmd>lua require'telescope'.extensions.live_grep_args.live_grep_args()<CR>", "live grep args"
}
lvim.builtin.which_key.mappings["lz"] = {
  "<cmd>lua require('actions-preview').code_actions()<CR>", "Code Action Menu"
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

-- some nice colors - ivy as telescope display
lvim.colorscheme = "catppuccin-mocha"
lvim.builtin.telescope.theme = "ivy"

-- line number relative to current position
vim.opt.relativenumber = true

-- disable log ; mine was about 1GiB -> enable it if needed
vim.lsp.set_log_level('off')

vim.diagnostic.config({ virtual_text = true })
lvim.builtin.treesitter.highlight.enable = true

lvim.builtin.treesitter.ensure_installed = { "cpp", "c", "cmake", "dockerfile", "yaml", "markdown", "json", "toml", "rst",
  "comment" }
lvim.builtin.mason.ensure_installed = { "cmakelang", "cmakelint", "hadolint" }

-- require c++ & clangd
-- lvim.builtin.which_key.mappings["lo"] = { "<cmd>ClangdToggleInlayHints<cr>", "Toggle Inlays Hints" }
-- lvim.builtin.which_key.mappings["lh"] = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch Source/Header" }

-- add c++ snips
require("luasnip").filetype_extend("cpp", { "cppdoc" })

-- lvim.transparent_window = true
-- require("notify").setup({ background_colour = "#11111B" })

vim.keymap.set({ "i" }, "<C-x><C-f>",
  function()
    require("fzf-lua").complete_file({
      cmd = "rg --files",
      winopts = { preview = { hidden = "nohidden" } }
    })
  end, { silent = true, desc = "Fuzzy complete file" })

-- load dap settings
require("user.lsp-settings")
require("user.dap-settings")
