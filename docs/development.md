# dst 101 — development

status: production reference

## scope

this note owns what the implementation accepts and how to work on it: the topic schema, what validation does and does not prove, rendering and navigation behavior, the asset pipeline, and the build workflow.

[`voice-and-philosophy.md`](voice-and-philosophy.md) owns how the handbook writes and teaches. [`editorial-grammar.md`](editorial-grammar.md) owns where information belongs on a page and how images support it.

the shell and authoring grammar are established. renderer rules protect consistency and prevent broken layouts without dictating one composition for every topic, so avoid turning today's successful page into tomorrow's mandatory template. prefer reusable behavior (balanced wrapping, validation, automatic decorative variants, generic block rendering) over topic-specific branches. a topic-specific renderer exception needs a concrete content problem the reusable grammar cannot express cleanly, not a page that would merely be easier to hard-code.

## repository map

```text
modmain.lua                           assets, shortcuts, HUD button, hot reload
modinfo.lua                           mod metadata and config options
scripts/dst101topics/                 topic modules (English, the source)
scripts/dst101data.lua                ordered topic loader and interface strings
scripts/dst101translations.lua        translation registry
scripts/dst101translations/<code>/    translated strings and topics
scripts/dst101validate.lua            authoring validation
scripts/dst101layout.lua              source-coordinate layout
scripts/widgets/dst101widget.lua      handbook renderer
scripts/widgets/dst101quietimagebutton.lua  handbook-local button
scripts/screens/dst101popupscreen.lua popup and keyboard handling
scripts/dst101illustrations.lua       generated scene manifest
source/assets/illustrations/          production scene PNGs
source/assets/icons/                  topic and search icons
source/assets/ui/                     shell and UI source PNGs
source/fonts/alegreya/                font sources and charset
images/illustrations/                 generated scene atlases
images/topics/                        generated topic icon atlases
images/ui/                            generated UI atlases
fonts/                                generated bitmap fonts
tools/                                build and preparation helpers
.build/                               ignored build intermediates and release copies
```

## build workflow

this is the one build workflow; other documents link here.

### prerequisites

