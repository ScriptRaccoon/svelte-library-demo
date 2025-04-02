import type { Handle } from '@sveltejs/kit'

const USER_COOKIE_NAME = 'user_id'

export const handle: Handle = async ({ event, resolve }) => {
	const user_id = event.cookies.get(USER_COOKIE_NAME)
	if (user_id) {
		event.locals.user_id = user_id
	} else {
		const id = crypto.randomUUID()
		event.cookies.set(USER_COOKIE_NAME, id, {
			path: '/',
			httpOnly: true,
			sameSite: 'strict',
			secure: true,
			maxAge: 60 * 60 * 24 * 365, // 1 year
		})
		event.locals.user_id = id
	}

	return await resolve(event)
}
