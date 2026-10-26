// Source code is private. This file shows only its classes and function signatures.

import type { CardRow, CardStore, CompanyAddress, Person } from "./cards.ts";
import { type Stripe, StripeError, type StripeOptions } from "./stripe.ts";

export const HUBER = undefined /* private */;

export const OTHER = undefined /* private */;

export const SABINE = undefined /* private */;

export const MARCO = undefined /* private */;

export const LENA = undefined /* private */;

export const KANZLEI = undefined /* private */;

export const BOB = undefined /* private */;

export const CADDY = undefined /* private */;

export const REQUEST = undefined /* private */;

interface Membership extends Person {
  company: string;
  user: string;
}

export class MemoryCardStore implements CardStore {
  members: Membership[];
  companies;
  vehicles;
  cardholders;
  cards: CardRow[];
  requests;
  userID(token: string) { /* private */ }
  memberOf(companyID: string, userID: string) { /* private */ }
  member(companyID: string, memberID: string) { /* private */ }
  company(companyID: string) { /* private */ }
  hasVehicle(companyID: string, vehicleID: string) { /* private */ }
  stripeAccount() { /* private */ }
  cardholder(companyID: string, memberID: string) { /* private */ }
  saveCardholder(companyID: string, memberID: string, stripeID: string) { /* private */ }
  insertCard(card: Omit<CardRow, "id" | "frozen_at" | "canceled_at">) { /* private */ }
  card(cardID: string) { /* private */ }
  updateCard(cardID: string, patch: Partial<CardRow>) { /* private */ }
  approveRequest(requestID: string, companyID: string, memberID: string, deciderID: string) { /* private */ }
}

export interface StripeCall {
  path: string;
  params: Record<string, unknown>;
  options: StripeOptions;
}

/** Answers like Stripe's test mode; `failWith` makes the next call fail. */
export class FakeStripe implements Stripe {
  calls: StripeCall[];
  failWith: string | null;
  private next;
  post(path: string, params: Record<string, unknown>, options: StripeOptions = {}) { /* private */ }
}
