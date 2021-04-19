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

self.base00 = "#282c34"
self.base01 = "#353b45"
self.base02 = "#3e4451"
self.base03 = "#545862"
self.base04 = "#565c64"
self.base05 = "#abb2bf"
self.base06 = "#b6bdca"
self.base07 = "#c8ccd4"
self.base08 = "#e06c75"
self.base09 = "#d19a66"
self.base0A = "#e5c07b"
self.base0B = "#98c379"
self.base0C = "#56b6c2"
self.base0D = "#61afef"
self.base0E = "#c678dd"
self.base0F = "#be5046"

class OneDark(ColorScheme):
    progress_bar_color = 39

    def use(self, context):  # pylint: disable=too-many-branches,too-many-statements
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            fg = 145
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                fg = 235
                bg = 204
            if context.border:
                fg = default
            if context.media:
                if context.image:
                    fg = 180
                else:
                    fg = 204
            if context.container:
                fg = 170
            if context.directory:
                fg = 39
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                fg = 114
                attr |= bold
            if context.socket:
                fg = 180
                bg = 252
                attr |= bold
            if context.fifo:
                fg = 180
                bg = 252
                attr |= bold
            if context.device:
                fg = 145
                bg = 252
                attr |= bold
            if context.link:
                fg = 38 if context.good else 204
                attr |= bold
                if context.bad:
                    bg = 235
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
                fg = 180

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = 16 if context.bad else 241
                if context.bad:
                    bg = 204
            elif context.directory:
                fg = 39
            elif context.tab:
                fg = 38 if context.good else 39
                bg = 239
            elif context.link:
                fg = cyan

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 170
                elif context.bad:
                    fg = 204
                    bg = 235
            if context.marked:
                attr |= bold | reverse
                fg = 237
                bg = 38
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = 204
                    bg = 235
            if context.loaded:
                bg = self.progress_bar_color

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = 170

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        return fg, bg, attr
