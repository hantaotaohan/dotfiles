# OneDark like colorscheme
# License: GNU GPL version 3
# Author: Ianis Lallemand <ianis.lallemand@gmail.com>, 2018
# This is a modification of Joseph Tannhuber's Solarized colorscheme.

from __future__ import (absolute_import, division, print_function)

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import (
    cyan, magenta, red, white, default,
    normal, bold, reverse,
    default_colors,
)


class OneDark(ColorScheme):
    progress_bar_color = 4

    def use(self, context):  # pylint: disable=too-many-branches,too-many-statements
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            fg = 7
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                fg = 0
                bg = 1
            if context.border:
                fg = default
            if context.media:
                if context.image:
                    fg = 3
                else:
                    fg = 1
            if context.container:
                fg = 5
            if context.directory:
                fg = 4
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                fg = 2
                attr |= bold
            if context.socket:
                fg = 3
                bg = 7
                attr |= bold
            if context.fifo:
                fg = 11
                bg = 7
                attr |= bold
            if context.device:
                fg = 145
                bg = 252
                attr |= bold
            if context.link:
                fg = 5 if context.good else 1
                attr |= bold
                if context.bad:
                    bg = 0
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (red, magenta):
                    fg = white
                else:
                    fg = red
            if not context.selected and (context.cut or context.copied):
                fg = 239
                attr |= bold
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    bg = 237
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta

            if context.inactive_pane:
                fg = 8

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = 0 if context.bad else 0
                if context.bad:
                    bg = 1
            elif context.directory:
                fg = 0
            elif context.tab:
                fg = 7 if context.good else 4
                bg = 0
            elif context.link:
                fg = cyan

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 5
                elif context.bad:
                    fg = 1
                    bg = 0
            if context.marked:
                attr |= bold | reverse
                fg = 8
                bg = 38
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = 1
                    bg = 0
            if context.loaded:
                bg = self.progress_bar_color

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = 5

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        return fg, bg, attr
