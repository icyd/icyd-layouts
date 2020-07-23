# IcyD Dvorak keyboard layout

Based on the [Programmer Dvorak](http://www.kaufmann.no/roland/dvorak/) of Roland Kaufmann.
This layout adds the vocals with acute accent (and ñ), to be access with Alt+Ctl or
AltGr, on the vocals keys for Spanish's typists.

Number are keep on `shift` modifier, but in `QWERTY` order.
Some symbols are moved in order to have the same bracket/brace/parenthesis on the same fingers, on opposite hands.

The number row is:
- Shift: ~ 1 2 3 4 5 6 7 8 9 0 % \`
- Nomod: $ & [ { ( * = + ) } ] ! #

Also semicolon and single quote are swapped, as in normal Dvorak layout.

*NOTE:* In case of Windows layout, it automatically set swap between ESC and
CAPS_LOCK, also use by default hex keypad with lv5:ralt\_switch by default. To
imitate this behaviour with the Linux version, use xkb option `caps:swapescape`.
Use the following Xorg configuration for keyboard: `Option "XkbOptions" "caps:swapescape,lv3:ralt_switch,compose:102,numpad:shift3,keypad:hex"`

**NOTE**: No compiled yet for MacOs and Windows. BE CAREFUL.
