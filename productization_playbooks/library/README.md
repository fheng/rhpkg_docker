# Library

## Path: `./library`

## Purpose

This directory stores all the ansible custom [modules](http://docs.ansible.com/ansible/latest/dev_guide/developing_modules.html) that have been developed for various purposes. It is also the location for other types of "supporting" scripts. All the content in this directory should be as reusable as possible.

## Structure

The general structure of this sub-directory is as follows:

```
.
├── library
│   ├── README.md
│   ├── module1.py
│   ├── module2.py
│   └── utils
│       └── util_script1.py
```

Modules can be stored in the root of `./library`, or they can be grouped into related files. In the example above, "utility" scripts have been grouped into `./library/utils` directory.
