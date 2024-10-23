# gcloud shell funcs

.. and other crap.

The repository contains useful Bash shell funcs for the gcloud cli, cloud-sql-proxy and misc helper funcs.


## Content

* [Why?](#why)
* [Directory Structure](#directory-structure)
* [Pre-Reqs](#pre-reqs)
* [Usage & Examples](#usage)

## Why?

Why not? I'm lazy.

All of these functions can be used directly if sourced.

## Directory Structure:

```
|-- cloudsql_helper.sh       | Helper functions for CloudSQL
|-- cloudsql_proxy_helpe.sh  | Helper functions for the cloud_sql_proxy (1.37.0, no support for v2+)
|-- gcloud_helpers.sh        | Helper functions for the gcloud CLI
|-- generic_helpers.sh       | Generic bash/zsh helper functions, can be used directly if sourced.
```

## Pre-Reqs

### If you are on ... any Linux distro

Install the following:

* https://cloud.google.com/sdk/docs/install
* https://github.com/GoogleCloudPlatform/cloud-sql-proxy/releases/tag/v1.37.0

### If you are on a Mac

Install the following:
* https://github.com/GoogleCloudPlatform/cloud-sql-proxy/releases/tag/v1.37.0

**Execute the following:**

```
brew install bash gnu-getopt coreutils gcloud 
brew link gnu-getopt
brew link coreutils
echo 'export PATH="/opt/homebrew/bin:/opt/homebrew/opt/gnu-getopt/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Usage

```
source *.sh
```

You can then execute any of the functions like so:

```
get_secret my-project my-secret-name
```

These can - hopefully obviously - be used in shell scripts as well.

```
#!/usr/bin/env bash

for f in /path/to/the/files/*.sh; do source "${f}"; done

mypwd=$( get_secret my-project my-secret-name )

echo "${mypwd}"
```