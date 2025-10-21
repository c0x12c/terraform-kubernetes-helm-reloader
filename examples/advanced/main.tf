module "reloader" {
  source = "../../"

  namespace = "reloader-system"
  
  # Reloader Configuration
  watch_globally = true
  reload_strategy = "annotations"  # Use annotations strategy for GitOps
  log_level = "info"
  log_format = "json"
  
  # Resource Filtering
  resources_to_ignore = "configmaps"  # Ignore ConfigMaps, only watch Secrets
  ignored_workload_types = "jobs,cronjobs"
  namespaces_to_ignore = "kube-system,kube-public"
  
  # Resource Configuration
  replica_count = 2
  resources = {
    requests = {
      cpu = "50m"
      memory = "64Mi"
    }
    limits = {
      cpu = "200m"
      memory = "256Mi"
    }
  }
  
  # Node Selection
  node_selector = {
    "node-role.kubernetes.io/worker" = "true"
  }
  
  # Tolerations
  tolerations = [
    {
      key = "node-role.kubernetes.io/control-plane"
      operator = "Exists"
      effect = "NoSchedule"
    }
  ]
  
  # Security Context
  security_context = {
    run_as_non_root = true
    run_as_user = 65534
    run_as_group = 65534
    fs_group = 65534
  }
  
  # Labels
  labels = {
    "app.kubernetes.io/part-of" = "platform"
    "environment" = "production"
  }
}
