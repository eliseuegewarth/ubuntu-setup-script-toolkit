# Ubuntu Gnome 16.04 Setup
Bash Utils to configure your system quickly.

### How-To:
[SUDO REQUIRED]
```
git clone https://github.com/eliseuegewarth/ubuntu-gnome-16-04-setup.git ~/.magic_setup && \
cd ~/.magic_setup && \
./start_ubuntu.sh --full
```

### The `start_ubuntu.sh` do things like:

- install some text editors (atom and sublime text for now)
- install terminator, ssh packages and nodejs
- install docker and docker-compose
- install google chrome
- Configure Gnome interface:
    - icons
    - theme
    - background image (__you can replace file img/background.png by your choice__)
- Configure some sublime text preferences (if installed)

### The `ssh_config.sh` configure ssh_key. It use credentials you write in file `.secret_env`. Follow `env_example` instructions.
