# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2026-06-28

This is the initial release that modernizes the GKE Cluster deployment configurations to support Terraform 1.0+ and Google Cloud provider v4.x/5.x.

### Added
- **GitHub Actions Validation Workflow**: Configured `.github/workflows/validate.yml` to automatically validate the Terraform syntax using version `1.5.7`.
- **Dynamic Kubernetes Version Resolution**: Integrated a `google_container_engine_versions` data source to dynamically resolve and deploy the cluster using the latest stable GKE version available.

### Fixed
- **Credentials Validation Issue in CI**: Removed the deprecated hardcoded service account JSON path from `provider.tf` to follow modern cloud authorization standards and allow non-interactive validation.
- **Legacy Variables Naming**: Renamed the variable `region-common` containing hyphens to `region_common` in `variables.tf`, `provider.tf`, and `README.md` to prevent warnings.

### Modernized
- **Submodule References**: Updated GCP submodules source URLs in `cluster.tf` to point to the modern and fixed `module-tf-gcp-vpc.git` repository with tag `v2.0.0`.
- **Decoupled Versions**: Created a dedicated `versions.tf` file declaring modern Terraform and Google Provider constraints (Terraform `>= 1.0`, Google `>= 4.0.0`).
- **Cleaned Syntax**: Removed string interpolations from numeric attributes (e.g. `min_node_count = 1`).
