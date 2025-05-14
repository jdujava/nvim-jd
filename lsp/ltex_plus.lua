return {
    enabled = true,
    autostart = false, -- manually by ltex_extra keybinding
    settings = {
        ltex = {
            checkFrequency = 'save',
            latex = {
                commands = { -- https://valentjn.github.io/ltex/settings.html#ltexlatexcommands
                    ['\\texorpdfstring{}{}'] = 'dummy',
                    ['\\si{}'] = 'dummy',
                    ['\\SI{}'] = 'dummy',
                    ['\\SI{}{}'] = 'dummy',
                    ['\\QFT{}'] = 'dummy',
                    ['\\CFT{}'] = 'dummy',
                    ['\\AdS{}'] = 'vowelDummy',
                    ['\\AdSCFT{}'] = 'vowelDummy',
                    ['\\ldots{}'] = 'dummy',
                    ['\\includesvg[]{}'] = 'ignore',
                    ['\\hreflocal{}{}'] = 'ignore',
                    ['\\Cref*{}'] = 'dummy',
                },
                -- rules = {}, -- https://community.languagetool.org/rule/list?lang=en
            },
        },
    },
}
