import yaml
import sys

# file is given as first arg
with open(sys.argv[1], 'r') as f:
    data = yaml.load(f)

print(data)