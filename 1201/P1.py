INPUT = "input.txt"

front = []
back = []
with open(INPUT, "r") as inp:
    for i, l in enumerate(inp):
        f, b = map(int,l.strip().split())
        front.append(f)
        back.append(b)

front = sorted(front)
back = sorted(back)

print(sum([abs(l-r) for l, r in zip(front, back)]))
