# Warning this code is suuuper hacky 



# pyright: reportMissingImports=false

import datetime
# import importlib.util
import sys
from pathlib import Path

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.rgb import Color
from kitty.tab_bar import (DrawData, ExtraData, Formatter, TabBarData, as_rgb,
                           draw_attributed_string, draw_title)
from kitty.utils import color_as_int

# import psutil


# import json
# import subprocess
# from collections import defaultdict


timer_id = None


def calc_draw_spaces(*args) -> int:
    length = 0
    for i in args:
        if not isinstance(i, str):
            i = str(i)
        length += len(i)
    return length + len(args) - 1


def _draw_icon(screen: Screen, index: int, symbol: str = "") -> int:
    if index != 1:
        return 0

    fg, bg = screen.cursor.fg, screen.cursor.bg
    screen.cursor.fg = as_rgb(color_as_int(Color(255, 250, 205)))
    screen.cursor.bg = as_rgb(color_as_int(Color(60, 71, 77)))
    screen.draw(symbol)
    screen.cursor.fg, screen.cursor.bg = fg, bg
    screen.cursor.x = len(symbol)
    return screen.cursor.x


def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    print(extra_data)
    if draw_data.leading_spaces:
        screen.draw(" " * draw_data.leading_spaces)

    # TODO: https://github.com/kovidgoyal/kitty/discussions/4447#discussioncomment-2463083
    # tm = get_boss().active_tab_manager
    #     if tm is not None:
    #         w = tm.active_window
    #         if w is not None:
    #             cwd = w.cwd_of_child or ''
    #             log_error(cwd)

    draw_title(draw_data, screen, tab, index)
    trailing_spaces = min(max_title_length - 1, draw_data.trailing_spaces)
    max_title_length -= trailing_spaces
    extra = screen.cursor.x - before - max_title_length
    if extra > 0:
        screen.cursor.x -= extra + 1
        screen.draw("…")
    if trailing_spaces:
        screen.draw(" " * trailing_spaces)
    end = screen.cursor.x
    screen.cursor.bold = screen.cursor.italic = False
    screen.cursor.fg = 0
    if not is_last:
        screen.cursor.bg = as_rgb(color_as_int(draw_data.inactive_bg))
        screen.draw(draw_data.sep)
    screen.cursor.bg = 0
    return end
    

# Right status bar data functions should probably be a class here
def get_time():
    return datetime.datetime.now().strftime(" %H:%M")


def get_utc():
    time = datetime.datetime.now(datetime.timezone.utc) - datetime.timedelta(hours=7)
    return time.strftime(" (PST %H:%M)")


def get_date():
    return datetime.datetime.now().strftime(" %a %b %d")


def get_cwd():
    tm = get_boss().active_tab_manager
    if tm is not None:
        w = tm.active_window
        if w is not None:
            cwd = w.cwd_of_child or ''
            cwd = cwd.replace(str(Path.home()), '~')
            return " " + cwd


# def get_battery():
#     try:
#         spec = importlib.util.spec_from_file_location("psutil", "/Users/jhch/Library/Python/3.8/lib/python/site-packages/psutil/__init__.py")
#         psutil = importlib.util.module_from_spec(spec)
#         spec.loader.exec_module(psutil)
#         battery = psutil.sensors_battery()
#         return 'worked'
#     except Exception as e:
#         import sys
#         return sys.path[1][10:20]
#     # battery = psutil.sensors_battery()
#     return str(battery.percent)
#     return sys.path[1][:10]



# more handy kitty tab_bar things:
# REF: https://github.com/kovidgoyal/kitty/discussions/4447#discussioncomment-2183440
def _draw_right_status(screen: Screen, is_last: bool) -> int:
    if not is_last:
        return 0

    draw_attributed_string(Formatter.reset, screen)

    here_time = get_time()
    utc_date = get_utc() 
    date = get_date()
    cwd = get_cwd()
    # battery = get_battery()

    cells = [
        # (Color(135, 192, 149), battery),
        (Color(192, 163, 110), cwd),
        (Color(152, 187, 108), date),
        (Color(152, 187, 108), here_time),
        (Color(113, 115, 116), utc_date),
    ]

    right_status_length = calc_draw_spaces(*[e[1] for e in cells])

    draw_spaces = screen.columns - screen.cursor.x - right_status_length
    if draw_spaces > 0:
        screen.draw(" " * draw_spaces)
   
    screen.cursor.fg = 0
    for color, status in cells:
        screen.cursor.fg = as_rgb(color_as_int(color))
        screen.draw(status)
    screen.cursor.bg = 0

    if screen.columns - screen.cursor.x > right_status_length:
        screen.cursor.x = screen.columns - right_status_length

    return screen.cursor.x


# REF: https://github.com/kovidgoyal/kitty/discussions/4447#discussioncomment-1940795
# def redraw_tab_bar():
#     tm = get_boss().active_tab_manager
#     if tm is not None:
#         tm.mark_tab_bar_dirty()


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    _draw_icon(screen, index, symbol="  \uf490  ")
    _draw_left_status(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
    )
    _draw_right_status(
        screen,
        is_last,
    )

    return screen.cursor.x
