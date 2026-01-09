# Changelog

## [3.0.0](https://github.com/CloudNationHQ/terraform-azure-apim/compare/v2.5.0...v3.0.0) (2026-01-09)


### ⚠ BREAKING CHANGES

* this change causes recreates

### Features

* add type definitions and changed data structure ([#35](https://github.com/CloudNationHQ/terraform-azure-apim/issues/35)) ([4d8ff5d](https://github.com/CloudNationHQ/terraform-azure-apim/commit/4d8ff5d0758768cc9dd491090057962975f51284))
* updated documentation
* added type definitions
* removed deprecated and added missing properties

### Upgrade from v2.5.0 to v3.0.0:

- Update module reference to: `version = "~> 3.0"`
- The property and variable resource_group is renamed to resource_group_name

## [2.5.0](https://github.com/CloudNationHQ/terraform-azure-apim/compare/v2.4.1...v2.5.0) (2025-11-26)


### Features

* increment all module versions to the latest ([#31](https://github.com/CloudNationHQ/terraform-azure-apim/issues/31)) ([c693bcc](https://github.com/CloudNationHQ/terraform-azure-apim/commit/c693bcc38066ad072e18c67af5a7001c1c42ed27))

## [2.4.1](https://github.com/CloudNationHQ/terraform-azure-apim/compare/v2.4.0...v2.4.1) (2025-07-08)


### Bug Fixes

* sensitive keys lookup ([#25](https://github.com/CloudNationHQ/terraform-azure-apim/issues/25)) ([997a81d](https://github.com/CloudNationHQ/terraform-azure-apim/commit/997a81d56cf5eacf87ccaa084123a9e04b15075e))

## [2.4.0](https://github.com/CloudNationHQ/terraform-azure-apim/compare/v2.3.0...v2.4.0) (2025-07-07)


### Features

* removed azurerm provider config. ([#22](https://github.com/CloudNationHQ/terraform-azure-apim/issues/22)) ([e9f865a](https://github.com/CloudNationHQ/terraform-azure-apim/commit/e9f865a4f6e7645ec52b14ff12c5d5dcc4542432))

## [2.3.0](https://github.com/CloudNationHQ/terraform-azure-apim/compare/v2.2.0...v2.3.0) (2025-01-20)


### Features

* remove temporary files when deployment tests fails ([#12](https://github.com/CloudNationHQ/terraform-azure-apim/issues/12)) ([543c1d5](https://github.com/CloudNationHQ/terraform-azure-apim/commit/543c1d5af3d9a1542b4394d8e606768feee66c72))

## [2.2.0](https://github.com/CloudNationHQ/terraform-azure-apim/compare/v2.1.0...v2.2.0) (2024-11-11)


### Features

* enhance testing with sequential, parallel modes and flags for exceptions and skip-destroy ([#10](https://github.com/CloudNationHQ/terraform-azure-apim/issues/10)) ([5fb44d3](https://github.com/CloudNationHQ/terraform-azure-apim/commit/5fb44d32ec37ce183ae1e8ce11d5d81c3e289902))

## [2.1.0](https://github.com/CloudNationHQ/terraform-azure-apim/compare/v2.0.1...v2.1.0) (2024-10-11)


### Features

* auto generated docs and refine makefile ([#8](https://github.com/CloudNationHQ/terraform-azure-apim/issues/8)) ([afb59a9](https://github.com/CloudNationHQ/terraform-azure-apim/commit/afb59a92a29a36e312fc90125e9bce960db7f68b))

## [2.0.1](https://github.com/CloudNationHQ/terraform-azure-apim/compare/v2.0.0...v2.0.1) (2024-09-25)


### Bug Fixes

* Global tags and cleanup naming suffixes ([#6](https://github.com/CloudNationHQ/terraform-azure-apim/issues/6)) ([d62dc62](https://github.com/CloudNationHQ/terraform-azure-apim/commit/d62dc62f3fd26739bde1de1a97040f8b6acef6c2))

## [2.0.0](https://github.com/CloudNationHQ/terraform-azure-apim/compare/v1.0.0...v2.0.0) (2024-09-25)


### ⚠ BREAKING CHANGES

* Version 4 of the azurerm provider includes breaking changes.

### Features

* upgrade azurerm provider to v4 ([#4](https://github.com/CloudNationHQ/terraform-azure-apim/issues/4)) ([33551be](https://github.com/CloudNationHQ/terraform-azure-apim/commit/33551be4216fbe055c29e8524c4bee2793580700))

### Upgrade from v1.0.0 to v2.0.0:

- Update module reference to: `version = "~> 2.0"`

## 1.0.0 (2024-09-23)


### Features

* add initial resources ([#2](https://github.com/CloudNationHQ/terraform-azure-apim/issues/2)) ([abbdf22](https://github.com/CloudNationHQ/terraform-azure-apim/commit/abbdf22b5ac04eb8dbf6c69c7a31937c97529f7a))
