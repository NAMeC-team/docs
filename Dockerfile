# note: using a lightweight image such as alpine is difficult
# mdbook loads glibc dynamically, so can't use alpine

FROM ubuntu:22.04 AS build

RUN apt update && apt install -y curl
COPY ./books/ /tmp/books
RUN mkdir -p build && \
	curl -sSL https://github.com/rust-lang/mdBook/releases/download/v0.5.3/mdbook-v0.5.3-x86_64-unknown-linux-gnu.tar.gz | tar -xz --directory=bin && \
	ls -la bin/mdbook && \
	bin/mdbook build /tmp/books/embedded && \
	bin/mdbook build /tmp/books/software

FROM httpd:2.4 AS serve
COPY --from=build /tmp/books/embedded/book/ /usr/local/apache2/htdocs/embedded/
COPY --from=build /tmp/books/software/book/ /usr/local/apache2/htdocs/software/
COPY ./index.html /usr/local/apache2/htdocs/
