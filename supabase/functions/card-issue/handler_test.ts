// Source code is private. This file shows only its classes and function signatures.

import { assertEquals } from "@std/assert";
import {
  CADDY,
  FakeStripe,
  HUBER,
  KANZLEI,
  LENA,
  MARCO,
  MemoryCardStore,
  OTHER,
  REQUEST,
} from "../_shared/cards_fake.ts";
import { cardIssue, type Dependencies, parseIssue, spendingControls, splitName } from "./handler.ts";

function setup() { /* private */ }

function issue(as: string | null, body: Record<string, unknown>) { /* private */ }
