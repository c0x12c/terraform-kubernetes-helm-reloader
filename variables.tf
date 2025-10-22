variable "release_name" {
  description = "Name of the Helm release"
  type        = string
  default     = "reloader"
}

variable "namespace" {
  description = "Namespace to install Reloader"
  type        = string
  default     = "reloader-system"
}

variable "create_namespace" {
  description = "Whether to create the namespace"
  type        = bool
  default     = true
}

variable "chart_version" {
  description = "Version of the Reloader Helm chart"
  type        = string
  default     = "1.0.106"
}

variable "chart_url" {
  description = "URL of the Reloader Helm chart repository"
  type        = string
  default     = "https://stakater.github.io/stakater-charts"
}


# Reloader Configuration
variable "watch_globally" {
  description = "Whether to watch all namespaces globally"
  type        = bool
  default     = true
}

variable "reload_strategy" {
  description = "Strategy for triggering rolling updates (env-vars or annotations)"
  type        = string
  default     = "env-vars"
  validation {
    condition     = contains(["env-vars", "annotations"], var.reload_strategy)
    error_message = "Reload strategy must be either 'env-vars' or 'annotations'."
  }
}

variable "log_level" {
  description = "Log level for Reloader (debug, info, warn, error)"
  type        = string
  default     = "info"
  validation {
    condition     = contains(["debug", "info", "warn", "error"], var.log_level)
    error_message = "Log level must be one of: debug, info, warn, error."
  }
}

variable "log_format" {
  description = "Log format (text or json)"
  type        = string
  default     = "text"
  validation {
    condition     = contains(["text", "json"], var.log_format)
    error_message = "Log format must be either 'text' or 'json'."
  }
}

variable "resources_to_ignore" {
  description = "Resources to ignore (configmaps or secrets)"
  type        = string
  default     = null
  validation {
    condition     = var.resources_to_ignore == null || contains(["configmaps", "secrets"], var.resources_to_ignore)
    error_message = "Resources to ignore must be either 'configmaps' or 'secrets'."
  }
}

variable "ignored_workload_types" {
  description = "Comma-separated list of workload types to ignore (jobs, cronjobs)"
  type        = string
  default     = null
}

variable "resource_label_selector" {
  description = "Label selector to filter ConfigMaps/Secrets"
  type        = string
  default     = null
}

variable "namespace_selector" {
  description = "Label selector to filter namespaces"
  type        = string
  default     = null
}

variable "namespaces_to_ignore" {
  description = "Comma-separated list of namespaces to ignore"
  type        = string
  default     = null
}

# Annotation Key Overrides
variable "auto_annotation" {
  description = "Override reloader.stakater.com/auto annotation key"
  type        = string
  default     = null
}

variable "secret_auto_annotation" {
  description = "Override secret.reloader.stakater.com/auto annotation key"
  type        = string
  default     = null
}

variable "configmap_auto_annotation" {
  description = "Override configmap.reloader.stakater.com/auto annotation key"
  type        = string
  default     = null
}

variable "auto_search_annotation" {
  description = "Override reloader.stakater.com/search annotation key"
  type        = string
  default     = null
}

variable "search_match_annotation" {
  description = "Override reloader.stakater.com/match annotation key"
  type        = string
  default     = null
}

variable "secret_annotation" {
  description = "Override secret.reloader.stakater.com/reload annotation key"
  type        = string
  default     = null
}

variable "configmap_annotation" {
  description = "Override configmap.reloader.stakater.com/reload annotation key"
  type        = string
  default     = null
}

variable "pause_deployment_annotation" {
  description = "Override deployment.reloader.stakater.com/pause-period annotation key"
  type        = string
  default     = null
}

variable "pause_deployment_time_annotation" {
  description = "Override deployment.reloader.stakater.com/paused-at annotation key"
  type        = string
  default     = null
}

# Resource Configuration
variable "replica_count" {
  description = "Number of Reloader replicas"
  type        = number
  default     = 1
}

variable "image_repository" {
  description = "Reloader image repository"
  type        = string
  default     = "stakater/reloader"
}

variable "image_tag" {
  description = "Reloader image tag"
  type        = string
  default     = "v1.0.106"
}

variable "image_pull_policy" {
  description = "Image pull policy"
  type        = string
  default     = "IfNotPresent"
}

variable "resources" {
  description = "Resource requests and limits for Reloader"
  type = object({
    requests = optional(object({
      cpu    = optional(string, "10m")
      memory = optional(string, "32Mi")
    }), {})
    limits = optional(object({
      cpu    = optional(string, "100m")
      memory = optional(string, "128Mi")
    }), {})
  })
  default = {}
}

variable "node_selector" {
  description = "Node selector for Reloader pods"
  type        = map(string)
  default     = {}
}

variable "tolerations" {
  description = "Tolerations for Reloader pods"
  type = list(object({
    key      = string
    operator = string
    value    = optional(string)
    effect   = optional(string)
  }))
  default = []
}

variable "affinity" {
  description = "Affinity rules for Reloader pods"
  type        = any
  default     = {}
}

# Security Context
variable "security_context" {
  description = "Security context for Reloader pods"
  type = object({
    run_as_non_root = optional(bool, true)
    run_as_user     = optional(number, 65534)
    run_as_group    = optional(number, 65534)
    fs_group        = optional(number, 65534)
  })
  default = {}
}

variable "pod_security_context" {
  description = "Pod security context for Reloader pods"
  type = object({
    run_as_non_root = optional(bool, true)
    run_as_user     = optional(number, 65534)
    run_as_group    = optional(number, 65534)
    fs_group        = optional(number, 65534)
  })
  default = {}
}

# Monitoring
variable "enable_pprof" {
  description = "Enable pprof for profiling"
  type        = bool
  default     = false
}

variable "pprof_addr" {
  description = "Address to start pprof server on"
  type        = string
  default     = ":6060"
}

# Labels and Annotations
variable "labels" {
  description = "Labels to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "namespace_labels" {
  description = "Labels to apply to the namespace"
  type        = map(string)
  default     = {}
}

variable "namespace_annotations" {
  description = "Annotations to apply to the namespace"
  type        = map(string)
  default     = {}
}


# Additional Values
variable "additional_values" {
  description = "Additional values to pass to the Helm chart"
  type        = list(string)
  default     = []
}
