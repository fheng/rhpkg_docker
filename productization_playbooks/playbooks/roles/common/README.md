# common (role)

## Synopsis

Provides some "global" functions that may be used by other roles and playbooks.

* Sets the $HOME ENV variable fact.
* Sets the $VIRTUALENV_HOME ENV variable fact.
* Displays debug information if above ENV variables are not set.

## Requirements (on host that executes module)

* python >= 2.6

## Options

| parameter | required | default | choices |
| --- | --- | --- | --- |
| aaa | bbb | ccc | ddd |

## Examples

```
# implements the common role
- hosts: localhost
  become: False
  roles:
    - common
```

## Return values

| name | description | returned | type | sample |
| --- | --- | --- | --- | --- |
| USER_HOME | path of $HOME ENV variable | if $HOME exists | fact | `/home/jcitizen` |
| VIRTUALENV_HOME | path of $HOME VIRTUALENV_HOME variable | if $VIRTUALENV_HOME exists | fact | `/home/jcitizen/virtualenvs/myansible` |

## Notes

Nil
