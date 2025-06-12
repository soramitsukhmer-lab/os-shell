variable "VERSION" { default = "latest" }

target "default" {
  tags = [
    "soramitsukhmer-lab/os-shell:dev"
  ]
}

target "release" {
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
  tags = [
    "harbor.sorakh.io/soramitsukhmer-lab/os-shell:${VERSION}"
  ]
}
