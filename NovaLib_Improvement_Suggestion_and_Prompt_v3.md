# NovaLib GUI Framework — Improvement Suggestions & Implementation Prompt v3

---

## 🏗 ARCHITECTURE PHILOSOPHY

NovaLib is a **modular opt-in framework**. Every system below is independent — creators
include only what their script needs. Nothing is forced. The core library handles windows,
elements, themes, and animations. Everything else (KeySystem, ProfileSystem, HotkeyManager,
etc.) lives in `/Managers/` and is required only when the creator explicitly calls it.

```lua
-- Minimal usage — no key, no profile, just a window
local NovaLib = require(...)
local win = NovaLib:Window({ Title = "My Script" })

-- With KeySystem (optional)
local KeySystem = require(...Managers.keysystem)
local ks = KeySystem.new({ KeyUrl = "https://..." })
ks.OnSuccess = function() win:Show() end

-- With Discord link (optional — creator decides)
local ks = KeySystem.new({
    KeyUrl     = "https://...",
    GetKeyUrl  = "https://your-site.com",   -- nil = Get Key button hidden
    DiscordUrl = "https://discord.gg/...",  -- nil = Discord button hidden
})
```

---

## 📋 SUGGESTION SUMMARY

---

### 1. 🎨 Theme Fix — Rename "Midnight" → `Amethyst`
**Problem:** The "Midnight" theme uses purple/amethyst colors, visually misleading.
**Fix:** Rename to `Amethyst`. Update all references in NovaLib.lua and theme-loading logic.

---

### 2. 🔔 Notification System — Solid Style + Queue

#### 2A. Solid Style Fix
Remove glass/blur from notification frames. Replace with:
- `BackgroundTransparency = 0`, solid secondary color background
- 3px left border using the theme's accent color
- Subtle UIStroke drop-shadow instead of blur

#### 2B. Notification Queue ← **New**
When multiple notifications fire close together they stack cleanly instead of overlapping.

**Rules:**
- Max visible at once: configurable (`NotificationLimit`, default `3`)
- Positions: bottom-right by default; configurable (`TopRight`, `BottomLeft`, `BottomRight`, `TopLeft`)
- Each notification has: `[Icon]  Title  ·  Body text  [×]` + auto-dismiss progress bar
- Notification types with default icons and accent colors:

| Type | Icon | Color |
|---|---|---|
| `info` | `info` | Blue `(60, 120, 255)` |
| `success` | `check-circle` | Green `(25, 200, 80)` |
| `warning` | `alert-triangle` | Orange `(220, 140, 0)` |
| `error` | `alert-circle` | Red `(200, 50, 50)` |

- New notification slides in from the right (X offset +120 → 0, EasingStyle.Back)
- On dismiss: slides out to the right (0 → +120, then Destroy)
- If queue is full: next notification waits until one clears
- Progress bar on the left border drains over the `Duration` (default 4s)
- Manual `[×]` close always available
- `NovaLib:Notify({ Title, Body, Type, Duration, Icon })` is the call

**Stack layout (bottom-right example, 3 visible):**
```
                     ┌──────────────────────────────┐
                     │ ✅  Success  ·  Key accepted  │ ← newest
                     └──────────────────────────────┘
                     ┌──────────────────────────────┐
                     │ ℹ️  Info  ·  Server online    │
                     └──────────────────────────────┘
                     ┌──────────────────────────────┐
                     │ ⚠️  Warning  ·  High ping     │ ← oldest
                     └──────────────────────────────┘
```

---

### 3. 🔧 TopBar Color Seam Fix
**Problem:** Half-different color below the title caused by UICorner hack.
**Fix:** Match TopBar `BackgroundColor3` exactly to the parent header frame. Add a same-color
bridging Frame over the seam, or unify into one parent for natural clip.

---

### 4. 🖋 Font Overhaul

| Element | Font |
|---|---|
| Window title | Same as Intro title font (GothamBold or equivalent) |
| Intro screen | Current intro font (unchanged) |
| All other UI | **Sour Gummy** (`Font.fromName("Sour Gummy", Enum.FontWeight.Regular)`) |
| KeySystem GUI | **VT323** — monospace retro terminal look |

---

### 5. 🌬 Intro Animation — Wind + Letter Fade
- Split title into individual character Labels
- Each character tweens: Position `+40 X offset → 0`, Transparency `1 → 0`, staggered 0.05s
- After 1.5s hold: all characters tween out simultaneously (`Y -20`, Transparency `1`)
- Subtitle uses the same wind-in with a 0.3s delay after title finishes
- Full intro frame fades out after exit animation (0.4s)

---

### 6. 🔑 KeySystem — Optional Module (`Managers/keysystem.lua`)

> **This module is fully optional.** Creators include it only if they want key-gating.
> GetKey and Discord buttons inside it are also individually optional — pass `nil` to hide either.

#### 6A. Optional Architecture
```lua
-- Creator includes KeySystem → key gate is active
local ks = KeySystem.new({
    KeyUrl     = "https://raw.github.com/.../keys.txt",
    GetKeyUrl  = "https://mysite.com",   -- omit/nil → hides Get Key button
    DiscordUrl = "https://discord.gg/x", -- omit/nil → hides Discord button
    AllowClose = false,                  -- default: no X, cannot skip
})

-- Creator does NOT require keysystem.lua → no gate, script runs immediately
```

