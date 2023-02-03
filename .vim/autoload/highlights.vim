function! highlights#SystemHighlights() abort
    highlight Search            TERM=STANDOUT  CTERM=BOLD  CTERMFG=235  CTERMBG=204  GUIFG=#282C34  GUIBG=#E06C75 
    highlight IncSearch         TERM=STANDOUT  CTERM=BOLD  CTERMFG=1    CTERMBG=1    GUIFG=#282C34  GUIBG=#E06C75 
    highlight Folded            TERM=STANDOUT  CTERM=BOLD  CTERMFG=0    CTERMBG=5    GUIFG=#282C34  GUIBG=#E0AF68 
    highlight FoldColumn        TERM=STANDOUT  CTERM=BOLD  CTERMFG=0    CTERMBG=5    GUIFG=#ABB2BF  GUIBG=#282C34 
    highlight QuickFixLine      TERM=STANDOUT  CTERM=BOLD  CTERMFG=235  CTERMBG=180  GUIFG=#ABB2BF  GUIBG=#282C34 
    highlight SignColumn        TERM=STANDOUT  CTERM=BOLD  CTERMFG=2    CTERMBG=2    GUIFG=#E06C75  GUIBG=#282C34 
    highlight DiffDelete        TERM=STANDOUT  CTERM=BOLD  CTERMFG=235  CTERMBG=204  GUIFG=#E06C75  GUIBG=#E06C75 
    highlight CursorLineNr      TERM=STANDOUT  CTERM=BOLD  CTERMFG=145  CTERMBG=236  GUIFG=#61AFEF  GUIBG=#282C34 
    highlight Cursor            TERM=STANDOUT  CTERM=BOLD  CTERMFG=0    CTERMBG=7    GUIFG=#282C34  GUIBG=#ABB2BF 
    highlight NonText                          CTERM=BOLD  CTERMFG=0    CTERMBG=0    GUIFG=#282C34  GUIBG=#282C34 
    highlight Normal                                                                                GUIBG=NONE    
    highlight LineNr            TERM=STANDOUT  CTERM=BOLD  CTERMFG=145  CTERMBG=236  GUIFG=#59606D  GUIBG=#282C34
    highlight VertSplit         TERM=REVERSE   CTERM=BOLD  CTERMFG=59   CTERMBG=0    GUIFG=#3E4452  GUIBG=#282C34 
    highlight StatusLineNC      TERM=REVERSE   CTERM=BOLD  CTERMFG=59   CTERMBG=0    GUIFG=#3E4452  GUIBG=#282C34 
endfunction  
