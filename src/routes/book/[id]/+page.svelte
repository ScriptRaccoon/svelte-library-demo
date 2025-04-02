<script lang="ts">
	import StarRating from 'svelte-star-rating'
	let { data } = $props()
	let book = $derived(data.book)
	let saved_user_rating = $derived(data.user_rating)

	const rating_texts = ['Terrible', 'Bad', 'Okay', 'Good', 'Excellent']

	let selected_user_rating = $state(data.user_rating ?? null)
	let form_status = $state('')

	async function handle_submit(e: SubmitEvent) {
		e.preventDefault()
		if (selected_user_rating === null) {
			form_status = 'Please select a rating'
			return
		}

		if (saved_user_rating === null) {
			await submit_user_rating()
		} else {
			await update_user_rating()
		}
	}

	async function submit_user_rating() {
		const res = await fetch('/api/rating', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				book_id: book.id,
				rating: selected_user_rating,
			}),
		})

		form_status = res.ok ? 'Rating submitted!' : 'Error submitting rating'

		if (res.ok) {
			saved_user_rating = selected_user_rating
		}
	}

	async function update_user_rating() {
		if (selected_user_rating === saved_user_rating) {
			form_status = 'No changes made'
			return
		}

		const res = await fetch('/api/rating', {
			method: 'PATCH',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				book_id: book.id,
				rating: selected_user_rating,
			}),
		})

		form_status = res.ok ? 'Rating updated!' : 'Error updating rating'

		if (res.ok) {
			saved_user_rating = selected_user_rating
		}
	}

	let submit_button_text = $state(
		data.user_rating === null ? 'Submit rating' : 'Update rating',
	)
</script>

<svelte:head>
	<title>{book.title}</title>
</svelte:head>

<p>{book.author}</p>

<h2 class="title">{book.title}</h2>

{#if book.description}
	<p class="description">{book.description}</p>
{/if}

<section class="rating-container" aria-label="rating">
	<StarRating rating={book.average_rating} />
	<div class="rating-description">
		{book.average_rating.toFixed(1)} (based on {book.rating_count} ratings)
	</div>
</section>

<section>
	<h3>Details</h3>
	<div>
		<strong>Year of publication</strong> &ndash; {book.published_year}
	</div>
	<div>
		<strong>Genre</strong> &ndash;
		<a href="/genre/{book.genre_id}">
			{book.genre}
		</a>
	</div>
</section>

<section>
	<h3>Rate the book</h3>

	<form class="rating-form" onsubmit={handle_submit}>
		<select bind:value={selected_user_rating} class="select">
			{#each { length: 5 } as _, i}
				<option value={i + 1}>{i + 1} &ndash; {rating_texts[i]}</option>
			{/each}
		</select>
		<button class="button" type="submit">
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
</style>
