# dst 101 — handbook editorial grammar

> consistency should come from the book's visual language, not from repeating the same page template.
>
> another drawing by the same person, not another interpretation of the style.

status: concise production reference

## purpose

this note defines page composition, scene-image direction, visual consistency, captions, notes, related topics, and search metadata.

use the voice note for how the unnamed author thinks and teaches, and the development note for implementation details.

## the governing principle: versatile, not random

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

never add or remove an element merely to make neighboring pages different. equally, never flatten every page into one repeated arrangement for the sake of consistency.

> consistency comes from authorship, not cloning.

## the imagined artist

internally, imagine wheeler as a capable, observant field sketcher with strong taste.

she is not making flawless promotional art. images may be beautiful and carefully composed while still showing searching strokes, simplification, asymmetry, and uneven finish.

an image should exist because something made her stop and look: beauty, danger, usefulness, behavior, expression, mystery, atmosphere, or simple fascination.

## the locked image language

### hand and linework

- dark graphite / ink-like linework.
- lightly rough, exploratory marks.
- occasional overlapping or searching contours.
- modest line-weight variation.
- strongest contours on important foreground subjects.
- lighter, simpler marks as forms recede.
- loose repeated marks for grass, branches, clouds, ground texture, and distant terrain.

avoid vector-clean outlines and equally finished detail everywhere.

### color

use restrained, natural, slightly weathered washes / fills rather than glossy digital rendering.

common daylight colors include parchment neutrals, straw, ochre, muted olive, dusty green, warm brown, rust, soft orange, charcoal, and restrained blues.

these are a family, not a fixed palette.

recognizable subject colors, weather, biome, season, and time of day may pull an image cooler, darker, greener, brighter, or less warm.

### rendering

shading is economical and illustrative. texture and linework carry much of the description.

avoid photorealism, smooth airbrushing, cinematic concept-art grading, bloom, glossy rendering, or hyper-detailed materials.

### focal hierarchy

ask what the explorer was actually studying.

that point receives the clearest silhouette, strongest useful lines, most identifying detail, and most deliberate contrast or local color.

secondary scenery should support rather than compete.

### environment

- simplify distant trees and hills.
- use loose grass and ground marks.
- keep clouds as drawn shapes.
- reduce detail with distance.
- let paths, rocks, trees, camp objects, and terrain feel encountered rather than decoratively arranged.

### composition

prefer an observed moment over a promotional pose.

subjects do not need to be centered. asymmetry is welcome. the environment should feel inhabited rather than pasted behind the subject.

### finish range

quick observations and more careful studies may coexist. the amount of attention may change; the artist's materials and habits should not.

## style is not recurring scenery

do not confuse the visual identity with surface motifs.

sunsets, orange skies, autumn fields, winding paths, identical trees, the same horizon, or the same survivor pose are not required ingredients.

at the current production stage, deliberately welcome opportunities for clear midday, gray daylight, forest shade, rain, snow, fog, blue twilight, cave light, coastlines, marshes, and other natural conditions when they suit the subject.

warm evening scenes are still allowed. they simply should not become shorthand for the whole book.

## approved visual anchors

primary anchors:

- `setting_out.png`
- `crafting.png`
- `food_foraging.png`
- `food_cooking.png`

variation anchors include current approved darker, wetter, colder, creature-focused, and pale-blue daylight scenes.

use approved handbook images to match the artist's habits, not their literal scenery.

use current `dst` screenshots / assets for anatomy, objects, equipment, colors, and behavior.

use the handbook layout only for crop, scale, and display integration.

never let the most recent generated image become the sole style reference; compare against the broader approved set to avoid generational drift.

## scene-image production brief

stable instruction:

> create another standalone scene image by the same unnamed explorer who made the approved handbook references. preserve lightly rough exploratory dark linework, selective contour strength, simplified quieter backgrounds, restrained natural color, economical hand-drawn shading, and the sense of an observed field-journal moment. match the artist's habits, not the literal scenery of previous images. preserve current dst recognition cues. generate only the scene itself: no frame, page, title, caption, UI, signature, or decorative border.

subject-specific decisions should answer only what matters:

