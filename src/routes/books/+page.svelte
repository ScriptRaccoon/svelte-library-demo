<script lang="ts">
	let { data } = $props()
</script>

<svelte:head>
	<title>Books</title>
</svelte:head>

<h2>Books</h2>

<ul class="list">
	{#each data.books as book (book.id)}
		<li>
			<a href="/book/{book.id}">
				{book.title}
			</a>
		</li>
	{/each}
</ul>
