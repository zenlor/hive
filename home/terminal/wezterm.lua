local w = require 'wezterm'
local act = w.action
local c = w.config_builder()

if w.target_triple == 'x86_64-pc-windows-msvc' then
  c.default_prog = {'wsl.exe', '~', '-d', 'nix'}
end

if w.target_triple == 'x86_64-apple-darwin' then
end

if w.target_triple == 'x86_65-unknown-linux-gnu' then
end


c.use_fancy_tab_bar = true
c.tab_bar_at_bottom = false

c.max_fps = 144 -- Gsync monitor!
c.prefer_egl = true

c.color_scheme = 'Tokyo Night' --'Gruvbox Dark (Gogh)'

c.font = w.font 'Iosevka Term' --'IBM Plex Mono'
c.font_size = 14

-- muxing
c.leader = {key='b', mods='CTRL', timeout_milliseconds=500}

c.keys = {
  {key='a', mods='LEADER|CTRL', action=act.SendKey{key='a', mods='CTRL'}},
  {key='[', mods='LEADER', action=act.ActivateCopyMode},
  {key='f', mods='ALT',    action=act.TogglePaneZoomState},
  {key='c', mods='LEADER', action=act.SpawnTab 'CurrentPaneDomain'},
  {key='n', mods='LEADER', action=act.ActivateTabRelative(1)},
  {key='p', mods='LEADER', action=act.ActivateTabRelative(-1)},
  {key='w', mods='LEADER', action=act.ShowTabNavigator},
  {key='s', mods='LEADER', action=act.SplitVertical { domain = 'CurrentPaneDomain' }},
  {key='v', mods='LEADER', action=act.SplitHorizontal { domain = 'CurrentPaneDomain' }},
  {key="h", mods="LEADER", action=act.ActivatePaneDirection("Left")},
  {key="j", mods="LEADER", action=act.ActivatePaneDirection("Down")},
  {key="k", mods="LEADER", action=act.ActivatePaneDirection("Up")},
  {key="l", mods="LEADER", action=act.ActivatePaneDirection("Right")},
  {key="H", mods="LEADER", action=act.ActivateTabRelative(-1) },
  {key="L", mods="LEADER", action=act.ActivateTabRelative(1) },
}

for i = 1, 8 do
  table.insert(c.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

c.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

return c
