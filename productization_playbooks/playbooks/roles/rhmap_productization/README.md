# fhops\_laptop (role)

## Synopsis

The `fhops\_laptop` role contains a number of configuration and administration tasks, designed
to be run early on in the onboarding of a new member of the FHOPS team.

## Requirements (on host that executes module)

* python >= 2.7.6

## Options

| parameter | required | default | choices |
| --- | --- | --- | --- |
| USER\_HOME | YES | - | You should run the common role with task main to populate this |

## Examples

```
---
- hosts: 127.0.0.1
  connection: local
  tasks:
  - name: "Set USER_HOME env var facts"
    include_role:
      name: common
      tasks_from: main
  - name: "Run the FHOPS initial laptop setup task to clone repos"
    include_role:
      name: fhops_laptop
      tasks_from: clone_fhops_repos
  - name: "Run the FHOPS initial laptop setup task to create symlinks to important files"
    include_role:
      name: fhops_laptop
      tasks_from: create_fhops_symlinks
```

## Return values

| name | description | returned | type | sample |
| --- | --- | --- | --- | --- |
| - | - | - | - | - |

## Notes

Nil
