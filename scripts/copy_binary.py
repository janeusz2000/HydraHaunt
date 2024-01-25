import shutil
import sys
import os


def main():
    source_binary = sys.argv[1]
    output_dir = sys.argv[2]
    os.makedirs(output_dir, exist_ok=True)
    shutil.copy(source_binary, output_dir)


if __name__ == "__main__":
    main()
