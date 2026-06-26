local setup = require("util").setup_language
vim.pack.add({ "https://github.com/nvim-orgmode/orgmode" })

-- Setup orgmode
require("orgmode").setup({
  org_agenda_files = "~/org/gtd/*",
  org_default_notes_file = "~/org/inbox.org",
  org_todo_keywords = { "TODO", "DOING", "WAITING", "|", "DONE", "DELEGATED" },
  org_todo_keyword_faces = {
    WAITING = ":foreground blue :weight bold",
    DELEGATED = ":background #FFFFFF :slant italic :underline on",
    -- TODO = ":background #000000 :foreground red", -- overrides builtin color for `TODO` keyword
  },
  win_split_mode = "float",
  win_border = "rounded",
  org_agenda_skip_deadline_if_done = true,
  org_agenda_skip_scheduled_if_done = true,
  org_agenda_hide_empty_blocks = true,
  org_tags_exclude_from_inheritance = { "ignore_heading" },
  org_agenda_custom_commands = {
    o = {
      description = "Overview",
      types = {
        {
          type = "tags_todo",
          org_agenda_overriding_header = "OVERDUE",
          org_agenda_todo_ignore_deadlines = "future",
        },
        {
          type = "agenda",
          org_agenda_overriding_header = "Week overview",
          org_agenda_span = "week",
          org_agenda_start_on_weekday = 1,
          org_agenda_remove_tags = true,
        },
        {
          type = "tags_todo",
          org_agenda_overriding_header = "Next",
          org_agenda_tag_filter_preset = "next",
        },
        {
          type = "tags",
          org_agenda_overriding_header = "Consume",
          org_agenda_tag_filter_preset = "consume-ignore_heading",
          org_agenda_sorting_strategy = { "tag-up" },
        },
      },
    },
  },
  org_capture_templates = {
    t = {
      description = "Task",
      template = "* TODO %?",
      target = "~/org/inbox.org",
    },
    p = {
      description = "Project",
      template = "** %?",
      target = "~/org/gtd/projects.org",
      headline = "inactive",
    },
    e = {
      description = "Event",
      subtemplates = {
        r = {
          description = "Recurring",
          template = "** TODO %?\n DEADLINE: %t",
          target = "~/org/gtd/calendar.org",
          headline = "recurring",
        },
        o = {
          description = "One-time",
          template = "** %?\n %T",
          target = "~/org/gtd/calendar.org",
          headline = "one-time",
        },
      },
    },
  },
})

-- Experimental LSP support
vim.lsp.enable("org")

setup({
  filetype = { "org" },
  completion_sources = { name = "orgmode" },
  completion_providers = {
    orgmode = {
      name = "Orgmode",
      module = "orgmode.org.autocompletion.blink",
      fallbacks = { "buffer" },
    },
  },
})
