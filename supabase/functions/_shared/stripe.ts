// Source code is private. This file shows only its classes and function signatures.

export const STRIPE_API = undefined /* private */;

export interface StripeOptions {
  /** The company's own account under the platform (Connect, ADR 004). */
  account?: string | null;
  /** So a retried request doesn't issue a second card. */
  idempotencyKey?: string;
}

export interface Stripe {
  post(path: string, params: Record<string, unknown>, options?: StripeOptions): Promise<Record<string, unknown>>;
}

export class StripeError extends Error {
  constructor(message: string, readonly status: number, readonly code?: string) { /* private */ }
}

/** `{a: {b: [1, 2]}}` as `a[b][0]=1&a[b][1]=2`; undefined and null are left out. */
export function formEncode(params: Record<string, unknown>): string { /* private */ }

/** During the pilot cards run in test mode only (US-33): a live key is refused. */
export function isTestKey(key: string): boolean { /* private */ }

export function stripeClient(secretKey: string, fetcher: typeof fetch): Stripe { /* private */ }
