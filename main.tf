resource "helm_release" "this" {
  name             = var.release_name
  namespace        = var.namespace
  repository       = var.chart_url
  chart            = "reloader"
  version          = var.chart_version
  max_history      = 3
  create_namespace = var.create_namespace
  values           = [local.manifest]

  depends_on = [kubernetes_namespace.this]
}

resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
    labels = merge(
      {
        "app.kubernetes.io/name"       = "reloader"
        "app.kubernetes.io/instance"   = var.release_name
        "app.kubernetes.io/managed-by" = "terraform"
      },
      var.namespace_labels
    )
    annotations = var.namespace_annotations
  }
}

resource "kubernetes_cluster_role" "this" {
  count = var.create_rbac ? 1 : 0

  metadata {
    name = "${var.release_name}-reloader"
    labels = merge(
      {
        "app.kubernetes.io/name"       = "reloader"
        "app.kubernetes.io/instance"   = var.release_name
        "app.kubernetes.io/managed-by" = "terraform"
      },
      var.labels
    )
  }

  rule {
    api_groups = [""]
    resources  = ["secrets", "configmaps"]
    verbs      = ["list", "get", "watch"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "daemonsets", "statefulsets"]
    verbs      = ["list", "get", "update", "patch"]
  }

  rule {
    api_groups = ["apps.openshift.io"]
    resources  = ["deploymentconfigs"]
    verbs      = ["list", "get", "update", "patch"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["jobs", "cronjobs"]
    verbs      = ["list", "get", "update", "patch"]
  }
}

resource "kubernetes_cluster_role_binding" "this" {
  count = var.create_rbac ? 1 : 0

  metadata {
    name = "${var.release_name}-reloader"
    labels = merge(
      {
        "app.kubernetes.io/name"       = "reloader"
        "app.kubernetes.io/instance"   = var.release_name
        "app.kubernetes.io/managed-by" = "terraform"
      },
      var.labels
    )
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.this[0].metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.service_account_name
    namespace = var.namespace
  }
}

resource "kubernetes_service_account" "this" {
  count = var.create_rbac ? 1 : 0

  metadata {
    name      = var.service_account_name
    namespace = var.namespace
    labels = merge(
      {
        "app.kubernetes.io/name"       = "reloader"
        "app.kubernetes.io/instance"   = var.release_name
        "app.kubernetes.io/managed-by" = "terraform"
      },
      var.labels
    )
    annotations = var.service_account_annotations
  }
}
