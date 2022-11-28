def main():
    A = "reading"
    B = "eating"
    C = "traveling"
    D = "writing"
    E = "running"
    F = "music"
    G = "movies"
    H = "programming"

    interests = {
        "Marco": {A, D, E, F},
        "Anna": {E, A, G},
        "Maria": {G, D, E},
        "Paolo": {B, D, F},
        "Frank": {D, B, E, F, A},
        "Teresa": {F, H, C, D},
    }

    print("a) Table of common interests:")
    commoninterests = {
        (p1, p2): ints1 & interests[p2]
        # Iterate over all people's interests and store iteration index
        for i, (p1, ints1) in enumerate(interests.items())
        # Cast the dictionary to a list (containing the keys) and skip to the
        # people that are before the current person we are iterating
        for p2 in list(interests)[i + 1 :]
    }
    print(commoninterests)

    print("b) Maximum number of common interests:")
    maxCI = max(len(ints) for ints in commoninterests.values())
    print(maxCI)

    print("c) Pairs with maximum number of matching interests:")
    maxmatches = [pair for pair, ints in commoninterests.items() if len(ints) == maxCI]
    print(maxmatches)

    print("d) Pairs with low similarity:")
    lowJaccard = [
        pair
        # Iterate over all the pairs and their intersection
        for pair, ints in commoninterests.items()
        # Calculate the ratio between the intersection's size and the union size
        # and only add to the list if it's smaller than 0.25 (25%)
        if len(ints) / len(interests[pair[0]] | interests[pair[1]]) < 0.25
    ]
    print(lowJaccard)


# Start program:
main()
