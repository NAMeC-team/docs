# NAMeC mdBook documentation
## Layout
The docs are separated in one folder per division in the team (such as "software" or "embedded systems").
For now, each folder is supposed to be a unique mdBook.

You can find the documentation on the mdbook tool [here](https://rust-lang.github.io/mdBook/)
In each book, you can run `mdbook serve` to see your changes on each edit locally.
Nothing much different from what the documentation says, it's just mdbook folders.

## Updating the docs
Each change to the documentation must be performed on a separate branch, then a
PR should be created to merge those changes into the main branch.

The `Dockerfile` produces builds a new image on each PR merged into main (via GitHub actions).
This image will be copied to our remote server and deployed using a custom Docker compose script that is not stored on this repo.

Right now, the Dockerfile is a simple httpd server running with all books on their own path, and a style-less home page that lists all the books available, on port 80.
You can test the Dokcerfile locally with the following commands
```sh
# you can omit the sudo if you have Docker rootless set up
sudo docker build -t namec-team/docs:tmp .
sudo docker run -p 8080:80 namec-team/docs:tmp
```
and open http://localhost:8080 to see the result.