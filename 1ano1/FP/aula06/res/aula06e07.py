import os
import sys


def dirSizes(dir):
    for file in os.listdir(dir):
        size = os.stat(f"{dir}/{file}").st_size
        print(f"{file}: {size}")


def main():
    dir = sys.argv[1] if 1 < len(sys.argv) else "."
    dirSizes(dir)


if __name__ == "__main__":
    main()
