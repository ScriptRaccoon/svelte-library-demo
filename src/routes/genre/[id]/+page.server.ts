import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'

type Genre = {
	name: string
	books: {
		id: number
		title: string
	}[]
}

export const load: PageServerLoad = async (event) => {
	const id = event.params.id
	const res = await event.fetch(`/api/genre?id=${id}`)
	if (!res.ok) {
		return error(res.status, 'Failed to fetch genre')
	}
	const genre: Genre = await res.json()
	return { genre }
}
