# Roles

## Path: `./roles`

## Purpose

This directory stores all the ansible [roles](http://docs.ansible.com/ansible/latest/playbooks_roles.html) that are used.

## Structure

The general structure of this sub-directory is as follows:

```
.
└── playbooks
    ├── roles
       └── <role-name>
          ├── README.md
          ├── tasks
          │   └── main.yaml
          └── vars
              └── main.yaml
```

Where each role has a unique `<role-name>` that is descriptive of its function.

## Role structure

Each role should conform to a set structure also. For example, a `./tasks` subdirectory should always exist and contain a `main.yaml` file. Also, if variables are required, a `./vars` sub-directory should always exist and contain a `main.yaml` file.

The README should describe the purpose of the role and how it can be used. Some examples should also be included. Usage documentation should be in the same style as per the Ansible [modules](http://docs.ansible.com/ansible/latest/modules_by_category.html) documentation.

An `example_role` role exists that can be reused as the skeleton for new roles.

#### Role conventions

| Aspect | Convention |
| --- | --- |
| File extension | `.yaml` not `.yml` |
| Indentation | 2 spaces |
