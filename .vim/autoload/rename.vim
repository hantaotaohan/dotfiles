function! rename#Rename() abort
    let old_name = expand('%')
    let new_name = input('Rename files name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        try
            execute 'saveas ' . new_name
            call delete(expand('#'))
            execute "bdelete#"
            redraw!
        catch /:E13:/
            echohl ErrorMsg | echo " The file name already exists" | echohl None| redraw
        endtry
    else
        echohl ErrorMsg | echo " Not Changed Filename!" | echohl None| redraw
    endif
endfunction
