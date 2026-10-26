// Source code is private. This file shows only its classes and function signatures.

export type Role = "driver" | "manager" | "owner" | "accountant";

export interface Person {
  id: string;
  role: Role;
  displayName: string;
  email: string | null;
}

export interface CompanyAddress {
  name: string;
  street: string | null;
  postalCode: string | null;
  city: string | null;
  country: string;
}

export type CardStatus = "active" | "inactive" | "canceled";

export interface CardRow {
  id: string;
  company_id: string;
  member_id: string;
  vehicle_id: string | null;
  stripe_card_id: string;
  last4: string;
  exp_month: number;
  exp_year: number;
  status: CardStatus;
  per_payment_cents: number | null;
  daily_cents: number | null;
  monthly_cents: number | null;
  categories: string[];
  frozen_at: string | null;
  canceled_at: string | null;
}

export interface CardStore {
  /** The signed-in user behind a token, or null. */
  userID(token: string): Promise<string | null>;
  /** The user's active membership in a company. */
  memberOf(companyID: string, userID: string): Promise<Person | null>;
  /** An active member by ID. */
  member(companyID: string, memberID: string): Promise<Person | null>;
  company(companyID: string): Promise<CompanyAddress | null>;
  hasVehicle(companyID: string, vehicleID: string): Promise<boolean>;
  /** The company's own Stripe account, nil in test mode. */
  stripeAccount(companyID: string): Promise<string | null>;
  cardholder(companyID: string, memberID: string): Promise<string | null>;
  saveCardholder(companyID: string, memberID: string, stripeID: string): Promise<void>;
  insertCard(card: Omit<CardRow, "id" | "frozen_at" | "canceled_at">): Promise<CardRow>;
  card(cardID: string): Promise<CardRow | null>;
  updateCard(cardID: string, patch: Partial<CardRow>): Promise<CardRow>;
  /** Marks an open request approved by the decider, when there is one. */
  approveRequest(requestID: string, companyID: string, memberID: string, deciderID: string): Promise<boolean>;
}

/** Who may issue, unfreeze and cancel: the desk's deciders. */
export function decides(role: Role): boolean { /* private */ }
