INPUT = "input.txt"

front = []
back = {}
with open(INPUT, "r") as inp:
    for i, l in enumerate(inp):
        f, b = map(int,l.strip().split())
        front.append(f)
        if not b in back: back[b] = 0
        back[b] += 1

print(sum([f * back.get(f,0) for f in front]))
