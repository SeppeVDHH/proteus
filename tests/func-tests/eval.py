#!/usr/bin/env python3

import vcdvcd
import subprocess
import sys

#When 0xdead0 is present in the bus, the right result has been gotten
def evaluate():
    vcd = vcdvcd.VCDVCD("sim.vcd", [])
    addresses = vcd["TOP.Core.pipeline.dbus_cmd_payload_address[31:0]"]

    violation = False

    for (_, val) in addresses.tv:
        addr = int(val, 2)
        if str(hex(addr)) == "0xdead0":
            violation = True

    return violation


base_proteus = sys.argv[1]

test_cases = [
    "test-add",
    "test-loop",
    "test-fib"
]

#Tests for the functionality of the fence instruction
print("Functionality tests")
for case in test_cases:
    print(f"TEST {case}:")

    subprocess.call(["make", f"{case}.bin"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.call([f"{base_proteus}", f"{case}.bin"])
    print("✔ Correct result" if evaluate() else "X Wrong result")
    print()
