local icons = require('core/icons')

return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = {
    "BufferLinePick",
    "BufferLineCycleNext",
    "BufferLineCyclePrev"
  },
  keys = {
    { "<leader>bP",  "<cmd>BufferLinePick<cr>",       desc = "Bufferline Pick" },
    { "<leader>bn",  "<cmd>:BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<leader>bp",  "<cmd>:BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    { "<A-D-Right>", "<cmd>:BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<A-D-Left>",  "<cmd>:BufferLineCyclePrev<cr>", desc = "Previous buffer" },
  },
  opts = {
    options = {
      numbers = "none",
      close_command = "bdelete! %d",
      right_mouse_command = nil,
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,
      indicator = {
        icon = "▎",
        style = "icon",
      },
      buffer_close_icon = icons.ui.Close,
      modified_icon = icons.ui.CircleSmall,
      close_icon = icons.ui.Close,
      left_trunc_marker = icons.ui.ArrowLeft,
      right_trunc_marker = icons.ui.ArrowRight,
      max_name_length = 18,
      max_prefix_length = 15,
      tab_size = 10,
      diagnostics = false,
      custom_filter = function(bufnr)
        local exclude_ft = { "qf", "fugitive", "git" }
        local cur_ft = vim.bo[bufnr].filetype
        local should_filter = vim.tbl_contains(exclude_ft, cur_ft)

        if should_filter then
          return false
        end

        return true
      end,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true,
      separator_style = "bar",
      enforce_regular_tabs = false,
      always_show_bufferline = false,
      sort_by = "id",
    },
  },
}
