// Source code is private. This file shows only its classes and function signatures.

import type { SupabaseClient } from "@supabase/supabase-js";
import type { Store, StoredStation } from "./handler.ts";
import type { StationInput } from "./tankerkoenig.ts";

export function supabaseStore(db: SupabaseClient): Store { /* private */ }
