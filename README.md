Paperwork
=========
[<img src="https://img.shields.io/matrix/paperwork:matrix.org.svg?color=%2361BCEE&label=JOIN%20THE%20CHAT&server_fqdn=matrix.org&style=for-the-badge"/>](https://riot.im/app/#/room/#paperwork:matrix.org)

Paperwork is an open-source, self-hosted alternative to services like Evernote ®, Microsoft OneNote ® or Google Keep ®

## Version 2

This branch contains the second iteration of Paperwork, which is a complete rewrite. Not only is it based on another framework - it is based on a completely different technology stack. **It is in its very early development phase and not yet usable**.

*If you were looking for the Laravel-based version 1 of Paperwork, please check [out this branch](https://github.com/paperwork/paperwork/tree/1). **Version 1 is not in active development anymore!***

### I would love to help building v2!

Feel free to check out this branch and get involved with what's there already to get an idea of where Paperwork is heading. Also check out the [current issues](https://github.com/paperwork/paperwork/issues) to see what needs to be done or suggest what could be done in future iterations.

Also, you can join the [official chatroom](https://riot.im/app/#/room/#paperwork:matrix.org) and participate there.

**Info: 99% of the action happens [inside the other repositories](https://github.com/paperwork)! This repository only contains of the one-click-deployment of Paperwork!**

## Usage

This repository is structuring and unifying all required components for Paperwork. It its purpose is to provide an **example of how you *could* host Paperwork yourself**. However, please keep in mind that the stack file used in this repostiory should **not be used for real-world, internet-facing deployments**, as it lacks the ability to manage credentials between services in a secure manner.

```bash
$ git clone git@github.com:paperwork/paperwork.git
```

### Docker Stack

In order to easily get Paperwork running as a Docker stack, utilizing whichever orchestrator you'd like, this repository comes with a handy Makefile. Let's have a look at it:

```bash
$ make help
```

Launching the Paperwork can be done by make`-ing the `deploy` target:

```bash
$ make deploy
```

The Makefile then takes care of initializing Swarm, in case you haven't done that already, creating the encrypted network (`papernet`) and deploying the Paperwork stack on top of it.

**Note:** This Docker stack is configured to use `www.paperwork.local` (for the [web UI](https://github.com/paperwork/web)) and `api.paperwork.local` (for the API services). Hence you will need to add these to the `127.0.0.1` entry in your `/etc/hosts` file:

```
127.0.0.1   localhost paperwork.local api.paperwork.local www.paperwork.local
```

In order to stop/remove the whole stack, simply use the `undeploy` target:

```bash
$ make undeploy
```

**Note:** This won't make your Docker host leave Swarm again, in case it wasn't running in Swarm mode before deploying! If you'd like to turn off Swarm, you have to manually do so.

### Orchestrator

If you'd like to use a different orchestrator for stack deployment, you can do so by setting the `ORCHESTRATOR` variable on deploy:

```bash
$ make deploy ORCHESTRATOR=kubernetes
```

For more info, check the official Docker documentation [for Mac](https://docs.docker.com/docker-for-mac/kubernetes/#override-the-default-orchestrator) and [Windows](https://docs.docker.com/docker-for-windows/kubernetes/#override-the-default-orchestrator).

## Developing / Contributing

Please refer to [the individual services' repositories](https://github.com/paperwork) in order to get more information on how to contribute.

### Repositories

Here are the main repositories of Paperwork v2:

- [`paperwork`](https://github.com/paperwork/paperwork): This repository, containing the one-click-deployment and overall documentation
- [`paperwork.ex`](https://github.com/paperwork/paperwork.ex): Elixir SDK for building Paperwork services
- [`service-configs`](https://github.com/paperwork/service-configs): Configurations service that stores instance configs and provides them through an internal endpoint to other services
- [`service-users`](https://github.com/paperwork/service-users): Users service that stores user information and provides endpoints for users to register, login and update their information
- [`service-notes`](https://github.com/paperwork/service-notes): Notes service that stores all user's notes
- [`service-storages`](https://github.com/paperwork/service-storages): Storages service that stores all user's attachments
- [`web`](https://github.com/paperwork/web): Angular-based web front-end for Paperwork

### Paperwork Architecture

![Paperwork Architecture](Paperwork%20Architecture.png)

### Tasks/Issues

As for now, all tasks/issues are being [collected inside this repository](https://github.com/paperwork/paperwork/issues), just to keep it simple. On a long term, tasks/issues will be transferred into the related service's repository, in order to be able to reference them through git commits.

## Links

- [Browse](https://paperwork.cloud)
- [Chat](https://riot.im/app/#/room/#paperwork:matrix.org)
- [Tweet](https://twitter.com/paperworkcloud)
- [Mail](mailto:highfive@paperwork.cloud)
