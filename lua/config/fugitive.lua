local keymap = vim.keymap

keymap.set("n", "<leader>gg", "<cmd>Git<cr>", { desc = "status" })
keymap.set("n", "<leader>gS", "<cmd>Gwrite<cr>", { desc = "stage this file" })
keymap.set("n", "<leader>gcc", "<cmd>Git commit<cr>", { desc = "commit" })
keymap.set("n", "<leader>gF", "<cmd>Git pull<cr>", { desc = "fetch" })

-- convert git to Git in command line mode
vim.fn["utils#Cabbrev"]("git", "Git")

keymap.set("n", "<leader>gb", function()
  vim.ui.input({ prompt = "Enter a new branch name" }, function(user_input)
    if user_input == nil or user_input == "" then
      return
    end

    local cmd_str = string.format("G checkout -b %s", user_input)
    vim.cmd(cmd_str)
  end)
end, {
  desc = "Git: create new branch",
})

