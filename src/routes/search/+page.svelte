<script lang="ts">
	import { enhance } from '$app/forms'

	let { data } = $props()
	let books = $derived(data.books)

	let submitted = $state(false)

	function handle_submit(e: SubmitEvent) {
		if (submitted) {
			e.preventDefault()
			return
		}
		submitted = true
	}
</script>

<svelte:head>
	<title>Search for Books</title>
</svelte:head>

<h2>Search for Books</h2>

<form action="/search" method="GET" use:enhance onsubmit={handle_submit}>
	<label for="query">Query</label>
	<input
		type="text"
		id="query"
		name="q"
		placeholder="Search..."
		class="input"
		required
		value={data.query ?? ''}
	/>
	<button type="submit" class="button" disabled={submitted}>
		{#if submitted}
			Searching...
		{:else}
			Search
		{/if}
	</button>
</form>

{#if books}
	<section>
		<h3>Results ({books.length})</h3>

		{#if books.length}
			<ul class="list">
				{#each books as book (book.id)}
					<li>
						<a href="/book/{book.id}">
							{book.title}
						</a>
					</li>
				{/each}
			</ul>
		{:else}
			<p>No books matching '{data.query}'</p>
		{/if}
	</section>
{/if}

<style>
	label {
		display: block;
		margin-bottom: 0.25rem;
	}

	input {
		display: block;
		width: 100%;
		margin-bottom: 1rem;
	}

	section {
		margin-block: 2rem;
	}
</style>
