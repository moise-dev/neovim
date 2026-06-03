-- AutoSave toggleable implementation for Neovim

-- State variable
local autosave_enabled = true

-- Function to (re)register or remove the autosave autocommand
local function set_autosave(state, opts)
    opts = opts or {}
    autosave_enabled = state
    if state then
        vim.api.nvim_create_augroup("AutoSave", { clear = true })
        vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "TextChangedP" }, {
            group = "AutoSave",
            callback = function()
                local has_file = vim.api.nvim_buf_get_name(0) ~= ""
                if has_file and vim.bo.buftype == "" and vim.bo.modifiable and not vim.bo.readonly then
                    vim.cmd("silent! update")
                end
            end,
        })
        if opts.notify ~= false then
            vim.notify("AutoSave enabled", vim.log.levels.INFO)
        end
    else
        pcall(vim.api.nvim_del_augroup_by_name, "AutoSave")
        if opts.notify ~= false then
            vim.notify("AutoSave disabled", vim.log.levels.WARN)
        end
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

set_autosave(true, { notify = false })