Secondary action buttons (Get Key, Discord) are **purely optional per creator choice**:
- `GetKeyUrl = nil` → Get Key button does not render at all
- `DiscordUrl = nil` → Discord button does not render at all
- Both provided → both buttons appear in the footer row
- Only one provided → single centered secondary button

#### 6B. State Machine
```
IDLE        → No stored key; showing input
CONNECTING  → HttpService:GetAsync() in flight
COMPARING   → Remote key fetched; comparing to local cache
VERIFYING   → User submitted; validating against remote
GRANTED     → Key valid; success animation plays
DENIED      → Key invalid; shake + red flash
KEY_CHANGED → Remote key differs from cache; force re-entry
RESETTING   → User triggered reset/logout
DESTROYED   → Cleaned up
```

#### 6C. Close Logic (all opt-in, default: none)

| Config Key | Default | Behavior |
|---|---|---|
| `AllowClose = true` | `false` | Renders `[X]` in header |
| `EscToClose = true` | `false` | ESC key closes |
| `BackdropClose = true` | `false` | Click outside closes |

If none enabled and ESC is pressed → container shakes instead.

#### 6D. Layout
```
╔══════════════════════════════════════════╗  ← rotating gradient border (color by phase)
║ [●] NOVALIB KEYSYSTEM             [–][X] ║  ← server dot · minimize · close (optional)
╠══════════════════════════════════════════╣
║           [ PHASE ICON + GLOW ]          ║  ← swaps: lock/server/shield/alert-circle
║                                          ║
║         ACCESS KEY REQUIRED              ║  ← VT323, title
║    Enter your key to continue_           ║  ← blinking cursor on placeholder
║                                          ║
║  ┌──────────────────────────────────┐    ║
║  │ [🔑] __________________ [❌]    │    ║  ← key icon · input · clear
║  └──────────────────────────────────┘    ║
║                           0/50           ║  ← char counter
║                                          ║
║  [███████████░░░░░░] CONNECTING...       ║  ← progress bar (visible only during fetch)
║                                          ║
║  ┌──────────────────────────────────┐    ║
║  │      [log-in]  VERIFY KEY        │    ║  ← submit: full-width hero button
║  └──────────────────────────────────┘    ║
║                                          ║
║  [key] Get Key         [discord-icon]    ║  ← optional secondary buttons
║       (hidden if GetKeyUrl = nil)        ║    (hidden if DiscordUrl = nil)
║                                          ║
║  ┌──────────────────────────────────┐    ║
║  │  [shield]  STATUS: LOCKED        │    ║  ← typewriter status bar
║  └──────────────────────────────────┘    ║
║      NovaLib KeySystem v2  ●  Online     ║  ← footer: dot = green/red
╚══════════════════════════════════════════╝
```

Collapsed state (minimize button):
```
╔══════════════════════════════════════════╗
║ [●] NOVALIB KEYSYSTEM             [□][X] ║
╚══════════════════════════════════════════╝
```

#### 6E. Phase Colors & Icons

| Phase | Border | Icon | Status color |
|---|---|---|---|
| IDLE | White | `lock` | TextSecondary |
| CONNECTING | White (spinning) | `server` | TextSecondary |
| COMPARING | Cyan `(0,200,255)` | `code-2` | Cyan |
| VERIFYING | Yellow `(240,180,0)` | `log-in` (spin) | Yellow |
| GRANTED | Green `(25,200,80)` | `check-circle` | Green |
| DENIED | Red `(200,50,50)` | `alert-circle` | Red |
| KEY_CHANGED | Orange `(220,120,0)` | `key` | Orange |
| RESETTING | Gray | `log-out` | TextSecondary |

#### 6F. Features vs Example Template

| | Example | v2 Improved |
|---|---|---|
| Rotating gradient border | ✅ | ✅ + color by phase |
| Bubble particles / mouse-repel | ✅ | ✅ |
| Header icon glow | ✅ | ✅ + swaps per phase |
| Input focus glow | ✅ | ✅ |
| Close button | ❌ | ✅ optional |
| ESC to close | ❌ | ✅ optional |
| Backdrop close | ❌ | ✅ optional |
| Minimize/collapse | ❌ | ✅ |
| Get Key button | ✅ hardcoded | ✅ optional (nil hides) |
| Discord button | ✅ hardcoded | ✅ optional (nil hides) |
| State machine | ❌ | ✅ 8 phases |
| Typewriter status | ❌ | ✅ |
| Progress bar | ❌ | ✅ during fetch |
| Remote validation | ❌ template only | ✅ |
| Session cache | ❌ | ✅ readfile/writefile |
| Key-change detection | ❌ | ✅ |
| Auto-pass | ❌ | ✅ |
| Shake on deny | ❌ | ✅ |
| Success pulse | ❌ | ✅ |
| Tween cleanup | ❌ | ✅ TrackTween helper |
| Destroy/Reset/Hide API | ❌ | ✅ |
| VT323 font | ❌ Gotham | ✅ |
| Scanline CRT overlay | ❌ | ✅ |
| Cursor blink | ❌ | ✅ |
| Footer status dot | ❌ | ✅ |

