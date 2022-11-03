# AGISIT Project Team 29
# This file defines the pods using Terraform

#################################################################
# Definition of the Pods
#################################################################
# This file describes the pods.

#################################################################
# Ad Pod
#################################################################
resource "kubernetes_deployment" "adservice" {
  metadata {
    name = "adservice"
    labels = {
          app = "adservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "adservice"
        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "adservice"
          tier = "backend"
        }
      }

      spec {
        container {
          name  = "server"
          image = "ricardojss/agisit-team29:adservice"

          port {
            container_port = 9555
          }

          env {
            name  = "PORT"
            value = "9555"
          }

          resources {
            requests = {
              cpu = "200m"

              memory = "180Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}

#################################################################
# Store Cart Pod
#################################################################
resource "kubernetes_deployment" "cartservice" {
  metadata {
    name = "cartservice"
    labels = {
          app = "cartservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "cartservice"
        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "cartservice"
          tier = "backend"
        }
      }

      spec {
        container {
          name  = "server"
          image = "ricardojss/agisit-team29:cartservice"

          port {
            container_port = 7070
          }

          env {
            name  = "REDIS_ADDR"
            value = "redis-leader:6379"
          }

          resources {
            requests = {
              cpu = "200m"

              memory = "64Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}

#################################################################
# Cart DB (Redis) Pod Leader
#################################################################
resource "kubernetes_deployment" "redis-leader" {
  metadata {
    name = "redis-leader"
    labels = {
      app  = "redis"
      role = "leader"
      tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    progress_deadline_seconds = 1200 # In case of taking longer than 9 minutes
    replicas = 1
    selector {
      match_labels = {
        app  = "redis"
        tier = "backend"
      }
    }
    template {
      metadata {
        labels = {
          app  = "redis"
          role = "leader"
          tier = "backend"
        }
      }
      spec {
        container {
          image = "docker.io/redis:6.0.5"
          name  = "leader"

          port {
            container_port = 6379
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}
#################################################################
# Cart DB (Redis) Pod Followers
#################################################################
resource "kubernetes_deployment" "redis-follower" {
  metadata {
    name = "redis-follower"

    labels = {
      app  = "redis"
      role = "follower"
      tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    progress_deadline_seconds = 1200
    replicas = 3
    selector {
      match_labels = {
        app  = "redis"
      }
    }
    template {
      metadata {
        labels = {
          app  = "redis"
          role = "follower"
          tier = "backend"
        }
      }
      spec {
        container {
          image = "gcr.io/google_samples/gb-redis-follower:v2"
          name  = "follower"

          port {
            container_port = 6379
          }

          env {
            name  = "GET_HOSTS_FROM"
            value = "dns"
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}

#################################################################
# Checkout Pod
#################################################################
resource "kubernetes_deployment" "checkoutservice" {
  metadata {
    name = "checkoutservice"
    labels = {
          app = "checkoutservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "checkoutservice"
        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "checkoutservice"
          tier = "backend"
        }
      }

      spec {
        container {
          name  = "server"
          image = "ricardojss/agisit-team29:checkoutservice"

          port {
            container_port = 5050
          }

          env {
            name  = "PORT"
            value = "5050"
          }

          env {
            name  = "PRODUCT_CATALOG_SERVICE_ADDR"
            value = "productcatalogservice:3550"
          }

          env {
            name  = "SHIPPING_SERVICE_ADDR"
            value = "shippingservice:50051"
          }

          env {
            name  = "PAYMENT_SERVICE_ADDR"
            value = "paymentservice:50051"
          }

          env {
            name  = "EMAIL_SERVICE_ADDR"
            value = "emailservice:5000"
          }

          env {
            name  = "CURRENCY_SERVICE_ADDR"
            value = "currencyservice:7000"
          }

          env {
            name  = "CART_SERVICE_ADDR"
            value = "cartservice:7070"
          }

          resources {
            requests = {
              cpu = "100m"

              memory = "64Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}

#################################################################
# Currency Pod
#################################################################
resource "kubernetes_deployment" "currencyservice" {
  metadata {
    name = "currencyservice"
    labels = {
          app = "currencyservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "currencyservice"
        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "currencyservice"
          tier = "backend"
        }
      }

      spec {
        container {
          name  = "server"
          image = "ricardojss/agisit-team29:currencyservice"

          port {
            name           = "grpc"
            container_port = 7000
          }

          env {
            name  = "PORT"
            value = "7000"
          }

          resources {
            requests = {
              cpu = "100m"

              memory = "64Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}

#################################################################
# Email Pod
#################################################################
resource "kubernetes_deployment" "emailservice" {
  metadata {
    name = "emailservice"
    labels = {
          app = "emailservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "emailservice"
        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "emailservice"
          tier = "backend"
        }
      }

      spec {
        container {
          name  = "server"
          image = "ricardojss/agisit-team29:emailservice"

          port {
            container_port = 8080
          }

          env {
            name  = "PORT"
            value = "8080"
          }

          resources {
            requests = {
              cpu = "100m"

              memory = "64Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}

#################################################################
# Payment Pod
#################################################################
resource "kubernetes_deployment" "paymentservice" {
  metadata {
    name = "paymentservice"
    labels = {
          app = "paymentservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "paymentservice"
        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "paymentservice"
          tier = "backend"
        }
      }

      spec {
        container {
          name  = "server"
          image = "ricardojss/agisit-team29:paymentservice"

          port {
            container_port = 50051
          }

          env {
            name  = "PORT"
            value = "50051"
          }

          resources {
            requests = {
              cpu = "100m"

              memory = "64Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}

#################################################################
# Recommendations Pod
#################################################################
resource "kubernetes_deployment" "recommendationservice" {
  metadata {
    name = "recommendationservice"
    labels = {
          app = "recommendationservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "recommendationservice"
        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "recommendationservice"
          tier = "backend"
        }
      }

      spec {
        container {
          name  = "server"
          image = "ricardojss/agisit-team29:recommendationservice"

          port {
            container_port = 8080
          }

          env {
            name  = "PORT"
            value = "8080"
          }

          env {
            name  = "PRODUCT_CATALOG_SERVICE_ADDR"
            value = "productcatalogservice:3550"
          }

          resources {
            requests = {
              cpu = "100m"

              memory = "220Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}

#################################################################
# Shipping Pod
#################################################################
resource "kubernetes_deployment" "shippingservice" {
  metadata {
    name = "shippingservice"
    labels = {
          app = "shippingservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "shippingservice"
        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "shippingservice"
          tier = "backend"
        }
      }

      spec {
        container {
          name  = "server"
          image = "ricardojss/agisit-team29:shippingservice"

          port {
            container_port = 50051
          }

          env {
            name  = "PORT"
            value = "50051"
          }

          resources {
            requests = {
              cpu = "100m"

              memory = "64Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}

#################################################################
# Product Catalog Pod
#################################################################

resource "kubernetes_deployment" "productcatalogservice" {
  metadata {
    name = "productcatalogservice"
    labels = {
          app = "productcatalogservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "productcatalogservice"
        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "productcatalogservice"
          tier = "backend"
        }
      }

      spec {
        container {
          name  = "server"
          image = "ricardojss/agisit-team29:productcatalogservice"

          port {
            container_port = 3550
          }

          env {
            name  = "PORT"
            value = "3550"
          }

          resources {
            requests = {
              cpu = "100m"

              memory = "64Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}

#################################################################
# Frontend Pod
#################################################################
resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
    labels = {
          app = "frontend"
          tier = "frontend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "frontend"
        tier = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
          tier = "frontend"
        }
      }

      spec {
        container {
          name  = "server"
          image = "ricardojss/agisit-team29:frontend"

          port {
            container_port = 8080
          }

          env {
            name  = "PORT"
            value = "8080"
          }

          env {
            name  = "PRODUCT_CATALOG_SERVICE_ADDR"
            value = "productcatalogservice:3550"
          }

          env {
            name  = "CURRENCY_SERVICE_ADDR"
            value = "currencyservice:7000"
          }

          env {
            name  = "CART_SERVICE_ADDR"
            value = "cartservice:7070"
          }

          env {
            name  = "RECOMMENDATION_SERVICE_ADDR"
            value = "recommendationservice:8080"
          }

          env {
            name  = "SHIPPING_SERVICE_ADDR"
            value = "shippingservice:50051"
          }

          env {
            name  = "CHECKOUT_SERVICE_ADDR"
            value = "checkoutservice:5050"
          }

          env {
            name  = "AD_SERVICE_ADDR"
            value = "adservice:9555"
          }

          resources {
            requests = {
              cpu = "100m"

              memory = "64Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}
