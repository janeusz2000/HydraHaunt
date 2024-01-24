import sys
import subprocess

def check_program_installed(program):
    """Check if a program is installed by trying to call it."""
    try:
        subprocess.run([program, '--version'], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return True
    except subprocess.CalledProcessError:
        return False
    except FileNotFoundError:
        return False

def print_colored(text, color):
    """Print text in colored format."""
    colors = {
        "red": "\033[91m",
        "green": "\033[92m",
        "yellow": "\033[93m",
        "blue": "\033[94m",
        "magenta": "\033[95m",
        "cyan": "\033[96m",
        "white": "\033[97m",
        "reset": "\033[0m"
    }
    print(f"{colors.get(color, colors['white'])}{text}{colors['reset']}")

if __name__ == "__main__":
    # TODO: This will be fetched fron a config file
    prerequisits = ["docker", "rustc"]
    everything_installed = True
    for prerequisit in prerequisits:
        if not check_program_installed(prerequisit):
            print_colored(f"{prerequisit} is not installed or not in PATH.", "red")
            everything_installed = False
    if not everything_installed:
        sys.exit(1)
    sys.exit(0)


