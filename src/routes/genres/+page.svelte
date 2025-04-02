<script lang="ts">
	let { data } = $props()
	let genres = $derived(data.genres)
</script>

<svelte:head>
	<title>Genres</title>
</svelte:head>

<h2>Genres</h2>

<ul class="list">
	{#each genres as genre (genre.id)}
		<li>
			<a href="/genre/{genre.id}">
				{genre.name}
			</a>
		</li>
	{/each}
</ul>
