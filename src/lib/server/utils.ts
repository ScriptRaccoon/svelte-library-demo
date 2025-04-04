import { error } from '@sveltejs/kit'
import { z } from 'zod'

/**
 * General utility for wrapping async functions in try/catch blocks
 * and handling errors in a consistent way.
 * To be used in server-side SvelteKit code only (API routes, load functions).
 */
export async function handle_error<T>(
	fn: () => Promise<T>,
	message = 'Internal Server Error',
	status = 500,
): Promise<T> {
	try {
		return await fn()
	} catch (err) {
		console.error(err)
		error(status, message)
	}
}

/**
 * General utility for validating data using Zod schemas.
 * To be used in server-side SvelteKit code only (API routes, load functions).
 */
export function handle_validation<T>(data: unknown, schema: z.ZodSchema<T>): T {
	const { success, data: parsed } = schema.safeParse(data)
	if (!success) {
		console.error('Validation error for data:', data)
		error(400, 'Invalid data')
	}
	return parsed
}
