import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import type { GenreList } from '$lib/schemas'

export const load: PageServerLoad = async (event) => {
	const res = await event.fetch('/api/genres')

	if (!res.ok) {
		return error(res.status, 'Failed to fetch genres')
	}

	const genres: GenreList = await res.json()

	return { genres }
}
