variable "aws_region" {
  description = "Région AWS"
  default     = "us-east-1" # remplace par ta région valide
}

variable "public_key_path" {
  description = "Chemin vers la clé publique SSH"
  default     = "C:\\Users\\USER\\.ssh\\id_rsa.pub"
}

variable "allowed_ip" {
  description = "IP autorisée pour SSH"
  default     = "41.82.181.220/32" # À remplacer avec ta vraie IP
}
