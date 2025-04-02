import type { RequestHandler } from './$types'
import { error, json } from '@sveltejs/kit'
import { db } from '$lib/server/db'

const sql = `
SELECT
    books.id AS id,
    title,
    authors.name AS author,
    description,
    published_year,
    genres.name AS genre,
    genre_id,
    COUNT(ratings.rating) AS rating_count,
    COALESCE(AVG(ratings.rating), 0) AS average_rating
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
		const book = rows[0]
		return json(book)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch book')
	}
}
