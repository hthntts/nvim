local map = vim.keymap.set

map("n", "<leader>gg", "<cmd>Git<cr>", { desc = "Status" })
map("n", "<leader>gS", "<cmd>Gwrite<cr>", { desc = "Stage this file" })
map("n", "<leader>gcc", "<cmd>Git commit<cr>", { desc = "Commit" })
map("n", "<leader>gF", "<cmd>Git pull<cr>", { desc = "Fetch" })

-- convert git to Git in command line mode
vim.fn["utils#Cabbrev"]("git", "Git")

map("n", "<leader>gcb", function()
  vim.ui.input({ prompt = "Enter a new branch name" }, function(user_input)
    if user_input == nil or user_input == "" then
      return
    end

    local cmd_str = string.format("G checkout -b %s", user_input)
    vim.cmd(cmd_str)
  end)
end, {
  desc = "Branch",
})

