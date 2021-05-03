import yaml
import argparse 

parser = argparse.ArgumentParser(
    description="QnD tool to replace certain keys in any yaml"
)

parser.add_argument(
    "--file",
    "-f",
    dest="file",
    type=str,
    default="",
    help="File to be manipulated",
)

parser.add_argument(
    "--key",
    "-k",
    dest="key",
    type=str,
    default="",
    help="Key to be replaced",
)

parser.add_argument(
    "--value",
    "-v",
    dest="value",
    type=str,
    default="",
    help="Value to be replaced for",
)

args = parser.parse_args()

def set_value(data, key, value):
    obj = data
    keys = key.split('/')
    for k in keys[:-1]:
        if not k:
            continue
        if isinstance(obj, dict):
            if k in obj:
                obj = obj[k]
            else:
                obj[k] = {}
                obj = obj[k]
        elif isinstance(obj, list):
            raise NotImplementedError("Lists are not implemented yet")
        else:
            raise ValueError("Unsupported type at key {}".format(k))

    obj[keys[-1]] = value

if __name__ == "main":
    try:
        from yaml import CLoader as Loader, CDumper as Dumper
    except ImportError:
        from yaml import Loader, Dumper

    with open(args.file, 'r') as f:
        data = yaml.load(f, Loader=Loader)
    
    set_value(data, args.key, args.value)

    with open(args.file, 'w') as f:
        yaml.dump(data, f, Dumper=Dumper)
