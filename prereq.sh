#! /bin/sh

echo "Downloading prerequisited files.."

# Sources to be downloaded
virtio_exe_url="https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win-guest-tools.exe"
virtio_exe_filename="build_files/software/virtio-win-guest-tools.exe"

curl -L $virtio_exe_url --output $virtio_exe_filename
