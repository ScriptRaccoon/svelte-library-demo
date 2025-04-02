import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { RatingRequestSchema } from '$lib/schemas'

const sql = `
INSERT INTO
    ratings (user_id, book_id, rating)
VALUES
    (:user_id, :book_id, :rating);
`

export const POST: RequestHandler = async (event) => {
	try {
		const user_id = event.locals.userID
		if (!user_id) {
			return error(401, 'Unauthorized')
		}
		const body = await event.request.json()
		const { book_id, rating } = RatingRequestSchema.parse(body)
		await db.execute(sql, { user_id, book_id, rating })
		return json({ message: 'Rating received' })
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot save rating')
	}
}
