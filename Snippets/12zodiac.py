
def calc_12zodiac(year, known_year=2020, known_year_zodiac=0):
    # 子鼠、丑牛、寅虎、卯兔、辰龙、巳蛇、午马、未羊、申猴、酉鸡、戌狗、亥猪
    animals = ["🐀rat", "🐂cattle", "🐯tiger", "🐇rabbit", "🐉dragon", "🐍snake", "🐴horse", "🐑sheep", "🐒monkey", "🐓chicken", "🐶dog", "🐷pig"]

    year = int(year)
    # 已知 2020 年为鼠年
    year0 = int(known_year) - int(known_year_zodiac)

    if year >= year0:
        r = (year - year0) % 12
    else:
        r = (year0 - year) % 12 * (-1)

    return animals[r]


if __name__ == "__main__":
    import sys
    print(sys.argv)
    print(calc_12zodiac(*sys.argv[1:]))
