import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import { z } from 'zod'

const GenreListSchema = z.array(
	z.object({
		id: z.number(),
		name: z.string(),
	}),
)

export const load: PageServerLoad = async (event) => {
	const res = await event.fetch('/api/genres')

	if (!res.ok) {
		return error(res.status, 'Failed to fetch genres')
	}

	const genres = await res.json()

	const { success, data } = GenreListSchema.safeParse(genres)
	if (!success) {
		return error(500, 'Invalid genres data')
	}

	return { genres: data }
}
