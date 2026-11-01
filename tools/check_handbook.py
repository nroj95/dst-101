# =============================================================================
# dst 101 handbook check
#
# loads the handbook the way the mod does, in English and in every language
# registered in scripts/dst101translations.lua, and runs the same validation,
# without starting the game. a typo in a topic file, such as a missing comma,
# quote or bracket, or a broken authoring rule, is reported with the file,
# topic, page and region it concerns.
#
# it checks structure, not whether text fits on the page; read changed pages
# in game for that.
#
# needs lupa, which runs Lua 5.1 (the game's version) inside Python:
#   py -m pip install lupa
#
# usage:
#   py tools/check_handbook.py
#
# exits with status 1 when something is wrong. the pull request check in
# .github/workflows/check-handbook.yml runs this script.
# =============================================================================
import sys
from pathlib import Path

scripts = (Path(__file__).resolve().parent.parent / "scripts").as_posix()

try:
    import lupa.lua51 as lupa
except ImportError:
    sys.exit("check_handbook: needs lupa. install it with: py -m pip install lupa")


def fail(language, message):
    # The Lua stack trace only points inside the loader, not at the mistake.
    print(f"{language}: {message.split('stack traceback:')[0].strip()}")

    if "error loading module" in message:
        print(
            "\nthis usually means a missing comma, quote or bracket on the"
            " line named above or the one just before it."
        )

    sys.exit(1)


lua = lupa.LuaRuntime()
lua.execute(f'package.path = "{scripts}/?.lua;" .. package.path')

languages = ["en"] + sorted(lua.eval('require("dst101translations")').keys())

for language in languages:
    try:
        data = lua.eval(f'require("dst101data").load("{language}")')
    except lupa.LuaError as error:
        fail(language, str(error))

    topics = list(data.topics.values())
    pages = sum(len(topic.pages) for topic in topics)
    print(f"{language}: ok, {len(topics)} topics and {pages} pages")
