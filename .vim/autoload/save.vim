function! save#Save() abort 
    let cantSave = "redraw | echohl ErrorMsg | echo \"Can't save the file: \" . v:exception | return | echohl None"
    let notSaved = "redraw | echohl ErrorMsg | echo 'This buffer was NOT saved!' | return | echohl None"
    let time = strftime("%T")
    let file = expand('%:P')
    let permissions = getfperm(file)
        try
            silent w
        catch /:E45:\|:E505:\|:E212:/
            if (confirm("This Buffer is read only! Wanna save it anyway?", "&Yes\n&No", 2)==1)
                redraw
                try | silent w! | catch /:E212:/ |
                    if (confirm("Can't open the file, do you want to save it as Root?", "&Yes\n&No", 2)==1)
                        try | execute 'silent! write !sudo tee % >/dev/null' | edit! | catch | exe cantSave | endtry
                    else
                        exe notSaved
                    endif
                catch
                    exe cantSave
                endtry
            else
                exe notSaved
            endif
        endtry
    redraw
    echom '"' . file . '"' . " Save Done" . ' ' . time
    redraw
    echohl None
endfunction
