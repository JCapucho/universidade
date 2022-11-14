import sys


CHUNK_SIZE = 1024


def compareFiles(aFile, bFile):
    chunkIndex = 0
    while True:
        aChunk = aFile.read(CHUNK_SIZE)
        bChunk = bFile.read(CHUNK_SIZE)

        if len(aChunk) != len(bChunk):
            return chunkIndex

        if len(aChunk) == 0:
            break

        if aChunk != bChunk:
            return chunkIndex

        chunkIndex += 1
    return None


def main():
    if len(sys.argv) != 3:
        print("Program requires two arguments", file=sys.stderr)
        exit(1)

    aPath = sys.argv[1]
    bPath = sys.argv[2]

    with open(aPath, "rb") as aFile, open(bPath, "rb") as bFile:
        diff = compareFiles(aFile, bFile)
        if diff is None:
            print("Files are identical")
        else:
            print(
                f"File have a difference at chunk {diff} (offset {diff * CHUNK_SIZE})"
            )


if __name__ == "__main__":
    main()
