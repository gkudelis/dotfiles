import click
import contextlib
from functools import wraps
from pathlib import Path
import os
import sh


VARIANT_FILENAME = 'current_variant'


def with_logging(f):
    @wraps(f)
    def wrapped(*args):
        print('Start {}'.format(f.__name__))
        f(*args)
        print('Finish {}'.format(f.__name__))
    return wrapped


@click.group()
def cli():
    pass


@cli.command()
@with_logging
def prepare():
    variant = get_variant()
    if variant:
        restore_variant(get_variant())
        prepare_p10k()
        link()
        plug_install()
    else:
        print('Variant does not exist')


@cli.command()
@with_logging
def clear():
    plug_uninstall()
    unlink()
    remove_p10k()


@cli.command()
@click.argument('new_variant', required=False)
def variant(new_variant):
    if new_variant:
        set_variant(new_variant)
    else:
        print(get_variant())


@with_logging
def plug_install():
    sh.nvim('--headless', '+PlugInstall', '+UpdateRemotePlugins', '+qa')


@with_logging
def plug_uninstall():
    plugged_path = Path.home() / '.config' / 'nvim' / 'plugged'
    sh.rm('-rf', plugged_path)


@with_logging
def prepare_p10k():
    repository_url = 'https://github.com/romkatv/powerlevel10k.git'
    checkout_path = Path.home() / 'powerlevel10k'
    if checkout_path.is_dir():
        with cd(checkout_path):
            sh.git.pull()
    else:
        sh.git.clone('--depth=1', repository_url , checkout_path)


@with_logging
def remove_p10k():
    checkout_path = Path.home() / 'powerlevel10k'
    sh.rm('-rf', checkout_path)


@with_logging
def link():
    sh.stow('--no-folding', '--target=' + os.environ['HOME'], '--stow', 'current')


@with_logging
def unlink():
    sh.stow('--no-folding', '--target=' + os.environ['HOME'], '--delete', 'current')


def get_variant():
    variant_path = Path(VARIANT_FILENAME)
    if variant_path.exists():
        with variant_path.open() as variant_file:
            return variant_file.readline().strip()
    else:
        return 'default'


@with_logging
def set_variant(new_variant):
    with open(VARIANT_FILENAME, 'w+') as variant_file:
        variant_file.write(new_variant)


def common_files():
    for dirpath, _, filenames in os.walk('common'):
        for filename in filenames:
            fullname = Path(dirpath) / filename
            yield os.path.relpath(fullname, start='common')


def restore_file(filename, variant):
    common_filename = Path('common') / filename
    current_filename = Path('current') / filename
    os.makedirs(current_filename.parent, exist_ok=True)

    with open(common_filename) as common, open(current_filename, 'w') as current:
        for line in common:
            if line.startswith('----- '):
                partial_path = resolve_partial_path(line[6:-1], variant)
                if partial_path is not None:
                    with open(partial_path) as partial_content:
                        for partial_line in partial_content:
                            current.write(partial_line)
            else:
                current.write(line)


def resolve_partial_path(partial_name, variant):
    variant_partial_path = Path('variants') / variant / partial_name
    default_partial_path = Path('variants') / 'default' / partial_name

    if variant_partial_path.exists():
        return variant_partial_path
    elif default_partial_path.exists():
        return default_partial_path
    else:
        return None


@with_logging
def restore_variant(variant):
    sh.rm('-rf', 'current')
    sh.mkdir('current')
    for filename in common_files():
        restore_file(filename, variant)


@contextlib.contextmanager
def cd(path):
    previous_path = Path.cwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(previous_path)
