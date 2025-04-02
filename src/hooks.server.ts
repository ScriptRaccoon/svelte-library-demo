import type { Handle } from '@sveltejs/kit'

export const handle: Handle = async ({ event, resolve }) => {
	const userID = event.cookies.get('userID')
	if (userID) {
		event.locals.userID = userID
	} else {
		const randomID = crypto.randomUUID()
		event.cookies.set('userID', randomID, {
			path: '/',
			httpOnly: true,
			sameSite: 'strict',
			secure: true,
			maxAge: 60 * 60 * 24 * 365, // 1 year
		})
		event.locals.userID = randomID
	}

	return await resolve(event)
}