- what is happening?
- what caught the explorer's attention?
- what practical lesson, mood, or question does the scene support?
- what must remain accurate?
- what must remain undisclosed?
- what environment naturally belongs around it?
- what crop or safe-area requirement matters?

## image delivery

production opening:

```text
573x321
```

generate the scene only. the mod supplies the frame and page furniture.

judge every image both standalone and at real handbook size.

### edge treatment and vignette

do not apply a uniform vignette, dark border, rough ink frame, or parchment halo around every scene.

edge darkness and roughness should come from the composition itself. foreground trees, rocks, cave walls, weather, shadow, grass, or other forms may naturally gather along some edges while other edges remain open.

vary which edges carry visual weight. some images may have strong framing on one or two sides; others may remain mostly open.

avoid making every scene look like a separate framed card inside the handbook. the handbook already supplies the frame.

if an image feels artificially enclosed when viewed without the handbook frame, reduce the vignette or edge treatment.

## accuracy and spoilers

stylization should preserve the recognition cues the reader needs.

verify current `dst` creatures, objects, equipment, environments, and behavior separately from the art style.

visual spoilers count. do not reveal a memorable transformation, deeper area, reward, creature, or solution merely because an image slot exists.

when a named or recognizable survivor appears, verify the identifying visual cues that matter: silhouette, hair, clothing, signature equipment, companions, and other distinctive details. do not borrow another survivor's signature belongings or visual traits. if the generated character is ambiguous or wrong, fix the image rather than explaining the mismatch away.

protect the first encounter; explain opaque useful mechanics when the reader deliberately seeks that subject.

## survivor selection

when a survivor is shown, choose the current `dst` character who fits the scene best.

consider their personality, abilities, equipment, companions, interests, habits, silhouette, and the activity or environment being shown. a character-specific connection is welcome when it makes the scene feel more natural or adds a useful second layer.

no survivor is the default generic choice. wilson receives no special preference over the rest of the cast.

keep track of who has already appeared and actively look for natural opportunities to use survivors who have not. broad representation across the handbook is desirable, and ideally every current `dst` survivor will eventually appear at least once, but never choose a worse fit merely to complete the roster.

omit survivors entirely when an environment, creature, object, or activity study is stronger.

do not depict wheeler simply because she is the internal author foundation; the author remains visually unconfirmed.

### character-specific visual hints

when a survivor appears, their selection may quietly teach something true about that character.

a scene can show a survivor using a distinctive strength, companion, resistance, tool, or other mechanic when it fits the page naturally. this should add a second layer of information without turning a general topic into a character guide.

the page must still make sense to a reader who does not recognize the character-specific hint.

do not force character-specific casting when another survivor, no survivor, or an object/environment study would serve the page better.

when another recognizable survivor is pictured, avoid first-person captions that make that survivor appear to be the handbook's internal author. neutral phrasing or naming or referring to the pictured survivor is fine. this is especially important when the image demonstrates a mechanic belonging specifically to that survivor.

## page grammar

### sidebar label

short, literal navigation name.

### headline + subtitle

an optional page-level statement of lesson, angle, or mood.

when used, headline and subtitle are one unit:

```text
headline
subtitle
```

never use a subtitle alone.

headlines may appear on any page, not only page 1.

do not add one merely because the page number changed.

### headline wrapping

- if the headline fits on one line, keep the large one-line treatment.
- only if it does not fit, switch to the fixed two-line treatment and choose a balanced word-boundary split.
- if it still does not fit, rewrite the headline rather than shrinking indefinitely.

### headings

use headings only for real conceptual divisions.

some pages may need several, one, or none.

normal headings stay on one line whenever they fit. only headings that cannot fit are deliberately split at a balanced word boundary.

headings receive their divider automatically.

### top-left region

`top_left` is flexible, not a title slot. it may contain:

- headline + subtitle.
- page heading + text.
- heading + text.
- text only.
- multiple prose blocks.
- nothing.

### secondary-page openings

after page 1, use a compact `page_heading` when a distinct subtopic benefits from being recognizable immediately.

`page_heading` is a small page label, not another headline or section heading. it uses the handbook header font without a divider and normally sits above concise body text.

