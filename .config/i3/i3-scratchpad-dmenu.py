#!/usr/bin/env python3

#import i3ipc
#import subprocess
#import re

#i3 = i3ipc.Connection()

#def get_scratchpad_windows():
#    scratchpad_containers = i3.get_tree().scratchpad().descendents()
#    return filter(lambda c: c.type == 'con' and c.name, scratchpad_containers)

#def dmenu_choose(options):
#    """ Show a dmenu to choose a string item from a list of *options*. """
#    dmenu_process = subprocess.Popen(["dmenu", "-l", "10"], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
#    stdoutdata, _ = dmenu_process.communicate("\n".join(options).encode())
#    return stdoutdata.decode('utf-8')

#def main():
#    scratchpad_windows = get_scratchpad_windows()
#    window_titles = [w.name for w in scratchpad_windows]
#    if window_titles:
#        window_to_restore = re.escape(dmenu_choose(window_titles).strip())
#        i3.command('[title="{}"] scratchpad show'.format(window_to_restore))

#if __name__ == '__main__':
#    main()
    
    
import i3ipc
import sys
import subprocess
import os


# configure parameters to send to dmenu
dmenu_args = ['-i']

i3 = i3ipc.Connection()
tree = i3.get_tree()
scratch = tree.scratchpad()
focused = tree.find_focused()
cur_con_is_sp = False

# does not handle duplicate window names for now
sp_windows = {node.find_named('.*')[0].name: node.nodes[0]
              for node in scratch.floating_nodes}

if len(sp_windows) == 0:  # happens also when the only scratchpad is focused
    sys.exit(0)

# if current window is a scratchpad, then hide it
p = focused
while p.type != 'workspace':
    if p.floating and (p.scratchpad_state != 'none'):
        cur_con_is_sp = True
        break
    p = p.parent

if cur_con_is_sp:
    i3.command('scratchpad show')

# send all window names to dmenu and get selection
dm_proc = subprocess.Popen(["dmenu",'-f','-p','Search','-fn',"Saber-18",'-nb','#282c34','-nf','#Abb2bf', '-sb','#e06c75','-sf','#282c34'] + dmenu_args, 
                           stdin=subprocess.PIPE,
                           stdout=subprocess.PIPE,
                           universal_newlines=True)
sel_focus = dm_proc.communicate('\n'.join(sp_windows.keys()))

if dm_proc.returncode != 0:  # possibly user pressed Esc, do nothing
    sys.exit(1)

focus_win_name = sel_focus[0].strip()

# focus it
try:
    sp_windows[focus_win_name].command('focus')
except KeyError as e:
    sys.exit(2)

