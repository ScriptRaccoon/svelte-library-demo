<script lang="ts">
	let { data } = $props()
</script>

<svelte:head>
	<title>Genres</title>
</svelte:head>

<h2>Genres</h2>

<ul class="list">
	{#each data.genres as genre (genre.id)}
		<li>
			<a href="/genre/{genre.id}">
				{genre.name}
			</a>
		</li>
	{/each}
</ul>
