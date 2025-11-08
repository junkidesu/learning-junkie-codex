FROM haskell:9.6.4 AS build-stage

WORKDIR /usr/app

COPY ./package.yaml /stack.yaml ./stack.yaml.lock .

RUN stack build --only-dependencies

COPY . . 

RUN stack install --local-bin-path .

FROM ubuntu:20.04 AS deployment

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y libpq-dev
RUN apt-get install -y curl

COPY --from=build-stage /usr/app/learning-junkie-codex-exe /bin/

ENTRYPOINT ["/bin/learning-junkie-codex-exe"]
