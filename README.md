# Miro's Teatime

## BHAG

Be nice to the malfunctioning CRT TV.

Rule Change: Hitting it, fixes it.

## Assets

- [tileset from kenney.nl](https://kenney.nl/assets/1-bit-pack) - CC0 1.0
- [Background music Brahms by TheOuterLinux](https://opengameart.org/content/brahms-val3) - CC0 1.0
- [PressStart2P font](https://fonts.google.com/specimen/Press+Start+2P) - OFL
- [Konami Code](https://de.wikipedia.org/wiki/Konami_Code)

## Build and Export to itch.io

- Create new project on itch.io
- enable `SharedArrayBuffer support — (Experimental)`
  - Fixes error message on game load: `The following features required to run Godot projects on the Web are missing: ...`
- Build the Godot project using HTML template

  - `echo .build/ >> .gitignore`
  - Project -> Export... -> Add Preset -> Web -> (if not already installed, download the HTML template) -> Set output path to `.build/` -> Export Project...
  - package to zip

  ```sh
  rm -r .build
  mv .build/TheOldManAndTheTv.html .build/index.html
  zip .build/ .build/TheOldManAndTheTv.zip
  ```
