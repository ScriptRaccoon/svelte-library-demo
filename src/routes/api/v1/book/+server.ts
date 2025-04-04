import type { RequestHandler } from './$types'
import { error, json } from '@sveltejs/kit'
import { db } from '$lib/server/db'
import { BookSchema } from '$lib/schemas'

const sql = `
SELECT
    books.id AS id,
    title,
    authors.name AS author_name,
    authors.id AS author_id,
    books.description AS description,
    published_year,
    genres.name AS genre_name,
    genre_id,
    COUNT(ratings.rating) AS rating_count,
    COALESCE(AVG(ratings.rating), 0) AS rating_average
FROM
    books
    INNER JOIN authors ON books.author_id = authors.id
    INNER JOIN genres ON books.genre_id = genres.id
    LEFT JOIN ratings ON books.id = ratings.book_id
WHERE
    books.id = :id
GROUP BY
    books.id
`

export const GET: RequestHandler = async (event) => {
	const id = event.url.searchParams.get('id')
	if (!id) {
		return error(400, 'Missing id')
	}
	try {
		const { rows } = await db.execute(sql, { id })
		if (rows.length === 0) {
			return error(404, 'Book not found')
		}
		const { data: book, success } = BookSchema.safeParse(rows[0])
		if (!success) {
			return error(500, 'Invalid book data')
		}
		return json(book)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch book')
	}
}
