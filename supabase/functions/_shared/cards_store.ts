// Source code is private. This file shows only its classes and function signatures.

import type { SupabaseClient } from "@supabase/supabase-js";
import type { CardRow, CardStore, Person, Role } from "./cards.ts";

export function supabaseCardStore(db: SupabaseClient): CardStore { /* private */ }
