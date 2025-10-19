# learning-junkie-codex

Remote code execution tool for Haskell.

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

The package has not been uploaded to hackage yet. Assuming that you use Stack, perform the following steps to use the library in your Haskell project:

1. Add the library to `extra-deps` of the `stack.yaml` file:

```yaml
extra-deps:
- github: junkidesu/learning-junkie-codex
  commit: 9cb4e496dc009b60ffa3aeb5d72566caf7f43602 #latest commit ID
```

2. Add the library as a dependency in the `package.yaml` file:

```yaml
dependencies:
- learning-junkie-codex
```