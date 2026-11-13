# Persistence ownership

Hosts select backing directories; the module that owns a feature declares the
paths it needs. Preserve existing paths and permissions when moving declarations.

| Setting | Owner |
| --- | --- |
| `persistence.stateRoot`, `persistence.dataRoot` | `hosts/<host>/persist.nix` |
| Backing filesystems and `neededForBoot` | Host disk/hardware configuration |
| Preservation setup, common mount options, Home Manager bridge | `persistence/default.nix` |
| `home.persist` option declarations | `misc/home-manager.nix` |
| NixOS identity, logs, systemd state, root's Nix cache | `system/base.nix` |
| NetworkManager and desktop power state | `desktop/default.nix` |
| Service state (Tailscale, Samba, Bluetooth, Waydroid) | The corresponding service module |
| Application state in the home directory | The Home Manager module enabling that application or application bundle |
| Personal directories and private-directory permissions | `users/arcohol.nix` |
| Host-specific exceptions, such as M2's SSH host keys | The host module beside the relevant service configuration |

System services declare paths through
`preservation.preserveAt.${config.persistence.stateRoot}`. Home Manager modules
use `home.persist.directories` or `home.persist.files`; the bridge maps these to
the state root for each configured user. Darwin accepts these declarations but
has no preservation implementation.

Personal documents and projects use `config.persistence.dataRoot`. Merlot uses
`/storage`; M2 uses `/persist`. The two roots may be identical, so declarations
for both roots in the same module must use `lib.mkMerge` to avoid duplicate
attribute definitions.

Permissions and per-path flags belong beside the path declaration (`mode`,
`inInitrd`, or `how`), not in the backing filesystem configuration. Home Manager's
current interface accepts strings; permission-bearing user entries therefore
remain in the NixOS user module.

Linux base, user, and service modules currently assume that the host imports
`persistence`. Supporting non-persistent Linux hosts is a separate change.
