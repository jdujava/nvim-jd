" Inpiration: Christian Chiarulli <chrisatmachine@gmail.com>
" Maintainer: Jonas Dujava

set background=dark
let g:colors_name='noice'

hi  Normal           guifg=#abb2bf ctermfg=249  guibg=NONE    ctermbg=234  gui=NONE         cterm=NONE
hi  Comment          guifg=#608b4e ctermfg=65   guibg=NONE    ctermbg=NONE gui=italic       cterm=italic
hi  Constant         guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  String           guifg=#ce9178 ctermfg=174  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Character        guifg=#ce9178 ctermfg=174  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Number           guifg=#b5cea8 ctermfg=151  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Boolean          guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Float            guifg=#b5cea8 ctermfg=151  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Identifier       guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Function         guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Statement        guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Conditional      guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Repeat           guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Label            guifg=#9cdcfe ctermfg=153  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Operator         guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Keyword          guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Exception        guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  PreProc          guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Include          guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Define           guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Title            guifg=#4ec9b0 ctermfg=79   guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Macro            guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  PreCondit        guifg=#9cdcfe ctermfg=153  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Type             guifg=#9cdcfe ctermfg=153  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  StorageClass     guifg=#9cdcfe ctermfg=153  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Structure        guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Typedef          guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Special          guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  SpecialComment   guifg=#5c6370 ctermfg=241  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Error            guifg=#f44747 ctermfg=203  guibg=NONE    ctermbg=NONE gui=bold,reverse cterm=bold,reverse
hi  Todo             guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=bold,italic  cterm=bold,italic
hi  Underlined       guifg=#4ec9b0 ctermfg=79   gui=underline cterm=underline
hi  Cursor           guifg=#515052 ctermfg=239  guibg=#aeafad ctermbg=145  gui=NONE         cterm=NONE
hi  TermCursor       guifg=#1e1e1e ctermfg=0    guibg=#add8e6 ctermbg=15   gui=NONE         cterm=NONE
hi  ColorColumn      guifg=NONE    ctermfg=NONE guibg=#2c323c ctermbg=236  gui=NONE         cterm=NONE
hi  CursorLineNr     guifg=#abb2bf ctermfg=249  guibg=NONE    ctermbg=NONE gui=bold         cterm=bold
hi  SignColumn       guifg=NONE    ctermfg=NONE guibg=#1e1e1e ctermbg=234  gui=NONE         cterm=NONE
"hi Conceal          guifg=#5c6370 ctermfg=241  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi! link             Conceal       Special
hi  CursorColumn     guifg=NONE    ctermfg=NONE guibg=#2c323c ctermbg=236  gui=NONE         cterm=NONE
hi  CursorLine       guifg=NONE    ctermfg=NONE guibg=#2c323c ctermbg=236  gui=NONE         cterm=NONE
hi  Directory        guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  DiffAdd          guifg=#1e1e1e ctermfg=234  guibg=#608b4e ctermbg=65   gui=NONE         cterm=NONE
hi  DiffChange       guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  DiffDelete       guifg=#1e1e1e ctermfg=234  guibg=#d16969 ctermbg=167  gui=NONE         cterm=NONE
hi  DiffText         guifg=#1e1e1e ctermfg=234  guibg=#dcdcaa ctermbg=187  gui=NONE         cterm=NONE
hi  ErrorMsg         guifg=#f44747 ctermfg=203  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  VertSplit        guifg=#3e4452 ctermfg=238  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Folded           guifg=#268bd2 ctermfg=NONE guibg=#073642 ctermbg=19
hi  FoldColumn       guifg=NONE    ctermfg=NONE guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  IncSearch        guifg=none    ctermfg=187  guibg=#343434 ctermbg=241  gui=underline    cterm=underline
hi  LineNr           guifg=#64636d ctermfg=240  guibg=NONE    ctermbg=NONE gui=bold         cterm=bold
hi  LineNrAbove      guifg=#4b5263 ctermfg=240  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  LineNrBelow      guifg=#4b5263 ctermfg=240  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  NonText          guifg=#3b4048 ctermfg=238  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  Pmenu            guifg=#abb2bf ctermfg=249  guibg=#202020 ctermbg=236  gui=NONE         cterm=NONE
hi  PmenuSel         guifg=#dbd2df ctermfg=234  guibg=#323232 ctermbg=74   gui=NONE         cterm=NONE
hi  PmenuSbar        guifg=#dbd2df ctermfg=NONE guibg=#202020 ctermbg=238  gui=NONE         cterm=NONE
hi  PmenuThumb       guifg=NONE    ctermfg=NONE guibg=#abb2bf ctermbg=249  gui=NONE         cterm=NONE
hi  Question         guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  QuickFixLine     guifg=#1e1e1e ctermfg=234  guibg=#dcdcaa ctermbg=187  gui=NONE         cterm=NONE
hi  Search           guifg=none    ctermfg=234  guibg=#343434 ctermbg=187  gui=underline    cterm=underline
hi  SpecialKey       guifg=#3b4048 ctermfg=238  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  SpellBad         guifg=#f44747 ctermfg=203  guibg=NONE    ctermbg=NONE gui=underline    cterm=underline
hi  SpellCap         guifg=#d7ba7d ctermfg=180  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  SpellLocal       guifg=#d7ba7d ctermfg=180  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  SpellRare        guifg=#d7ba7d ctermfg=180  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  StatusLine       guifg=#abb2bf ctermfg=249  guibg=#282c34 ctermbg=236  gui=NONE         cterm=NONE
hi  StatusLineNC     guifg=#5c6370 ctermfg=241  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  StatusLineTerm   guifg=#abb2bf ctermfg=249  guibg=#282c34 ctermbg=236  gui=NONE         cterm=NONE
hi  StatusLineTermNC guifg=#2c323c ctermfg=236  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  TabLine          guifg=#5c6370 ctermfg=241  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  TabLineSel       guifg=#abb2bf ctermfg=249  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  TabLineFill      guifg=NONE    ctermfg=NONE guibg=#1e1e1e ctermbg=234  gui=NONE         cterm=NONE
hi  Terminal         guifg=#abb2bf ctermfg=249  guibg=#1e1e1e ctermbg=234  gui=NONE         cterm=NONE
hi  Visual           guifg=NONE    ctermfg=NONE guibg=#3e4452 ctermbg=238  gui=NONE         cterm=NONE
hi  VisualNOS        guifg=#3e4452 ctermfg=238  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  WarningMsg       guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi  WildMenu         guifg=#1e1e1e ctermfg=234  guibg=#569cd6 ctermbg=74   gui=NONE         cterm=NONE
hi  EndOfBuffer      guifg=#1e1e1e ctermfg=234  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE

