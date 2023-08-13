# TypeScriptTeatime's The Old Man and the TV

## BHAG

Be nice to the malfunctioning CRT TV.

Rule Change: Hitting it, fixes it.

## Assets

- [tileset from kenney.nl](https://kenney.nl/assets/1-bit-pack) - CC0 1.0
- [Background music Brahms by TheOuterLinux](https://opengameart.org/content/brahms-val3) - CC0 1.0
- [PressStart2P font](https://fonts.google.com/specimen/Press+Start+2P) - OFL
- [The Essential Retro Sound Effects Collection](https://opengameart.org/content/512-sound-effects-8-bit-style) - CC0 1.0
- [Konami Code](https://de.wikipedia.org/wiki/Konami_Code)

## Build and Export to itch.io

- Create new project on itch.io
- enable `SharedArrayBuffer support — (Experimental)`
  - Fixes error message on game load: `The following features required to run Godot projects on the Web are missing: ...`
- Build the Godot project using HTML template
  - `echo .build/ >> .gitignore`
  - `rm -r .build && mkdir .build`
  - Project -> Export... -> Add Preset -> Web -> (if not already installed, download the HTML template) -> Set output path to `.build/` -> Export Project... -> filename `index.html` -> disable `Export with Debug` -> Export
  - `/home/mirco/programming/gamedev/itchio-butler/butler push .build mkraenz/the-old-man-and-the-tv:web`
- In itch.io, edit project -> Uploads -> enable `This file will be played in the browser`
