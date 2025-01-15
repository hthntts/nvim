local icons = require('core.icons')

-- local function normalize_path(path)
--   return path:gsub("\\", "/")
-- end
--
-- local function normalize_cwd()
--   return normalize_path(vim.loop.cwd()) .. "/"
-- end
--
-- local function is_subdirectory(cwd, path)
--   return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
-- end
--
-- local function split_filepath(path)
--   local normalized_path = normalize_path(path)
--   local normalized_cwd = normalize_cwd()
--   local filename = normalized_path:match("[^/]+$")
--
--   if is_subdirectory(normalized_cwd, normalized_path) then
--     local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
--     return stripped_path, filename
--   else
--     local stripped_path = normalized_path:sub(1, -(#filename + 1))
--     return stripped_path, filename
--   end
-- end
--
-- local function path_display(_, path)
--   local stripped_path, filename = split_filepath(path)
--   if filename == stripped_path or stripped_path == "" then
--     return filename
--   end
--   return string.format("%s ~ %s", filename, stripped_path)
-- end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    "nvim-telescope/telescope-ui-select.nvim",

    -- Useful for getting pretty icons, but requires a Nerd Font.
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-symbols.nvim",
  },
  keys = {
    { "<leader><leader>", "<cmd>Telescope find_files<cr>",      desc = "Find file in project" },
    { "<leader>/",        "<cmd>Telescope live_grep<cr>",       desc = "Search project" },
    { "<leader>cx",       "<cmd>Telescope diagnostics<cr>",     desc = "LSP: List errors" },
    { "<leader>ff",       "<cmd>Telescope find_files<cr>",      desc = "Find file in project" },
    { "<leader>fr",       "<cmd>Telescope oldfiles<cr>",        desc = "Recent files" },
    { "<leader>fw",       "<cmd>Telescope grep_string<cr>",     desc = "Find current word" },

    { "<leader>gC",       "<cmd>Telescope git_commits<cr>",     desc = "Git commits" },
    { "<leader>gb",       "<cmd>Telescope git_branches<cr>",    desc = "Git branches" },
    { "<leader>gs",       "<cmd>Telescope git_status<cr>",      desc = "Git status (diff view)" },

    { "<leader>hb",       "<cmd>Telescope builtin<cr>",         desc = "Telescope builtin" },
    { "<leader>hc",       "<cmd>Telescope command_history<cr>", desc = "Command history" },
    { "<leader>hh",       "<cmd>Telescope help_tags<cr>",       desc = "Help" },
    { "<leader>hk",       "<cmd>Telescope keymaps<cr>",         desc = "Keymaps" },
    { "<leader>ht",       "<cmd>Telescope colorscheme<cr>",     desc = "Themes" },

    { "<leader>ie",       "<cmd>Telescope symbols<cr>",         desc = "Emoji" },

    -- { "<leader>sr",       "<cmd>Telescope resume<cr>",         desc = "Search resume" },
    -- { "<leader>sm",       "<cmd>Telescope marks<cr>",          desc = "Search marks" },

    {
      "<leader>sh",
      "<cmd>lua require'telescope.builtin'.search_history(require('telescope.themes').get_dropdown({previewer=false}))<cr>",
      desc = "Search history"
    },
    {
      "<leader>si",
      "<cmd>lua require'telescope.builtin'.lsp_document_symbols({symbols={'Class','Function','Method','Constructor','Interface','Module','Property'},})<cr>",
      desc = "Jump to symbol"
    },
    {
      "<leader>bo",
      "<cmd>lua require'telescope.builtin'.live_grep({grep_open_files=true,prompt_title='Live Grep in Open Files'})<cr>",
      desc = "Seach open buffer"
    },
    {
      "<leader>bb",
      "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({previewer=false}))<cr>",
      desc = "Switch buffer"
    },
    {
      "<leader>,",
      "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({previewer=false}))<cr>",
      desc = "Switch buffer"
    },
    {
      "<leader>ss",
      "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find({previewer=false})<cr>",
      desc = "Search buffer"
    },

  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')

    require("telescope").setup({
      defaults = {
        -- Full
        -- layout_strategy = "horizontal",
        -- layout_config = {
        --   horizontal = {
        --     prompt_position = "top",
        --     width = { padding = 0 },
        --     height = { padding = 0 },
        --     preview_width = 0.5,
        --   },
        -- },

        -- Center
        layout_config = {
          height = 0.8,
          width = 0.9,
          prompt_position = "top",
          bottom_pane = {
            height = 0.5,
            preview_width = 0.6,
            preview_cutoff = 120,
          },
          center = {
            height = 0.4,
            preview_cutoff = 40,
          },
          cursor = {
            preview_cutoff = 40,
            preview_width = 0.6,
          },
          horizontal = {
            preview_width = 0.6,
            preview_cutoff = 120,
          },
          vertical = {
            preview_cutoff = 40,
          },
        },

        -- path_display = path_display,
        path_display = { "absolute" },
        sorting_strategy = "ascending",
        prompt_prefix = icons.ui.Telescope .. icons.ui.ChevronRight .. " ",
        selection_caret = icons.ui.Play,
        multi_icon = icons.ui.Check,
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-l>"] = actions.cycle_history_next,
            ["<C-h>"] = actions.cycle_history_prev,

            ["<C-c>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,

            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-g>"] = actions.complete_tag,
          },
          n = {
            ["q"] = actions.close,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,
            ["?"] = actions.which_key,
            ["<esc>"] = actions.close,

            ["<C-c>"] = actions.close,
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,

            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          file_ignore_patterns = { "^node_modules", "^.git/", "^.venv" },
          hidden = true,
        },
        buffers = {
          -- initial_mode = "normal",
          sort_lastused = true,
          -- sort_mru = true,
          mappings = {
            n = {
              ["d"] = actions.delete_buffer,
              ["l"] = actions.select_default,
            },
          },
        },
      },
      live_grep = {
        file_ignore_patterns = { "^node_modules", "^.git/", "^.venv" },
        additional_args = function(_)
          return { "--hidden" }
        end,
      },
      extensions = {
        tmuxinator = {
          select_action = 'switch', -- | 'stop' | 'kill'
          stop_action = 'stop',     -- | 'kill'
          disable_icons = false,
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
      git_files = {
        previewer = false,
      },
    })

    -- Enable telescope fzf native, if installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "remote-sshfs")
  end,
}
