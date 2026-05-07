<p align="center">
  <img width="140" src="https://raw.githubusercontent.com/simple-icons/simple-icons/develop/icons/playstation.svg">
</p>

<h1 align="center">EXP-C0RE</h1>

<p align="center">
  Minimal PS4/PS5 UI hijack framework for learning framebuffer rendering, overlays, and emulator frontend development.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-PS4%20%7C%20PS5-blue">
  <img src="https://img.shields.io/badge/Resolution-1920x1080-success">
  <img src="https://img.shields.io/badge/Language-C-important">
  <img src="https://img.shields.io/badge/Renderer-Framebuffer-orange">
  <img src="https://img.shields.io/badge/Status-Experimental-red">
</p>

---

## What is EXP-C0RE?

EXP-C0RE is a minimal educational framework showing how UI hijacking and framebuffer rendering work internally on SWRR for both PlayStation 4 and PlayStation 5.

This project demonstrates:

- Video output hijacking
- Direct framebuffer rendering
- Text rendering
- Pad input handling
- Overlay/UI systems
- Graphics takeover concepts
- Emulator frontend foundations

The repository intentionally does **NOT** include the NES emulator itself.

Instead, the goal is to help developers understand:

- how emulator frontends work
- how framebuffer rendering works
- how overlays are drawn
- how custom UI systems are built
- how graphics hijacking operates internally

---

## Features

- Simple modular architecture
- Direct framebuffer rendering
- Bitmap font rendering
- Video output hijacking
- Pad input debugging
- Clean rendering pipeline
- Easy to modify and extend
- Educational-oriented codebase
- 1920×1080 and resizeable
- PS4 + PS5 compatible concepts

---

## EXP-C0RE Architecture

EXP-C0RE is separated into multiple independent layers so developers can replace rendering, input handling, or emulator logic without rewriting the entire framework.

| Layer | File(s) | Purpose |
|:--|:--|:--|
| **System Interface** | `core.h` | Type definitions, syscall wrappers, and `NC/SYM` helper macros for calling internal PlayStation functions |
| **Video Hijack** | `hijack.h` / `hijack.c` | Terminates the game renderer, creates a new video output, allocates direct-memory framebuffers, and performs flips using `sceVideoOut` |
| **UI Rendering** | `ui.h` / `ui.c` | Clears framebuffers and renders scaled text using an 8×8 bitmap font with pixel doubling or arbitrary scaling |
| **Main Logic** | `main.c` | Initialises video + pad input, renders debug/UI text, handles runtime logic, and exits cleanly on `R1` |

> [!TIP]
> Because every subsystem is isolated, developers can easily integrate their own renderer, emulator frontend, menu system, or overlay layer.

---

## Rendering Pipeline

```text
Game Renderer
      ↓
Hijack Graphics Output
      ↓
Allocate Custom Framebuffers
      ↓
Draw UI/Text
      ↓
Flip Buffers via sceVideoOut
      ↓
Display Custom Overlay
```

---

## Based On

- [Lua-C0re](https://github.com/Gezine/Luac0re) — by Gezine
- [emu-c0re](https://github.com/egycnq/EmuC0re) — by egycnq
- [Emu-Building iPhone Tools](https://github.com/MexrlDev/Star-Wars-Racer-Revenge-Mods/tree/main/iPhone-Nes-Luncher-Tools) — by MexrlDev

---

## Building

Clone the repository:

```bash
git clone https://github.com/MexrlDev/Exp-C0re.git
cd EXP-C0RE
```

Edit whatever you need, then run the GitHub Actions workflow.

After building:

1. Ignore the generated `.elf`
2. Take the generated `.bin`
3. Convert the `.bin` into hex using:
   - my coverer via python - [BIN to HEX](https://github.com/MexrlDev/Exp-C0re/blob/main/iPhone-Pythonica-Tools/Cover-Bin-To-Lua-Hex.py)
   - or a Bin-to-Lua tool
4. Replace:

```lua
local sc = "HEX HERE"
```

5. Send the Lua script to the game using Gezine lua sender or my own [python sender](https://github.com/MexrlDev/Exp-C0re/blob/main/iPhone-Pythonica-Tools/Special-iPhone-Exp-Luncher.py).

---

## Learning Goals

EXP-C0RE is designed to help developers learn:

- Low-level framebuffer rendering
- Graphics hijacking
- Overlay systems
- Emulator UI design
- Text rendering
- Buffer flipping
- Input handling
- Rendering abstraction layers
- PlayStation homebrew structure

---

## ⚠ Notes

> [!WARNING]
> This project is for Star Wars Racer Revange and NOT FOR OTHER GAMES.

> [!NOTE]
> The current implementation targets 1920×1080 rendering.

> [!TIP]
> The framework is intentionally simple so developers can easily expand it into larger projects.

---

## Future Ideas

- PNG rendering
- Texture support
- GPU accelerated rendering
- Emulator frontend integration
- Animated UI
- File browser (which i did, but only browse content_temp -_-)
- Audio output
- Multiple resolution support
- Better font rendering
- Theme system

---

## Credits

Huge respect to:

- Gezine
- egycnq
- PlayStation reverse engineering community
- Homebrew developers and researchers
