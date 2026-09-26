# dst 101 — development

status: production reference

project:

```text
D:\dev\projects\dst\dst-101
```

## scope

this note documents the technical handbook implementation.

use the separate voice/philosophy note for writing decisions and the editorial grammar note for composition and image direction.

the shell and authoring grammar are considered established. add new structural systems only when real content exposes a concrete limitation, and prefer reusable behavior over topic-specific renderer branches.

## main project areas

```text
scripts/dst101topics/                 topic modules
scripts/dst101data.lua                ordered topic loader
scripts/dst101validate.lua            authoring validation
scripts/widgets/dst101widget.lua      handbook renderer
scripts/screens/dst101popupscreen.lua popup / keyboard handling
scripts/dst101illustrations.lua       generated scene manifest
source/assets/illustrations/          production scene PNGs
source/assets/icons/                  topic/search icons
images/illustrations/                 runtime scene atlases
images/topics/                        topic icon atlases
images/ui/                            runtime UI atlas
tools/                                build/preparation helpers
```

## handbook coordinate system

the handbook uses the high-resolution `1533x865` source coordinate system and scales the full `design_root` for display.

overall size and placement are considered locked unless real content exposes a problem.

main authored regions:

```text
top_left
illustration
illustration_caption
bottom_left
right
note
bottom_footer
```

`top_left` is intentionally flexible. it is not a dedicated title slot.

## block types

current reusable content blocks:

```text
headline
subtitle
page_heading
heading
text
bullets
related_topics
spacer
caption
note
```

normal authored data should stay inside these reusable types rather than creating topic-specific renderer branches.

## topic ordering

sidebar order uses loose thematic grouping for readability. it is not a progression path, prerequisite tree, or recommended play order.

related subjects may sit near one another, and foundational topics may appear earlier, but players should remain free to jump directly to whatever interests or troubles them.

## authoring grammar enforced by validation

`dst101data.lua` loads the ordered topic modules, then runs `dst101validate.lua`.

currently enforced:

- topic ids exist and are unique.
- headline is immediately followed by subtitle.
- subtitle never appears without its headline.
- `page_heading` may appear only as the first `top_left` block on page 2+.
- each page may contain at most one non-empty `page_heading`.
- every illustrated page has exactly one non-empty caption block.
- caption regions do not exist without an illustration.
- non-empty right columns begin with a heading.
- each right-column heading has body content.
- right-column body currently uses `text` and/or `bullets`.
- no consecutive right-column text blocks for one thought.
- `bottom_left` does not use normal headings; `Related topics` is the only allowed heading there.
- related topics appear at most once per topic.
- related topics live in `bottom_left` on page 1 only.
- when present, `bottom_left` contains only the `Related topics` heading and related topics.
- they immediately follow `Related topics`.
- they are the final block in `bottom_left`.
- they contain 2–4 distinct valid topic ids.
- a topic cannot link to itself.

## typography

custom fonts:

```text
body:              dst101_alegreya_regular
subtitle/caption:  dst101_alegreya_italic
headline/page_heading/heading: HEADERFONT
```

important values:

```text
page_heading size        30
page_heading line_height 30
page_heading spacing      4

heading size             36
heading line_height      36
heading spacing           5

body size                24
body spacing        32
```

fixed heading `line_height` keeps divider placement stable despite glyph-height differences.

## headline rendering

headlines use two fixed treatments:

```text
one line -> 64
wrapped  -> 48, maximum two lines
```

one-line headlines stay large whenever they fit.

only headlines that cannot fit switch to the fixed two-line treatment, where the renderer chooses a balanced word-boundary split.

if copy still cannot fit, rewrite the headline rather than progressively shrinking type.

## secondary-page headings

`page_heading` is a compact identifier for a distinct subtopic on page 2 or later.

it uses `HEADERFONT` at size `30`, shares the balanced heading-wrapping behavior, and does not create a divider.

when used, it is the first block in `top_left`. body text that follows should continue the thought rather than repeat the label.

plain prose openings remain valid when a secondary page does not benefit from a label.

## normal heading wrapping

normal section headings also preserve one-line rendering whenever possible.

only headings that cannot fit the region are deliberately split into a balanced two-line word-boundary layout.

this prevents weak orphan lines such as a single final word while leaving shorter headings unchanged.

headings automatically create their ornamental divider.

## top-left text-only openings

when `top_left` begins with body text rather than a headline/page heading/heading, the renderer applies:

```text
vertical offset: 24 source units
left inset:      20 source units
```

this makes prose-only openings intentional without forcing a headline.

## right-column grammar

right column:

```text
heading
body

heading
body
```

body may contain prose, bullets, or both.

paragraphs belonging to the same right-column thought stay inside one text block separated by paragraph breaks.

left-side regions remain deliberately looser.

## dividers

six divider variants are available:

```text
divider_01 ... divider_06
```

authors do not choose divider presence or variant.

```text
heading      -> automatic divider
headline     -> no divider
page_heading -> no divider
text         -> no divider
```

variant selection is deterministic from topic/page/region/block context.

## bullets

bullet lists use a dedicated renderer.

current treatment:

```text
marker:          ◆
marker size:     84% of body size
marker width:    16
marker/text gap: 7
item gap:        3
```

