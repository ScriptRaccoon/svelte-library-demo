import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'
import { GenreBooksSchema } from '$lib/schemas'

async function get_genre(id: string) {
	const sql = 'SELECT name, description FROM genres WHERE id = :id'
	const { rows } = await db.execute(sql, { id })
	if (rows.length === 0) {
		return null
	}
	const { name, description } = rows[0]
	return { name, description }
}

const sql = `
SELECT
    title,
    books.id as id
FROM
    genres
    INNER JOIN books ON books.genre_id = genres.id
WHERE
    genres.id = :id
`

export const GET: RequestHandler = async (event) => {
	const id = event.url.searchParams.get('id')
	if (!id) {
		return error(400, 'Missing id')
	}
	try {
		const genre = await get_genre(id)
		if (!genre) throw new Error('Genre not found')
		const { name, description } = genre
		const { rows } = await db.execute(sql, { id })
		const genre_with_books = GenreBooksSchema.parse({
			id: Number(id),
			description,
			name,
			books: rows,
		})
		return json(genre_with_books)
	} catch (err) {
		console.error(err)
		return error(500, 'Cannot fetch genre details')
	}
}
