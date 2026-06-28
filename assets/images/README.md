# Images

Drop your image files (`.png`, `.jpg`, `.webp`, `.svg`) in this folder, then
point at them from `scripts/site_data.gd`, e.g.:

```gdscript
{ "image": "res://assets/images/pottery_01.jpg" }
```

Tips for a Godot **web** build (everything is downloaded up front):

- Pre-compress images before importing — aim for ~1600px on the long edge and
  save as JPG/WebP. A gallery of huge originals = a slow first load.
- This is the "handful of curated images" path. For a dense, full-res set,
  keep that page in plain HTML instead (ask and I'll build it).

`placeholder.svg` is the stand-in shown until you add real images.
