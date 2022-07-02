# Basic Packer Demo

## Overview

This is a very simple Packer example to build an Ubuntu Server 20.04 VM.

Demonstrates basic Packer usage.

In the real world, you would want to use more variables, and turn the `http/user-data`
file into a template instead of hard-coding the username and password.

## Sample usage

```bash
packer init ./ubuntu-server/

packer -var "ssh_password=packer" validate ./ubuntu-server/

# Build with defaults:
packer -var "ssh_password=packer" build ./ubuntu-server/

# Use a var file:
packer -var-file ./my.pkrvars.hcl -var "ssh_password=packer" build ./ubuntu-server/
```