hi TSComment            guifg=#608b4e ctermfg=65   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSError              guifg=#f44747 ctermfg=203  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSPunctDelimiter     guifg=#abb2bf ctermfg=249  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSPunctBracket       guifg=#abb2bf ctermfg=249  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSPunctSpecial       guifg=#abb2bf ctermfg=249  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSConstant           guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSConstBuiltin       guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSConstMacro         guifg=#4ec9b0 ctermfg=79   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSStringRegex        guifg=#ce9178 ctermfg=174  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSString             guifg=#ce9178 ctermfg=174  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSStringEscape       guifg=#d7ba7d ctermfg=180  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSCharacter          guifg=#ce9178 ctermfg=174  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSNumber             guifg=#b5cea8 ctermfg=151  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSBoolean            guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSFloat              guifg=#b5cea8 ctermfg=151  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSAnnotation         guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSAttribute          guifg=#4ec9b0 ctermfg=79   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSNamespace          guifg=#4ec9b0 ctermfg=79   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSFuncBuiltin        guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSFunction           guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSFuncMacro          guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSParameter          guifg=#9cdcfe ctermfg=153  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSParameterReference guifg=#9cdcfe ctermfg=153  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSMethod             guifg=#dcdcaa ctermfg=187  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSField              guifg=#9cdcfe ctermfg=153  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSProperty           guifg=#9cdcfe ctermfg=153  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSConstructor        guifg=#4ec9b0 ctermfg=79   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSConditional        guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSRepeat             guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSLabel              guifg=#9cdcfe ctermfg=153  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSKeyword            guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSKeywordFunction    guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSKeywordOperator    guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSOperator           guifg=#abb2bf ctermfg=249  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSException          guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSType               guifg=#4ec9b0 ctermfg=79   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSTypeBuiltin        guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSStructure          guifg=#ff00ff ctermfg=201  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSInclude            guifg=#c586c0 ctermfg=175  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSVariable           guifg=#9cdcfe ctermfg=153  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSVariableBuiltin    guifg=#9cdcfe ctermfg=153  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSText               guifg=#ffff00 ctermfg=226  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSStrong             guifg=#ffff00 ctermfg=226  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSEmphasis           guifg=#ffff00 ctermfg=226  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSUnderline          guifg=#ffff00 ctermfg=226  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSTitle              guifg=#ffff00 ctermfg=226  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSLiteral            guifg=#ce9178 ctermfg=174  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSURI                guifg=NONE    ctermfg=NONE guibg=NONE    ctermbg=NONE gui=underline cterm=underline
hi TSTag                guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSTagDelimiter       guifg=#5c6370 ctermfg=241  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSQueryLinterError   guifg=#ff8800 ctermfg=208  guibg=NONE    ctermbg=NONE gui=NONE      cterm=NONE
hi TSDefinition         guifg=NONE    ctermfg=NONE guibg=#2f2f2f ctermbg=187  gui=underline cterm=underline
hi TSDefinitionUsage    guifg=NONE    ctermfg=NONE guibg=#2f2f2f ctermbg=238  gui=NONE      cterm=NONE

