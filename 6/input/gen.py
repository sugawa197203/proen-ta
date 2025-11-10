from random import randint

files = 50

ALPHABET = "abcdefghijklmnopqrstuvwxyz-"

def main():
    for i in range(files):
        with open(f"./random-{i}.txt", "w") as f:
            n = randint(1, 30)
            words = []
            for _ in range(n):
                randlength = randint(1, 30)
                random_words = "".join(ALPHABET[randint(0, len(ALPHABET) - 1)] for _ in range(randlength))
                words.append(random_words)
            f.write("\n".join(words))

if __name__ == "__main__":
    main()            
