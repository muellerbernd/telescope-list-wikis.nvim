local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    error "This extension requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)"
end

local vw_pickers = require "telescope._extensions.list_wikis.picker"
return telescope.register_extension {
    exports = {
        list_wikis = vw_pickers.wikis
    }
}
