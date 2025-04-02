import { z } from 'zod'

export const BookListSchema = z.array(
	z.object({
		id: z.number(),
		title: z.string(),
	}),
)

export type BookList = z.infer<typeof BookListSchema>

export const GenreListSchema = z.array(
	z.object({
		id: z.number(),
		name: z.string(),
	}),
)

export type GenreList = z.infer<typeof GenreListSchema>

export const GenreSchema = z.object({
	id: z.number(),
	name: z.string(),
	books: z.array(
		z.object({
			id: z.number(),
			title: z.string(),
		}),
	),
})

export type Genre = z.infer<typeof GenreSchema>

export const RatingRequestSchema = z.object({
	book_id: z.number(),
	rating: z.number().min(1).max(5),
})

export type RatingRequest = z.infer<typeof RatingRequestSchema>

export const BookSchema = z.object({
	id: z.number(),
	title: z.string(),
	author: z.string(),
	description: z.string().nullable(),
	genre: z.string(),
	genre_id: z.number(),
	published_year: z.number().nullable(),
	rating_count: z.number().min(0),
	average_rating: z.number().min(0).max(5),
})

export type Book = z.infer<typeof BookSchema>
