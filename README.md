# Advent of Code

https://adventofcode.com/2015

# How to use this repo

## Install dependencies

```shell
$ make install
```

## Start a new day's puzzles

```shell
$ make gen01

Created directory: day01
Created file: day01/__init__.py
Created file: day01/input.txt
Created file: day01/solution1.py
Created file: day01/solution2.py
Created file: day01/test_solution1.py
Created file: day01/test_solution2.py
```

## Using the input file

It is recommended that your download the input file directly to the day's
folder, overwriting the `input.txt` file that's already there.

## Running tests

### All tests for a given day

```shell
$ make test01
...
collected 2 items

day01/test_solution1.py .
day01/test_solution2.py .
```

### One part for a given day

```shell
$ make test01p1
...
collected 1 item

day01/test_solution1.py .
```

## Running your solutions

```shell
$ make d01p1
the answer

$ make d01p2
the other answer
```

## Handling single-line puzzle inputs

The template is set up to handle multi-line inputs by default. To handle
single-line inputs, simply edit as per the following diff

```diff
@@ -5,8 +5,7 @@ from utils.read import read_file_iter

 # Use the following line instead if the input is a single line
-# def solver(input: str) -> str:
-def solver(input: Iterable[str]) -> str:
+def solver(input: str) -> str:
     return "the answer"

@@ -15,5 +14,4 @@ if __name__ == "__main__":
     input_iter = read_file_iter(input_path)

     # Use the following line instead if the input is a single line
-    # print(solver(next(input_iter)), end="")
-    print(solver(input_iter), end="")
+    print(solver(next(input_iter)), end="")
```

## Handling multi-line puzzle inputs

Multi-line inputs is the default - no changes are required in order to
make this work. However, do note that the input is passed in as a generator.
If you need to iterate over the input multiple times, it is advisable to
first assign a local variable, such as a list, to store the input lines, eg

```python
def solver(input: Iterable[str]) -> str:
    input_lines = list(input)
    ...
```

## Inputting your answer

Mac users can copy the result to the clipboard using

```shell
$ make d01p1 | pbcopy
```
