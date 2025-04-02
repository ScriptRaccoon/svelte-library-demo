import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'
import type { Book } from '$lib/schemas'

export const load: PageServerLoad = async (event) => {
	const id = event.params.id
	const res = await event.fetch(`/api/book?id=${id}`)

	if (!res.ok) {
		return error(res.status, 'Failed to fetch book')
	}

	const book: Book = await res.json()

	return { book }
}
