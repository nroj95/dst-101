# dst 101 — handbook editorial grammar

> consistency should come from the book's visual language, not from repeating the same page template.
>
> same hand, same taste, same materials, same worldview — different things worth stopping to draw.

status: production reference

## purpose

this note owns where information belongs on a page and the judgment behind captions, notes, related topics, search tags and illustrations.

[`voice-and-philosophy.md`](voice-and-philosophy.md) owns how the unnamed author thinks, teaches and sounds. [`development.md`](development.md) owns what the schema enforces, display limits and the asset pipeline; this note links there instead of repeating them.

## versatile, not random

pages should feel collected from one journey, not cloned from one template.

variation is expected in:

- page density.
- number of headings.
- whether a headline is used.
- whether bullets are useful.
- whether a note appears.
- whether related topics appear.
- image subject, composition, weather, season, time of day, biome, palette, and amount of finish.

consistency should come from:

- the same author's judgment and voice.
- the same fonts and page grammar.
- the same artistic hand and rendering habits.
- the same caption, divider, note, bullet, and tile treatments.

never add or remove an element merely to make neighboring pages different. equally, never flatten every page into one repeated arrangement for the sake of consistency. when a page looks different because its content genuinely calls for it, that is healthy.

## page grammar

the hard rules (which blocks each region accepts, headline/subtitle pairing, right-column structure, related-topic placement) are enforced by validation and listed in [development](development.md#authoring-rules-enforced-by-validation). this section covers the judgment those rules leave open.

### sidebar label

short, literal navigation name.

### headline and subtitle

an optional page-level statement of lesson, angle, or mood. headline and subtitle are one unit; a subtitle never appears alone.

headlines may appear on any page, not only page 1. do not add one merely because the page number changed.

a headline that does not fit in two lines should be rewritten, not shrunk.

### page labels in Contents

Contents labels page 1 by its headline and later pages by their `page_heading`, falling back to `Page N`. the label is optional as a layout element, but when used it also has to identify the page's subject to someone scanning Contents or searching.

### secondary-page openings

after page 1, use a compact `page_heading` when a distinct subtopic benefits from being recognizable immediately.

`page_heading` is a small page label, not another headline or section heading. it normally sits above concise body text, and the body should continue from the label rather than repeat it: after `Winter`, begin with the useful fact rather than another sentence beginning `Winter...`.

plain body text or a short bullet list is still valid when a label adds nothing. do not add a `page_heading` merely because the page number changed.

### headings

use headings only for real conceptual divisions. some pages need several, one, or none. headings receive their divider automatically; authors never place dividers.

normal `heading` blocks are conceptual divisions, not substitutes for `page_heading`.

### top-left region

`top_left` is flexible, not a title slot. it may contain:

- headline + subtitle.
- page heading + text.
- heading + text.
- text only.
- multiple prose blocks.
- nothing.

### bottom-left region

`bottom_left` is quieter supporting space beneath the illustration: body text, bullets when the items are genuinely parallel, or related topics. conceptual sections that need headings belong in the right column.

### right column

the right column is deliberately more structured: heading, body, heading, body. body may be prose, bullets, or both. paragraphs of one thought stay in one text block.

left-side regions remain deliberately looser.

### balancing page density

do not crowd the right column simply because it is the most structured region.

when a secondary idea does not need its own heading, `bottom_left` may carry concise prose that gives the page more breathing room, especially when the right column already holds the main explanation.

move information because its role fits the quieter region, not merely to fill empty parchment.

### paragraphs and bullets

use prose for reasoning, cause and effect, observation, context, trade-offs, and judgment. concise does not mean every sentence needs its own heading.

use bullets for genuinely parallel items such as supplies, warning signs, possible responses, short examples, or preparation checks. do not turn reasoning into bullets when context matters more than scanability.

### topic length and page density

there is no fixed page-count quota, and empty parchment is allowed.

some pages may be sparse; others moderately dense. add pages only when the subject genuinely needs them. do not invent an extra lesson merely to justify page 2, and do not compress useful explanation simply to preserve empty space.

## captions

every illustrated page has exactly one caption, and it shows one line.

it should add authored perspective rather than narrate the visible image: an observation, reaction, question, memory, small discovery, or restrained dry aside.

do not force advice, explanation, or a lesson into it merely because the image has one. the body teaches; the caption may simply react. how captions sound is in the [voice note](voice-and-philosophy.md#captions).

### viewpoint

choose first-person, neutral, or survivor-specific phrasing according to the scene.

first person is welcome when the scene can plausibly be the author's own. when another recognizable survivor is pictured, avoid first person that makes that survivor look like the handbook's author; neutral phrasing, or naming or referring to the pictured survivor, is fine. this matters most when the image demonstrates a mechanic belonging to that survivor, but it applies to every cameo.

## notes

notes are intentionally rare, and show at most two lines.

use one when a private reminder, warning, mistake, aside, creature remark, useful contradiction, unresolved thought, or short memorable factual oddity genuinely adds something without duplicating the body. do not manufacture a note merely because the strip exists.

the animal beside the note is decoration chosen by the renderer, not a reason to write one.

essential survival information must not depend only on a note.

## related topics

related-topic tiles are optional navigation, not decoration. content chooses only whether the section belongs and which topics it links.

they live on page 1 only, so they clearly relate to the whole topic rather than a later subtopic.

- use 2–4 genuinely close, distinct topics.
- omit the section if fewer than two strong links qualify.
- links do not need to be reciprocal.

## search tags

search already indexes every visible piece of text on a page (the full list is in [development](development.md#search)).

use topic-level tags only for useful vocabulary a reader might search for that the visible content does not already provide. there is no tag count; zero tags is valid.

a tag match opens page 1, while an exact `page_heading` match opens that page. avoid page-specific tags unless a `page_heading` already routes that term to the intended page.

## illustrations

illustrations are `573x321` scenes; the production files and builders are in [development](development.md#asset-pipeline).

### the imagined artist

internally, imagine wheeler as a capable, observant field sketcher with strong taste.

she is not making flawless promotional art. images may be beautiful and carefully composed while still showing searching strokes, simplification, asymmetry, and uneven finish.

an image should exist because something made her stop and look: beauty, danger, usefulness, behavior, expression, mystery, atmosphere, or simple fascination. it records an observed moment, not a diagram of every fact on the page.

### the locked image language

#### hand and linework

- dark graphite / ink-like linework.
- lightly rough, exploratory marks.
- occasional overlapping or searching contours.
- modest line-weight variation.
- strongest contours on important foreground subjects.
- lighter, simpler marks as forms recede.
- loose repeated marks for grass, branches, clouds, ground texture, and distant terrain.

avoid vector-clean outlines and equally finished detail everywhere.

#### color

use restrained, natural, slightly weathered washes / fills rather than glossy digital rendering.

common daylight colors include parchment neutrals, straw, ochre, muted olive, dusty green, warm brown, rust, soft orange, charcoal, and restrained blues. these are a family, not a fixed palette.

keep the treatment consistent without preferring one mood. the subject, weather, biome, season, and time of day decide whether a scene feels warm, cool, bright, dark, dry, wet, snowy, underground, or otherwise. sunset light, autumn warmth, pale blue daylight, gray rain, winter cold, murky marsh, cave darkness, and ocean blue are all valid; none is the default handbook look.

#### rendering

shading is economical and illustrative. texture and linework carry much of the description.

avoid photorealism, smooth airbrushing, cinematic concept-art grading, bloom, glossy rendering, or hyper-detailed materials.

#### focal hierarchy

ask what the explorer was actually studying.

that point receives the clearest silhouette, strongest useful lines, most identifying detail, and most deliberate contrast or local color. secondary scenery should support rather than compete.

#### environment

- simplify distant trees and hills.
- use loose grass and ground marks.
- keep clouds as drawn shapes.
- reduce detail with distance.
- let paths, rocks, trees, camp objects, and terrain feel encountered rather than decoratively arranged.

#### composition

prefer an observed moment over a promotional pose.

subjects do not need to be centered. asymmetry is welcome. the environment should feel inhabited rather than pasted behind the subject.

#### finish range

quick observations and more careful studies may coexist. the amount of attention may change; the artist's materials and habits should not.

### visual reference anchors

primary anchors:

- `setting_out.png`
- `crafting.png`
- `food_foraging.png`
- `food_cooking.png`

these are the concrete reference for how the locked image language looks in practice. newer approved images may expand subject matter, scenery, weather, lighting, and mood without redefining the underlying hand.

### style is not recurring scenery

the locked image language defines the artist's hand, not the places she keeps visiting.

treat every scene as a fresh location decision. do not inherit the scenery, terrain structure, horizon, vegetation, framing, or background arrangement of an earlier image. choose the environment again from the world of `dst` based on the subject, mechanic, mood, season, time of day, and spoiler boundary.

reusing a biome is sometimes correct; reusing the same scenery is not. two forest scenes can still differ in density, terrain, openness, tree type, foreground framing, weather, light, water, horizon, and spatial structure. repeated autumn hills, distant rocky spires, lakes, pine-lined horizons, open grassland, or birch framing count as repetition even when the characters and lesson differ.

before generating, compare against recent approved scenes and ask:

> if the subject were removed, would this background look substantially like one we have already used?

if yes, redesign the scenery unless the subject genuinely requires that similarity.

variety never outranks mechanical accuracy, spoiler restraint, or the subject of the page. do not reveal a late, hidden, or memorable environment merely because recent images need variety. when several environments would serve equally well, prefer the one that expands the handbook's visual range.

#### environments to draw from

these are possibilities, not a rotation schedule or quota:

- dense evergreen forest and enclosed forest interiors.
- deciduous woodland.
- savanna and broad grassland.
- marshes, reeds, wet ground, ponds, and swampy terrain.
- mosaic and mixed broken terrain.
- rocky ground, mineral country, and meteor-scarred areas.
- badlands and oasis desert.
- coastlines, beaches, islands, and ocean environments.
- lunar island terrain and vegetation.
- ice and frozen coastal environments.
- cave mud, rocky caverns, stalagmite country, and underground forests.
- red, green, blue, and mixed fungal cave environments.
- lunar grotto and other unusual underground environments.
- ancient ruins, labyrinths, residential ruins, sacred areas, military ruins, and the atrium.

#### spatial structure, not only biome labels

changing a few props inside the same landscape is not enough. vary the structure of the scene when the subject allows it:

- enclosed or open.
- near or distant horizon.
- flat, rolling, broken, or strongly vertical terrain.
- dense forest interior or exposed clearing.
- narrow path or broad plain.
- foreground-heavy or distant vista.
- dry ground, standing water, coastline, or open ocean.
- dense vegetation or sparse terrain.
- natural landscape, camp, ruins, or cave chamber.
- clear weather, rain, snow, fog, darkness, or unusual light.

a visible horizon is not required. some scenes should be enclosed by trees, vegetation, rock, structures, darkness, weather, or terrain, with little or no distant vista.

### edge treatment and vignette

do not apply a uniform vignette, dark border, rough ink frame, or parchment halo around every scene. the handbook already supplies the frame.

edge darkness and roughness should come from the composition itself: foreground trees, rocks, cave walls, weather, shadow, or grass may gather along some edges while others stay open. vary which edges carry visual weight.

if an image feels artificially enclosed when viewed without the handbook frame, reduce the edge treatment.

### accuracy and visual spoilers

stylization should preserve the recognition cues the reader needs. verify current `dst` creatures, objects, equipment, environments, and behavior separately from the art style.

visual spoilers count: an image can solve a mystery even when the prose stays coy. do not reveal a memorable transformation, deeper area, reward, creature, or solution merely because an image slot exists. the [spoiler rule](voice-and-philosophy.md#the-central-spoiler-rule) applies to pictures as it does to text: protect the first encounter, and explain opaque useful mechanics when the reader deliberately seeks that subject.

### survivors

three separate decisions: is the survivor recognizable, is it drawn in the handbook's hand, and is this the right survivor for the scene?

#### identity

current `dst` assets and screenshots are the authority for silhouette, hair, clothing, equipment, proportions, and other identifying traits.

- preserve identity through silhouette first: hair and head shape, posture, body proportions, clothing, equipment, and other distinctive traits should read before small facial details.
- keep the exaggerated, stylized anatomy of `dst`: oversized heads, narrow bodies, thin or lanky limbs, and unusual posture where they belong to that survivor, without forcing everyone into one body template.
- keep faces simple and graphic. expression comes mainly from eye shape, brows, mouth, pose, and gesture.
- preserve individual differences. do not drift toward one shared face, body type, prettiness standard, or generic cartoon / anime design.
- keep signature clothing, hair, equipment, and companions character-specific. never borrow another survivor's belongings or traits.

if the generated character is ambiguous or wrong, fix the image rather than explaining the mismatch away.

when a survivor already has an approved handbook depiction, use it as a secondary reference for how that character has been translated into the handbook's hand. compare the new image with it; if the reader would wonder whether it is the same character, correct the drift. a mistake repeated in an earlier image does not become canon: the `dst` references still win. borrow identity only, never the earlier pose, composition, scenery, lighting, or background.

#### drawing

render those traits through the same hand as everything else: lightly rough exploratory linework, selective contour emphasis, restrained color, economical shading, visible sketch character, and modest finish.

survivors should look redrawn by the same traveler who drew the environments, not pasted in from official game art or rendered as cleaner concept art than the scene around them.

#### casting

when a survivor is shown, choose the current `dst` character who fits the scene best: personality, abilities, equipment, companions, interests, habits, silhouette, and the activity or environment.

no survivor is the default choice; wilson gets no special preference. broad representation across the handbook is desirable, and ideally every current survivor appears eventually, but never choose a worse fit merely to complete the roster.

omit survivors entirely when an environment, creature, object, or activity study is stronger.

when several survivors appear together, prefer one shared situation in which their different strengths emerge naturally, not a lineup of signature abilities. the scene should still feel like something the author happened to observe.

do not depict wheeler merely because she is the internal author foundation. if she appears naturally, keep the handbook's authorship visually unconfirmed.

a survivor's selection may quietly teach something true about them: a distinctive strength, companion, resistance, tool, or mechanic shown in use. the page must still make sense to a reader who does not recognize the hint, and the hint does not need explaining. do not force character-specific casting when another survivor, no survivor, or an object or environment study would serve the page better. the caption may reinforce the hint, following the [viewpoint rule](#viewpoint).

### scene-image production brief

a paste-ready prompt. it repeats the rules above on purpose, because the image generator does not read this note.

> create another standalone scene image by the same unnamed explorer, following the locked handbook image language. preserve lightly rough exploratory dark linework, selective rather than uniformly heavy contours, simplified quieter backgrounds, restrained natural color, economical hand-drawn shading, visible paper-and-sketch character, and the sense of an observed field-journal moment. keep backgrounds visibly simpler, lower-detail, and lower-contrast than the main subject unless the environment itself is the subject. avoid drifting toward polished digital concept art, crisp graphic rendering, heavy saturation, excessive detail, or uniformly clean forms.
>
> match the artist's habits, not the literal scenery of previous images. treat the scenery as newly designed for this specific image rather than as a variation of any previous handbook background. choose an environment that actually belongs in `dst` and fits the subject. if several environments fit equally well, prefer one whose biome, vegetation, terrain, openness, horizon structure, weather, or spatial character differs materially from recent approved scenes. do not default to open temperate hills, a distant lake, pine-lined horizons, rocky spires, or any other successful recurring backdrop. enclosed forest interiors, marshes, savannas, rocky country, deserts, coasts, ocean, lunar terrain, caves, fungal forests, ruins, and other appropriate `dst` environments are all available when the content and spoiler boundary permit them.
>
> when a recognizable survivor appears, preserve current `dst` identity, silhouette, exaggerated proportions, facial simplicity, hair, clothing, and signature visual cues, then redraw those traits through the same rough handbook hand. do not normalize survivors toward realistic anatomy, generic anime proportions, a shared pretty face, or polished character concept art. generate only the scene itself: no frame, page, title, caption, UI, signature, or decorative border.

subject-specific decisions should answer only what matters:

- what is happening?
- what caught the explorer's attention?
- what practical lesson, mood, or question does the scene support?
- what must remain accurate?
- what must remain undisclosed?
- what environment naturally belongs around it, and how will its background differ from recent approved scenes?
- what crop or safe-area requirement matters?

## audits

### same-artist audit

the image on its own, before approval:

1. does the linework look like the same hand, including its roughness, searching contours, and selective emphasis?
2. does color behave with similar restraint without forcing every scene toward the same temperature or palette?
3. is detail concentrated selectively rather than spread evenly across every object and surface?
4. does the environment differ materially from recent scenes when the subject permits it, or did we merely rearrange props inside another version of the same backdrop?
5. does distant scenery simplify compatibly with the locked image language?
6. does the subject sit naturally in the world rather than looking pasted onto a decorative backdrop?
7. does the scene feel observed rather than staged or promotional?
8. does edge treatment arise from the composition rather than an automatic vignette?
9. when a survivor appears, do silhouette, proportions, facial simplicity, hair, clothing, posture, and other identity cues still read as that `dst` survivor?
10. does the image keep the discovery the page's text keeps?
11. without the handbook frame, would this still look like another drawing by the same traveler?
12. if the image looks impressive on its own but conflicts with the locked image language, have we resisted approving polish at the expense of the established hand?

### page audit

the assembled page, read in game at actual size:

- does every visible element contribute?
- are headings real divisions rather than labels for every paragraph?
- does the page vary naturally without copying a neighboring layout?
- are mechanics and recognition cues current and correct?
- do text and image together preserve discovery?
- does the crop work, and does the image read clearly at real handbook size?
- is every word visible, including the one-line caption and two-line note?
- does the caption add rather than describe?
- did the note, if present, earn its place?
- are related links selective?
- does the page label read well in Contents, and do useful search terms land on the right topic and page?
