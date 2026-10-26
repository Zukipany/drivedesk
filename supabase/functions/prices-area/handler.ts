// Source code is private. This file shows only its classes and function signatures.

import { cellsCovering, distanceKm, isInGermany, type Point } from "./area.ts";
import { ATTRIBUTION, listURL, MAX_RADIUS_KM, parseList, SOURCE, type StationInput } from "./tankerkoenig.ts";

export const CACHE_LIFETIME_MS = undefined /* private */;

type Fuel = typeof FUELS[number];

/** A station with its latest prices, as stored. */
export interface StoredStation {
  id: string;
  source: string;
  brand: string;
  name: string;
  street: string | null;
  house_number: string | null;
  place: string | null;
  latitude: number;
  longitude: number;
  is_open: boolean | null;
  prices: { fuel_type: string; price_milli: number; changed_at: string }[];
}

/** What the handler needs from the database; store.ts implements it with supabase-js. */
export interface Store {
  /** When each cell was last fetched. */
  fetchedAt(cells: string[]): Promise<Map<string, Date>>;
  /** Takes the source's next request slot, or false when another request just ran. */
  takeSlot(source: string): Promise<boolean>;
  /** Stores a fetch and stamps the cells it covered completely. */
  record(source: string, stations: StationInput[], cells: string[], seenAt: Date): Promise<void>;
  /** Stations with their latest prices in these cells. */
  stations(cells: string[]): Promise<StoredStation[]>;
}

export interface Dependencies {
  store: Store;
  fetch: typeof fetch;
  now: () => Date;
  tankerkoenigKey: string;
}

interface AreaRequest extends Point {
  radiusKm: number;
}

function json(body: unknown, status = 200): Response { /* private */ }

/** Validates the body: a point and a radius of 1 to 25 km (default 5). */
export function parseRequest(body: unknown): AreaRequest | string { /* private */ }

/** A stored station in Tankerkönig's list.php shape, with when each price changed. */
function asListStation(station: StoredStation, center: Point) { /* private */ }

export async function pricesArea(request: Request, deps: Dependencies): Promise<Response> { /* private */ }
