<script lang="ts">
	let { data } = $props()
	let books = $derived(data.books)
</script>

<svelte:head>
	<title>Books</title>
</svelte:head>

<h2>Books</h2>

<ul class="list">
	{#each books as book (book.id)}
		<li>
			<a href="/book/{book.id}">
				{book.title}
			</a>
		</li>
	{/each}
</ul>
