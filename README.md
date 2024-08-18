# LEMP stack with Python

Linux + Nginx + MySQL + Python, **minimal** stack, thanks to docker compose

## Services

### *Proxy*

A [Nginx](https://hub.docker.com/_/nginx) server listening on exposed and forwarded port _`80`_. Redirects to the entrypoint for this app which is **web** ip address+port. 

It depends on **web** service to start.

### *Web* 

An empty image of [Python: 3.9](https://hub.docker.com/_/python) with:

- libmysql-client
- mysql-client 
- [PDM](https://pdm-project.org/en/latest/) for package management

And dev tools for it's dev-stage like:

- git
- [cookiecutter](https://github.com/cookiecutter/cookiecutter)
- [copier](https://copier.readthedocs.io/en/stable/)

By default it has port _`8000`_ exposed, only to other services in this docker coompose network.

This service depends on "**db**" service to start.

### *DB* 

[MySQL 8.4 LTS](https://hub.docker.com/_/mysql) service.

It comes with an dummy _`init.sql`_ that creates a database "**todoapp**", uses the credentials from _`.env`_ and creates a table called "**tasks**".

Exposed port 3306 by default.

## Use

You can start development from your usual **WSL** distribution, inside the terminal, *clone* this project and then *run* the commands.

### 1 - **Start up the stack**

```bash
docker compose --env-file .env.dev -f compose-dev.yaml up --watch
```

This will start the services, keep the files in sync, watch for rebuilds, and show you the services's logs.

### 2 - **Enter web service terminal**

Open another terminal and run:

```bash
docker compose --env-file .env.dev -f compose-dev.yaml exec web bash
```

This will give you access to the **web** service terminal inside the workdir (project root directory).

### 3 - **Create a Python project**

Once inside the container you can run PDM commands and create a new project.

```bash
pdm init [template]
```

### 4 - **Add dependency packages needed**

You can now dd package(s) to _`pyproject.toml`_ and install them.

```bash
pdm add <package> [packages...]
```

### 5 - **Install everything...**

And install dependencies from lock file and resolve paths.

```bash
pdm install [packages...]
```

This also builds the project as "editable" package.


### 5 - **Run the project!!!**

If you created a project from a template or wrote the app, the entrypoint will be or probably should be referenced in _`[pdm.script]`_ block-section in _`pyproject.toml`_ with the key _`start`_

```bash
pdm run start
```

Now enjoy!!!

### 6 - Common PDM commands

To list packages installed in the current working set.

```bash
pdm list
```

Resolve and lock dependencies and update the _`pdm.lock`_ file.

```bash
pdm lock
```

You can also update package(s) in _`pyproject.toml`_.

```bash
pdm update [packages...]
```

And also remove packages from _`pyproject.toml`_.

```bash
pdm remove <package> [packages...]
```

## Some extra help

To test the database from **web** service, just enter the bash in the **web** service.

```bash
docker compose exec web bash
```

And run the following command yo show all the databases in the **db** service.

```bash
mysql --user=$DB_USER --password=$(cat $DB_PASS) --host=$DB_HOST --execute="SHOW DATABASES;"
```

To test it from the "**db**" service enter the bash.

```bash
docker compose exec db bash
```

And run the following command too.

```bash
mysql --user=$MYSQL_USER --password=$(cat $MYSQL_PASSWORD_FILE) --execute "SHOW DATABASES;"
```

## Clarifications

### Git

To use git like you normally do in your host machine, you have to have:

- Docker Desktop **_"WSL 2 based engine"_** option enabled.
- Your **_github credentials_** configured in your default WSL2 distro.