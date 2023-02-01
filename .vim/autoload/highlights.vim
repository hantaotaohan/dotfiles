function! highlights#SystemHighlights() abort
    highlight Search            term=standout  cterm=bold  ctermfg=235  ctermbg=204  guifg=#282C34  guibg=#E06C75 
    highlight IncSearch         term=standout  cterm=bold  ctermfg=1    ctermbg=1    guifg=#282C34  guibg=#E06C75 
    highlight Folded            term=standout  cterm=bold  ctermfg=0    ctermbg=5    guifg=#282c34  guibg=#E0AF68 
    highlight FoldColumn        term=standout  cterm=bold  ctermfg=0    ctermbg=5    guifg=#ABB2BF  guibg=#282C34 
    highlight QuickFixLine      term=standout  cterm=bold  ctermfg=235  ctermbg=180  guifg=#ABB2BF  guibg=#282C34 
    highlight SignColumn        term=standout  cterm=bold  ctermfg=2    ctermbg=2    guifg=#E06C75  guibg=#282C34 
    highlight DiffDelete        term=standout  cterm=bold  ctermfg=235  ctermbg=204  guifg=#E06C75  guibg=#E06C75 
    highlight CursorLineNr      term=standout  cterm=bold  ctermfg=145  ctermbg=236  guifg=#61AFEF  guibg=#282C34 
    highlight Cursor            term=standout  cterm=bold  ctermfg=0    ctermbg=7    guifg=#282C34  guibg=#ABB2BF 
    highlight NonText                          cterm=bold  ctermfg=0    ctermbg=0    guifg=#282C34  guibg=#282C34 
    highlight Normal                                                                                guibg=NONE    
    highlight LineNr                                                                                guibg=NONE    
    highlight VertSplit         term=reverse   cterm=bold  ctermfg=59   ctermbg=0    guifg=#3E4452  guibg=#282C34 
    highlight StatusLineNC      term=reverse   cterm=bold  ctermfg=59   ctermbg=0    guifg=#3E4452  guibg=#282C34 
endfunction  
