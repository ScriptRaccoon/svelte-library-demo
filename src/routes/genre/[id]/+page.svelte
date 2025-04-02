<script lang="ts">
	let { data } = $props()
	let genre = $derived(data.genre)
</script>

<svelte:head>
	<title>{genre.name}</title>
</svelte:head>

<h1>{genre.name}</h1>

<ul>
	{#each genre.books as book (book.id)}
		<li>
			<a href="/book/{book.id}">
				{book.title}
			</a>
		</li>
	{/each}
</ul>