#### 6G. API Surface
```lua
KeySystem.new(config)  -- config fields:
  KeyUrl, Title, StorageKey,
  GetKeyUrl,       -- nil → hides Get Key button
  DiscordUrl,      -- nil → hides Discord button
  AllowClose,      -- default false
  EscToClose,      -- default false
  BackdropClose,   -- default false
  AutoDismiss,     -- default true
  AutoDismissDelay -- default 2

ks.OnSuccess = function(key, tier) end
ks.OnClose   = function() end
ks.OnDenied  = function(attempt) end

ks:Destroy()   -- exit animation + full cleanup
ks:Reset()     -- clears cache, returns to IDLE
ks:Hide()      -- exit animation, object alive
ks:Show()      -- re-shows if hidden
ks:Minimize()  -- collapse to header bar
ks:Maximize()  -- expand body
```

---

### 7. 👤 Profile System — Optional Module (`Managers/profilesystem.lua`)

Reads the same remote file as KeySystem. Parses line 2 for tier.

**Displays:** avatar thumbnail, username, tier badge, live FPS (rocket icon), live ping (signal icon).

Tier badges:

| Tier | Icon | Color |
|---|---|---|
| `premium` | `user-check` | Gold |
| `vip` | `star` | Purple |
| `free` | `user` | Default |

Ping icon mapping:

| MS | Icon | Color |
|---|---|---|
| 0–50 | `signal-zero` | Green |
| 51–100 | `signal-low` | Lime |
| 101–200 | `signal-medium` | Yellow |
| 201+ | `signal-high` | Red |

---

### 8. ⌨ Hotkey Rebinding System — `Managers/hotkeys.lua`

A standalone manager. Creators use it to register functions under a named keybind.
Users can rebind any registered key from a rebind panel. Toggleable binds are supported —
the same key acts as an on/off switch for any element or function.

#### 8A. Creator API
```lua
local HotkeyManager = require(...Managers.hotkeys)

-- Basic hotkey (fires once on press)
HotkeyManager:Bind({
    Key      = Enum.KeyCode.RightShift,
    Label    = "Toggle GUI",
    Callback = function() window:Toggle() end,
})

-- Toggle hotkey (fires callback with true/false, same key = on/off)
HotkeyManager:Bind({
    Key           = Enum.KeyCode.F5,
    Label         = "Auto-Farm",
    Toggle        = true,
    DefaultActive = false,
    Callback      = function(isActive)
        if isActive then startFarm() else stopFarm() end
    end,
})

-- Bind a hotkey directly to a NovaLib Toggle element
local toggle = section:Toggle({ Label = "Fly Mode", Default = false })
HotkeyManager:BindToToggle({
    Key    = Enum.KeyCode.F,
    Label  = "Fly Toggle",
    Toggle = toggle,   -- presses the element programmatically
})

-- Unbind
HotkeyManager:Unbind(Enum.KeyCode.RightShift)
```

#### 8B. Rebind Panel
`HotkeyManager:OpenRebindPanel()` shows a GUI panel listing all registered binds.

```
╔══════════════════════════════════════════╗
║  ⌨  HOTKEY BINDINGS                   [X]║
╠══════════════════════════════════════════╣
║  Toggle GUI          [RIGHT SHIFT]  [✏] ║
║  Auto-Farm (toggle)  [F5]           [✏] ║
║  Fly Toggle          [F]            [✏] ║
║                                          ║
║          [RESET ALL TO DEFAULT]          ║
╚══════════════════════════════════════════╝
```

Clicking `[✏]` enters listening mode: the row highlights and the next key pressed becomes
the new binding. Pressing ESC cancels. Pressing a key already in use shows a conflict warning.

#### 8C. Toggle Indicator
When a toggle hotkey is active, a small floating badge appears (configurable position):
```
[ F5  ■ AUTO-FARM ]   ← green dot when on, gray when off
```

#### 8D. Persistence
All bindings and toggle states are saved to `writefile("NL_Hotkeys.json")` on change.
Loaded automatically on next launch.

#### 8E. Methods
```lua
HotkeyManager:Bind(config)           -- register a hotkey
HotkeyManager:BindToToggle(config)   -- bind key to a NovaLib Toggle element
HotkeyManager:Unbind(keyCode)        -- remove binding
HotkeyManager:OpenRebindPanel()      -- open the rebind UI
HotkeyManager:CloseRebindPanel()     -- close it
HotkeyManager:GetState(keyCode)      -- returns current toggle state (bool)
HotkeyManager:SetState(keyCode, bool)-- force-set toggle state
HotkeyManager:ResetAll()             -- reset all binds to defaults
HotkeyManager:Destroy()              -- disconnect all, cleanup
```

---

### 9. 🎨 Theme Selector — In Profile Panel

A dropdown in the Profile panel tab that lists all available themes and applies them live.

```
╔══════════════════════════╗
║  🎨  Theme               ║
║  [ Amethyst          ▼ ] ║
╚══════════════════════════╝
```

- Changing the theme tweens all element colors simultaneously using a shared tween function
- Selected theme is saved to local storage
- Loaded on next launch before anything renders (no flash of wrong theme)
- Previewing: hovering a theme option in the dropdown applies it temporarily;
  clicking confirms. Moving off without clicking reverts to previous theme.

---

