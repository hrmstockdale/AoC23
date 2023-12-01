from typing import Iterable


def read_file_iter(input_path: str) -> Iterable[str]:
    with input_path.open() as f:
        for line in f:
            yield line.rstrip("\n")
