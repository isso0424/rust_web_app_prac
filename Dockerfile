FROM rust:1.54.0 AS builder

WORKDIR /todo

COPY Cargo.toml Cargo.toml
RUN mkdir src
RUN echo "fn main(){}" > src/main.rs
RUN cargo build --release
COPY ./src ./src
COPY ./templates ./templates
RUN rm -rf target/release/deps/rust_web_app_prac*
RUN cargo build ---release

FROM debian:10.4
COPY --from=builder /todo/target/release/rust_web_app_prac /usr/local/bin/rust_web_app_prac
CMD ["rust_web_app_prac"]