### 10. 🗂 Animated Tab Transitions

Replace instant tab switches with smooth animations. Two style options (creator picks):

| Style | Animation |
|---|---|
| `Slide` | Content slides in from the direction of the new tab (right→left for forward, left→right for back) |
| `Fade` | Active tab fades out (0.15s), new tab fades in (0.15s) |

Implementation:
- Active content frame tweens `Position` or `BackgroundTransparency`
- Tab underline/indicator bar slides horizontally to the new tab position
- Active tab label uses theme accent color; inactive uses TextSecondary
- Transition cannot be interrupted mid-animation (new click is queued)

---

### 11. 🔍 Element Search Bar

A search field at the top of complex windows that filters visible elements in real time.

- Icon: `search` (magnifying glass) inside the input field on the left
- Icon: `x` clear button on the right when input is non-empty
- As user types, elements whose labels do not match are hidden (`Visible = false`)
- Section headers are hidden if all their children are hidden
- Sections with matching children remain visible with only matching children shown
- No match → shows centered "No results for '...'" message
- Empty query → restores all elements
- Clear button or pressing ESC clears the field and restores all

```
┌──────────────────────────────────────────┐
│  [🔍]  Search elements...          [❌]  │
└──────────────────────────────────────────┘
```

---

### 12. 📂 Collapsible Sections

Sections can be collapsed/expanded with an animated arrow icon.

```
  ▼  Combat Settings          ← expanded (arrow points down)
  ────────────────────────
     [Toggle] Aimbot
     [Slider] Smoothness
     [Toggle] Silent Aim

  ►  Movement Settings        ← collapsed (arrow points right)
```

- Clicking the section header toggles collapse
- Height animates smoothly (TweenService, EasingStyle.Quad, 0.2s)
- Arrow rotates 90° using TweenService
- Collapsed state is saved per section to local storage
- API: `section:Collapse()`, `section:Expand()`, `section:Toggle()`
- Creator can set `DefaultCollapsed = true` in section config

---

### 13. 💡 Additional Feature Suggestions

---

#### 13A. 🏷 Tooltip System
Any element can have a tooltip. Hovering shows a small popup with an icon and description.

```lua
toggle:SetTooltip({
    Icon = "info",
    Text = "Enables silent aim on all NPCs within range."
})
```

Tooltip appears after 0.4s hover delay, positioned above the element (flips to below if too close to top). Fades in/out. Never clips off-screen.

---

#### 13B. 🖱 Right-Click Context Menu
Right-clicking any interactive element opens a small context menu.

```
┌──────────────────────┐
│  📋  Copy value      │
│  📌  Pin element     │
│  🔄  Reset to default│
│  ℹ️  Element info    │
└──────────────────────┘
```

Creator can add custom items per element:
```lua
toggle:AddContextItem({ Icon = "bookmark", Label = "Save state", Callback = fn })
```

---

#### 13C. 📌 Element Pinning
Users can right-click → Pin any element. Pinned elements appear in a "Pinned" section
at the top of the window, regardless of which tab they belong to.
Useful for frequently-used controls in complex scripts.

---

#### 13D. 🔢 Tab Badge / Counter
Tabs can display a notification counter badge:

```lua
tab:SetBadge(3)     -- shows a red "3" badge on the tab
tab:ClearBadge()    -- removes the badge
```

```
  [ Combat (3) ]  [ Movement ]  [ Settings ]
```

---

#### 13E. 🪟 Window Drag Constraints
Windows are confined to the visible screen area. Dragging beyond the edge snaps to the boundary
instead of flying offscreen. Optional `SnapToEdges` config: snaps to screen quadrants.

---

#### 13F. 📏 Separator Element
A styled horizontal divider for visual grouping inside sections:

```lua
section:Separator({ Label = "Advanced", Icon = "settings" })
-- or just a plain line:
section:Separator()
```

```
  ── Advanced ──────────────────
```

---

#### 13G. 📊 Progress Bar Element
A visual fill bar element creators can update programmatically:

```lua
local bar = section:ProgressBar({ Label = "EXP", Min = 0, Max = 100, Value = 42 })
bar:SetValue(75)   -- animates fill
bar:SetColor(Color3.fromRGB(80, 200, 120))
```

Fill animates with TweenService. Shows percentage label on the right.

---

#### 13H. 📋 Config Import / Export
In settings or profile panel, two buttons:

- **Export** — serializes all toggle/slider/textbox states to a JSON string, copies to clipboard
- **Import** — opens a TextBox, user pastes a JSON string; values are applied live

```lua
NovaLib:ExportConfig()   -- returns JSON string + copies to clipboard
NovaLib:ImportConfig(str) -- applies JSON config string
```

Useful for sharing presets or backing up settings.

---

#### 13I. 🖼 Loading Skeleton
While a window's content is loading (e.g. during remote fetch), elements show animated
skeleton placeholders instead of blank space:

- Placeholder bars shimmer with a left-to-right highlight animation
- Once content loads, skeleton fades out and real elements fade in
- Creator controls: `element:SetLoading(true/false)`

---

#### 13J. 🔘 Multi-Select Dropdown
An extended dropdown that allows selecting more than one option:

