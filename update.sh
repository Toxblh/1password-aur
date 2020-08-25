# Version of app
VERSION=`sudo apt-cache show 1password | grep -Po "(Filename: ).*1password-\K([a-z0-9\.-])+\d+" | head -n 1`
AUR_VERSION=`echo $VERSION | grep -Po "(\d+\.)+\d+"`

# Filepath
# https://onepassword.s3.amazonaws.com/linux/debian/${path}
FILEPATH=`sudo apt-cache show 1password | grep -Po "(Filename: )\K(.)*" | head -n 1`

# SHA256
CHECKSUM=`sudo apt-cache show 1password | grep -Po "(SHA256: )\K(.)*" | head -n 1`

echo "
{
    \"aur-version\": \"${AUR_VERSION}\",
    \"version\": \"${VERSION}\",
    \"filebase\": \"https://onepassword.s3.amazonaws.com/linux/debian\",
    \"filedeb\": \"${FILEPATH}\",
    \"filepath\": \"https://onepassword.s3.amazonaws.com/linux/debian/pool/main/1/1password/1password-${VERSION}.deb\",
    \"sha256\": \"${CHECKSUM}\"
}"

echo "# Maintainer: Anton Palgunov <toxblh@gmail.com>

pkgname=1password-bin
_pkgname=1Password
_binname=1password
pkgver=${AUR_VERSION}
_pkgver=${VERSION}
pkgrel=1
pkgdesc=\"Password manager and secure wallet\"
arch=('x86_64')
license=('custom:LicenseRef-1Password-Proprietary')
options=(!strip)
url='https://1password.com/'
source=(\"https://onepassword.s3.amazonaws.com/linux/debian/pool/main/1/1password/1password-\$_pkgver.deb\")
sha256sums=('${CHECKSUM}')

package() {
  bsdtar -xv -C \"\${pkgdir}\" -f \"\${srcdir}/data.tar.xz\"

  mkdir -p \"\${pkgdir}/usr/bin/\"
  ln -s \"/opt/\${_pkgname}/\${_binname}\" \"\${pkgdir}/usr/bin\"/
}" > 1password-bin/PKGBUILD

echo "\n\nPKGBUILD:\n"

cat 1password-bin/PKGBUILD
