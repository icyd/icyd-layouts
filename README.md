# IcyD Dvorak keyboard layout

Based on the [Programmer Dvorak](http://www.kaufmann.no/roland/dvorak/) of Roland Kaufmann.
This layout adds the vocals with acute accent (and ñ), to be access with Alt+Ctl or
AltGr, on the vocals keys for Spanish's typists.

Number are keep on `shift` modifier, but in `QWERTY` order.
Some symbols are moved in order to have the same bracket/brace/parenthesis on the same fingers, on opposite hands.

Also semicolon and single quote are swapped, as in normal Dvorak layout.

## Linux

To install use the installer bash script `install.sh`. Simply run:

```bash

    sudo sh install.sh --install
```

To remove use remove use the `--remove` flag. Recommended options for keyboard:
`Option "XkbOptions" "caps:swapescape,lv3:ralt_switch,compose:102,numpad:shift3,keypad:hex"`

## Windows

Generated with `Microsoft Keyboard Layout Creator 1.4`, with this software, you can load the file `windows/icyd.klc` and do some modifications, then generate the binary files. To uninstall, remove it from `Apps & features`.

## MacOS

Compiled binary is the old version. **Not yet generated for new version**, take it into consideration.

## Keyboard Layout

The layout image is generated using <http://www.keyboard-layout-editor.com>.

![Keyboard layout](misc/keyboard-layout.jpg)