the body should continue from the label rather than repeat it. for example, after `Winter`, begin with the useful fact rather than another sentence beginning `Winter...`.

plain body text or a short bullet list is still valid when a label adds nothing. do not add a `page_heading` merely because the page number changed.

normal `heading` blocks remain conceptual divisions, not substitutes for `page_heading`.

### right column

right-column content is deliberately more structured:

```text
heading
body

heading
body
```

body may be prose, bullets, or both.

do not start the right column with standalone body content.

do not use separate consecutive text blocks merely to represent paragraphs in one thought; keep those paragraphs inside one text block.

### paragraphs

use prose for reasoning, cause and effect, observation, context, trade-offs, and judgment.

concise does not mean every sentence needs its own heading.

### bullets

use bullets for genuinely parallel items such as supplies, warning signs, possible responses, short examples, or preparation checks.

do not turn reasoning into bullets when context matters more than scanability.

### dividers

```text
headline     -> no divider
page_heading -> no divider
heading      -> automatic divider
text         -> no divider
```

authors do not independently place decorative dividers.

## captions

every illustrated page has exactly one caption.

it should add authored perspective rather than narrate the visible image.

it may contain an observation, reaction, question, memory, small discovery, or restrained dry aside.

keep it brief.

do not force advice, explanation, or a lesson into the caption merely because the image has one. instructional work belongs primarily in the page text.

choose first-person, neutral, or survivor-specific phrasing according to the scene. first person is welcome when the scene can plausibly belong to the author; recognizable survivor cameos should preserve the author mystery.

## notes

notes are intentionally rare.

use them when a private reminder, warning, mistake, aside, creature remark, useful contradiction, or unresolved thought genuinely adds something.

do not manufacture a note merely because the strip exists.

a short factual oddity may also earn the margin when it adds something memorable without duplicating the body.

essential survival information must not depend only on a note.

## related topics

related-topic tiles are optional navigation, not decoration.

when used:

- place them at the bottom of page 1 only, so they clearly relate to the overall topic rather than a later subtopic.
- when present, `bottom_left` contains only the `Related topics` heading and the related-topic tiles.
- introduce them with a normal `Related topics` heading.
- use 2–4 genuinely close, distinct topic links.
- never link the topic to itself.
- omit the section if fewer than two strong links qualify.

links do not need to be reciprocal.

the renderer chooses decorative tile variants automatically; content data chooses only whether the section belongs and which topics it links.

## topic length and page density

there is no fixed page-count quota.

empty parchment is allowed.

some pages may be sparse; others may be moderately dense. add pages only when the subject genuinely needs them.

do not invent an extra lesson merely to justify page 2, and do not compress useful explanation simply to preserve empty space.

## search metadata

search already indexes topic title, topic tags, subtitle, page headings, headings, body text, bullets, captions, and notes.

use topic-level tags only for useful vocabulary a reader might search for that visible content does not already provide.

there is no mandatory tag count. zero extra tags is valid.

remember:

```text
exact page_heading match -> that page
topic title/tag match -> page 1
other visible page-content match -> first matching page
```

avoid page-specific topic tags unless an exact page_heading match routes that term to the intended page.

## same-artist audit

before approving an image, ask:

1. does the linework look like the same hand?
2. does color behave with similar restraint?
3. is detail concentrated selectively?
4. does distant scenery simplify compatibly?
5. does the subject sit naturally in the world?
6. does the scene feel observed rather than staged?
7. without the frame, would this still look like another drawing by the same traveler?

## final page audit

ask:

- does every visible element contribute?
- are headings real divisions rather than labels for every paragraph?
- does the image belong to the same-artist family?
- does the image show something this explorer would actually notice?
- does the page vary naturally without copying a neighboring layout?
- are mechanics and recognition cues current and correct?
- do text and image preserve discovery?
- does the crop work at real display size?
- does edge treatment arise naturally from the composition rather than an automatic vignette?
- does the caption add rather than describe?
- did the note, if present, earn its place?
- are related links selective?
- do useful search terms land on the right topic/page?

## final compass

same hand, same taste, same materials, same worldview — different things worth stopping to draw.

clear without being rigid. authored without being messy. consistent without being sterile.
