<header>
	<h1>Svelte Library Demo</h1>

	<nav>
		<ul>
			<li>
				<a href="/">Home</a>
			</li>
			<li>
				<a href="/books">Books</a>
			</li>
			<li>
				<a href="/genres">Genres</a>
			</li>
		</ul>
	</nav>
</header>

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
</style>
