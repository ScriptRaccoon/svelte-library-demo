import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import { z } from 'zod'

const GenreSchema = z.object({
	name: z.string(),
	books: z.array(
		z.object({
			id: z.number(),
			title: z.string(),
		}),
	),
})

export const load: PageServerLoad = async (event) => {
	const id = event.params.id
	const res = await event.fetch(`/api/genre?id=${id}`)

	if (!res.ok) {
		return error(res.status, 'Failed to fetch genre')
	}

	const genre = await res.json()

	const { success, data } = GenreSchema.safeParse(genre)
	if (!success) {
		return error(500, 'Invalid genre data')
	}

	return { genre: data }
}
