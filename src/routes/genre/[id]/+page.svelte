<script lang="ts">
	let { data } = $props()
	let genre = $derived(data.genre)
</script>

<svelte:head>
	<title>{genre.name}</title>
</svelte:head>

<h2>{genre.name}</h2>

<p>{genre.description}</p>

{#if genre.books.length}
	<ul class="list">
		{#each genre.books as book (book.id)}
			<li>
				<a href="/book/{book.id}">
					{book.title}
				</a>
			</li>
		{/each}
	</ul>
{:else}
	<p>No books are available within that genre</p>
{/if}
