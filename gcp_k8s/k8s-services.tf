# AGISIT Project Team 29
# This file defines the services using Terraform

#################################################################
# Definition of the Services
#################################################################
# This file describes the services.

#################################################################
# Ad Service
#################################################################
resource "kubernetes_service" "adservice" {
  metadata {
    name = "adservice"
    labels = {
          app = "adservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    port {
      name        = "grpc"
      port        = 9555
      target_port = "9555"
    }

    selector = {
      app = "adservice"
      tier = "backend"
    }

    type = "ClusterIP"
  }
}

#################################################################
# Cart Service
#################################################################
resource "kubernetes_service" "cartservice" {
  metadata {
    name = "cartservice"
    labels = {
          app = "cartservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    port {
      name        = "grpc"
      port        = 7070
      target_port = "7070"
    }

    selector = {
      app = "cartservice"
      tier = "backend"
    }

    type = "ClusterIP"
  }
}

#################################################################
# Cart DB (Redis) Leader Service
#################################################################
resource "kubernetes_service" "redis-leader" {
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
    selector = {
      app  = "redis"
      role = "leader"
      tier = "backend"
    }

    port {
      port        = 6379
      target_port = 6379
    }
  }
}

#################################################################
# Cart DB (Redis) Follower Service
#################################################################
resource "kubernetes_service" "redis-follower" {
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
    selector = {
      app  = "redis"
      role = "follower"
      tier = "backend"
    }

    port {
      port        = 6379
    }

    type = "ClusterIP"
  }
}


#################################################################
# Checkout Service
#################################################################
resource "kubernetes_service" "checkoutservice" {
  metadata {
    name = "checkoutservice"
    labels = {
          app = "checkoutservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    port {
      name        = "grpc"
      port        = 5050
      target_port = "5050"
    }

    selector = {
      app = "checkoutservice"
      tier = "backend"
    }

    type = "ClusterIP"
  }
}

#################################################################
# Currency Service
#################################################################
resource "kubernetes_service" "currencyservice" {
  metadata {
    name = "currencyservice"
    labels = {
          app = "currencyservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    port {
      name        = "grpc"
      port        = 7000
      target_port = "7000"
    }

    selector = {
      app = "currencyservice"
      tier = "backend"
    }

    type = "ClusterIP"
  }
}

#################################################################
# Email Service
#################################################################
resource "kubernetes_service" "emailservice" {
  metadata {
    name = "emailservice"
    labels = {
          app = "emailservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    port {
      name        = "grpc"
      port        = 5000
      target_port = "8080"
    }

    selector = {
      app = "emailservice"
      tier = "backend"
    }

    type = "ClusterIP"
  }
}

#################################################################
# Payment Service
#################################################################
resource "kubernetes_service" "paymentservice" {
  metadata {
    name = "paymentservice"
    labels = {
          app = "paymentservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    port {
      name        = "grpc"
      port        = 50051
      target_port = "50051"
    }

    selector = {
      app = "paymentservice"
      tier = "backend"
    }

    type = "ClusterIP"
  }
}

#################################################################
# Recommendations Service
#################################################################
resource "kubernetes_service" "recommendationservice" {
  metadata {
    name = "recommendationservice"
    labels = {
          app = "recommendationservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    port {
      name        = "grpc"
      port        = 8080
      target_port = "8080"
    }

    selector = {
      app = "recommendationservice"
      tier = "backend"
    }

    type = "ClusterIP"
  }
}

#################################################################
# Shipping Service
#################################################################
resource "kubernetes_service" "shippingservice" {
  metadata {
    name = "shippingservice"
    labels = {
          app = "shippingservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    port {
      name        = "grpc"
      port        = 50051
      target_port = "50051"
    }

    selector = {
      app = "shippingservice"
      tier = "backend"
    }

    type = "ClusterIP"
  }
}

#################################################################
# Product Catalog Service
#################################################################
resource "kubernetes_service" "productcatalogservice" {
  metadata {
    name = "productcatalogservice"
    labels = {
          app = "productcatalogservice"
          tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    port {
      name        = "grpc"
      port        = 3550
      target_port = "3550"
    }

    selector = {
      app = "productcatalogservice"
      tier = "backend"
    }

    type = "ClusterIP"
  }
}

#################################################################
# Frontend Service
#################################################################
resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend"
    labels = {
          app = "frontend"
          tier = "frontend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = "8080"
    }

    selector = {
      app = "frontend"
      tier = "frontend"
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "frontend_external" {
  metadata {
    name = "frontend-external"
    namespace = kubernetes_namespace.application.id   
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = "8080"
    }

    selector = {
      app = "frontend"
      tier = "frontend"
    }

    type = "LoadBalancer"
  }
}
