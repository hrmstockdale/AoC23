import shutil
import sys
from itertools import chain
from pathlib import Path

FILE_DIR = Path(__file__).parent
ROOT_DIR = FILE_DIR.parent
TEMPLATE_DIR = FILE_DIR / "template"
TEMPLATE_FILES = sorted(
    chain(TEMPLATE_DIR.glob("*.py"), TEMPLATE_DIR.glob("*.txt"))
)


def exit_with_error(message):
    print(f"Error: {message}", file=sys.stderr)

    sys.exit(1)


if len(sys.argv) != 2:
    exit_with_error("generate.py requires exactly one argument (day number)")

try:
    day = int(sys.argv[1])
except Exception:
    exit_with_error(f"Unable to parse parameter '{sys.argv[1]}' as an integer")

if not (0 < int(day) <= 25):
    exit_with_error(f"Not a valid day: '{day}'. Must be a number from 1 to 25")


to_dir = ROOT_DIR / f"day{day:02d}"

try:
    to_dir.mkdir()
except FileExistsError:
    exit_with_error(
        f"Cannot create dir '{to_dir.name}' because it already exists"
    )

print(f"\nCreated directory: {to_dir.name}")

for from_file in TEMPLATE_FILES:
    shutil.copy(from_file, to_dir)

    print(f"Created file: {to_dir.name}/{from_file.name}")
