# IcyD Dvorak keyboard layout
Based on the [Programmer Dvorak](http://www.kaufmann.no/roland/dvorak/) of Roland Kaufmann.
This layout only add the vocals with acute accent, to be access with Alt+Ctl or
AltGr, on the vocals keys for Spanish's typists.

Also will include another personal modifications.

*NOTE:* In case of Windows layout, it automatically set swap between ESC and
CAPS_LOCK, also use by default hex keypad with lv3:ralt\_switch by default. To
imitate this behaviour with the Linux version, the following options need to be
set:
`XkbOptions=lv3:ralt\_switch,compose:102,numpad:shift3,keypad:hex`
Also the *esc\_capslock\_swap* should be copied to system to allow ESC <> CAPS_LOCK
swaping. Then run: `# systemd-hwdb update; udevadm trigger`
