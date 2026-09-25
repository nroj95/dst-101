# contributing to dst 101

thanks for considering helping with `dst 101`.

the project values careful improvement more than adding material for its own sake. a smaller handbook that is clear, accurate, natural, and visually coherent is preferable to a larger one that explains everything.

## start with the relevant reference

before making a substantial change, read the reference that governs that part of the project:

- `docs/voice-and-philosophy.md` for writing, teaching philosophy, spoiler restraint, and research.
- `docs/editorial-grammar.md` for page composition, captions, illustrations, and visual consistency.
- `docs/development.md` for implementation, validation, navigation, search, and asset pipelines.

## writing and editing

manual editing from native english speakers is particularly welcome.

when revising handbook prose:

- preserve the meaning unless the mechanic itself needs correction.
- prefer natural, concrete language.
- preserve spoiler restraint.
- avoid turning the handbook into a walkthrough or optimization guide.
- avoid manufactured wit, aphorisms, dramatic lines, or overly polished captions.
- let personality come from what the handbook author actually noticed or experienced.
- read nearby pages so the same warning, rhythm, joke, or phrase does not repeat unnecessarily.

captions should add an authored observation or reaction rather than explain the illustration or repeat the body text.

## gameplay changes

current `don't starve together` mechanics are the authority.

community discussions are useful for finding recurring beginner problems and practical advice, but mechanics discovered through community sources should be verified separately before publication.

prefer:

- current game data or scripts when exact behavior matters.
- official klei posts for recent or change-prone behavior.
- `dontstarve.wiki.gg` for established mechanics.

avoid silently carrying mechanics over from the original `don't starve`, `shipwrecked`, or `hamlet` when they differ from `don't starve together`.

## illustrations

illustrations should remain recognizable as work by the same field-journal artist.

important goals include:

- lightly rough exploratory linework.
- restrained natural color.
- economical shading.
- selective detail.
- quieter backgrounds.
- accurate survivor and creature identity.
- varied scenery rather than recurring background templates.
- clear reading at actual handbook size.

existing primary visual anchors define the hand. newer images may expand scenery, weather, subject matter, and mood but should not gradually redefine the underlying style.

manual paintovers, anatomy corrections, cleanup, and replacement illustrations are welcome.

## code

prefer reusable behavior over topic-specific renderer branches.

good cleanup includes:

- removing duplication.
- improving names.
- simplifying control flow.
- removing dead code.
- tightening validation.
- documenting non-obvious behavior.
- preserving established user-facing behavior unless a change solves a real problem.

please keep source files using lf line endings.

## generated assets

after editing production illustrations:

```powershell
.\tools\build_illustration_atlases.ps1
```

after editing topic icons:

```powershell
.\tools\build_topic_atlases.ps1
```

generated atlases should be committed together with the source assets that produced them.

## focused changes

keep pull requests reasonably focused.

if a change mixes unrelated writing, artwork, renderer changes, and cleanup, separating those pieces usually makes review easier.

## credit

meaningful contributors will be credited.

credit may appear in the repository and in the in-game handbook credits where appropriate.

when contributing, state the name or handle you would like used for credit. if you prefer not to be listed publicly, say so.

## contribution licensing

by submitting a contribution, you confirm that you have the right to contribute it.

software contributions are submitted under the MIT License.

handbook prose and documentation text contributions are submitted under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. code snippets and software examples are submitted under the MIT License unless otherwise noted.

visual contributions may contain or depict klei entertainment intellectual property and are therefore not automatically covered by either blanket license. by submitting visual work for inclusion in `dst 101`, you permit the project to include, modify, and redistribute that contribution as part of free, non-commercial versions of `dst 101`, subject to any rights held by klei entertainment or other third parties.

do not submit artwork, code, text, or other material taken from another creator unless its license or the creator's permission allows it and the required attribution is included.

see `LICENSE.md` for the repository's licensing scope.
