# Shareef Joseph — Portfolio (Godot)

A Godot 4 portfolio site built **node-first**: every page, card, label and grid
is a real node in a `.tscn` you can open and rearrange. No page is assembled in
code. Scripts only do behaviour (navigation, feeding a card's inspector text into
its nodes). The look is centralized in one theme.

## Open it

1. Godot **4.3+** → Import → pick `project.godot`.
2. Press Play (F5). The main scene is `scenes/LandingPage.tscn`.

## How it's wired

- **`scenes/LandingPage.tscn`** — the home page. A `GridContainer` of
  `CategoryCard` instances. Each card is a Button; in the Inspector you set
  **Target Scene** (open another page) or **External Url** (open a browser tab).
- **`scenes/pages/*.tscn`** — one scene per category (GameDev, DigitalArt,
  Blacksmithing, BowMaking, Pottery). Open one and you'll see the title, blurb,
  grids and cards as nodes. Rearrange freely.
- **`scenes/components/MediaCard.tscn`** — the reusable card. Select an instance
  and fill **Image / Title / Description / Link Text / External Url** in the
  Inspector (it updates live in the editor). Leave the text empty → it's a plain
  image tile; fill it in → it's a project card with a button.
- **`scenes/components/CategoryCard.tscn`** — the reusable landing tile (a Button).
- **`scenes/Background.tscn`** — the gradient backdrop, instanced into each page.
- **`theme/portfolio_theme.tres`** — colours, fonts, card/button styling. Tweak
  here and the whole site restyles. (It's the project's default theme, so every
  Control uses it automatically.)
- **`scripts/nav_button.gd`** — makes a Button navigate (Target Scene / External
  Url). **`scripts/media_card.gd`** — feeds a card's inspector fields into its
  nodes. That's all the code.

### Navigation is in-app, not HTML
"Links" are Godot scene changes (`change_scene_to_file`) driven by the
**Target Scene** path you set on each button — no HTML routing. The only
external links are the Writing card and the Game Dev "Play on itch.io" buttons.

## Common edits

| I want to…                | Do this |
|---------------------------|---------|
| Change a card's image/text | select the `MediaCard` instance → Inspector |
| Add a card                | duplicate a `MediaCard` instance in the grid |
| Add a category            | duplicate a page scene, then add a `CategoryCard` to the landing Grid and set its **Target Scene** |
| Change colours/fonts/shape | edit `theme/portfolio_theme.tres` |
| Add images                | drop files in `assets/images/`, then set them on a card's **Image** |

### Fonts (optional, to match the HTML exactly)
The HTML used *DM Serif Display* (headings) + *Quicksand* (body). Godot can't pull
Google Fonts at runtime — download the `.ttf`s into `assets/fonts/` and set them
in the theme (Default Font + a larger size on headings). Until then it uses
Godot's default font with the right sizes/colours.

## Pages that stay HTML

- **Writing** embeds live Google Docs, so it stays `web-extra/writing.html`. Its
  landing card uses **External Url = `writing.html`**.
- For a **high-res, image-heavy** page, keep it in plain HTML and link to it the
  same way (a CategoryCard with an External Url). Ask and I'll build one.

## Export to web (GitHub Pages)

1. **Project → Export → Add… → Web**.
2. **Turn Thread Support OFF** — GitHub Pages can't send the COOP/COEP headers the
   threaded build needs, so it would show a blank page there.
3. Export to a folder (Godot writes `index.html` + engine files).
4. Copy `web-extra/writing.html` and `web-extra/style.css` next to that
   `index.html` so the Writing button (and its "Back Home" link) work.
5. Push to your Pages repo.

> A Godot web build is canvas/WASM: it downloads the engine + all images up front
> and isn't SEO/selectable-text friendly. That's the trade for editing everything
> in Godot. The document-heavy Writing page staying HTML keeps it fast/indexable.

## Heads-up

Built without a Godot install to run against — treat it as v1. If anything errors
on first open (a theme key, a node path, a property name), paste the exact message
and I'll fix it.
