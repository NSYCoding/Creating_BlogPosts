My fellow students and passionate programmers,

I am pleased to announce that I have written two scripts that have most likely saved me some money.
Since I post about what I have learned, I thought it would be a good idea to create a blog.
What I wanted most for my blog was to save as much money as possible. That means no server is needed, and therefore no new monthly costs.

In other words: I wanted a static website where I push dynamic `post-${i}.json` files to my Github repository using `git push`. This way, I can view my own blog in my `index.html`.

In short, I wrote a PowerShell script that creates JSON files, which are then fetched with JavaScript. With JavaScript, each post is loaded individually using `URLSearchParams` and a `Promise`.

What I have learned:
I have (further) learned:
- That there are many ways to achieve a goal, especially after being a software development student for over a year.
- That more is possible by asking new questions.
- That even more is possible by combining technologies.
- How `URLSearchParams` works.

I hope my information or code has been valuable.

The Github link: