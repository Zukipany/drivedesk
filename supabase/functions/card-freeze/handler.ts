// Source code is private. This file shows only its classes and function signatures.

import { type CardRow, type CardStatus, type CardStore, decides } from "../_shared/cards.ts";
import { bearer, isUUID, json, readBody } from "../_shared/http.ts";
import { isTestKey, type Stripe, StripeError } from "../_shared/stripe.ts";

export type Action = "freeze" | "unfreeze" | "cancel";

export interface Dependencies {
  store: CardStore;
  stripe: Stripe;
  stripeKey: string;
  now: () => Date;
}

export function parseFreeze(body: Record<string, unknown> | null): { cardID: string; action: Action } | string { /* private */ }

export async function cardFreeze(request: Request, deps: Dependencies): Promise<Response> { /* private */ }
