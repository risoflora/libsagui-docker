# `libsagui-docker`

Official Docker image for Sagui library.

## Building latest version

```bash
git clone https://github.com/risoflora/libsagui-docker.git
cd libsagui-docker/
./make.sh
```

**NOTE:** On Ubuntu, remember to: `sudo apt-get install -y qemu qemu-user-static`.
And then: `docker buildx ls`. ([Reference](https://stackoverflow.com/questions/73253352/docker-exec-bin-sh-exec-format-error-on-arm64))

## Generated files

```bash
tree -L 1 output/
output/
├── gnutls-3.6.15-mingw_386.zip
├── gnutls-3.6.15-mingw_amd64.zip
├── html
├── libsagui-3.3.1_checksums.txt
├── libsagui-3.3.1-linux_amd64.tar.gz
├── libsagui-3.3.1-windows_386.zip
├── libsagui-3.3.1-windows_amd64.zip
├── libsagui_tls-3.3.1-linux_amd64.tar.gz
├── libsagui_tls-3.3.1-windows_386.zip
└── libsagui_tls-3.3.1-windows_amd64.zip

1 directory, 9 files
```
