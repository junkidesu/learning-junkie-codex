# learning-junkie-codex

Remote code execution tool for Haskell. This library provides a Servant client function `executeClient` for remotely executing your code.

Currently, the following environments are supported, with future plans to add more languages:
- Haskell
- Node
- Python

## Getting Started

First and foremost, clone the repository on your local machine:

```sh
$ git clone https://github.com/junkidesu/learning-junkie-codex
```

### Prerequisites

To build the tool locally, ensure that the following are installed:

- [Stack](https://docs.haskellstack.org/en/stable/)
- [Cabal](https://cabal.readthedocs.io/en/stable/)

Stack and Cabal can be installed either independently or with the [GHCup](https://www.haskell.org/ghcup/) tool.

### Build Locally

To build the project, run `stack build` at the root of the cloned repository:

```sh
$ stack install
```

## Usage

### Library 
The package has not been uploaded to hackage yet. Assuming that you use Stack, perform the following steps to use the library in your Haskell project:

1. Add the library to `extra-deps` of the `stack.yaml` file:

```yaml
extra-deps:
- github: junkidesu/learning-junkie-codex
  commit: 9cb4e496dc009b60ffa3aeb5d72566caf7f43602 # check the latest commit ID on GitHub
```

2. Add the library as a dependency in the `package.yaml` file:

```yaml
dependencies:
- learning-junkie-codex
```

### Service 

To start the service locally, first run `stack install` at the root of the repository, and then execute

```sh
$ learning-junkie-codex-exe
```

This will start the code execution server locally on port 3001.

The OpenApi specification of the documentation is available at https://learning-junkie-codex-main.onrender.com/swagger-ui