hi htmlArg            guifg=#d7ba7d ctermfg=180 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlBold           guifg=#d7ba7d ctermfg=180 guibg=NONE ctermbg=NONE gui=bold      cterm=bold
hi htmlEndTag         guifg=#abb2bf ctermfg=249 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlH1             guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlH2             guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlH3             guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlH4             guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlH5             guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlH6             guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlItalic         guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=italic    cterm=italic
hi htmlLink           guifg=#4ec9b0 ctermfg=79  guibg=NONE ctermbg=NONE gui=underline cterm=underline
hi htmlSpecialChar    guifg=#d7ba7d ctermfg=180 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlSpecialTagName guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlTag            guifg=#abb2bf ctermfg=249 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlTagN           guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlTagName        guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi htmlTitle          guifg=#abb2bf ctermfg=249 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE

hi markdownBlockquote        guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownBold              guifg=#d7ba7d ctermfg=180 guibg=NONE ctermbg=NONE gui=bold      cterm=bold
hi markdownCode              guifg=#608b4e ctermfg=65  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownCodeBlock         guifg=#608b4e ctermfg=65  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownCodeDelimiter     guifg=#608b4e ctermfg=65  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownH1                guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownH2                guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownH3                guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownH4                guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownH5                guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownH6                guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownHeadingDelimiter  guifg=#d16969 ctermfg=167 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownHeadingRule       guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownId                guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownIdDeclaration     guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownIdDelimiter       guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownItalic            guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=italic    cterm=italic
hi markdownLinkDelimiter     guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownLinkText          guifg=#569cd6 ctermfg=74  guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownListMarker        guifg=#d16969 ctermfg=167 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownOrderedListMarker guifg=#d16969 ctermfg=167 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownRule              guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE      cterm=NONE
hi markdownUrl               guifg=#4ec9b0 ctermfg=79  guibg=NONE ctermbg=NONE gui=underline cterm=underline

hi MatchWord       guifg=NONE    ctermfg=NONE guibg=NONE    ctermbg=NONE gui=underline    cterm=underline
hi MatchParen      guifg=NONE    ctermfg=NONE guibg=NONE    ctermbg=NONE gui=underline    cterm=underline
hi MatchWordCur    guifg=NONE    ctermfg=NONE guibg=NONE    ctermbg=NONE gui=underline    cterm=underline
hi MatchParenCur   guifg=NONE    ctermfg=NONE guibg=NONE    ctermbg=NONE gui=underline    cterm=underline
hi diffAdded       guifg=#608b4e ctermfg=65   guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi diffRemoved     guifg=#d16969 ctermfg=167  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi diffFileId      guifg=#569cd6 ctermfg=74   guibg=NONE    ctermbg=NONE gui=bold,reverse cterm=bold,reverse
hi diffFile        guifg=#3b4048 ctermfg=238  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi diffNewFile     guifg=#608b4e ctermfg=65   guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi diffOldFile     guifg=#d16969 ctermfg=167  guibg=NONE    ctermbg=NONE gui=NONE         cterm=NONE
hi debugPc         guifg=NONE    ctermfg=NONE guibg=#4ec9b0 ctermbg=79   gui=NONE         cterm=NONE
hi debugBreakpoint guifg=#d16969 ctermfg=167  guibg=NONE    ctermbg=NONE gui=reverse      cterm=reverse

