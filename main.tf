provider "google" {
    zone = "us-central"
    project="mythic-inn-420620"
   
  
}

resource "google_cloud_run_service" "service1" {
  name     = "cloudrun-srv"
  location = "us-central1"
  
 

  template {
    
    spec {
      containers {
        name = "hello-1"
        ports {
          container_port = 8080
        }
        image = "us-central1-docker.pkg.dev/mythic-inn-420620/my-docker-repo1/okay:${var.tag}"
        volume_mounts {
          name = "shared-volume"
          mount_path = "/app"
          }
        
      }
     

      volumes {
          name = "shared-volume"
          empty_dir {
          medium = "Memory"
          size_limit = "500Mi"
        }
      }
    }
  }
  


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
