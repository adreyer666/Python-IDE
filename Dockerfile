FROM debian:bullseye-slim

ARG DEBIAN_FRONTEND=noninteractive

# install just enough system and X11
RUN apt-get update \
    && apt-get upgrade -q -y \
    && apt-get install -q -y --no-install-recommends \
	apt-utils procps iproute2 \
	curl ca-certificates gpg sudo \
	vim-tiny less mlocate fakeroot gpg-agent \
	xauth x11-apps xterm \
	libxtst6 libasound2 \
	xdg-utils darkmint-gtk-theme gtk-theme-switch gnome-tweaks

# dev languages and tools
RUN apt-get install -q -y --no-install-recommends \
	build-essential \
	python3 python3-dev python3-pip python3-venv python3-wheel \
	git \
	pandoc fonts-dejavu

RUN apt-get install -q -y --no-install-recommends \
	python3-setuptools \
	python3-autopep8 \
	python3-flake8 python3-flake8-docstrings \
	python3-mccabe \
	python3-pytest
RUN python3 -m pip install -U 'python-language-server[all]'

# atom install
RUN curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add - \
    && echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends atom

#RUN curl -Lk https://atom.io/download/deb -o /tmp/atom.deb \
#    && dpkg -i /tmp/atom.deb \
#    && apt-get install -f

# ensure that we have a clean installation
RUN apt-get install -f
RUN apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/apt/archives/partial

# --- create user and workarea --- #
# change user so application does not run as root
ENV USER  user
ENV PASS  user
RUN useradd -d /home/user -m -s /bin/bash $USER
RUN echo "$USER:$PASS" | chpasswd
RUN echo "$USER   ALL=(ALL:ALL) NOPASSWD: ALL"  > /etc/sudoers.d/$USER
RUN mkdir -p /home/user/.atom/config.cson
COPY .atom.config.cson /home/user/.atom/config.cson
RUN mkdir -p /workspace && chown -R $USER: /workspace

# --- from now on run as user --- #
USER $USER
# atom extensions
RUN apm install \
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

## RUN apm install \
## 	python-jedi \
## 	git-plus \
## 	merge-conflicts \
## 	split-diff \
## 	dbg \
## 	dbg-gdb \
## 	platformio-ide-terminal \
## 	atom-ide-ui

WORKDIR /workspace
CMD [ "atom", "-f", "--no-sandbox" ]

