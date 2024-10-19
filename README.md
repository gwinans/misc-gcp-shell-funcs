# gcloud shell funcs

.. and other crap.

The repository contains useful Bash shell funcs for the gcloud cli, cloud-sql-proxy and misc helper funcs.

## Why?

Why not? I'm lazy.

All of these functions can be used directly if sourced.

## Directory Structure:

```
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
