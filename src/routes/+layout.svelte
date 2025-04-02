<script lang="ts">
	import './app.css'
</script>

<header>
	<h1>Svelte Library Demo</h1>

	<nav>
		<ul>
			<li>
				<a href="/">Books</a>
			</li>
			<li>
				<a href="/genres">Genres</a>
			</li>
		</ul>
	</nav>
</header>

<main>
	<slot></slot>
</main>

<style>
	header {
		text-align: center;
		padding-block: 1.25rem;
		background-color: var(--primary-color);
	}

	nav {
		margin-top: 0.25rem;
	}

	ul {
		display: flex;
		justify-content: center;
		list-style: none;
		gap: 1rem;
	}

	main {
		max-width: 42rem;
		margin-inline: auto;
		padding: 1rem;
		margin-bottom: 1rem;
	}
</style>
