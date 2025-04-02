import { error } from '@sveltejs/kit'
import type { PageServerLoad } from '../$types'

type Genre = {
	id: number
	name: string
}

export const load: PageServerLoad = async (event) => {
	const res = await event.fetch('/api/genres')
	if (!res.ok) {
		return error(res.status, 'Failed to fetch genres')
	}
	const genres: Genre[] = await res.json()
	return { genres }
}
