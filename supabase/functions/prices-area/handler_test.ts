// Source code is private. This file shows only its classes and function signatures.

import { assert, assertEquals } from "@std/assert";
import { geohash } from "./area.ts";
import { CACHE_LIFETIME_MS, type Dependencies, parseRequest, pricesArea, type Store, type StoredStation } from "./handler.ts";
import type { StationInput } from "./tankerkoenig.ts";

const fixtureURL = (name: string) => { /* private */ };

/** The database's behaviour in memory: what migration 0004's functions do. */
class MemoryStore implements Store {
  cells;
  rows;
  slotFree;
  slotsTaken;
  fetchedAt(cells: string[]) { /* private */ }
  takeSlot() { /* private */ }
  record(source: string, stations: StationInput[], cells: string[], seenAt: Date) { /* private */ }
  stations(cells: string[]) { /* private */ }
}

function dependencies(store: MemoryStore, options: Partial<Dependencies> = {}) { /* private */ }

function ask(body: unknown) { /* private */ }
