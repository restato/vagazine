import yaml

def read_yaml(filepath):
    data = None
    with open(filepath, encoding='utf-8') as f:
        data = yaml.load(f)
    return data

if __name__ == "__main__":
    print(read_yaml('./data/for-baby-food.yaml'))
    