import type { RequestHandler } from './$types'
import { error, json } from '@sveltejs/kit'
import { db } from '$lib/server/db'

const sql = `
SELECT
    books.id as id,
    title,
    authors.name as author,
    description,
    published_year,
    genres.name as genre,
    genre_id
FROM
    books
    INNER JOIN authors ON books.author_id = authors.id
    INNER JOIN genres ON books.genre_id = genres.id
WHERE
    books.id = :id
`

export const GET: RequestHandler = async (event) => {
	const id = event.url.searchParams.get('id')
	if (!id) {
		return error(400, 'Missing id')
	}
	const { rows } = await db.execute(sql, { id })
	const book = rows[0]
	return json(book)
}
