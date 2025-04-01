import type { PageServerLoad } from './$types'

export const load: PageServerLoad = async ({ fetch }) => {
	const res = await fetch('/api/titles')
	const books = (await res.json()) as { id: number; title: string }[]
	return { books }
}
