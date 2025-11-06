-- AutoSave toggleable implementation for Neovim

-- State variable
local autosave_enabled = true

-- Function to (re)register or remove the autosave autocommand
local function set_autosave(state)
    autosave_enabled = state
    if state then
        vim.api.nvim_create_augroup("AutoSave", { clear = true })
        vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "TextChangedP" }, {
            group = "AutoSave",
            callback = function()
                if vim.bo.modifiable and not vim.bo.readonly then
                    vim.cmd("silent! update")
                end
            end,
        })
        vim.notify("AutoSave enabled", vim.log.levels.INFO)
    else
        vim.api.nvim_del_augroup_by_name("AutoSave")
        vim.notify("AutoSave disabled", vim.log.levels.WARN)
    end
end

-- Commands :AutoSave on / off / toggle
vim.api.nvim_create_user_command("AutoSave", function(opts)
    local arg = opts.args:lower()
    if arg == "on" then
        set_autosave(true)
    elseif arg == "off" then
        set_autosave(false)
    elseif arg == "toggle" or arg == "" then
        set_autosave(not autosave_enabled)
    else
        vim.notify("Usage: :AutoSave [on|off|toggle]", vim.log.levels.ERROR)
    end
end, { nargs = "?" })

-- Keymap <leader>as to toggle AutoSave
vim.keymap.set("n", "<leader>as", function()
    vim.cmd("AutoSave toggle")
end, { desc = "Toggle AutoSave" })

set_autosave(true)
