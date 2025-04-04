<script lang="ts">
	import { invalidateAll } from '$app/navigation'
	import {
		faCalendar,
		faLayerGroup,
		faQuoteLeft,
		faQuoteRight,
	} from '@fortawesome/free-solid-svg-icons'
	import Fa from 'svelte-fa'
	import StarRating from 'svelte-star-rating'
	let { data } = $props()
	let book = $derived(data.book)

	const rating_texts = ['Terrible', 'Bad', 'Okay', 'Good', 'Excellent']

	let selected_user_rating = $state(data.user_rating)
	let form_status = $state('')
	let enable_submission = $state(true)

	async function handle_submit(e: SubmitEvent) {
		e.preventDefault()
		if (!enable_submission) return
		enable_submission = false
		form_status = ''

		if (selected_user_rating === null) {
			form_status = 'Please select a rating'
			enable_submission = true
			return
		}

		if (data.user_rating === null) {
			await submit_user_rating()
		} else {
			await update_user_rating()
		}
	}

	async function submit_user_rating() {
		const res = await fetch('/api/v1/userrating', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				book_id: book.id,
				rating: selected_user_rating,
			}),
		})

		form_status = res.ok ? 'Rating submitted!' : 'Error submitting rating'

		if (res.ok) {
			invalidateAll()
		} else {
			enable_submission = true
		}
	}

	async function update_user_rating() {
		if (selected_user_rating === data.user_rating) {
			form_status = 'No changes made'
			enable_submission = true
			return
		}

		const res = await fetch('/api/v1/userrating', {
			method: 'PATCH',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				book_id: book.id,
				rating: selected_user_rating,
			}),
		})

		form_status = res.ok ? 'Rating updated!' : 'Error updating rating'

		if (res.ok) {
			invalidateAll()
		} else {
			enable_submission = true
		}
	}

	let submit_button_text = $state(
		data.user_rating === null ? 'Submit rating' : 'Update rating',
	)
</script>

<svelte:head>
	<title>{book.title}</title>
</svelte:head>

<p>
	<a href="/author/{book.author_id}">{book.author_name}</a>
</p>

<h2 class="title">{book.title}</h2>

{#if book.description}
	<p class="description">
		<Fa icon={faQuoteLeft} />
		{book.description}
		<Fa icon={faQuoteRight} />
	</p>
{/if}

<section class="rating-container" aria-label="rating">
	<StarRating rating={book.rating_average} />
	<div class="rating-description">
		{book.rating_average.toFixed(1)} (based on {book.rating_count} ratings)
	</div>
</section>

<section class="details">
	<h3>Details</h3>
	<div>
		<Fa icon={faCalendar} />
		<strong>Year of publication</strong> &ndash; {book.published_year}
	</div>
	<div>
		<Fa icon={faLayerGroup} />
		<strong>Genre</strong> &ndash;
		<a href="/genre/{book.genre_id}">
			{book.genre_name}
		</a>
	</div>
</section>

<section>
	<h3>Rate the book</h3>

	<form class="rating-form" onsubmit={handle_submit}>
		<select bind:value={selected_user_rating} class="select" aria-label="rating">
			{#each { length: 5 } as _, i}
				<option value={i + 1}>{i + 1} &ndash; {rating_texts[i]}</option>
			{/each}
		</select>
		<button class="button" type="submit" disabled={!enable_submission}>
			{submit_button_text}
		</button>
	</form>

	<div class="form_status" aria-live="polite">
		{form_status}
	</div>
</section>

<style>
	.title {
		margin-top: -0.5rem;
	}

	section {
		margin-bottom: 1.5rem;
	}

	.description {
		font-size: 1.25rem;
	}

	.rating-container {
		display: flex;
		align-items: start;
		gap: 0.25rem;
	}

	.rating-description {
		color: var(--secondary-font-color);
	}

	.rating-form {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
		margin-block: 0.5rem;

		@media (min-width: 600px) {
			flex-direction: row;
			gap: 1rem;
		}
	}

	.details :global(svg) {
		width: 2rem;
		margin-left: -0.25rem;
	}
</style>
