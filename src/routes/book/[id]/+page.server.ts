import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'

type Book = {
	id: number
	title: string
	author: string
	description: string
	genre: string
	genre_id: number
	published_year: number
	rating_count: number
	average_rating: number
}

export const load: PageServerLoad = async (event) => {
	const id = event.params.id
	const res = await event.fetch(`/api/book?id=${id}`)
	if (!res.ok) {
		return error(res.status, 'Failed to fetch book')
	}
	const book: Book = await res.json()
	return { book }
}
