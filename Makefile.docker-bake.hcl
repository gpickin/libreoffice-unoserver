variable "ALPINE_VERSION" {
    default = "3.16"
}
variable "S6_OVERLAY_VERSION" {
    default = "v3.1.5.0"
}
variable "UNOSERVER_REST_API_VERSION" {
    default = "v0.8.5"
}

variable "DOCKER_META_IMAGES" {}
variable "DOCKER_META_VERSION" {}

target "docker-metadata-action" {
    tags = [
        "${DOCKER_META_IMAGES}:${DOCKER_META_VERSION}"
    ]
}

target "default" {
    inherits = ["docker-metadata-action"]
    dockerfile = "Dockerfile"
    context = "."
    args = {
        ALPINE_VERSION = "${ALPINE_VERSION}"
        S6_OVERLAY_VERSION = "${S6_OVERLAY_VERSION}"
        UNOSERVER_REST_API_VERSION = "${UNOSERVER_REST_API_VERSION}"
        S6_VERBOSITY = 2
        S6_KEEP_ENV = 1
        S6_BEHAVIOUR_IF_STAGE2_FAILS = 0
        ALPING_EXTRA_PKGS = "htop"
    }
}
