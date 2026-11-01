# contributing to dst 101

thanks for stopping by! small fixes are very welcome: a clearer sentence, a wrong fact, a caption that sounds off. you don't need to read every document first.

## the easiest way to help

open an [issue](https://github.com/nroj95/dst-101/issues) saying which page and what feels off. "sailing, page 3 reads stiffly" is plenty. no git or setup needed.

## your first text edit

each topic is one file in `scripts/dst101topics/`, named after it: `fire.lua`, `sailing.lua`, and so on. the words are in the `text` lines, the longer ones between `[[` and `]]`:

```lua
{
    type = "text",
    text = [[A Campfire is quick and temporary. Once it burns out, it is gone.]],
},
```

change the words, leave the rest as it is, and open a pull request. text edits need no build and no formatting step.

to see your change in game, put the repository in DST's `mods` folder, enable `dst 101 (dev)`, and pick a key for `Developer: reload handbook key` in its options. that key reloads the text without restarting. if you can't test, just say so; every change is checked before it's merged.

## writing in a nutshell

the handbook reads like notes from an experienced explorer passing on what she noticed. keep it light:

- plain, everyday words. short sentences are fine.
- give the consequence and leave the choice to the reader, rather than "you must".
- the message, not wiki detail. numbers only when the reader acts on them, like a recipe amount.
- don't spoil first encounters. explain what helps the player decide, not every surprise.
- check mechanics against current `don't starve together`, not single-player or an old wiki page.
- a caption is one line about a moment in the picture, not a summary of the page.
- notes are rare asides. anything important belongs in the main text.
- improving a page usually helps more than adding one, and nearby pages shouldn't repeat each other.

when you want more depth, the long references are for looking things up, not homework:

- [`docs/voice-and-philosophy.md`](docs/voice-and-philosophy.md) — voice, teaching, spoilers, and research.
- [`docs/editorial-grammar.md`](docs/editorial-grammar.md) — what goes where on a page, captions, notes, related topics, and illustrations.
- [`docs/development.md`](docs/development.md) — files, validation, rendering, search, builds, and translations.

## other ways to help

### translations

a translation can start with the interface strings and a single topic; everything untranslated stays English. the steps are in [translations](docs/development.md#translations). carry over the voice rather than translating word for word, and check the pages in game, since longer languages run out of room first.

### illustrations

corrections, cleanup, paintovers, and redraws are all welcome: survivor details, anatomy, backgrounds that got too busy, scenes that read poorly at handbook size. keep to the [locked image language](docs/editorial-grammar.md#illustrations). artwork needs a rebuild, covered in the [build workflow](docs/development.md#build-workflow).

### code

cleanup is welcome: duplication, dead code, names, clearer validation. keep what players see the same unless a change fixes a real problem, and prefer small steps over rewrites. [`docs/development.md`](docs/development.md) maps the code.

### gameplay accuracy and testing

if the game does something the handbook gets wrong, an issue saying what you saw is perfect. how mechanics are checked is in the [research discipline](docs/voice-and-philosophy.md#research-discipline).

## sending a change

- keep a pull request to one kind of change. text, art, and code are easier to review apart.
- for a gameplay fix, say how you checked it.
- say how you would like to be credited.
- art and code changes follow the [build workflow](docs/development.md#build-workflow): rebuild what changed, format Lua with `stylua .`, check in game, and commit sources together with their generated outputs.

## credit

contributors are credited in the repository, and substantial work, whether writing, art, code, research, testing, or translation, is also credited in the handbook itself.

say the name or handle you'd like used. anonymous credit is fine, and so is not being listed publicly.

## contribution licensing

by submitting a contribution, you confirm that you have the right to contribute it.

software contributions are submitted under the MIT License.

handbook prose and documentation text contributions are submitted under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. code snippets and software examples are submitted under the MIT License unless otherwise noted.

visual contributions may contain or depict klei entertainment intellectual property and are therefore not automatically covered by either blanket license. by submitting visual work for inclusion in `dst 101`, you permit the project to include, modify, and redistribute that contribution as part of free, non-commercial versions of `dst 101`, subject to any rights held by klei entertainment or other third parties.

do not submit artwork, code, text, or other material taken from another creator unless its license or the creator's permission allows it and the required attribution is included.

see [`LICENSE.md`](LICENSE.md) for the repository's licensing scope.
