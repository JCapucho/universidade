import os


def printDirFiles(d):
    lst = os.listdir(d)
    for fname in lst:
        path = os.path.join(d, fname)
        if os.path.isfile(path):
            ftype = "FILE"
        elif os.path.isdir(path):
            ftype = "DIR"
        else:
            ftype = "?"
        print(ftype, path)
    return


def findFiles(root, ext):
    results = []
    lst = os.listdir(root)
    for fname in lst:
        path = os.path.join(root, fname)
        if os.path.isdir(path):
            results.extend(findFiles(path, ext))
        if os.path.isfile(path) and path.endswith(ext):
            results.append(fname)
    return results


def main():
    print("Testing printDirFiles('..'):")
    printDirFiles("..")

    print("\nTesting findFiles('.', '.py'):")
    lst = findFiles(".", ".py")
    print(lst)
    assert isinstance(lst, list)

    print("\nTesting findFiles('..', '.csv'):")
    lst = findFiles("..", ".csv")
    print(lst)


if __name__ == "__main__":
    main()
