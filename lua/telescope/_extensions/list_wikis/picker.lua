local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local state = require("telescope.actions.state")
local conf = require("telescope.config").values
local M = {}

M.wikis = function(opts)
    opts = opts or {}

    local wiki_tbl = vim.api.nvim_eval("g:mywiki_list")

    print(vim.inspect(wiki_tbl))
    if vim.tbl_isempty(wiki_tbl) then
        print("returned")
        return
    end

    -- print(vim.inspect(wiki_tbl))
    local wiki_formatted = {}

    for k, v in pairs(wiki_tbl) do
        -- print(k, v["path"])
        local current_wiki = v["path"]
        table.insert(wiki_formatted, current_wiki)
    end

    -- print(vim.inspect(wiki_formatted))
    pickers
        .new(opts, {
            prompt_title = "My-Wikis",
            finder = finders.new_table({
                results = wiki_formatted,
            }),
            sorter = sorters.get_generic_fuzzy_sorter(),
            -- previewer = conf.grep_previewer(opts),
            -- previewer = {
            --     conf.file_previewer(opts)
            -- },
            attach_mappings = function(prompt_bufnr, map)
                local open_wiki = function()
                    actions.close(prompt_bufnr)
                    local selection = state.get_selected_entry(prompt_bufnr)

                    local wiki_name = wiki_formatted[selection.index]

                    local command = ":e " .. wiki_name .. ""
                    vim.api.nvim_exec(command, false)
                end

                map("i", "<CR>", open_wiki)
                map("n", "<CR>", open_wiki)

                return true
            end,
        })
        :find()
end

-- M.wikis()

return M
