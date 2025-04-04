import { error } from '@sveltejs/kit'

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
