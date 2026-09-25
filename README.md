# dst 101

a spoiler-conscious illustrated survival handbook for `don't starve together`.

`dst 101` adds an in-game handbook intended to help newer players understand the world without turning discovery into a walkthrough.

the handbook covers practical survival, exploration, creatures, seasons, equipment, farming, sailing, caves, and other systems through short illustrated pages written from the perspective of an experienced explorer.

> `dst 101` is an unofficial fan-made project. it is not affiliated with or endorsed by klei entertainment.

## philosophy

the goal is not to tell players the correct way to play.

`don't starve together` can be about exploring, building, fighting, farming, cooking, sailing, collecting, helping friends, quiet camp life, or simply seeing what is over the next hill.

the handbook should support those choices rather than prescribe a progression path.

the general idea is simple:

> give the player enough information to make a decision while leaving the decision and discovery to them.

the handbook tries to:

- explain mechanics that are difficult to understand naturally.
- prepare players for danger without revealing every surprise.
- teach useful principles rather than rigid strategies.
- acknowledge trade-offs instead of treating every risk as a mistake.
- leave room for experimentation, failure, retreat, and different playstyles.
- remain useful without becoming a replacement for playing the game.

## the handbook voice

the unnamed author is internally based on an older, more experienced wheeler organizing expedition notes into a survival handbook.

she is never formally identified in the handbook.

her writing is practical, curious, occasionally playful, and based on things she could plausibly have observed or experienced. she is experienced without being omniscient and enthusiastic without turning every page into a joke.

captions are especially important. they should feel like field notes or immediate reactions rather than miniature lessons or polished quotations.

plain, situational language is preferred over writing that sounds deliberately clever, dramatic, poetic, or memorable.

## illustrations

each illustrated page uses a `573x321` field-journal scene created for the handbook.

the established visual language uses:

- lightly rough graphite / ink-like linework.
- restrained, weathered color.
- economical hand-drawn shading.
- selective detail and contour emphasis.
- backgrounds simpler than the focal subject.
- observed moments rather than promotional poses.
- varied environments, weather, seasons, lighting, and compositions.

the aim is for every scene to look like another drawing by the same traveler rather than another interpretation of the style.

current `don't starve together` references are used for survivor, creature, item, structure, and environment accuracy.

## project status

`dst 101` is approaching its initial public release.

the main handbook systems and initial content set are in place. current work is increasingly focused on refinement, testing, accuracy, visual consistency, cleanup, and release preparation rather than adding content simply to make the handbook larger.

future additions should solve a genuine player need.

## contributing

contributions are welcome.

the areas where outside help would be especially valuable are:

### natural english editing

a manual language pass from native english speakers would be very useful.

good contributions include:

- making sentences sound more natural.
- catching awkward or overly formal wording.
- reducing repetition across nearby pages.
- improving rhythm without making the prose more elaborate.
- finding captions that sound written rather than genuinely observed.
- catching terminology that feels unnatural to experienced players.

please preserve the existing teaching intent and spoiler restraint rather than rewriting the handbook into wiki prose.

### illustration review and cleanup

another careful visual pass would also be valuable.

useful work includes:

- correcting survivor, creature, equipment, structure, or environment details.
- improving survivor identity and silhouette consistency.
- reducing style drift between illustrations.
- simplifying backgrounds that became too detailed.
- correcting awkward anatomy or generation artifacts.
- improving compositions that read poorly at actual handbook size.
- improving scenery variety where several images feel too similar.

### code cleanup

the implementation has grown alongside the handbook content and would benefit from another engineering pass.

useful improvements include:

- simplifying duplicated logic.
- improving naming and organization.
- removing obsolete code and assets.
- tightening validation.
- improving maintainability without changing established behavior.
- replacing special cases with reusable behavior where practical.

large structural rewrites should solve a concrete problem rather than replace working systems solely for architectural preference.

### gameplay accuracy and testing

mechanical corrections and in-game testing are welcome too.

gameplay information should be checked against current `don't starve together`. practical community experience is useful for deciding what matters, while game data, official klei information, and `dontstarve.wiki.gg` are preferred for verifying mechanics.

see [`CONTRIBUTING.md`](CONTRIBUTING.md) before making substantial changes.

## ai assistance

`dst 101` has been developed with substantial assistance from generative ai.

ai has been used throughout the project for tasks including:

- drafting and revising handbook text.
- researching and organizing gameplay topics.
- reviewing page structure and project documentation.
- assisting with code and development workflows.
- generating and iterating on handbook illustrations.

the project is still manually directed, reviewed, edited, tested, and curated. gameplay information is checked rather than treating generated answers as authoritative, and generated illustrations are selected, revised, and corrected rather than treated as automatically final.

contributors are especially welcome to catch things automated assistance missed: unnatural writing, inaccurate details, visual inconsistencies, unnecessary code, and other rough edges.

## contributor credit

meaningful contributors will be properly credited.

contributors may be listed in the repository and in the in-game handbook credits where appropriate. this includes substantial writing and editing, illustration work, code, research, testing, localization, and similar contributions.

if you contribute under a particular name or handle, include how you would like to be credited. anonymous credit is also fine.

## project references

three documents contain the detailed project rules:

- [`docs/voice-and-philosophy.md`](docs/voice-and-philosophy.md) — writing voice, teaching philosophy, spoiler restraint, and research approach.
- [`docs/editorial-grammar.md`](docs/editorial-grammar.md) — page composition, illustration direction, captions, visual consistency, and content grammar.
- [`docs/development.md`](docs/development.md) — renderer behavior, validation, navigation, search, asset pipelines, and implementation details.

read the relevant reference before making substantial changes in that area.

## repository layout

```text
scripts/dst101topics/                 handbook topic data
scripts/dst101data.lua                ordered topic loader
scripts/dst101validate.lua            authoring validation
scripts/widgets/dst101widget.lua      handbook renderer
scripts/screens/dst101popupscreen.lua popup and keyboard handling
scripts/dst101illustrations.lua       generated illustration manifest

source/assets/illustrations/          production illustration pngs
source/assets/icons/                  topic and search icons

images/illustrations/                 generated illustration atlases
images/topics/                        generated topic icon atlases
images/ui/                            runtime ui atlas

tools/                                build and preparation helpers
docs/                                 detailed project references
```

## asset rebuilding

production illustrations are stored as `573x321` png files in:

```text
source/assets/illustrations/
```

after changing illustration sources:

```powershell
.\tools\build_illustration_atlases.ps1
```

after changing topic icons:

```powershell
.\tools\build_topic_atlases.ps1
```

generated `.tex` assets are not refreshed by the handbook development hot reload and normally require restarting `don't starve together`.

## licensing

this repository uses different terms for different kinds of material.

in summary:

- project software is licensed under the MIT License.
- handbook prose and project documentation text are licensed under CC BY-NC-SA 4.0.
- illustrations and other visual assets are not covered by those blanket grants because the project contains `don't starve together`-derived characters, creatures, objects, and designs.
- klei entertainment retains all rights to its games and intellectual property.
- third-party material remains subject to its own terms.

see [`LICENSE.md`](LICENSE.md) for the complete scope.

the project is intended to be distributed freely as an unofficial, non-commercial player creation under klei entertainment's published player creation and mod guidelines.
