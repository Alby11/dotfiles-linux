import sys
import pylnk3


def read_lnk(path):
    lnk = pylnk3.Lnk(path)
    print(f"Path: {lnk.path}")  # Assuming 'path' might be the correct attribute
    print(f"Wrk dir: {lnk.working_dir}")
    print(f"Args: {lnk.arguments}")
    # If 'path' is not correct, you might need to consult pylnk3's documentation or source code.
    # Common attributes might include lnk.real_path, lnk.working_dir, lnk.arguments, etc.


if __name__ == "__main__":
    if len(sys.argv) > 1:
        read_lnk(sys.argv[1])
    else:
        print("Usage: python read_lnk.py path_to_shortcut.lnk")
