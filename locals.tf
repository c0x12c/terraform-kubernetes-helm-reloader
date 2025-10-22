locals {
  # Build the Helm values manifest
  manifest = yamlencode({
    reloader = {
      watchGlobally = var.watch_globally
      reloadStrategy = var.reload_strategy
      logLevel = var.log_level
      logFormat = var.log_format
      
      # Resource filtering
      resourcesToIgnore = var.resources_to_ignore
      ignoredWorkloadTypes = var.ignored_workload_types
      resourceLabelSelector = var.resource_label_selector
      namespaceSelector = var.namespace_selector
      namespacesToIgnore = var.namespaces_to_ignore
      
      # Annotation overrides
      autoAnnotation = var.auto_annotation
      secretAutoAnnotation = var.secret_auto_annotation
      configmapAutoAnnotation = var.configmap_auto_annotation
      autoSearchAnnotation = var.auto_search_annotation
      searchMatchAnnotation = var.search_match_annotation
      secretAnnotation = var.secret_annotation
      configmapAnnotation = var.configmap_annotation
      pauseDeploymentAnnotation = var.pause_deployment_annotation
      pauseDeploymentTimeAnnotation = var.pause_deployment_time_annotation
      
      # Debugging
      enablePprof = var.enable_pprof
      pprofAddr = var.pprof_addr
    }
    
    replicaCount = var.replica_count
    
    image = {
      repository = var.image_repository
      tag = var.image_tag
      pullPolicy = var.image_pull_policy
    }
    
    serviceAccount = {
      create = true
      name = "reloader"
      annotations = {}
    }
    
    rbac = {
      create = true
    }
    
    resources = var.resources
    
    nodeSelector = var.node_selector
    
    tolerations = var.tolerations
    
    affinity = var.affinity
    
    securityContext = var.security_context
    
    podSecurityContext = var.pod_security_context
  })
}
