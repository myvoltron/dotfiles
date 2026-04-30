return {
  {
    "stevearc/oil.nvim",
    keys = {
      {
        "-",
        "<cmd>Oil<cr>",
        desc = "Open parent directory with Oil",
      },
    },
    opts = {
      -- neo-tree를 메인 explorer로 유지하기 위해 false
      default_file_explorer = false,

      columns = {
        "icon",
      },

      view_options = {
        show_hidden = true,
      },

      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,
    },
  },
}
