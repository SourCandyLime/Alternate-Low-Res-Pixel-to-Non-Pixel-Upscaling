# Pixelation Shaders for Godot 4

Transform your game into retro pixel-art style with **hexagon** or **triangle** pixels instead of traditional squares!

![Preview Image Here]

## Features

- 🔷 **Hexel Shader** - Hexagonal pixel rendering
- 🔺 **Trixel Shader** - Triangular pixel rendering  
- 🎮 **Ready-to-use templates** - Drop in and start creating
- ⚡ **Real-time rendering** - Efficient shader-based approach
- 🎨 **Low-res aesthetic** - Perfect for retro-style games

## Installation

1. Download and extract to `res://addons/AlternatePixels/`
2. Enable the plugin in **Project → Project Settings → Plugins**
3. Check the console for confirmation message

## Quick Start

### Method 1: Drag & Drop (Recommended)
1. Navigate to `res://addons/AlternatePixels/templates/` in the FileSystem dock
2. Drag `HexelRoot.tscn` or `TrixelRoot.tscn` into your scene
3. Add your game content as a child of the **SubViewport** node
4. Run your game!

### Method 2: Manual Setup
If you want to add the shader to an existing scene:
1. Copy the shader from `Shaders/Hexel.gdshader` or `Shaders/Trixel.gdshader`
2. Apply to a TextureRect that displays your SubViewport texture
3. Set the shader parameter `src_tex` to your SubViewport's texture

## Usage

### Viewport Resolution
Adjust the `resolution` property in the inspector to change the internal rendering resolution:
- **Hexel**: Standard aspect ratios work fine (e.g., 320x180 for 16:9)
- **Trixel**: Use 2:1 aspect ratio content (e.g., 320x90 for 16:9 display)

### For Smooth Rendering (Triangle)
To avoid edge jittering with the triangle shader:
- Snap horizontal movement to **2-pixel increments**
- Snap vertical movement to **1-pixel increments**

Example in your character controller:
```gdscript
velocity.x = round(velocity.x / 2.0) * 2.0  # Snap to 2px
velocity.y = round(velocity.y)  # Snap to 1px
```

### Adding Game Content
Your game content goes **inside the SubViewport node**:
```
HexelRoot (or TrixelRoot)
├─ SubViewport
│  └─ Screen  ← Add your content here
│     ├─ Player
│     ├─ TileMap
│     └─ etc...
└─ Control
   └─ Shader (shader applied automatically)
```

## Technical Details

### Hexel Shader
- Uses axial coordinate system for perfect hexagon rounding
- Flat-top hexagon orientation
- Works with standard aspect ratios

### Trixel Shader  
- Equilateral triangle tessellation
- Alternating up/down triangle pattern
- **Important**: Requires 2:1 aspect ratio game content
  - A 4x4 square in your game becomes a 2x4 rectangle in screen space
  - This displays as 4x4 equilateral triangles on screen

## Aspect Ratio Guide

### Hexel Shader
| Display Ratio | Viewport Resolution |
|---------------|---------------------|
| 16:9          | 320x180, 640x360    |
| 4:3           | 320x240, 640x480    |
| 21:9          | 420x180             |

### Trixel Shader  
| Display Ratio | Game Content Ratio | Viewport Resolution |
|---------------|-------------------|---------------------|
| 16:9          | 32:9              | 320x90, 640x180     |
| 4:3           | 8:3               | 320x120             |
| 21:9          | 42:9              | 420x90              |

## Tips & Tricks

- **Performance**: Lower viewport resolutions run faster
- **Art Style**: Triangles give sharper diagonal lines than hexagons
- **Camera Movement**: For smoothest results, consider pixel-snapped movement
- **UI**: Place UI elements outside the SubViewport for crisp text

## Troubleshooting

**Q: The triangles look stretched!**  
A: Make sure your game content is authored at 2:1 aspect ratio

**Q: Edges are jittery when I move!**  
A: Snap your camera/character movement to pixel increments (2px horizontal, 1px vertical for triangles)

**Q: Input isn't working!**  
A: Make sure you haven't removed the `RootHandler.gd` script from the root node

## Credits

Created by Taggert S. Allred
Inspired by Hexagons are the Bestagons by CGPGray

## License

MIT License © 2025 Taggert S. Allred

Free to use in your projects, both personal and commercial. See [LICENSE.md](LICENSE.md) for details.
