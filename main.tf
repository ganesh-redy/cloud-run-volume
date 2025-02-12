provider "google" {
    zone = "us-central"
    project="mythic-inn-420620"
   
  
}

resource "google_cloud_run_service" "cloud_run" {
  name     = var.image_name
  location = var.region

  template {
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/my-docker-repo1/${var.image_name}:${var.image_tag}"
        
        ports {
          container_port = 8080  # ✅ Ensure this is set!
        }
 volume_mounts {
          name       = "shared-volume"
          mount_path = "/app"
        }
      }
 volumes {
        name = "shared-volume"
        empty_dir {
          medium     = "Memory"
          size_limit = "500Mi"
        }

        
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }




resource "google_cloud_run_service_iam_member" "all" {
    service = google_cloud_run_service.service1.name
    location = google_cloud_run_service.service1.location
    role = "role/run.invoker"
    member = "allUsers"
    
  
}


variable "tag" {
    description = "take value from build_number"
    type = string
} 
