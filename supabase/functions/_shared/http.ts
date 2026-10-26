// Source code is private. This file shows only its classes and function signatures.

export function json(body: unknown, status = 200): Response { /* private */ }

/** The signed-in user's token from `Authorization: Bearer …`. */
export function bearer(request: Request): string | null { /* private */ }

/** The body as an object, or null when it isn't JSON. */
export async function readBody(request: Request): Promise<Record<string, unknown> | null> { /* private */ }

export function isUUID(value: unknown): value is string { /* private */ }
