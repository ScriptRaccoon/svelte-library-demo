import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import type { Genre } from '$lib/schemas'

export const load: PageServerLoad = async (event) => {
	const id = event.params.id
	const res = await event.fetch(`/api/genre?id=${id}`)

	if (!res.ok) {
		return error(res.status, 'Failed to fetch genre')
	}

	const genre: Genre = await res.json()

	return { genre }
}
