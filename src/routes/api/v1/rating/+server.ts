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
		const user_id = event.locals.user_id
		if (!user_id) {
			return error(401, 'Unauthorized')
		}

		const body = await event.request.json()
		const { data, success } = RatingRequestSchema.safeParse(body)
		if (!success) {
			return error(400, 'Invalid request body')
		}
		const { book_id, rating } = data
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
	const user_id = event.locals.user_id
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
		const { data, success } = RatingResponseSchema.safeParse(rows[0])
		if (!success) {
			return error(500, 'Invalid rating data')
		}
		const { rating } = data
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
		const user_id = event.locals.user_id
		if (!user_id) {
			return error(401, 'Unauthorized')
		}

		const body = await event.request.json()
		const { data, success } = RatingRequestSchema.safeParse(body)
		if (!success) {
			return error(400, 'Invalid request body')
		}
		const { book_id, rating } = data
		await db.execute(patch_sql, { user_id, book_id, rating })
		return json({ message: 'Rating updated' })
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot update rating')
	}
}
