# GitHub Statistics aggregator

Small web application, shows my GitHub repositories statistics to boost my ego.

2018 Nicolas Mora <mail@babelouest.org>

Version 0.5

## Installation

### Statistics aggregator

The script `huddersfield/github-stats/index.js` is used to gather a repository statistics on GitHub, it will use your [GitHub token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) stored in the file `huddersfield/GITHUB_TOKEN`.

You can execute `npm install` to install npm dependencies locally.

Usage is:

```shell
$ nodejs huddersfield/github-stats/index.js <github_user> <repository> <path_output>
$ # for example
$ nodejs huddersfield/github-stats/index.js torvalds linux huddersfield/github-stats/website/data/
```

Note: `<path_output>` must point to your directory `huddersfield/github-stats/website/data/` for the web application to work.

This script is intented to be executed every day.

You can use crontab to execute it every day at the same time, example:

```
# m h  dom mon dow   command
0 2 * * * /usr/bin/nodejs /opt/huddersfield/github-stats/index.js torvalds linux /opt/huddersfield/github-stats/website/data/
```

### Web application

Setup your web server to point to `huddersfield/github-stats/website`, example configuration for apache2:

```
Alias /ghs /opt/huddersfield/github-stats/website
<Directory /opt/huddersfield/github-stats/website>
  <filesMatch "\.(json)$">
    FileETag None
    <ifModule mod_headers.c>
      Header unset ETag
      Header set Cache-Control "max-age=0, no-cache, no-store, must-revalidate"
      Header set Pragma "no-cache"
      Header set Expires "Wed, 11 Jan 1984 05:00:00 GMT"
    </ifModule>
  </filesMatch>
</Directory>
```

Warning: This web application has no authentication built-in.
