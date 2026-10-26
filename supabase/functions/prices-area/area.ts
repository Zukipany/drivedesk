// Source code is private. This file shows only its classes and function signatures.

export const CELL_PRECISION = undefined /* private */;

export interface Point {
  latitude: number;
  longitude: number;
}

export interface Bounds {
  south: number;
  north: number;
  west: number;
  east: number;
}

/** The geohash of a point: alternate longitude and latitude bits, five per character. */
export function geohash(point: Point, chars = CELL_PRECISION): string { /* private */ }

/** The rectangle a geohash stands for. */
export function cellBounds(hash: string): Bounds { /* private */ }

/** Great-circle distance in km. */
export function distanceKm(a: Point, b: Point): number { /* private */ }

/** The point of a rectangle closest to `p` (km-accurate enough at cell scale). */
function closestPoint(bounds: Bounds, p: Point): Point { /* private */ }

function corners(bounds: Bounds): Point[] { /* private */ }

export interface Coverage {
  /** Every cell that touches the circle: the cells to read prices from. */
  touched: string[];
  /** Cells completely inside the circle: a fetch of the circle covers all their stations. */
  inside: string[];
}

/** The cells a circle around `center` touches, and the ones it covers completely. */
export function cellsCovering(center: Point, radiusKm: number): Coverage { /* private */ }

/** Roughly Germany: Tankerkönig only knows German stations. */
export function isInGermany(point: Point): boolean { /* private */ }
