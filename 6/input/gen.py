from random import randint

files = 50

LANGUAGE = "abcdefghijklmnopqrstuvwxyz-"

def get_random_word(length):
    word = "".join(LANGUAGE[randint(0, len(LANGUAGE) - 1)] for _ in range(length))
    return word

def main():
    for i in range(files):
        with open(f"./random-{i}.txt", "w") as f:
            n = randint(1, 30)
            words = [get_random_word(randint(1, 30)) for _ in range(n)]
            f.write("\n".join(words))

if __name__ == "__main__":
    main()            