```lua
section:MultiDropdown({
    Label   = "Game Modes",
    Options = {"PvP", "PvE", "Raid", "Farm"},
    Default = {"PvP"},
    Callback = function(selected) end  -- selected = {"PvP", "Raid"}
})
```

Selected options show checkmarks. A "X selected" summary shows in the closed dropdown.

---

#### 13K. 🎨 Color Picker Element
Let users customize accent colors without editing code:

```lua
section:ColorPicker({
    Label   = "Accent Color",
    Default = Color3.fromRGB(100, 150, 255),
    Callback = function(color) NovaLib:SetAccent(color) end
})
```

Opens a small HSV wheel + hex input panel on click. Live preview updates the element.

---

#### 13L. 🔤 Click-to-Copy Label
A label element that copies its text content to clipboard on click:

```lua
section:CopyLabel({ Label = "Script Key:", Value = "MY-KEY-ABC123", Icon = "copy" })
```

```
  Script Key:  MY-KEY-ABC123  [📋]
```

Click anywhere on the row → `setclipboard(value)` → brief "Copied!" feedback.

---

#### 13M. 🌐 Announcement Banner / Marquee
A scrolling text strip at the top of a window for announcements:

```lua
window:SetBanner({
    Text  = "v2.1 — Auto-Farm improved · Discord: discord.gg/xyz",
    Speed = 60,  -- pixels per second
    Icon  = "megaphone",
    Color = Color3.fromRGB(255, 180, 0),
})
window:ClearBanner()
```

Text scrolls right-to-left continuously. Solid background, no transparency.

---

#### 13N. 🗄 Element Disable State
Any element can be visually greyed out and non-interactive:

```lua
toggle:SetEnabled(false)   -- greys out, blocks clicks
slider:SetEnabled(true)    -- re-enables
```

Disabled elements show at reduced opacity (0.4) with a `cursor: not-allowed` feel
(hover does nothing, no color change).

---

#### 13O. ⌨ Keyboard Navigation
Tab key cycles focus between interactive elements inside the active window.
Arrow keys operate sliders and dropdowns when focused. Enter submits/toggles.
Esc closes dropdowns. Visual focus ring around the active element.

---

#### 13P. 🔄 Undo / Redo for Sliders and TextBoxes
`Ctrl+Z` reverts the last value change; `Ctrl+Shift+Z` re-applies it.
History per element, up to 20 steps. Creators can trigger programmatically:

```lua
slider:Undo()
textbox:Redo()
```

---

#### 13Q. 🐛 Developer Debug Overlay
A toggleable overlay (default hotkey: `Ctrl+Shift+D`) that shows:
- Element names, types, sizes, and positions as floating labels
- Live FPS counter
- Tween count, active connections
- Current theme name
- Window hierarchy tree

Useful during scripting; should be auto-disabled in release builds via `NovaLib.Debug = false`.

---

#### 13R. 🕐 Clock / Timer Element
A text element that displays real time or an in-game countdown:

```lua
-- Real clock
section:Clock({ Format = "HH:MM:SS", Label = "Time", Icon = "clock" })

-- Countdown timer
local timer = section:Countdown({ Seconds = 300, Label = "Respawn", Icon = "timer" })
timer:Start()
timer:Pause()
timer:Reset()
timer.OnComplete = function() end
```

---

#### 13S. 📄 Multi-Page Window
Windows can have multiple pages navigated by prev/next arrows instead of tabs.
Good for setup wizards or paged config:

```lua
local wizard = NovaLib:PagedWindow({ Title = "Setup Wizard" })
local page1 = wizard:AddPage({ Title = "Step 1 of 3" })
local page2 = wizard:AddPage({ Title = "Step 2 of 3" })
wizard:SetPage(2)
wizard:NextPage()
wizard:PrevPage()
```

Page transitions use slide animation.

---

#### 13T. 📐 Window Resize by Dragging
Users can resize a NovaLib window by dragging the bottom-right corner handle.
Min size clamped to content. Creator sets `Resizable = true/false` in window config.
Resize handle: small diagonal-lines icon in the bottom-right corner.

---

## 🤖 IMPLEMENTATION PROMPT v3

> Copy and paste to Claude with framework folder access to implement all changes.

---

