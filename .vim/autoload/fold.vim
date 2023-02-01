function! fold#NeatFoldText() abort
    let line = ' █    ' . substitute(getline(v:foldstart), '\s* \{2,}s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '  █  ' . printf("%12s", lines_count . ' LINES') . '     █ '
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart(' ⭕  INFORMATION  ⭕  █ ' . repeat(foldchar, v:foldlevel*6) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 0)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextend . foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength)
endfunction