marker and text are separate so wrapped items retain hanging indentation.

## notes

note regions are optional.

when no note exists, the note strip and animal are hidden.

current animals:

```text
crow
catcoon
splumonkey
```

the starting animal is derived deterministically from the topic id, then rotates by page number. adding or removing notes elsewhere does not reshuffle existing pages.

text clearance adapts to the current animal.

## related topics

current layout supports up to four columns.

important rules:

- optional.
- 2–4 valid close links.
- page 1 only.
- introduced by `Related topics` heading.
- final block in `bottom_left`.

content data chooses only the linked topic ids.

the renderer chooses one stable decorative tile variant per containing topic, and the whole tile group shares that variant.

## page footer

single-page topics show the normal fleur divider only.

multi-page topics show:

```text
previous button
Previous page
asymmetric fleur
page counter
Next page
next button
```

visible footer buttons navigate within the current topic.

## keyboard navigation

```text
Up / W    -> previous topic, page 1
Down / S  -> next topic, page 1
Left / A  -> previous page; from page 1, previous topic's final page
Right / D -> next page; from final page, next topic's page 1
```

while search is active, Left/Right retain normal text-cursor behavior, Up/Down move through filtered topic results and open their matching pages, and WASD remains normal text input.

`Enter` focuses the search field when it is not already being edited.

## search

search indexes:

```text
topic title
topic tags
subtitle
page heading
heading
body text
bullets
caption
note
```

page selection:

```text
exact page_heading match -> that page
topic title/tag match     -> page 1
other page-content match  -> first matching page
```

query growth may move the current topic to its matching page.

query shrinking or clearing never automatically changes the current page.

manual paging while search remains active wins.

search editing also supports:

- the `×` button clears the query and keeps the field active.
- clicking a topic while search is active keeps the field active so typing can continue.
- `Escape` exits search before closing the handbook; a non-empty query is cleared.
- `Ctrl+Backspace` deletes the previous word.

## sidebar scrolling

visible topic slots:

```text
16
```

supported interaction:

- mouse wheel.
- baked top/bottom scrollbar arrows.
- track click.
- slider drag.
- keyboard topic navigation.

`topic_scroll_index` is the single source of truth.

search-filtered topic lists automatically receive the correct scroll range.

## handbook-local quiet buttons

use:

```text
scripts/widgets/dst101quietimagebutton.lua
```

for handbook controls rather than the normal `widgets/imagebutton`.

it preserves focus visuals, hover textures, clicking, and click sounds while omitting handbook hover/focus sounds.

do not globally mute dst UI sounds.

## shortcuts

player handbook shortcut is configurable through `modinfo.lua`.

default:

```text
B
modifier: None
```

developer hot reload is also configurable but disabled by default.

modifier matching is exact.

plain typing shortcuts are suppressed while a text field is active; intentionally modified chords remain available.

## hot reload

the development reload clears and reloads handbook Lua/data modules while preserving the current topic/page when possible.

it covers Lua, layout, widget, screen, data, and manifest code.

it does **not** reload rebuilt `.tex` assets or fonts. those require rebuilding and normally a dst restart.

changes to `modmain.lua` or `modinfo.lua` also require a proper mod/game reload because startup handlers/config metadata are not re-registered by handbook hot reload.

## scene-image pipeline

### production image source of truth

`source/assets/illustrations/*.png` contains the canonical editable handbook artwork.

the prepared `573x321` production png is the version to keep, review, and edit. manual cleanup, paintovers, character corrections, and other small art fixes should normally be made directly to that production image, then the runtime atlases should be rebuilt.

larger image-generation outputs are working intermediates rather than required project assets. they do not need to be committed or archived in the repository unless one has specific future editing value that the production image cannot preserve.

production scene opening:

```text
573x321
```

prepare one source image:

```powershell
.\tools\prepare_illustration.ps1 `
    -Source '<master.png>' `
    -Name '<scene_name>'
```

this center-crops/resizes to `573x321` and uses `pngquant` when useful.

rebuild runtime atlases:

```powershell
.\tools\build_illustration_atlases.ps1
```

builder behavior:

- validates all production images are `573x321`.
- uses a `3x5` grid of `672x400` cells.
- maximum atlas size `2048x2048`.
- generates runtime `.tex/.xml` files.
- regenerates `scripts/dst101illustrations.lua`.

## other asset builders

```text
tools/build_ui_atlas.ps1
tools/build_topic_atlases.ps1
```

runtime atlases:

```text
images/ui/base_template.tex/xml
images/ui/dst101_ui.tex/xml
images/topics/dst101_topics_color.tex/xml
images/topics/dst101_topics_gray.tex/xml
images/illustrations/dst101_illustrations_*.tex/xml
```

## implementation versatility

avoid turning today's successful page into tomorrow's mandatory template.

renderer rules should protect consistency and prevent broken layouts without dictating one composition for every topic.

prefer reusable behavior such as balanced wrapping, validation, automatic decorative variants, and generic block rendering over topic-specific branches.

a topic-specific renderer exception should need a concrete content problem that the reusable grammar cannot express cleanly. do not add one merely because a single page would be easier to hard-code.

when a page looks different because its content genuinely calls for it, that is healthy. structural consistency should support variation rather than erase it.
