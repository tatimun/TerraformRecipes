terraform {
  backend "s3" {
    bucket         = "buckettatitestmameluco2"  
    key            = "terraform.tfstate"         
    region         = "us-east-1"                 
    dynamodb_table = "terraform-lock-table"      
    encrypt        = true                        
  }
}