resource "local_file" "def" {
  content  = "def!"
  filename = "${path.module}/def.txt"
}

resource "local_file" "def2" {
  content  = "def2!"
  filename = "${path.module}/def2.txt"
}