```
You have full access to the NovaLib Roblox GUI framework folder.
Analyze all files thoroughly, then implement the following tasks in order.

═══════════════════════════════════════════════════════════
ARCHITECTURE NOTE
═══════════════════════════════════════════════════════════
NovaLib is opt-in modular. Core (windows/elements/themes) is always present.
Managers (KeySystem, ProfileSystem, HotkeyManager) are required only when the
creator explicitly loads them. Never auto-load or force-include any Manager.

═══════════════════════════════════════════════════════════
TASK 1 — RENAME MIDNIGHT THEME → AMETHYST
═══════════════════════════════════════════════════════════
In Themes.lua rename "Midnight" to "Amethyst".
Update every reference in NovaLib.lua and any theme-loading logic.

═══════════════════════════════════════════════════════════
TASK 2 — NOTIFICATION SYSTEM OVERHAUL
═══════════════════════════════════════════════════════════
A) Remove glass/blur from notification frames.
   Replace with: BackgroundTransparency = 0, solid secondary color background,
   3px left accent border, UIStroke drop-shadow.

B) Implement Notification Queue in Components/Notification.lua:
   - NovaLib:Notify({ Title, Body, Type, Duration, Icon })
   - Types: "info" (blue), "success" (green), "warning" (orange), "error" (red)
   - Default icons per type: info, check-circle, alert-triangle, alert-circle
   - Max visible: configurable NotificationLimit (default 3)
   - Position: configurable ("TopRight", "BottomRight", "TopLeft", "BottomLeft")
   - Stack vertically with 8px gap between notifications
   - Slide in from right on appear (X +120 → 0, EasingStyle.Back)
   - Slide out to right on dismiss (X 0 → +120, then Destroy)
   - Auto-dismiss progress bar drains over Duration seconds
   - Manual [×] close button always visible
   - Queue: if at limit, new notifications wait for a slot

═══════════════════════════════════════════════════════════
TASK 3 — FIX TOPBAR COLOR SEAM
═══════════════════════════════════════════════════════════
Match TopBar BackgroundColor3 exactly to the header parent frame.
Add a bridging Frame of the same color to cover the seam, or unify into one parent.

═══════════════════════════════════════════════════════════
TASK 4 — FONT CHANGES
═══════════════════════════════════════════════════════════
- Window titles: same Font as current Intro title
- All other UI: Font.fromName("Sour Gummy", Enum.FontWeight.Regular)
- KeySystem only: Font.fromName("VT323") or Enum.Font.Code fallback
- Comment each font assignment for easy future changes

═══════════════════════════════════════════════════════════
TASK 5 — INTRO ANIMATION UPGRADE
═══════════════════════════════════════════════════════════
- Split title into individual character Labels
- Each: tween Position +40 X offset → 0, Transparency 1 → 0
  TweenInfo: EasingStyle.Quad, EasingDirection.Out, staggered 0.05s per char
- After 1.5s hold: all tween out simultaneously (Y -20, Transparency 1)
- Subtitle: same wind-in with 0.3s delay after title
- Fade full intro frame after exit (0.4s)

═══════════════════════════════════════════════════════════
TASK 6 — CREATE framework/src/Managers/keysystem.lua
═══════════════════════════════════════════════════════════
Visual base: adopt the style from example-keysystem.txt
(rotating gradient border, bubble particles with mouse-repel, header icon glow ring,
input focus glow) but rebuild all logic from scratch.

A) OPTIONAL SECONDARY BUTTONS
   config.GetKeyUrl  → if nil, do NOT render Get Key button
   config.DiscordUrl → if nil, do NOT render Discord button
   If both provided: render both in a 48/48 split row beneath Submit
   If only one: render it full-width in that row

B) CLOSE LOGIC (all opt-in)
   config.AllowClose  = true → render [X] in header
   config.EscToClose  = true → ESC closes
   config.BackdropClose = true → backdrop click closes
   All three default false.
   ESC pressed with no close allowed → horizontal shake animation on container.
   Close path: cancel all State.ActiveTweens, disconnect State.Connections,
   tween container size → 0 (EasingStyle.Back.In, 0.3s), backdrop → transparent,
   task.delay(0.35) Destroy ScreenGui, fire KeySystem.OnClose.

C) MINIMIZE
   [–] button in header (next to [X], only if AllowClose = true)
   Click → tween container height to 50px, hide body content
   Click again → restore. Double-click header = same toggle.

D) STATE MACHINE
   State.Phase: IDLE → CONNECTING → COMPARING → VERIFYING → GRANTED/DENIED/KEY_CHANGED
   SetPhase(phase): update icon, border gradient color, call TypewriterStatus
   Phase colors: IDLE/CONNECTING=White, COMPARING=Cyan(0,200,255),
   VERIFYING=Yellow(240,180,0), GRANTED=Green(25,200,80),
   DENIED=Red(200,50,50), KEY_CHANGED=Orange(220,120,0)

E) TYPEWRITER STATUS
   TypewriterStatus(label, message, color, speed=0.03)
   Cancel previous coroutine before starting new one.
   Phase messages:
     CONNECTING → "> CONTACTING REMOTE SERVER..."
     COMPARING  → "> COMPARING LOCAL CACHE..."
     VERIFYING  → "> VALIDATING KEY..."
     GRANTED    → "> ACCESS GRANTED. WELCOME."
     DENIED     → "> INVALID KEY. ACCESS DENIED."
     KEY_CHANGED→ "> KEY UPDATED. RE-ENTRY REQUIRED."
     RESETTING  → "> SESSION CLEARED."

F) PROGRESS BAR
   Visible only during CONNECTING and VERIFYING phases.
   Animate width 0% → 80% over 1.5s (indeterminate).
   Jump to 100% on fetch complete. Hide after GRANTED or DENIED.

G) REMOTE VALIDATION
   1. SetPhase("CONNECTING")
   2. pcall(HttpService:GetAsync(config.KeyUrl)) → remoteKey = line 1, tier = line 2
   3. Fetch fail → error status, disable Submit
   4. Read local: pcall(readfile(config.StorageKey))
   5. Local == remote → SetPhase("GRANTED"), fire OnSuccess, AutoDismiss if configured
   6. Local != remote → delete local, SetPhase("KEY_CHANGED")
   7. No local → SetPhase("IDLE"), show GUI

H) KEY SUBMISSION
   Submit click or Enter:
   1. SetPhase("VERIFYING")
   2. Compare input to remoteKey
   3. Match → writefile(StorageKey, key), SetPhase("GRANTED"),
              border pulses green 3x, fire OnSuccess(key, tier),
              AutoDismiss if config.AutoDismiss = true
   4. No match → SetPhase("DENIED"), shake container (tween +10,-10,+6,-6,0 X),
                 fire OnDenied(attempt), re-enable Submit after 1.5s

I) TWEEN TRACKING
   All tweens via TrackTween(tween) → stored in State.ActiveTweens
   All connections stored in State.Connections

J) LAYOUT ADDITIONS
   Header: [●server dot] TITLE [–][X]
   server dot: 8x8 circle, green online / red offline
   Scanline overlay: Frame BackgroundTransparency=0.97, UIGradient alternating
   Cursor blink: task.spawn loop appending/removing "_" to placeholder every 0.5s
   Footer: "NovaLib KeySystem v2  ·  [Online/Offline]"

K) API
   KeySystem.new(config) — config: KeyUrl, Title, StorageKey, GetKeyUrl, DiscordUrl,
                                   AllowClose, EscToClose, BackdropClose,
                                   AutoDismiss(true), AutoDismissDelay(2)
   ks.OnSuccess = function(key, tier) end
   ks.OnClose   = function() end
   ks.OnDenied  = function(attempt) end
   ks:Destroy() | ks:Reset() | ks:Hide() | ks:Show() | ks:Minimize() | ks:Maximize()

L) FONT: Font.fromName("VT323") everywhere. No Gotham.

═══════════════════════════════════════════════════════════
TASK 7 — CREATE framework/src/Managers/profilesystem.lua
═══════════════════════════════════════════════════════════
A) ProfileSystem.new({ KeyUrl, ShowFPS=true, ShowPing=true })
B) Parse line 2 of remote file for tier: "free" / "premium" / "vip"
C) Fetch avatar via Players:GetUserThumbnailAsync(), display username + tier badge
D) Tier: premium=user-check(gold), vip=star(purple), free=user(default)
E) FPS: RunService.RenderStepped, rolling 30-frame average, rocket icon
F) Ping: Stats["Data Ping"], map to signal-zero/low/medium/high icons with colors
G) Layout: avatar(50x50) + username + badge | FPS + MS bar below
H) Theme Selector dropdown inside this panel:
   - Lists all available themes from Themes.lua
   - Hover preview (temporary apply), click to confirm
   - Saves selected theme to writefile("NL_Theme.txt")
   - Loads on startup before rendering

═══════════════════════════════════════════════════════════
TASK 8 — CREATE framework/src/Managers/hotkeys.lua
═══════════════════════════════════════════════════════════
A) HotkeyManager:Bind({ Key, Label, Toggle, DefaultActive, Callback })
B) HotkeyManager:BindToToggle({ Key, Label, Toggle }) — links to a NovaLib Toggle element
C) HotkeyManager:Unbind(keyCode)
D) HotkeyManager:OpenRebindPanel() — lists all binds, click [✏] then press new key
   Conflict detection: if key already bound, show warning. ESC = cancel rebind.
E) Toggle indicator badge: floating label showing bind label + on/off dot
F) Persistence: writefile("NL_Hotkeys.json") on every change, load on init
G) HotkeyManager:GetState(keyCode) | SetState(keyCode, bool) | ResetAll() | Destroy()

═══════════════════════════════════════════════════════════
TASK 9 — CORE ELEMENT UPGRADES (NovaLib.lua)
═══════════════════════════════════════════════════════════
A) Animated Tab Transitions:
   Tab config: Style = "Slide" or "Fade" (default "Fade")
   Fade: active frame transparency 0→1 (0.15s), new frame 1→0 (0.15s)
   Slide: active frame moves out, new frame moves in (direction by tab order)
   Tab indicator bar slides to new tab position using TweenService.
   Queue clicks during transition.

B) Element Search Bar:
   Window config: Searchable = true → renders search row at top
   [🔍] icon left, [×] clear right (visible when text non-empty)
   Filters element Labels (case-insensitive substring match) in real time.
   Hides sections if all children hidden. Shows "No results for '...'" if empty.
   ESC clears field.

C) Collapsible Sections:
   Section config: Collapsible = true (default), DefaultCollapsed = false
   Header click → tween height (Quad, 0.2s), rotate arrow icon 90°
   section:Collapse() | section:Expand() | section:Toggle()
   State saved per section key to writefile("NL_Sections.json")

D) Separator Element:
   section:Separator({ Label = "Advanced", Icon = "settings" })
   -- or section:Separator() for plain line

E) Progress Bar Element:
   local bar = section:ProgressBar({ Label, Min, Max, Value, Color })
   bar:SetValue(n) — animates fill
   bar:SetColor(color3)

F) Tooltip System:
   element:SetTooltip({ Icon, Text })
   Appears after 0.4s hover delay, above element (flips below if near top edge)
   Fade in/out. Never clips offscreen.

G) Element Disable State:
   element:SetEnabled(bool) — disabled = opacity 0.4, no interaction

H) Tab Badge:
   tab:SetBadge(count) | tab:ClearBadge()

I) Click-to-Copy Label:
   section:CopyLabel({ Label, Value, Icon="copy" })
   Click → setclipboard(Value) → brief "Copied!" feedback on label

J) Announcement Banner:
   window:SetBanner({ Text, Speed=60, Icon, Color }) | window:ClearBanner()
   Scrolling marquee strip at top of window.

K) Multi-Select Dropdown:
   section:MultiDropdown({ Label, Options, Default, Callback })
   Checkmarks on selected items. "X selected" summary when closed.

L) Window Drag Constraint:
   Clamp dragged window position to screen bounds.
   Optional SnapToEdges = true config for quadrant snapping.

═══════════════════════════════════════════════════════════
TASK 10 — UPDATE example.lua
═══════════════════════════════════════════════════════════
Add complete working examples for:
- KeySystem with GetKeyUrl + DiscordUrl (and show nil versions hiding buttons)
- KeySystem with AllowClose, EscToClose examples
- ProfileSystem with theme selector
- HotkeyManager:Bind basic + Toggle + BindToToggle
- HotkeyManager:OpenRebindPanel()
- NovaLib:Notify all four types
- section:Separator, ProgressBar, CopyLabel
- window:SetBanner
- Tab with SetBadge
- Collapsible section with DefaultCollapsed
- element:SetTooltip and element:SetEnabled

Comment every config key explaining what it does.

═══════════════════════════════════════════════════════════
TASK 11 — ADD HEADER COMMENT BLOCKS TO NEW MANAGER FILES
═══════════════════════════════════════════════════════════
keysystem.lua header:
-- [[
--   NovaLib KeySystem v2 — Optional Module
--   ─────────────────────────────────────────
--   Include this file only if your script requires key-gating.
--   If you do not require() this file, no key gate is shown.
--
--   Remote file format (line 1 = key, line 2 = tier):
--     MY-SECRET-KEY-2025
--     premium
--
--   Secondary buttons are optional:
--     GetKeyUrl  = nil → hides Get Key button
--     DiscordUrl = nil → hides Discord button
--
--   Close behavior defaults to none (key cannot be skipped).
--   Enable any of: AllowClose, EscToClose, BackdropClose.
-- ]]

hotkeys.lua header:
-- [[
--   NovaLib HotkeyManager — Optional Module
--   ─────────────────────────────────────────
--   Register named keybinds with callbacks or direct Toggle element links.
--   Users can rebind any registered key via HotkeyManager:OpenRebindPanel().
--   Toggle binds fire callback(true/false) on every press.
--   All bindings are saved and restored automatically.
-- ]]

═══════════════════════════════════════════════════════════
AFTER ALL TASKS — VERIFICATION CHECKLIST
═══════════════════════════════════════════════════════════
□ Amethyst theme correct, no "Midnight" references remain
□ Notifications stack, queue, slide in/out correctly
□ TopBar no color seam
□ Fonts correct: Sour Gummy body, VT323 KeySystem only
□ Intro animation: letters blow in staggered, blow out together
□ KeySystem: Get Key hidden when GetKeyUrl = nil
□ KeySystem: Discord hidden when DiscordUrl = nil
□ KeySystem: CloseGUI, Minimize, Reset all functional
□ KeySystem: State machine transitions correctly
□ KeySystem: Typewriter status for all phases
□ HotkeyManager: Bind, BindToToggle, OpenRebindPanel all work
□ HotkeyManager: persistence (writefile/readfile round-trip)
□ Profile: theme selector live-previews and saves
□ Tabs: animated transitions (Fade or Slide)
□ Search bar: filters elements and sections live
□ Collapsible: animates, state saved
□ All new elements (Separator, ProgressBar, CopyLabel, Banner, MultiDropdown)
□ Tooltips visible, positioned correctly, no clipping
□ example.lua compiles and demonstrates all new systems
```