- PowerShell 7. the illustration, shell and preparation scripts declare `#Requires -Version 7.0`.
- ImageMagick's `magick` on `PATH`, for illustration preparation and every atlas builder.
- Docker with the `dstmodders/ktools:4.5.1` image. every builder that writes a `.tex` (atlases, shells and fonts) runs `ktech` from it.
- `pngquant` on `PATH`, for `prepare_illustration.ps1`. the script looks it up before doing anything, so it is required even when it ends up keeping the lossless resize.
- BMFont, for `build_alegreya_fonts.ps1` only. the script expects it at the `$bmfont` path near its top.
- Python (`py`), for `build_release.py`, and for `check_handbook.py` with `lupa` installed.
- [StyLua](https://github.com/JohnnyMorganz/StyLua), for formatting.

### the loop

1. edit the source.
2. run the builder for what changed.
3. reload or restart as the table says. after a Lua or topic change, `py tools/check_handbook.py` runs the loader and validation in every registered language without the game (it needs `py -m pip install lupa` once). the same check runs on every push and pull request.
4. look at the result in game at actual size. validation proves structure, not fit (see [what validation does not prove](#what-validation-does-not-prove)).
5. format Lua from the repository root with `stylua .`. `stylua.toml` holds the settings, and `.styluaignore` leaves topic data and the generated manifest alone.
6. commit the source and its generated outputs together.

```text
changed                                    run                                      then
scripts/ Lua, topic data                   nothing                                  hot reload
source/assets/illustrations/*.png          .\tools\build_illustration_atlases.ps1   restart DST
source/assets/icons/                       .\tools\build_topic_atlases.ps1          restart DST
handbook_base.png or handbook_page.png     .\tools\build_handbook_shell.ps1         restart DST
other source/assets/ui/ artwork            .\tools\build_ui_atlas.ps1               restart DST
source/fonts/alegreya/ or charset.txt      .\tools\build_alegreya_fonts.ps1         restart DST
modmain.lua or modinfo.lua                 nothing                                  reload the mod
```

the game loads only the generated outputs, and the repository is itself the dev mod folder. a source change without its outputs is not what anyone sees in game, and outputs without their sources cannot be rebuilt, so the two always land in the same commit.

source files use LF line endings; `.gitattributes` enforces it.

### hot reload

the reload shortcut is the `Developer: reload handbook key` option in the mod config, disabled by default. it clears every module with `dst101` in its name and, if the handbook was open, reopens it at the same topic and page.

it covers topic data, layout, widget, screen, loader, validator and manifest code.

it does **not** reload rebuilt `.tex` assets or fonts. those normally need a DST restart. changes to `modmain.lua` or `modinfo.lua` need a proper mod or game reload, because startup handlers and config metadata are registered only once.

`tools/handbook_overview.ps1` lists topics in sidebar order with page counts, page headings and illustrations without starting the game.

## topic schema

`dst101data.lua` loads the topic modules in sidebar order, swapping in any [translated](#translations) ones, then runs `dst101validate.lua`. an authoring error stops the handbook from opening, with a message naming the topic, page and region.

a topic holds `id`, `title`, `icon`, optional `tags`, and `pages`. a page holds an optional `illustration` name and a `regions` table.

the five authored block regions, and the block types each renders:

```text
top_left              headline, subtitle, page_heading, heading, text, bullets
right                 heading, text, bullets
bottom_left           text, bullets, related_topics
illustration_caption  caption
note                  note
```

the illustration is a page field, not a block region, and the footer is generated navigation. neither is authored as a block list.

`top_left` is intentionally flexible. it is not a dedicated title slot.

## authoring rules enforced by validation

- topic ids exist and are unique.
- every topic has a title, an icon, and at least one page with a `regions` table.
- every block has its text, except headlines (which fall back to the topic title) and related topics; bullets have items.
- every region is one of the five above and holds only the block types it renders. anything else would silently vanish.
- a note region holds at most one note.
- a headline is immediately followed by a subtitle, and a subtitle never appears without its headline.
- `page_heading` appears only as the first `top_left` block on page 2 or later.
- an illustrated page has an `illustration_caption` region with exactly one caption; a page without an illustration has no caption region.
- a non-empty right column begins with a heading, and every right-column heading has body content (`text`, `bullets`, or both).
- adjacent `text` blocks in the right column are always rejected. paragraphs go inside one text block, separated by blank lines. multi-paragraph text is written between `[[` and `]]`, never with `\n` escapes.
- `bottom_left` has no headings.

related topics:

- at most one `related_topics` block per topic, on page 1, as the only block in `bottom_left`. the renderer adds the `Related topics` heading above it from the interface strings.
- 2–4 distinct, valid topic ids, never the topic itself.

### what validation does not prove

validation checks structure, not that every word is visible. the renderer truncates rather than overflowing in these places:

```text
caption             one line
note                two lines
headline fallback   two lines, when even the wrapped treatment does not fit
```

body regions are not measured against the page either. read every changed page in game at actual size.

## rendering

### coordinate system

the handbook uses the high-resolution `1533x865` source coordinate system from `dst101layout.lua` and scales the whole `design_root` for display. overall size and placement are locked unless real content exposes a problem.

### typography

```text
body:                          dst101_alegreya_regular
subtitle/caption/note:         dst101_alegreya_italic
headline/page_heading/heading: HEADERFONT
```

```text
page_heading size        30
page_heading line_height 30
page_heading spacing      4

heading size             36
heading line_height      36
heading spacing           5

body size                24
body spacing             32
```

`spacing` is the gap after a block ends, not line spacing.

the fixed heading `line_height` keeps divider placement stable despite glyph-height differences between headings.

### headlines

```text
one line -> 64
wrapped  -> 48, maximum two lines
```

a headline stays at the large one-line size whenever it fits. only a headline that cannot fit switches to the two-line treatment, with a balanced word-boundary split. if it still does not fit, rewrite it rather than shrinking type; the fallback truncates.

### headings and page headings

`heading` and `page_heading` stay on one line whenever they fit. one that cannot fit is split into two balanced lines at a word boundary, which prevents weak orphan lines such as a single final word while leaving shorter headings unchanged.

`page_heading` uses `HEADERFONT` at size `30` and creates no divider.

### text-only openings

when `top_left` begins with body text rather than a headline, page heading or heading, the renderer applies:

```text
vertical offset: 24 source units
left inset:      20 source units
```

this makes prose-only openings look intentional without forcing a headline.

### dividers

authors do not choose divider presence or variant.

```text
heading      -> automatic divider
headline     -> no divider
page_heading -> no divider
text         -> no divider
```

the variant (`divider_01` … `divider_06`) comes from a stable hash of topic, page, region and block position. related-topic tile variants and the note animal work the same way, so adding content elsewhere never reshuffles existing pages.

### bullets

```text
marker:          ◆
marker size:     84% of body size
marker width:    16
marker/text gap: 7
item gap:        3
```

marker and text are separate widgets so wrapped items keep their hanging indentation.

### notes

when a page has no note, the note strip and animal are hidden.

```text
crow
catcoon
splumonkey
```

each topic gets a starting animal from a hash of its id, which then rotates by page number. text clearance adapts to the current animal.

### related topics

the layout supports up to four tiles under a heading the renderer draws from the interface strings. content data chooses only the linked topic ids; the renderer gives the whole tile group one stable decorative variant per topic.

### page footer

single-page topics show the plain fleur divider. multi-page topics show:

```text
previous button
Previous page
asymmetric fleur
page counter
Next page
next button
```

footer buttons page only within the current topic; keyboard paging crosses topics.

## navigation and search

### opening the handbook

- the configured shortcut, `B` with no modifier by default (`open_shortcut` and `open_modifier` in `modinfo.lua`). modifier matching is exact, so `Ctrl` also requires Shift and Alt to be up.
- the HUD button beside the map controls, unless `show_hud_button` turns it off. its tooltip names the shortcut.
- a controller's Menu Misc 3 button, or an LB+RB skill slot instead when the Simple Controller mod is active.

it opens only from the normal HUD, not over another screen.

plain typing shortcuts are ignored while a text field is active; modified chords still work. an open shortcut that the handbook also navigates with (WASD, arrows, Enter, Escape, Tab) does not close it while it is open.

closing stores the topic, page and Contents position on the player, so it lasts until the player entity goes away, not across launches. reopening returns there unless `reopen_behavior` is set to always open Contents.

### contents

Contents is the first sidebar entry and where a fresh handbook opens. it lists every topic with its pages in a grid on the frameless `handbook_base` shell: page 1 by its headline, later pages by their `page_heading`, or `Page N` without one.

when the grid needs more than one Contents page, a numbered page selector appears on the right. the mouse wheel over the grid turns Contents pages; elsewhere it scrolls the sidebar.

`Tab` toggles between Contents and the topic page it was opened from.

### keyboard

```text
Up / W    -> previous topic, page 1
Down / S  -> next topic, page 1
Left / A  -> previous page; from page 1, previous topic's final page
Right / D -> next page; from final page, next topic's page 1
Tab       -> Contents, or back to the page it was opened from
Enter     -> start search
Escape    -> leave search, otherwise close the handbook
```

stepping before the first topic reaches Contents.

while search is active, Left/Right keep normal text-cursor behavior, Up/Down move through the filtered results and open their matching pages, and WASD is ordinary text input.

### search

search indexes topic title, topic tags, headline, subtitle, page heading, heading, body text, bullets, caption and note. matching ignores case, including the accented capitals the handbook font covers (Latin-1 and Latin Extended-A).

page selection:

```text
exact page_heading match -> that page
topic title/tag match    -> page 1
other page-content match -> first matching page
```

a growing query may move the current topic to its matching page. a shrinking or cleared query never changes the page by itself, and manual paging while search stays active wins. a query that matches nothing shows `No matches` in the sidebar and leaves the current page open.

- the `×` button clears the query and keeps the field active.
- clicking a topic while searching keeps the field active, so typing can continue.
- `Escape` leaves search and clears a non-empty query; the next press closes the handbook.
- `Ctrl+Backspace` deletes the previous word.

### sidebar

sidebar order (`TOPIC_MODULES` in `dst101data.lua`) is loose thematic grouping for readability, not a progression path or recommended play order. players should stay free to jump to whatever interests or troubles them.

sixteen topic slots are visible. the mouse wheel, the baked scrollbar arrows, track clicks, slider drags and keyboard topic navigation all move `topic_scroll_index`, the single source of truth for the scroll position. search-filtered lists get the right scroll range automatically.

### quiet buttons

handbook controls use `scripts/widgets/dst101quietimagebutton.lua` instead of the normal `widgets/imagebutton`. it keeps focus visuals, hover textures, clicking and click sounds, but drops the hover and focus sounds, so moving the mouse across the book stays quiet.

it is local on purpose: muting DST's UI sounds globally would silence every other screen too.

## asset pipeline

### canonical sources and intermediates

`source/assets/illustrations/*.png` holds the canonical editable artwork: one prepared `573x321` PNG per scene, matching the illustration opening exactly so it renders 1:1 without stretching. keep, review and edit that file. paintovers, character corrections and other art fixes go directly into it, followed by an atlas rebuild.

larger image-generation outputs are working intermediates. they do not belong in the repository unless one has editing value the production image cannot preserve.

prepare one source image from anywhere:

```powershell
.\tools\prepare_illustration.ps1 `
    -Source '<master.png>' `
    -Name '<scene_name>'
```

it center-crops and resizes to `573x321`, then keeps the `pngquant` result only if it meets the quality floor and is smaller. the master stays untouched, so a crop can always be revised.

`build_illustration_atlases.ps1`:

- checks that every production image is `573x321` with a lower-case `snake_case` name.
- packs a `3x5` grid of `672x400` cells into atlases of at most `2048x2048`. the cell padding protects sampling at the image edges.
- writes the runtime `.tex/.xml` files and regenerates `scripts/dst101illustrations.lua`, which tells the renderer which atlas holds each scene.

### other builders

```text
tools/build_handbook_shell.ps1     handbook_base / handbook_page shells
tools/build_ui_atlas.ps1           UI atlas and Contents grid atlas
tools/build_topic_atlases.ps1      colour and grayscale topic icons
tools/build_alegreya_fonts.ps1     bitmap fonts (BMFont + ktech in Docker)
```

runtime outputs:

```text
images/ui/handbook_base.tex/xml
images/ui/handbook_page.tex/xml
images/ui/dst101_ui.tex/xml
images/ui/dst101_toc_grid.tex/xml
images/topics/dst101_topics_color.tex/xml
images/topics/dst101_topics_gray.tex/xml
images/illustrations/dst101_illustrations_*.tex/xml
fonts/dst101_alegreya_regular.zip
fonts/dst101_alegreya_italic.zip
```

## translations

English in `scripts/dst101topics/` and `dst101data.lua`'s `ENGLISH_STRINGS` is the source. a translation may cover any part of it; everything else stays English, so one can grow a topic at a time.

to add or extend a language:

1. use the game's language code (`fr`, `de`, `pl`, `ru`, ...) so the `Game language` option finds it. a language the game does not offer, such as `nb`, also needs a line in `modinfo.lua`'s `language` option.
2. register it in `scripts/dst101translations.lua` with the ids of the topics it translates.
3. add `scripts/dst101translations/<code>/strings.lua`, returning the interface strings it translates. keys match `ENGLISH_STRINGS`; `page` is a `string.format` pattern such as `Page %d`.
4. copy each listed topic from `scripts/dst101topics/` to `scripts/dst101translations/<code>/` and translate its text and tags. keep the id, illustrations and related topic ids. pages may be reworded or split differently when the language needs it; validation applies as usual.
5. read every translated page in game. longer languages overflow first in captions (one line), notes (two lines) and the right column.

loading fails with a message for an unknown string key, a registered topic that does not exist, or a translated topic with a changed id.

the handbook's body font covers Latin-1 and Latin Extended-A, which suits most western and central European languages. Cyrillic, Greek, CJK or Romanian `ș`/`ț` need glyphs added to `source/fonts/alegreya/charset.txt` and a font rebuild, if Alegreya has them. HUD key names come from the game in its language. `modinfo.lua` labels stay English.

## workshop releases

the repository is the dev copy. build a release copy for the Don't Starve Mod Tools ModUploader:

```powershell
py .\tools\build_release.py 1.1.0
```

the copy lands in `.build/release/<yyyyMMdd-HHmmss>/` with only runtime files and licenses, the name `DST 101`, the given version, and no developer reload options. point ModUploader at that folder.

the version must differ from the one on the Workshop. ModUploader writes it to the item's version tag, which DST compares with installed copies, so publish through ModUploader rather than SteamCMD, which cannot set tags.
