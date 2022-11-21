#!/usr/bin/env python3


def insertTeamsList():
    teams = []
    while True:
        team = input("Insira uma equipa ou uma linha em branco: ")
        if team == "":
            break
        teams.append(team)
    return teams


def allMatches(teams):
    assert len(teams) >= 2, "Requires two or more teams!"
    games = []
    for i, team in enumerate(teams):
        for j, enemy in enumerate(teams):
            if i != j:
                games.append((team, enemy))
    return games


def insertMatchesResults(matches):
    results = {}
    for match in matches:
        print(f"Insira os resultado do jogo '{match[0]}' vs '{match[1]}'")

        while True:
            try:
                house = int(input(f"Golos marcados por '{match[0]}': "))
                guest = int(input(f"Golos marcados por '{match[1]}': "))
                break
            except ValueError:
                print("Insira valores válidos!")

        results[match] = (house, guest)

    return results


def calculateTeamsScore(results):
    teamsScore = {}

    for (match, result) in results.items():
        # Iterate over the two teams that participated in the match and
        # keep their index in the match
        for i, team in enumerate(match):
            # Get their record or initialize a new one
            record = teamsScore.setdefault(team, [0, 0, 0, 0, 0, 0])

            # Get the goals scored by the team we are currently processing
            thisGoals = result[i]
            # Get the goals scored by the other team, we use a modulus
            # operations to wrap back to the first teams goals when processing
            # the second team
            enemyGoals = result[(i + 1) % 2]

            # Update the goals scored and suffered
            record[3] += thisGoals
            record[4] += enemyGoals

            # Update the points and match results
            if thisGoals < enemyGoals:
                record[2] += 1
            elif thisGoals > enemyGoals:
                record[0] += 1
                record[-1] += 3
            else:
                record[1] += 1
                record[-1] += 1

    return teamsScore


def listaClassif(teamsScore):
    sortedTeamsScore = sorted(
        teamsScore.items(), key=lambda record: record[1], reverse=True
    )
    print(
        "{:>12s} : Vitórias : Empates : Derrotas : Marcados : Sofridos : Pontos".format(
            "Equipa"
        )
    )
    for name, record in sortedTeamsScore:
        print(
            "{:>12s} : {:>8} : {:>7} : {:>8} : {:>8} : {:>8} : {:>6}".format(
                name, *record
            )
        )


def getChampion(teamsScore):
    maxPoints = 0
    maxDiff = 0
    champion = ""

    for name, record in teamsScore.items():
        diff = record[3] - record[4]

        if record[-1] > maxPoints:
            maxPoints = record[-1]
            champion = name
            maxDiff = diff
        elif record[-1] == maxPoints and diff > maxDiff:
            champion = name
            maxDiff = diff

    return champion


def main():
    teams = insertTeamsList()
    matches = allMatches(teams)
    results = insertMatchesResults(matches)
    teamsScore = calculateTeamsScore(results)
    listaClassif(teamsScore)
    champion = getChampion(teamsScore)
    print(f"'{champion}' é a equipa campeã")


main()
