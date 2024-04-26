#! /bin/env sh

echo "Downloading prerequisited files.."

# Sources to be downloaded
virtio_exe_url="https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win-guest-tools.exe"
virtio_exe_filename="build_files/software/virtio-win-guest-tools.exe"
virtio_iso_url="https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso"
virtio_iso_filename="virtio-win.iso"
#curl -L $virtio_exe_url --output $virtio_exe_filename

if [ ! -d temp ]; then
    echo "Create folder..."
    mkdir temp
else 
    echo "Folder exists!"
fi

curl -L $virtio_iso_url --output ./temp/$virtio_iso_filename



