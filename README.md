# NAMeC mdBook documentation
Collection of 'mdbook's folders that contain the documentation of each division of the codebase of NAMeC

## Development requirements
- [mdbook](https://rust-lang.github.io/mdBook/guide/installation.html)

## Layout
The docs are separated in one folder per division in the team (such as "software" or "embedded systems").
For now, each folder is supposed to be a unique mdBook.

You can find the documentation on the mdbook tool [here](https://rust-lang.github.io/mdBook/)
In each book, you can run `mdbook serve` to see your changes on each edit locally.
Nothing much different from what the documentation says, it's just mdbook folders.

## Updating the docs
Each change to the documentation must be performed on a separate branch, then a
PR should be created to merge those changes into the main branch. The PR must
- modify content in `books/`
- change the `version` file to a number that respects semantic versioning

When both occurs, and the PR is merged, the new version is automatically pushed to our
[Dockerhub repository](https://hub.docker.com/repository/docker/namecteam/docs), updating the
`latest` tag and adding a new tag with the content of the `version` file.

*Nothing stops you from writing anything in that file, like nyan cat, or french fries. Please don't do it ;-;*

PRs have to be reviewed by at least one person. You can probably bypass that though, but it's better if someone checks you updated
the documentation correctly ('corporate workflow' type of stuff).
The server does not automatically pull the new image (yet), so you have to request a sysadmin to re-run the associated docker-compose on the server.

Right now, the Dockerfile is a simple httpd server running with all books on their own path, and a style-less home page that lists all the books available, on port 80.
If you want to see the result, opening the `index.html` file won't work, it's supposed to be copied inside the Docker image for deployment. Sorry :c

Instead, you can either serve the whole documentation locally with the following commands
```sh
# you can omit the sudo if you have Docker rootless set up
sudo docker build -t namec-team/docs:tmp .
sudo docker run -p 8080:80 namec-team/docs:tmp
```
and open http://localhost:8080 to see the result.

To edit a single book and see your results on every change, just navigate to the book's root folder and run `mdbook serve`.

## CI pipelines
- Docker build check : ran whenever content in the `books/` directory changes in a PR
- Upload new Docker image : see above
The second workflow can be ran manually. Unless you have some testing to do, do not trigger that workflow manually,
the idea being that changing the version file helps us keep track of the past versions of the documentation.

## mdbook syntax
See [mdbook docs](https://rust-lang.github.io/mdBook/format/markdown.html)
