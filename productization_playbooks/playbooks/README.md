# Playbooks

## Path: `./playbooks`

## Purpose

This directory stores all the ansible [playbooks](http://docs.ansible.com/ansible/latest/playbooks.html) that are used, in addition to the [roles](http://docs.ansible.com/ansible/latest/playbooks_roles.html). All the [variables](http://docs.ansible.com/ansible/latest/playbooks_variables.html) for the playbooks (at the playbook scope) are stored in `/var`.

## Structure

The general structure of this sub-directory is as follows:

```
.
└── playbooks
    ├── README.md
    ├── myplaybook1.yaml
    ├── myplaybook2.yaml
    ├── roles
    │   └── common
    │       ├── README.md
    │       └── tasks
    │           └── main.yaml
    └── vars
        └── main.yaml
```

### Playbooks

Playbooks are Ansible’s configuration, deployment, and orchestration language. They can describe a policy you want your remote systems to enforce or a set of steps in a general IT process.

Playbooks are saved in the root of this sub-directory as `.yaml` files. If required, they can be grouped further into sub-directories named after the function or purpose of the grouping. Lower-case is used for all directory and filenames.

```
├── myplaybook1.yaml
├── myplaybook2.yaml
├── ...
```

#### Playbook conventions

| Aspect | Convention |
| --- | --- |
| File extension | `.yaml` not `.yml` |
| Indentation | 2 spaces |

### Roles

While it is possible to write a playbook in one very large file (and you might start out learning playbooks this way), eventually you’ll want to reuse files and start to organise things. Roles in Ansible build on the idea of include files and combine them to form clean, reusable abstractions – they allow you to focus more on the big picture and only dive down into the details when needed. Roles have a pre-defined structure which is described in the README in that directory.

```
.
├── roles <--
└── vars
```

### Vars

While automation exists to make it easier to make things repeatable, all of our systems are not exactly alike. Variables in Ansible are how we deal with differences between systems. Ansible also has the concept of variable [scope](http://docs.ansible.com/ansible/latest/playbooks_variables.html#variable-scopes) and variable [precedence](http://docs.ansible.com/ansible/latest/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable). The purpose of this directory is to be a home for those variables with a "playbook" scope. Roles also have a similar directory for variables at the "role" scope.

```
.
├── roles
└── vars <--
```
