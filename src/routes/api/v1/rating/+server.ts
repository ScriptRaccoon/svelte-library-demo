import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { RatingRequestSchema, RatingResponseSchema } from '$lib/schemas'
import { handle_error, handle_validation } from '$lib/server/utils'

const post_sql = `
INSERT INTO
    ratings (user_id, book_id, rating)
VALUES
    (:user_id, :book_id, :rating);
`

export const POST: RequestHandler = async (event) => {
	const user_id = event.locals.user_id
	if (!user_id) {
		error(401, 'Unauthorized')
	}

	const body = await handle_error(() => event.request.json(), 'Invalid request body')

	const { book_id, rating } = handle_validation(body, RatingRequestSchema)

	await handle_error(
		() => db.execute(post_sql, { user_id, book_id, rating }),
		'Cannot save rating',
	)

	return json({ message: 'Rating received' })
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
		error(401, 'Unauthorized')
	}

	const book_id = event.url.searchParams.get('book_id')
	if (!book_id) {
		error(400, 'Missing book_id')
	}

	const { rows } = await handle_error(
		() => db.execute(get_sql, { user_id, book_id }),
		'Cannot fetch rating',
	)

	if (rows.length === 0) {
		return json(null)
	}

	const { rating } = handle_validation(rows[0], RatingResponseSchema)

	return json(rating)
}

const patch_sql = `
UPDATE ratings
	SET rating = :rating
WHERE
	user_id = :user_id
	AND book_id = :book_id
`

export const PATCH: RequestHandler = async (event) => {
	const user_id = event.locals.user_id
	if (!user_id) {
		error(401, 'Unauthorized')
	}

	const body = await handle_error(() => event.request.json(), 'Invalid request body')

	const { book_id, rating } = handle_validation(body, RatingRequestSchema)

	await handle_error(
		() => db.execute(patch_sql, { user_id, book_id, rating }),
		'Cannot update rating',
	)

	return json({ message: 'Rating updated' })
}
