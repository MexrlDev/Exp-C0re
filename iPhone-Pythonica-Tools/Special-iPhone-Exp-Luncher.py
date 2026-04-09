# Sends Lua directly to payload port and executes it

import socket
import os
import sys

DEFAULT_HOST = "" # <<<< IP HERE!!
PAYLOAD_PORT = 9026
DEFAULT_LUA_FILE = "exm.lua"


def send_lua(host: str, lua_path: str) -> bool:
    if not os.path.isfile(lua_path):
        print(f"File not found: {lua_path}")
        return False

    try:
        with open(lua_path, "rb") as f:
            data = f.read()

        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(10)

        sock.connect((host, PAYLOAD_PORT))
        sock.sendall(data)
        sock.close()

        print(f"Executed {os.path.basename(lua_path)} ({len(data)} bytes)")
        return True

    except Exception as e:
        print(f"Send error: {e}")
        return False


def main():
    host = DEFAULT_HOST
    lua_file = DEFAULT_LUA_FILE

    args = sys.argv[1:]
    if len(args) >= 1:
        host = args[0]
    if len(args) >= 2:
        lua_file = args[1]

    send_lua(host, lua_file)


if __name__ == "__main__":
    main()
