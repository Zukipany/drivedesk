# Source code is private. This file shows only its classes and function signatures.

"""Renders German fuel and charging receipts as images for the OCR bench.

Layouts follow real receipts from German stations (line wording, decimal commas,
unit spellings, VAT lines, shop items). Each receipt is rendered clean and in
degraded variants that mimic phone photos of thermal paper: tilted, blurred,
faded, noisy. Ground truth goes to expected.json.

    python3 tools/receipt-bench/make_receipts.py
"""
import json
import random
from pathlib import Path
from PIL import Image, ImageDraw, ImageFilter, ImageFont, ImageEnhance
OUT = ...
FONT = ...
FONT_SIZE = ...
WIDTH = ...
RECEIPTS = ...
HOLDOUT = ...
HOLDOUT_2 = ...
HOLDOUT_3 = ...


def render(lines):
    ...


def on_table(receipt, angle=0.0):
    """Places the receipt on a darker table, as in a phone photo."""
    ...


def degrade(image, kind, rng):
    ...


def main():
    ...


if __name__ == '__main__':
    ...
