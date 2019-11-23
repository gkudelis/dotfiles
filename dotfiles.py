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
    def wrapped():
        print("Start {}".format(f.__name__))
        f()
        print("Finish {}".format(f.__name__))
    return wrapped


def stow_common_args():
    return ["--no-folding", "--dir=current", "--target=" + os.environ["HOME"]]


def packages():
    return list(map(lambda p: p.split("/")[-1], glob.glob("current/*")))


def diff_file(variant):
    return "variants/{}.diff".format(variant)


@with_logging
def plug_install():
    sh.nvim("--headless", "+PlugInstall", "+UpdateRemotePlugins", "+qa")


@with_logging
def plug_uninstall():
    plugged_path = os.path.join(os.environ["HOME"], ".config/nvim/plugged")
    sh.rm("-rf", plugged_path)


@with_logging
def link():
    for package in packages():
        sh.stow(*stow_common_args(), "--stow", package)


@with_logging
def unlink():
    for package in packages():
        sh.stow(*stow_common_args(), "--delete", package)


@add_to_dispatch
@with_logging
def install():
    link()
    plug_install()


@add_to_dispatch
@with_logging
def uninstall():
    plug_uninstall()
    unlink()


@add_to_dispatch
@with_logging
def reset_to_common():
    sh.rm("-rf", "current")
    sh.cp("-R", "common", "current")


@add_to_dispatch
@with_logging
def store(variant):
    sh.diff("-ruN", "common", "current", _out=diff_file(variant), _ok_code=[0, 1])


@add_to_dispatch
@with_logging
def restore(variant):
    unlink()
    reset_to_common()
    sh.patch("--directory=current", "--strip=1", _in=open(diff_file(variant)))
    link()


if __name__ == "__main__":
    if len(sys.argv) > 1:
        dispatch(*sys.argv[1:])
    else:
        explain_usage()
