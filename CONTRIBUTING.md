# contributing to dst 101

thanks for considering helping with `dst 101`.

the project values careful improvement more than adding material for its own sake. a smaller handbook that is clear, accurate, natural, and visually coherent is preferable to a larger one that explains everything, so new content should solve a genuine player need.

## the references

each rule has one home. read the one that governs your change first:

- [`docs/voice-and-philosophy.md`](docs/voice-and-philosophy.md) — writing voice, teaching philosophy, spoiler restraint, and research.
- [`docs/editorial-grammar.md`](docs/editorial-grammar.md) — where information belongs on a page, captions, notes, related topics, and illustrations.
- [`docs/development.md`](docs/development.md) — repository map, schema and validation, rendering, navigation, search, the asset pipeline, and the build workflow.

## where help is most useful

### natural english editing

a manual pass from native english speakers is very welcome:

- making sentences sound more natural.
- catching awkward or overly formal wording.
- reducing repetition across nearby pages.
- improving rhythm without making the prose more elaborate.
- finding captions that sound written rather than genuinely observed.
- catching terminology that feels unnatural to experienced players.

preserve the meaning unless the mechanic itself needs correction, and keep the teaching intent and spoiler restraint rather than rewriting the handbook into wiki prose.

### illustration review and cleanup

- correcting survivor, creature, equipment, structure, or environment details.
- improving survivor identity and silhouette consistency.
- reducing style drift between illustrations.
- simplifying backgrounds that became too detailed.
- correcting awkward anatomy or generation artifacts.
- improving compositions that read poorly at actual handbook size.
- improving scenery variety where several images feel too similar.

manual paintovers, anatomy corrections, cleanup, full redraws, and replacement illustrations are all welcome, within the [locked image language](docs/editorial-grammar.md#illustrations).

### code cleanup

the implementation grew alongside the content and would benefit from another engineering pass: removing duplication and dead code or assets, improving names and organization, simplifying control flow, tightening validation, and documenting non-obvious behavior.

preserve established user-facing behavior unless a change solves a real problem. large structural rewrites should solve a concrete problem rather than replace working systems for architectural preference.

### gameplay accuracy and testing

mechanical corrections and in-game testing are welcome. current `don't starve together` is the authority; how to verify a mechanic is in the [research discipline](docs/voice-and-philosophy.md#research-discipline).

## submitting a change

keep pull requests focused. a change that mixes unrelated writing, artwork, renderer changes, and cleanup is easier to review as separate pieces.

before submitting:

- follow the [build workflow](docs/development.md#build-workflow): rebuild what changed, read the affected pages in game at actual size, format Lua with StyLua, and commit sources together with their generated outputs.
- for a gameplay change, say how you verified it.
- say how you would like to be credited.

## credit

meaningful contributors will be credited, in the repository and in the in-game handbook credits where appropriate. this includes substantial writing and editing, illustration work, code, research, testing, localization, and similar contributions.

when contributing, state the name or handle you would like used. anonymous credit is fine, and so is not being listed publicly; just say so.

## contribution licensing

by submitting a contribution, you confirm that you have the right to contribute it.

software contributions are submitted under the MIT License.

handbook prose and documentation text contributions are submitted under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. code snippets and software examples are submitted under the MIT License unless otherwise noted.

visual contributions may contain or depict klei entertainment intellectual property and are therefore not automatically covered by either blanket license. by submitting visual work for inclusion in `dst 101`, you permit the project to include, modify, and redistribute that contribution as part of free, non-commercial versions of `dst 101`, subject to any rights held by klei entertainment or other third parties.

do not submit artwork, code, text, or other material taken from another creator unless its license or the creator's permission allows it and the required attribution is included.

see [`LICENSE.md`](LICENSE.md) for the repository's licensing scope.
