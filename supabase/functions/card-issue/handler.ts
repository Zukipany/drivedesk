// Source code is private. This file shows only its classes and function signatures.

import { type CardRow, type CardStore, decides } from "../_shared/cards.ts";
import { bearer, isUUID, json, readBody } from "../_shared/http.ts";
import { isTestKey, type Stripe, StripeError } from "../_shared/stripe.ts";

/** The merchant categories a fleet card may work at (Stripe's names). */
export const CATEGORIES = undefined /* private */;

export const DEFAULT_CATEGORIES = [ /* private */ ];

/** 5,000 € a payment is more than any tank or charge; anything above is a typo. */
export const MAX_LIMIT_CENTS = undefined /* private */;

export interface Dependencies {
  store: CardStore;
  stripe: Stripe;
  stripeKey: string;
  now: () => Date;
}

export interface IssueRequest {
  companyID: string;
  memberID: string;
  vehicleID: string | null;
  requestID: string | null;
  perPaymentCents: number | null;
  dailyCents: number | null;
  monthlyCents: number | null;
  categories: string[];
}

function limit(value: unknown, name: string): number | null | string { /* private */ }

export function parseIssue(body: Record<string, unknown> | null): IssueRequest | string { /* private */ }

/** "Lena Wagner" as Stripe wants an individual: a first and a last name. */
export function splitName(name: string): { first: string; last: string } { /* private */ }

export function spendingControls(issue: IssueRequest) { /* private */ }

export async function cardIssue(request: Request, deps: Dependencies): Promise<Response> { /* private */ }
