# Setup homepage metadata status

Date: `2026-06-16`

## Result

The homepage code that serves `https://hermes-agent.nousresearch.com/` and the live `/desktop` download section is **not present in this repository**.

What is in this repo:

- `website/` is a Docusaurus docs site deployed to `/docs/`
- `.github/workflows/deploy-site.yml` triggers a **separate Vercel deploy hook**
- there is no local source file for the live Next.js/Vercel homepage route that renders `/desktop`

## Missing homepage path / repo

Missing codebase:

- the external Next.js/Vercel homepage project for `https://hermes-agent.nousresearch.com/`
- specifically the route/component that renders the live `#downloads` section on `/desktop`

Missing local path in this repo:

- there is no matching source under `website/src/pages`, `website/static`, or `website/docs`

## Current live download links

Observed from the live `/desktop` HTML payload on `2026-06-16`:

- Windows: `https://hermes-assets.nousresearch.com/Hermes-Setup.exe?build=c6b0eb4de0e5`
- macOS: `https://hermes-assets.nousresearch.com/Hermes-Setup.dmg?build=c6b0eb4de0e5`
- Linux: `https://github.com/NousResearch/hermes-agent/releases`

## Build metadata now generated in this repo

Updated workflows:

- `.github/workflows/build-bootstrapper.yml`
- `.github/workflows/release-bootstrapper.yml`

Generated file:

- `apps/bootstrap-installer/src-tauri/target/release/setup-metadata.json`

Schema:

```json
{
  "version": "v0.1.1-noverhead-rc.2",
  "commit": "b24c4a471",
  "builtAt": "2026-06-16T12:34:56Z",
  "fileName": "NOverhead-Agent-Desktop-Setup.exe",
  "sha256": "<sha256>",
  "channel": "stable"
}
```

Notes:

- `sha256` is computed from the actual built `.exe` via `Get-FileHash`
- release builds upload `setup-metadata.json` as a GitHub Release asset next to the installer
- branch builds upload `setup-metadata.json` as a workflow artifact

## Homepage file that must be changed later

The future homepage fix must happen in the external homepage repo that owns:

- `/desktop`
- the download cards / download button URLs
- the runtime data source for `windows`, `mac`, and `linux` download targets

That homepage route/component must be updated to either:

- fetch `setup-metadata.json` from the release asset or asset host, or
- fetch a derived `latest.json`/manifest generated from the same metadata, or
- have the metadata injected during that homepage build/deploy

This repo alone cannot make the live homepage show `Version`, `Commit`, `Built`, and `SHA256`, because the rendering code for that page is not present here.
