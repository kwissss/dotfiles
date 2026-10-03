# dotfiles

My dotfiles managed by [mise](https://mise.jdx.dev/dotfiles.html).

## Layout

- `mise.toml` - shared config: `[dotfiles]` entries, git identity `[vars]`, and
  the fisher bootstrap task. Symlinked to `~/.config/mise/config.toml` on apply,
  so it is also the global mise config.
- `mise.<machine>.toml` - per-machine overlays: `[tools]`, machine-only
  dotfiles, and the `machine` template var. Selected via `MISE_ENV`.
- `home/` - the dotfile sources. `home/config` is symlinked file-by-file into
  `~/.config`; `*.tmpl` files are rendered with the mise template engine
  (`~/.gitconfig`, `~/.ssh/config`).

SSH auth and git commit signing go through the 1Password SSH agent
(`op-ssh-sign`); no private key lives on disk.

## Machines

| Machine   | Device             | Shell | Packages      |
| --------- | ------------------ | ----- | ------------- |
| `cachyos` | Desktop (CachyOS)  | fish  | pacman + mise |

## Bootstrap (cachyos)

```bash
sudo pacman -S --needed fish ghostty ttf-firacode-nerd vim bat kubectl helm k9s flux krew
curl https://mise.run | sh   # installs ~/.local/bin/mise
git clone https://github.com/kwissss/dotfiles ~/.dotfiles
cd ~/.dotfiles
mise trust
mkdir -p ~/.config/mise
printf 'env = ["cachyos"]\n' > ~/.config/mise/miserc.toml
mise bootstrap --yes
```

`mise bootstrap` applies the dotfiles, installs the declared `[tools]`, and
runs the fisher task. Re-run it (or `mise dotfiles apply`) after pulling changes.
