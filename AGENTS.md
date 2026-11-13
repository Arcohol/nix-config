# Guidelines

- Keep changes simple, focused, and consistent with nearby code.
- Share common settings; keep host-specific settings in `modules/hosts/<host>/`.
- Every `.nix` file under `modules/` is automatically imported as a flake-parts module.
- Run `nix fmt` and `git diff --check`; evaluate affected hosts.
- For refactors, compare system derivation paths and investigate differences.
- Use Conventional Commits, e.g. `refactor(persistence): simplify configuration`.