---

## 📁 File Structure After All Changes

```
framework/
├── src/
│   ├── Components/
│   │   ├── Notification.lua    ← MODIFIED (solid style + queue)
│   │   ├── Tooltip.lua         ← NEW
│   │   ├── ContextMenu.lua     ← NEW
│   │   └── ...
│   ├── Managers/               ← all optional, creator requires only what they need
│   │   ├── keysystem.lua       ← NEW (v2: state machine, close logic, optional buttons)
│   │   ├── profilesystem.lua   ← NEW (avatar, tier, FPS, ping, theme selector)
│   │   ├── hotkeys.lua         ← NEW (rebindable hotkeys, toggle binds, rebind panel)
│   │   └── ...
│   ├── Themes/
│   │   └── Themes.lua          ← MODIFIED (Midnight → Amethyst)
│   └── Elements/
│       ├── Separator.lua       ← NEW
│       ├── ProgressBar.lua     ← NEW
│       ├── CopyLabel.lua       ← NEW
│       ├── MultiDropdown.lua   ← NEW
│       ├── ColorPicker.lua     ← NEW (future)
│       └── ...
├── NovaLib.lua                 ← MODIFIED (all core upgrades)
├── example.lua                 ← MODIFIED (all new systems demonstrated)
└── README.md
```

---

*NovaLib improvement suggestion document v3 — modular opt-in architecture, full KeySystem
redesign with optional buttons and close logic, HotkeyManager with toggle binds and rebind
panel, notification queue, animated tabs, search bar, collapsible sections, 14 new element
types and UI systems.*
