import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { RatingRequestSchema, RatingResponseSchema } from '$lib/schemas'

const post_sql = `
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
		await db.execute(post_sql, { user_id, book_id, rating })
		return json({ message: 'Rating received' })
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot save rating')
	}
}

const get_sql = `
SELECT
    rating
FROM
    ratings
WHERE
    user_id = :user_id
    AND book_id = :book_id
`

export const GET: RequestHandler = async (event) => {
	const user_id = event.locals.userID
	if (!user_id) {
		return error(401, 'Unauthorized')
	}

	const book_id = event.url.searchParams.get('book_id')
	if (!book_id) {
		return error(400, 'Missing book_id')
	}

	try {
		const { rows } = await db.execute(get_sql, { user_id, book_id })
		if (rows.length === 0) {
			return json(null)
		}

		const { rating } = RatingResponseSchema.parse(rows[0])
		return json(rating)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch rating')
	}
}

const patch_sql = `
UPDATE ratings
	SET rating = :rating
WHERE
	user_id = :user_id
	AND book_id = :book_id
`

export const PATCH: RequestHandler = async (event) => {
	try {
		const user_id = event.locals.userID
		if (!user_id) {
			return error(401, 'Unauthorized')
		}

		const body = await event.request.json()

		const { book_id, rating } = RatingRequestSchema.parse(body)

		const res = await db.execute(patch_sql, { user_id, book_id, rating })
		console.log(res) // TEMP

		return json('ok')
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot update rating')
	}
}
