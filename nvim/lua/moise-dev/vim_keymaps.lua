-- Define global keymaps, diagnostic navigation, and editing shortcuts.
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex, { desc = "Open file explorer" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({
        count = -1,
        on_jump = function(diagnostic, bufnr)
            if diagnostic then
                vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor" })
            end
        end,
    })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({
        count = 1,
        on_jump = function(diagnostic, bufnr)
            if diagnostic then
                vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor" })
            end
        end,
    })
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Move blocks highlighted up (K) or down (J)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted block up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Concatenate the below line up" })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Save to computer clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Save selected lines to computer clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Save current line to computer clipboard" })

vim.keymap.set("n", "Q", "<nop>")

-- Resize vertical panes
vim.keymap.set("n", "<A-h>", ":vertical resize -5<CR>", { noremap = true, silent = true, desc = "Resize split left" })
vim.keymap.set("n", "<A-l>", ":vertical resize +5<CR>", { noremap = true, silent = true, desc = "Resize split right" })

vim.keymap.set("n", "<A-w>", ":set wrap<CR>", { desc = "[W]ord [w]rap" })
vim.keymap.set("n", "<leader>x", "<cmd>! chmod +x %<CR>", { silent = true, desc = "Make file executable" })
vim.keymap.set("n", "<leader>as", function()
    vim.cmd("AutoSave toggle")
end, { desc = "Toggle AutoSave" })

vim.filetype.add({
    extension = {
        mdx = "markdown",
    },
})

-- Malware Reports
local function next_citation_id(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    for line_index = #lines, 1, -1 do
        local id = lines[line_index]:match('<Cit%s+id="(%d+)"')
        if id then
            return tonumber(id) + 1
        end
    end

    return 1
end

local function add_malware_citation()
    local bufnr = vim.api.nvim_get_current_buf()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local next_id = next_citation_id(bufnr)
    local ref = string.format(' <Ref id="%d"/>', next_id)
    local access_date = vim.fn.strftime("%b %d %Y")
    local citation = string.format(
        '<Cit id="%d" pageName="Microsoft" articleName="function" url="" lastAccessDate="%s" />',
        next_id,
        access_date
    )
    local insert_col = #line == 0 and 0 or math.min(col + 1, #line)

    vim.api.nvim_buf_set_text(bufnr, row - 1, insert_col, row - 1, insert_col, { ref })
    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { citation })
    vim.api.nvim_win_set_cursor(0, { row, insert_col + #ref })
end

vim.keymap.set(
    "n",
    "<leader>ma",
    'i<CustAside variant="answer">\n</CustAside><Esc>',
    { noremap = true, silent = true, desc = "Astro Answer" }
)

vim.keymap.set(
    "n",
    "<leader>mb",
    'a <Ref id="x"/><Esc>',
    { noremap = true, silent = true, desc = "Astro BackReference" }
)

vim.keymap.set("n", "<leader>mc", add_malware_citation, { noremap = true, silent = true, desc = "Astro Citation" })

vim.keymap.set(
    "n",
    "<leader>mq",
    'i<CustAside variant="question">\n</CustAside><Esc>',
    { noremap = true, silent = true, desc = "Astro Question" }
)

vim.keymap.set(
    "n",
    "<leader>mm",
    'i<Cit id="" pageName="Microsoft" articleName="function" url="" lastAccessDate="xxx xx 2026" /> <Esc>',
    { noremap = true, silent = true, desc = "Astro Cit Microsoft" }
)

vim.keymap.set("n", "<leader>mr", "a → ", { noremap = true, silent = true, desc = "Astro Arrow" })

vim.keymap.set(
    "n",
    "<leader>mt",
    'i<CustAside variant="tip">\n</CustAside><Esc>',
    { noremap = true, silent = true, desc = "Astro Tip" }
)
