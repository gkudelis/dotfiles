#!/usr/bin/env python3
from functools import wraps
import glob
import os
import sh
import sys


commands = dict()


def explain_usage():
    print("Available commands: {}".format(", ".join(commands.keys())))


def add_to_dispatch(f):
    commands[f.__name__] = f
    return f


def dispatch(command, *args):
    if command in commands:
        commands[command](*args)
    else:
        explain_usage()


def with_logging(f):
    @wraps(f)
    def wrapped(*args):
        print("Start {}".format(f.__name__))
        f(*args)
        print("Finish {}".format(f.__name__))
    return wrapped


@with_logging
def plug_install():
    sh.nvim("--headless", "+PlugInstall", "+UpdateRemotePlugins", "+qa")


@with_logging
def plug_uninstall():
    plugged_path = os.path.join(os.environ["HOME"], ".config/nvim/plugged")
    sh.rm("-rf", plugged_path)


@with_logging
def link():
    sh.stow("--no-folding", "--target=" + os.environ["HOME"], "--stow", "current")


@with_logging
def unlink():
    sh.stow("--no-folding", "--target=" + os.environ["HOME"], "--delete", "current")


def select_variant():
    return os.getenv("DOTFILES_VARIANT", "default")


def common_files():
    for dirpath, _, filenames in os.walk("common"):
        for filename in filenames:
            fullname = os.path.join(dirpath, filename)
            yield os.path.relpath(fullname, start="common")


def restore_file(filename, variant):
    common_filename = os.path.join("common", filename)
    current_filename = os.path.join("current", filename)
    os.makedirs(os.path.dirname(current_filename), exist_ok=True)

    with open(common_filename) as common, open(current_filename, 'w') as current:
        for line in common:
            if line.startswith("----- "):
                partial_path = resolve_partial_path(line[6:-1], variant)
                if partial_path is not None:
                    with open(partial_path) as partial_content:
                        for partial_line in partial_content:
                            current.write(partial_line)
            else:
                current.write(line)


def resolve_partial_path(partial_name, variant):
    variant_partial_path = os.path.join('variants', variant, partial_name)
    default_partial_path = os.path.join('variants', 'default', partial_name)

    if os.path.exists(variant_partial_path):
        return variant_partial_path
    elif os.path.exists(default_partial_path):
        return default_partial_path
    else:
        return None


@with_logging
def restore_variant(variant):
    sh.rm("-rf", "current")
    sh.mkdir("current")
    for filename in common_files():
        restore_file(filename, variant)


@add_to_dispatch
@with_logging
def install():
    restore_variant(select_variant())
    link()
    plug_install()


@add_to_dispatch
@with_logging
def uninstall():
    plug_uninstall()
    unlink()


if __name__ == "__main__":
    if len(sys.argv) > 1:
        dispatch(*sys.argv[1:])
    else:
        explain_usage()