" hi LspDiagnosticsUnderlineHint guifg=#729cb3 ctermfg=73 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiagnosticError guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiagnosticWarn  guifg=#ff8800 ctermfg=208 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiagnosticInfo  guifg=#ffcc66 ctermfg=221 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi DiagnosticHint  guifg=#9cdcfe ctermfg=75  guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
sign define DiagnosticSignError text=󰜺 texthl=DiagnosticError linehl= numhl=
sign define DiagnosticSignWarn  text=󱈸 texthl=DiagnosticWarn  linehl= numhl=
sign define DiagnosticSignInfo  text=󰋽 texthl=DiagnosticInfo  linehl= numhl=
sign define DiagnosticSignHint  text=󰛩 texthl=DiagnosticHint  linehl= numhl=
    " ERROR = "",
    " WARN = "",
    " INFO = "",
    " HINT = "",

hi QuickScopePrimary   guifg='#5fffff' gui=underline,bold ctermfg=81    cterm=underline
hi QuickScopeSecondary guifg='#afff5f' gui=underline,bold ctermfg=155   cterm=underline
hi Floaterm            guibg=NONE
" hi FloatermBorder      guibg=#202020   guifg=#252525
hi link FloatermBorder Normal
hi Yank                guifg=none      ctermfg=234        guibg=#343434 ctermbg=187 gui=NONE cterm=NONE

" Completition - cmp.nvim
hi CmpGhostText guifg=#767676 ctermfg=65   guibg=NONE    ctermbg=NONE
hi link CmpItemAbbr CmpGhostText
" hi  CmpItemAbbr            guifg=#abb2bf ctermfg=249  guibg=#282c34 ctermbg=236  gui=italic		cterm=NONE
hi  CmpItemAbbrMatch           guifg=#dbe2ef ctermfg=249  guibg=NONE    ctermbg=234  gui=NONE         cterm=NONE
hi CmpItemAbbrDeprecated gui=underline
" hi CmpItemAbbrDeprecated guifg='#ff0000'
" hi link CmpItemKind TSComment
" hi CmpItemMenu guifg='#ff0000'
highlight! CmpBorderedWindow_Normal guibg=#202020
" highlight! CmpBorderedWindow_CursorLine guibg=#323232
highlight! CmpBorderedWindow_CursorLine guibg=#252525 gui=bold
highlight! CmpBorderedWindow_FloatBorder guibg=#1e1e1e

highlight! CmpItemKindDefault guibg=NONE guifg=#569cd6
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKind guibg=NONE guifg=#569cd6


" hi texCmd ctermfg=1
" hi texArg ctermfg=140
" hi texOpt ctermfg=140

" hi texCmdParts ctermfg=140
" hi texPartArgTitle ctermfg=140
" hi texCmdTitle ctermfg=140
" hi texCmdAuthor ctermfg=140
" hi texTitleArg ctermfg=140
" hi texAuthorArg ctermfg=140
" hi texFootnoteArg ctermfg=140

" environments
" hi texCmdEnv ctermfg=12
hi texEnvArgName ctermfg=4
" hi texEnvOpt ctermfg=140

" hi texMathZone ctermfg=12
" hi texMathDelim ctermfg=12
" hi texMathDelimZone ctermfg=12
" hi texMathCmd ctermfg=12
" hi texMathCmdEnv ctermfg=12
" hi texMathCmdEnvArgName ctermfg=4
" hi texCmdMathText ctermfg=140
" hi! link texCmdMathEnv  texMathCmdEnv
hi texMathEnvArgName ctermfg=4
