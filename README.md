# TFE Organization Module

This is a module for creating Organizations in Terraform Enterprise using YAML configuration files. This module relies on a Project and Workspace module to provision those resources from a single Org config file.

### Short term To Do

- Add type definitions for variables for each module to ensure YAML is the proper structure
- Testing - confirm the current code works as expected (adding/removing teams, configuration works as expected, adding/removing users etc)

### Ongoing Feature Additions

- Add more configuration customization capabilities in each module.

## YAML configuration examples

Organization:

Teams:
