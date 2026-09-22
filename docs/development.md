# dst 101 — development

status: concise production reference

project:

```text
D:\dev\projects\dst\dst-101
```

## scope

this note documents the technical handbook implementation.

use the separate voice/philosophy note for writing decisions and the editorial grammar note for composition and image direction.

the shell and authoring grammar are considered established. new structural systems should be added only when real content exposes a concrete limitation.

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

variation advances only across pages that actually contain notes.

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

raw arrow-key behavior:

```text
Up    -> previous topic, page 1
Down  -> next topic, page 1
Left  -> previous page; from page 1, previous topic's final page
Right -> next page; from final page, next topic's page 1
```

search editing retains normal text-field arrow behavior.

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
F5
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
images/ui/dst101_ui.tex/xml
images/topics/dst101_topics_color.tex/xml
images/topics/dst101_topics_gray.tex/xml
images/illustrations/dst101_illustrations_*.tex/xml
```

## research/version verification

content production should not assume a familiar mechanic is current.

preferred order:

```text
recent/change-prone dst behavior
-> official klei dst changelogs / update posts / steam announcements

established dst mechanics
-> current dontstarve.wiki.gg, with game context checked

exact implementation behavior
-> current game scripts/data

wheeler voice/character evidence
-> single-player/hamlet primary material and dontstarve.wiki.gg
```

community discussions and practical guides are a separate required research layer for gameplay topics.

use them to discover recurring beginner problems, commonly recommended tactics, overlooked mechanics, misconceptions, and disagreements. prefer repeated patterns across multiple discussions over isolated advice.

community consensus does not establish mechanical truth. verify useful community-derived claims separately against current `dst` sources before publishing them.

do not turn stable beginner facts into unnecessary changelog archaeology. use freshness checks where they can materially affect correctness.

## normal content-production workflow

1. author or identify a real topic.
2. inspect current community discussions and practical guides for recurring beginner problems, useful advice, overlooked mechanics, misconceptions, and disagreements.
3. verify candidate mechanics and spoiler boundaries against current `dst` sources.
4. decide what belongs in `dst 101` and what should remain discoverable.
5. compose it with the established grammar.
6. create the scene in the approved visual family.
7. review it beside the anchor set and at handbook size.
8. add useful search tags only when needed.
9. add selective related-topic links only when useful.
10. polish where real content exposes a need.
11. change structure only when the current system genuinely cannot express the content.

future work should normally focus on topic modules, wording, scene-image production, search metadata, and related-topic relationships rather than core widget redesign.

## implementation versatility

avoid turning today's successful page into tomorrow's mandatory template.

renderer rules should protect consistency and prevent broken layouts without dictating one composition for every topic.

prefer reusable behavior such as balanced wrapping, validation, automatic decorative variants, and generic block rendering over topic-specific branches.

when a page looks different because its content genuinely calls for it, that is healthy.

## useful git checks

before committing tracked changes:

```powershell
git --no-pager diff --check
git status --short
```

for newly added files, stage first and also run:

```powershell
git diff --cached --check
```

this catches whitespace errors in untracked files that ordinary `git diff --check` cannot see.

## current conclusion

`dst 101` now has a stable shell, validated authoring grammar, flexible page composition, deterministic decorative variation, search/navigation systems, and a working scene-image production pipeline.

the project is in content production, not framework design.

keep the implementation permissive enough for varied pages while strict enough to stop accidental new conventions.
