from setuptools import setup

setup(
    name='dotfiles',
    version='1.0.0',
    py_modules=['dotfiles'],
    install_requires=[
        'click==8.0.1',
        'sh==1.14.1',
    ],
    entry_points={
        'console_scripts': [
            'dotfiles = dotfiles:cli',
        ],
    },
)
