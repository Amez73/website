# Deploying to shareefjoseph.com (GitHub Pages + CI)

Every push to `master` triggers `.github/workflows/deploy.yml`, which exports the
Godot web build and publishes it to GitHub Pages. One-time setup:

## 1. Confirm the export preset (do this once in the editor)
The repo ships a `Web` preset in `export_presets.cfg`, but open the editor to be
sure it's valid for your Godot version:

1. **Project → Export… → Web**.
2. Make sure **Thread Support is OFF** (Variant section). GitHub Pages can't send
   the COOP/COEP headers that the threaded build needs, so threads ON = blank page.
3. Set **Export Path** to `build/web/index.html` if it isn't already.
4. Close the dialog (this re-saves `export_presets.cfg` correctly). Commit it.

## 2. Match the Godot version in CI
Open `.github/workflows/deploy.yml` and set `GODOT_VERSION` to your exact editor
version (**Help → About**). It's currently `4.6`.

## 3. Push to GitHub
```bash
git remote add origin https://github.com/Amez73/<repo-name>.git
git push -u origin master
```

## 4. Enable Pages + custom domain
In the GitHub repo:

1. **Settings → Pages → Build and deployment → Source = GitHub Actions.**
2. **Settings → Pages → Custom domain → `shareefjoseph.com`** → Save.
3. At your DNS provider, point the domain at GitHub Pages:
   - apex `shareefjoseph.com` → four `A` records to GitHub's IPs
     (`185.199.108.153`, `.109.153`, `.110.153`, `.111.153`), and/or
   - `www` → `CNAME` to `amez73.github.io`.
4. Re-tick "Enforce HTTPS" once the cert provisions.

## 5. Done
Push anything → the Action builds the web export, copies in `writing.html` +
`style.css` + `CNAME`, and deploys. The site appears at shareefjoseph.com.

> If the Action fails on the Godot download step, the `GODOT_VERSION` release/
> templates probably don't exist under that exact tag — set it to a version that
> does (e.g. the latest stable shown on the Godot downloads page).
