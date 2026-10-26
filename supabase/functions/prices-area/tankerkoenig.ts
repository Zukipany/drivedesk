// Source code is private. This file shows only its classes and function signatures.

import type { Point } from "./area.ts";

export const SOURCE = undefined /* private */;

export const MAX_RADIUS_KM = undefined /* private */;

export const ATTRIBUTION = { /* private */ };

/** A station as the database stores it (public.record_station_prices). */
export interface StationInput {
  source_id: string;
  brand: string;
  name: string;
  street: string | null;
  house_number: string | null;
  postal_code: string | null;
  place: string | null;
  latitude: number;
  longitude: number;
  is_open: boolean | null;
  prices: { e5?: number; e10?: number; diesel?: number };
}

export function listURL(center: Point, radiusKm: number, apiKey: string): URL { /* private */ }

/** A missing price comes as false or null; 0 or less is a reporting error, never free fuel. */
function price(value: unknown): number | undefined { /* private */ }

function text(value: unknown): string | null { /* private */ }

export class TankerkoenigError extends Error {
}

/** The stations of a list.php answer, ready for the database. */
export function parseList(body: unknown): StationInput[] { /* private */ }
