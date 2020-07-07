# Python-IDE

A simple portable python IDE environment

## Prep OS
```
apt install \
    curl ca-certificates gpg sudo \
    xauth x11-apps xterm \
    libxtst6 libasound2 \
    fakeroot gpg-agent xdg-utils \
    git jq \
    build-essential \
    pandoc fonts-dejavu
```

## Interpreter and basic packages

### Check local environment before installing
```
echo "system packages:"
dpkg -l | grep -E 'python[23]*-'
ls -la /usr/lib/python*/dist-packages/

echo "global pip packages:"
ls -la /usr/local/lib/python*/dist-packages/ # /usr/local/bin/$name

echo "user pip packages:"
ls -la ~/.local/lib/python*/site-packages/
```

### Install system packages and global pip packages
```
apt install \
    python3 python3-dev python3-pip python3-wheel \
    python3-pytest pylint flake8 pyflakes3
apt install \
    python3-setuptools \
    python3-pydocstyle \
    python3-aniso8601 python3-click python3-autopep8 python3-pep8 \
    python3-mccabe python3-flake8 python3-flake8-docstrings \
    python3-pylint-common python3-pylint-plugin-utils \
    python3-pylint-django python3-pylint-flask \
    python3-pycodestyle python3-pytoml python3-toml python3-yapf \
    python3-jinja2 python3-lxml \
    python3-markdown python3-markups python3-markupsafe \
    python3-jedi python3-jsonrpc python3-ujson python3-jsonschema \
    python3-pluggy python3-rope python3-pygments \
    python3-pyrsistent python3-send2trash python3-setproctitle \
    python3-flask python3-flask-httpauth python3-flask-sqlalchemy \
    python3-webob python3-werkzeug \
    python3-pyqt5

python3 -m pip install -U \
    'python-language-server[all]'
```

## Editor: Atom
```
curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -
echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list
apt update
apt install -y --no-install-recommends atom
```

### Check additional atom packages as user (!)
```
apm list
```

### Install additional atom packages as user (!)
```
apm install \
    busy-signal \
    intentions \
	auto-detect-indentation \
	output-panel \
	language-docker \
	ide-json \
        json-colorer \
        json-converter \
        pretty-json \
    ide-python \
    	autocomplete-python \
        python-indent \
    	python-autopep8 \
        python-requirements \
    	python-debugger \
        atom-python-run \
    	atom-python-test \
    	docblock-python \
    	build-python \
    linter \
        linter-python \
        linter-python-pep8 linter-python-pep257 \
        linter-flake8 linter-pyflakes \
        linter-swagger \
        linter-ui-default \
    rest-client \
    tidy-markdown
```

