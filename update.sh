# Update Info
apt-get update

# Version of app
VERSION=`apt-cache show 1password | grep -Po "(Version: )\K(.)*" | head -n 1`

# Filepath
# https://onepassword.s3.amazonaws.com/linux/debian/${path}
FILEPATH=`apt-cache show 1password | grep -Po "(Filename: )\K(.)*" | head -n 1`

# SHA256
CHECKSUM=`apt-cache show 1password | grep -Po "(SHA256: )\K(.)*" | head -n 1`

echo "
{
    \"version\": \"${VERSION}\"
    \"filepath\": \"https://onepassword.s3.amazonaws.com/linux/debian/${FILEPATH}\"
    \"sha256\": \"${CHECKSUM}\"
}
"

echo "# Maintainer: Anton Palgunov <toxblh@gmail.com>

pkgname=1password-bin
_pkgname=1Password
_binname=1password
pkgver=${VERSION}
pkgrel=1
pkgdesc="Password manager and secure wallet"
arch=('x86_64')
license=('LicenseRef-1Password-Proprietary')
options=(!strip)
url='https://1password.com/'
source=("https://onepassword.s3.amazonaws.com/linux/debian/pool/main/1/1password/1password-\$pkgver.deb")
sha256sums=('${CHECKSUM}')

package() {
  bsdtar -xv -C "\${pkgdir}" -f "\${srcdir}/data.tar.xz"

  mkdir -p "\${pkgdir}/usr/bin/"
  ln -s "/opt/\${_pkgname}/\${_binname}" "\${pkgdir}/usr/bin"/
}" > PKGBUILD



