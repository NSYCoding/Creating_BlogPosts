fetch('posts/total-posts.json')
    .then(response => response.json())
    .then(meta => {
        const totalPosts = meta.totalPosts;
        const urlParams = new URLSearchParams(window.location.search);
        const page = parseInt(urlParams.get('page')) || 1;
        const postsPerPage = 1;
        const lastPage = Math.ceil(totalPosts / postsPerPage);

        const startPost = (page - 1) * postsPerPage + 1;
        const endPost = startPost + postsPerPage;

        const fetchPromises = [];
        for (let i = startPost; i < endPost; i++) {
            fetchPromises.push(
                fetch(`posts/post-${i}.json`)
                    .then(response => {
                        if (!response.ok) {
                            console.error(`Failed to fetch post-${i}.json: HTTP error! status: ${response.status}`);
                            return null;
                        }
                        return response.json();
                    })
                    .then(data => ({
                        index: i,
                        data
                    }))
                    .catch(err => {
                        console.log(err);
                        return null;
                    })
            );
        }

        Promise.all(fetchPromises).then(results => {
            let allPostsHTML = '';
            results.forEach(result => {
                if (result && result.data) {
                    allPostsHTML += `
                        <div class="post">
                            <h2>${result.data.title}</h2>
                            <p>${result.data.content}</p>
                        </div>
                    `;
                }
            });

            if (!allPostsHTML) {
                allPostsHTML = `<div class="no-posts">No posts found for this page.</div>`;
            }

            document.body.innerHTML = `
                <div class="all-posts">${allPostsHTML}</div>
                <div class="pagination">
                    <a href="?page=${page - 1}" ${page === 1 ? 'style="visibility:hidden;"' : ''}>Previous</a>
                    <a href="?page=${page + 1}" ${page === lastPage ? 'style="visibility:hidden;"' : ''}>Next</a>
                </div>
            `;
        });
    });