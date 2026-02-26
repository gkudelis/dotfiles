#!/usr/bin/env python3

import argparse
import os
import shutil
import subprocess
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parent
VARIANT_FILENAME = 'current_variant'
DOTFILES_LINK = Path.home() / '.local' / 'bin' / 'dotfiles'


def log(f):
    def wrapped(*args, **kwargs):
        print(f'Start {f.__name__}')
        f(*args, **kwargs)
        print(f'Finish {f.__name__}')
    return wrapped


def get_variant():
    variant_path = Path(VARIANT_FILENAME)
    if variant_path.exists():
        return variant_path.read_text().strip()
    return 'default'


@log
def set_variant(name):
    Path(VARIANT_FILENAME).write_text(name)


def common_files():
    for dirpath, _, filenames in os.walk('common'):
        for filename in filenames:
            yield os.path.relpath(Path(dirpath) / filename, start='common')


def resolve_partial_path(partial_name, variant):
    for base in [Path('variants') / variant, Path('variants') / 'default']:
        path = base / partial_name
        if path.exists():
            return path
    return None


def restore_file(filename, variant):
    common_path = Path('common') / filename
    current_path = Path('current') / filename
    current_path.parent.mkdir(parents=True, exist_ok=True)

    with open(common_path) as src, open(current_path, 'w') as dst:
        for line in src:
            if line.startswith('----- '):
                partial = resolve_partial_path(line[6:-1], variant)
                if partial is not None:
                    dst.write(partial.read_text())
            else:
                dst.write(line)


@log
def restore_variant(variant):
    shutil.rmtree('current', ignore_errors=True)
    Path('current').mkdir()
    for filename in common_files():
        restore_file(filename, variant)


@log
def prepare_antidote():
    url = 'https://github.com/mattmc3/antidote.git'
    dest = Path.home() / '.antidote'
    if dest.is_dir():
        subprocess.run(['git', 'pull'], cwd=dest, check=True)
    else:
        subprocess.run(['git', 'clone', '--depth=1', url, str(dest)], check=True)


@log
def link():
    subprocess.run([
        'stow', '--no-folding', f'--target={os.environ["HOME"]}', '--stow', 'current'
    ], check=True)
    DOTFILES_LINK.parent.mkdir(parents=True, exist_ok=True)
    DOTFILES_LINK.unlink(missing_ok=True)
    DOTFILES_LINK.symlink_to(REPO_ROOT / 'dotfiles.py')


@log
def unlink():
    subprocess.run([
        'stow', '--no-folding', f'--target={os.environ["HOME"]}', '--delete', 'current'
    ], check=True)
    DOTFILES_LINK.unlink(missing_ok=True)


def cmd_prepare(_args):
    variant = get_variant()
    restore_variant(variant)
    prepare_antidote()
    link()


def cmd_clear(_args):
    unlink()


def cmd_variant(args):
    if args.name:
        set_variant(args.name)
    else:
        print(get_variant())


def main():
    parser = argparse.ArgumentParser(description='Dotfiles manager')
    sub = parser.add_subparsers(dest='command', required=True)

    sub.add_parser('prepare', help='Assemble configs, install antidote, and symlink into $HOME')
    sub.add_parser('clear', help='Remove symlinks from $HOME')

    variant_parser = sub.add_parser('variant', help='Get or set the current variant')
    variant_parser.add_argument('name', nargs='?', help='Variant name to set')

    args = parser.parse_args()
    os.chdir(REPO_ROOT)
    {'prepare': cmd_prepare, 'clear': cmd_clear, 'variant': cmd_variant}[args.command](args)


if __name__ == '__main__':
    main()
