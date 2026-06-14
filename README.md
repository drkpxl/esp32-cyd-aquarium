# ESP32 CYD Aquarium

A little animated pixel aquarium for the ESP32-2432S028R, better known as the
Cheap Yellow Display. It's adapted from
[Livegrid OpenMatrix](https://github.com/livegrid/OpenMatrix).

<p align="center">
  <img src="https://img.shields.io/badge/license-AGPL--3.0-blue.svg" alt="License: AGPL-3.0">
  <img src="https://img.shields.io/badge/platform-ESP32--2432S028R-orange.svg" alt="Platform: ESP32-2432S028R">
  <img src="https://img.shields.io/badge/built%20with-PlatformIO-f5822a.svg" alt="Built with PlatformIO">
  <a href="https://ko-fi.com/lagerpun"><img src="https://img.shields.io/badge/Ko--fi-Support-ff5f5f.svg?logo=kofi&logoColor=white" alt="Support on Ko-fi"></a>
</p>

<p align="center">
  <img src="docs/images/cyd-aquarium-demo.gif" alt="ESP32 CYD Aquarium running on a Cheap Yellow Display" width="360">
</p>

<p align="center">
  <a href="docs/images/aquarium.mp4">MP4 video</a>
</p>

It turns one of these small 2.8 inch ESP32 touchscreens into a self-running
desk aquarium: moving water, a handful of small creatures, plants, and drifting
food. This build is **fully offline** — no clock, no Wi-Fi, and no network
setup. Flash it and it just runs. It also dims its own backlight using the
light sensor already on the board.

It's my own CYD take on the OpenMatrix aquarium, not a straight port of the
original HUB75 RGB matrix project. The default build is just about the screen,
so you don't need any external temperature, humidity, or CO2 sensors to run it.

## Flash From Your Browser

The easiest way to install — no toolchain required. Open the web installer in
**Chrome or Edge**, plug your CYD in over USB, and click install:

➡️ **[Web Installer](https://drkpxl.github.io/esp32-cyd-aquarium/)**

It flashes a prebuilt, offline aquarium image straight from the browser.

## What It Does

It boots straight into the scene and keeps itself going without you touching
anything. Bigger creatures swim around while smaller stuff drifts in the
background, and the whole thing is drawn on the TFT in a way that mimics a
small LED matrix.

## Features

- Standalone, **fully offline** live aquarium for the ESP32-2432S028R / CYD board.
- One-click **browser web installer** — no PlatformIO needed to flash.
- 240x320 ILI9341 TFT output with an 80x106 logical pixel-aquarium frame.
- Dot-grid renderer that gives the TFT a small LED-matrix look.
- Autonomous fish, stars, turtles, snakes, octopuses, boids, plants, food, and
  animated water.
- No clock, no Wi-Fi, no touch, and no network setup in the default build —
  it just runs.
- Automatic TFT backlight using the onboard GPIO34 light sensor.
- No external environmental sensors needed for the default build.
- Tested on the common ESP32-2432S028R / Cheap Yellow Display hardware.

> The clock, Wi-Fi/NTP time sync, and touch-to-feed are still in the codebase
> but disabled by default in this build. They can be re-enabled with the
> `CYD_SHOW_CLOCK`, `CYD_WIFI_TIME`, and `CYD_ENABLE_TOUCH` build flags in
> `platformio.ini`.

## Hardware

Tested on:

| Part | Detail |
| --- | --- |
| Board | ESP32-2432S028R / Cheap Yellow Display style |
| Module | ESP32-WROOM-32 class |
| Display | 2.8 inch 240x320 ILI9341 TFT |
| Touch | XPT2046 resistive |
| Light sensor | Onboard, on GPIO34 |

CYD boards and clones vary. Start with the tested configuration in this repo,
then see [docs/HARDWARE.md](docs/HARDWARE.md) and
[docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) if your board behaves
differently.

## Quick Start

Install [PlatformIO](https://platformio.org/) first, then build the default
environment:

```powershell
pio run -e esp32-2432s028r
```

Flash your board, replacing `COMx` with your serial port:

```powershell
pio run -e esp32-2432s028r -t upload --upload-port COMx
```

Open the monitor:

```powershell
pio device monitor --environment esp32-2432s028r --baud 115200 --port COMx
```

Detailed steps are in [docs/BUILD_AND_FLASH.md](docs/BUILD_AND_FLASH.md).

## Display Tuning and Panel Variants

CYD boards ship with different panel revisions, so the same firmware can look
wrong on a different board (inverted, washed out, byte-swapped colors, or a
dark/orange/purple background). All of the display tuning lives in
`platformio.ini` as `-D` build flags, so it's the single place to adjust:

| Flag | Purpose |
| --- | --- |
| `TFT_INVERSION_ON` / `TFT_INVERSION_OFF` | flips light/dark if the background is inverted |
| `CYD_TFT_SWAP_BYTES` | `1`/`0` — fixes byte-swapped (rainbow/scrambled) colors |
| `CYD_BACKGROUND_BRIGHTNESS` | brightness of the water only |
| `CYD_FOREGROUND_BRIGHTNESS` / `CYD_FOREGROUND_SATURATION` | brightness/vividness of the creatures only |
| `CYD_AUTO_BACKLIGHT_MIN_PERCENT` | floor for the auto-dimming backlight |

This build is tuned for: inversion off, byte-swap on, bright water. See
[docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) if your board looks off.

## Re-enabling the Clock and Wi-Fi

This build ships offline with the clock, Wi-Fi/NTP, and touch turned off. To
turn the clock and NTP time sync back on, set `-DCYD_SHOW_CLOCK=1` and
`-DCYD_WIFI_TIME=1` in `platformio.ini`, then copy
`include/WifiSecrets.example.h` to `include/WifiSecrets.h` and fill in your
Wi-Fi name and password (`WifiSecrets.h` is git-ignored on purpose).

See [docs/WIFI_TIME.md](docs/WIFI_TIME.md).

## Documentation

- [Hardware notes](docs/HARDWARE.md)
- [Build and flash guide](docs/BUILD_AND_FLASH.md)
- [Wi-Fi and NTP setup](docs/WIFI_TIME.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)
- [Development notes](docs/DEVELOPMENT_NOTES.md)
- [Attribution](docs/ATTRIBUTION.md)

## Support ☕

I built this for fun and put it out there for free. If you've enjoyed it and
would like to see it grow, buying me a coffee helps me keep tinkering and adding
new things to it. A star, an issue about your board variant, or a short hardware
report are always welcome too.

<p align="center">
  <a href="https://ko-fi.com/lagerpun">
    <img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Buy Me a Coffee at ko-fi.com">
  </a>
</p>

## Attribution

This project is based on
[Livegrid OpenMatrix](https://github.com/livegrid/OpenMatrix), an AGPL-3.0
project for ESP32-driven HUB75 RGB matrices.

I've adapted the aquarium idea and the supporting code for the
ESP32-2432S028R / Cheap Yellow Display TFT board. That meant changing the
display target, the hardware assumptions, the clock behavior, the backlight
handling, and a fair bit of scene tuning for this smaller screen. It isn't an
official Livegrid project.

See [docs/ATTRIBUTION.md](docs/ATTRIBUTION.md).

## License

This project is released under the GNU Affero General Public License v3.0
because the upstream OpenMatrix project is AGPL-3.0.

See [LICENSE](LICENSE).
