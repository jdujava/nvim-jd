return {
    {
        'mbbill/undotree',
        keys = {
            { 'U', '<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>' },
        },
        config = function()
            vim.g.undotree_WindowLayout = 2
        end
    }
}
