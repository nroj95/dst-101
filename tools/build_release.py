# =============================================================================
# dst 101 workshop release builder
#
# builds a clean release copy of the mod for the Don't Starve Mod Tools
# ModUploader, leaving the repository as the dev copy.
#
# usage:
#   py tools/build_release.py 1.1.0
#
# output:
#   .build/release/<yyyyMMdd-HHmmss>/
#
# the release copy:
# - contains only runtime files and licenses; backups and os clutter are
#   skipped.
# - renames the mod from "dst 101 (dev)" to "DST 101".
# - sets modinfo.lua's version to the given one. ModUploader refuses a
#   version equal to the one already on the Workshop and writes it to the
#   item's version tag, which DST compares with installed copies.
# - drops the developer-only reload_* configuration options; modmain.lua
#   leaves the reload shortcut unbound when they are missing.
#
# every modinfo.lua rewrite must match exactly, so a reworded dev line fails
# the build instead of quietly shipping dev settings.
# =============================================================================

import argparse
import fnmatch
import re
import shutil
import subprocess
import sys
from datetime import datetime
from pathlib import Path

project_root = Path(__file__).resolve().parent.parent
release_root = project_root / ".build" / "release"

release_name = "DST 101"

runtime_files = [
    "modinfo.lua",
    "modmain.lua",
    "modicon.tex",
    "modicon.xml",
    "LICENSE.md",
]

runtime_directories = [
    "LICENSES",
    "scripts",
    "images",
    "fonts",
]

skipped_names = [
    "*.bak",
    "*.bak.*",
    "*.test-backup",
    "Thumbs.db",
    ".DS_Store",
]

developer_option = re.compile(
    r'\n    \{\n        name = "reload_\w+",\n.*?\n    \},',
    re.DOTALL,
)


# =============================================================================
# helpers
# =============================================================================

def fail(message):
    sys.exit(f"build_release: {message}")


def is_skipped(path):
    return any(fnmatch.fnmatch(path.name, pattern) for pattern in skipped_names)


def copy_runtime(destination):
    for name in runtime_files:
        shutil.copy2(project_root / name, destination / name)

    for name in runtime_directories:
        for source in sorted((project_root / name).rglob("*")):
            if source.is_dir() or is_skipped(source):
                continue

            target = destination / source.relative_to(project_root)
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, target)


def replace_line(text, key, value):
    pattern = re.compile(rf'^{key} = ".*"$', re.MULTILINE)

    if len(pattern.findall(text)) != 1:
        fail(f'modinfo.lua needs exactly one top-level {key} = "..." line')

    return pattern.sub(f'{key} = "{value}"', text)


def release_modinfo(text, version):
    text = replace_line(text, "name", release_name)
    text = replace_line(text, "version", version)
    text, removed = developer_option.subn("", text)

    if removed == 0 or '"reload_' in text:
        fail("could not cleanly remove the reload_* developer options")

    return text


def warn_if_dirty():
    status = subprocess.run(
        ["git", "status", "--short"],
        cwd=project_root,
        capture_output=True,
        text=True,
    ).stdout

    if status.strip():
        print("note: the working tree has uncommitted changes; they are included.")


# =============================================================================
# build
# =============================================================================

def main():
    parser = argparse.ArgumentParser(
        description="builds a clean DST 101 release copy for ModUploader",
    )
    parser.add_argument("version", help='release version, e.g. "1.1.0"')
    version = parser.parse_args().version

    if not re.fullmatch(r"\d+(\.\d+)*", version):
        fail(f'"{version}" is not a dotted number version such as 1.1.0')

    # rewrite before copying so a failed rewrite leaves no half-built release
    text = (project_root / "modinfo.lua").read_text(encoding="utf-8", newline="")
    modinfo = release_modinfo(text, version)

    destination = release_root / datetime.now().strftime("%Y%m%d-%H%M%S")
    if destination.exists():
        fail(f"{destination} already exists; try again in a second")

    destination.mkdir(parents=True)

    copy_runtime(destination)
    (destination / "modinfo.lua").write_text(modinfo, encoding="utf-8", newline="")

    warn_if_dirty()

    file_count = sum(1 for path in destination.rglob("*") if path.is_file())
    print(f"built {release_name} {version} ({file_count} files)")
    print(f"point ModUploader at: {destination}")


if __name__ == "__main__":
    main()
