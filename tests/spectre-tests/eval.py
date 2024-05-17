#!/usr/bin/env python3

import vcdvcd
import subprocess
import sys


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
    "secret-before-branch",
    "secret-after-branch",
    "spectrev1",
    "spectrev2",
    "spectrersb"
]

#Tests for the security of the fence instruction
print("Security tests")
for case in test_cases:
    print(f"TEST {case}:")

    with open(f"{case}.s") as source:
        lines = source.readlines()
        stripped = [
            line for line in lines if not line.strip().startswith("fence")]
        with open(f"{case}_stripped.s", 'w') as stripped_file:
            stripped_file.writelines(stripped)


    subprocess.call(["make", f"{case}_stripped.bin"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.call([f"{base_proteus}", f"{case}_stripped.bin"])
    print("NO FENCE:", end='\t')
    print("🗲 Secret leaked!" if evaluate() else "✔ Secret did not leak!")
    print()


    subprocess.call(["make", f"{case}.bin"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.call([f"{base_proteus}", f"{case}.bin"])
    print("WITH FENCE:", end='\t')
    print("🗲 Secret leaked!" if evaluate() else "✔ Secret did not leak!")
    print()
