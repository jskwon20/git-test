resource "local_file" "def" {
  content  = "def!"
  filename = "${path.module}/def.txt"
}
