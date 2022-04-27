# use-private-docker-action

Action that allows for running docker container actions from private registries

## The Problem

The runners for GitHub Actions currently do not support running a private docker container as a
GitHub Action. GitHub does support running a public docker container as a GitHub action though.

So for example, if you publish a docker container that isn't public to GHCR and try and run it,
GitHub Actions will fail to pull the container.

```yaml
  - name: Fail to Run Private Docker Container Action
    uses: docker://ghcr.io/owner/private-container-action:1.2.3
    with:
      input_1: 'input'
    env:
      ENV_VAR_1: 'env-var'
```

## The Solution

Introducing `use-private-docker-action`, the public GitHub Action that will pull and execute a
privately hosted docker action.

This action merely pulls the action you want to execute with the credentials specified, and runs it
in docker. This is "docker in docker", however, since you are sharing the same docker socket as the
GitHub runner, your docker container is running just like any other container and not within a
nested docker host. Thus, you will still see all the benefits of docker layer caching that GitHub
runners provide.

## Usage
```yaml
  - name: Successfully Run Private Docker Container Action
    uses: rdinardi-bw/use-private-docker-action@main
    with:
      docker_registry: ghcr.io
      docker_username: ${{ github.actor }}
      docker_password: ${{ secrets.GITHUB_TOKEN }}
      package: ghcr.io/owner/private-container-action:1.2.3
      inputs: |
        with:
          input_1: 'test'
        env:
          ENV_VAR_1: 'env-var'
```
