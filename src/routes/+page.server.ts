import { error } from '@sveltejs/kit'
import type { PageServerLoad } from './$types'

type BookTitle = {
	id: number
	title: string
}

export const load: PageServerLoad = async ({ fetch }) => {
	const res = await fetch('/api/titles')
	if (!res.ok) {
		return error(res.status, 'Failed to fetch books')
	}
	const books: BookTitle[] = await res.json()
	return { books }
}
