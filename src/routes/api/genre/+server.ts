import { error, json } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import { db } from '$lib/server/db'

async function get_genre_name(id: string) {
	const { rows } = await db.execute('SELECT name FROM genres WHERE id = :id', { id })
	return rows[0].name
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
	const name = await get_genre_name(id)
	const { rows: books } = await db.execute(sql, { id })
	return json({ name, books })
}
