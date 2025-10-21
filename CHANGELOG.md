# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-XX

### Added

- Initial release of the Terraform Kubernetes Helm Reloader module
- Support for deploying Stakater Reloader using Helm
- Configurable RBAC with ClusterRole and ClusterRoleBinding
- Support for all Reloader configuration options including:
  - Reload strategies (env-vars, annotations)
  - Resource filtering (ConfigMaps, Secrets, workload types)
  - Namespace filtering and selection
  - Annotation key overrides
  - Logging configuration
  - Debugging options (pprof)
- Resource configuration (requests, limits, node selector, tolerations, affinity)
- Security context configuration
- Comprehensive examples (basic, advanced, GitOps)
- Complete documentation with usage examples

### Features

- **Reload Strategies**: Support for both env-vars and annotations strategies
- **Resource Filtering**: Filter by resource types, workload types, and labels
- **Namespace Management**: Global watching or selective namespace filtering
- **Security**: Configurable security contexts and RBAC
- **Observability**: JSON logging and pprof support
- **GitOps Ready**: Annotations strategy prevents config drift in ArgoCD/Flux
- **Production Ready**: Resource limits, node selection, and high availability support
