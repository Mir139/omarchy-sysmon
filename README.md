# omarchy-sysmon

A tiny [Omarchy](https://omarchy.org) top-bar module showing **CPU load**, **Intel iGPU load** and **RAM used**:

```
󰻠 12%  󰢮 3%  󰍛 8.2G
```

Hover for details; click to open `btop`.

## How it works

It is a plain `command` bar module (no QML, no plugin), a ~80-line bash script:

- **CPU**: delta of `/proc/stat` between two runs.
- **GPU**: 100% minus the time spent in RC6 (GPU idle state) from sysfs. No root, no `intel_gpu_top`. Works with the `i915` and `xe` drivers. The GPU part is hidden if neither is found.
- **RAM**: `MemTotal - MemAvailable` from `/proc/meminfo`.

State between runs is kept in `$XDG_RUNTIME_DIR/omarchy-sysmon.state`.

## Install

Requires `jq` and a Nerd Font (Omarchy ships one).

```bash
git clone https://github.com/Mir139/omarchy-sysmon && cd omarchy-sysmon
./install.sh
```

This copies the script to `~/.config/omarchy/bar/scripts/`, adds the module to the right of the bar in `~/.config/omarchy/shell.json` (backup saved as `shell.json.bak.sysmon`). Equivalent manual entry:

```json
{
  "id": "sysmon",
  "type": "command",
  "exec": "~/.config/omarchy/bar/scripts/sysmon-status",
  "interval": 2,
  "onClick": "omarchy-launch-or-focus-tui btop"
}
```

Uninstall with `./uninstall.sh`.

## Limitations

- Intel GPUs only (NVIDIA/AMD would need `nvidia-smi` / `gpu_busy_percent`).
- The GPU figure is derived from RC6 residency, so it is an approximation of the busy time.

## License

MIT
