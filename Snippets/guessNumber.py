def guessNumber(times=10):
    print(
f"""猜数字游戏
- 随机生成一个 [1, 100] 的数
- 共有 {times} 次猜测机会
- 猜错提示大小
""")
    import random
    number = random.randint(1, 100)

    while times > 0:
        n = int(input(f"猜测一个 [1, 100] 的整数, 还有 {times} 次机会: "))
        if n == number:
            break
        else:
            times -= 1
            print("大了" if n > number else "小了")

    print("猜对了!" if times > 0 else "Game over...")


if __name__ == "__main__":
    guessNumber()