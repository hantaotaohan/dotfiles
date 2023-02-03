" --------------------------------------------------------------o----------------------------------------------------------------o
" 自定义颜色
" --------------------------------------------------------------o----------------------------------------------------------------o

    let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

" --------------------------------------------------------------o----------------------------------------------------------------o
    let s:p.tabline.left   = [ [ '#ABB2BF', '#5A6378' ] ]
    let s:p.tabline.tabsel = [ [ '#E4EBFF', '#3E4452' ] ]
    let s:p.tabline.middle = [ [ '#959CA9', '#2C323D' ] ]
    let s:p.tabline.right  = [ [ '#ABB2BF', '#5A6378' ], [ '#ABB2BF', '#3E4452', 'bold' ] ]
    " let s:p.tabline.right  = [ [ '#282C34', '#98c379' ], [ '#ABB2BF', '#3E4452', 'bold' ] ]

" --------------------------------------------------------------o----------------------------------------------------------------o
    let s:p.normal.left   = [ 
                \ [ '#282C34', '#98C379' ],
                \ [ '#282C34', '#5A6378' ],
                \ [ '#ABB2BF', '#3E4452' ],
                \ [ '#7D828C', '#2C323C' ],
                \ ]

    let s:p.normal.middle = [ 
                \ [ '#ABB2BF', '#2C323C' ],
                \ ]

    let s:p.normal.right  = [ 
                \ [ '#282C34', '#98C379' ],
                \ [ '#ABB2BF', '#3E4452' ],
                \ [ '#7D828C', '#2F3541' ],
                \ [ '#7D828C', '#2C323C' ],
                \ [ '#C678DD', '#2C323C' ],
                \ [ '#E5C07B', '#2C323C' ], 
                \ ]
" --------------------------------------------------------------o----------------------------------------------------------------o
    let s:p.insert.left   = [ 
                \ [ '#282C34', '#61AFEF' ],
                \ [ '#282C34', '#5A6378' ],
                \ [ '#ABB2BF', '#3E4452' ],
                \ [ '#7EBCEF', '#2C323C' ], 
                \ ]

    let s:p.insert.right  = [ 
                \ [ '#282C34', '#61AFEF' ],
                \ [ '#ABB2BF', '#3E4452' ],
                \ [ '#7D828C', '#2F3541' ],
                \ [ '#7D828C', '#2C323C' ],
                \ [ '#C678DD', '#2C323C' ],
                \ [ '#7D828C', '#2C323C' ], 
                \ ]
" --------------------------------------------------------------o----------------------------------------------------------------o
    let s:p.visual.left   = [ 
                \ [ '#282C34', '#C678DD' ],
                \ [ '#282C34', '#5A6378' ],
                \ [ '#ABB2BF', '#3E4452' ],
                \ [ '#C678DD', '#2C323C' ], 
                \ ]

    let s:p.visual.right  = [ 
                \ [ '#282C34', '#C678DD' ],
                \ [ '#ABB2BF', '#3E4452' ],
                \ [ '#7D828C', '#2F3541' ],
                \ [ '#7D828C', '#2C323C' ],
                \ [ '#C678DD', '#2C323C' ],
                \ [ '#7D828C', '#2C323C' ], 
                \ ]
" --------------------------------------------------------------o----------------------------------------------------------------o
    let s:p.replace.left   = [ 
                \ [ '#282C34', '#E06C75' ],
                \ [ '#282C34', '#5A6378' ],
                \ [ '#ABB2BF', '#3E4452' ],
                \ [ '#E06C75', '#2C323C' ], 
                \ ]

    let s:p.replace.right  = [ 
                \ [ '#282C34', '#E06C75' ],
                \ [ '#ABB2BF', '#3E4452' ],
                \ [ '#7D828C', '#2F3541' ],
                \ [ '#7D828C', '#2C323C' ],
                \ [ '#C678DD', '#2C323C' ],
                \ [ '#7D828C', '#2C323C' ], 
                \ ]
" --------------------------------------------------------------o----------------------------------------------------------------o
    let s:p.inactive.left   = [ 
                \ [ '#25282C', '#3E4452' ],
                \ [ '#536C70', '#2C323D' ],
                \ [ '#536C70', '#2C323D' ],
                \ [ '#536C70', '#2C323D' ],
                \ [ '#536C70', '#2C323D' ], 
                \ ]

    let s:p.inactive.middle = [ 
                \ [ '#2C323D', '#2C323D' ],
                \ ]

    let s:p.inactive.right  = [ 
                \ [ '#25282C', '#3E4452' ],
                \ [ '#536C70', '#2C323D' ],
                \ [ '#536C70', '#2C323D' ],
                \ [ '#536C70', '#2C323D' ],
                \ [ '#536C70', '#2C323D' ],
                \ [ '#3E4452', '#3E4452' ], 
                \ ]

    let g:lightline#colorscheme#one#palette = lightline#colorscheme#fill(s:p)
