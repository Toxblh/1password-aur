# Version of app
VERSION=`curl -s https://downloads.1password.com/linux/debian/dists/edge/main/binary-amd64/Packages | grep -Po "(Filename: ).*1password-\K([a-z0-9\.-])+\d+" | head -n 1`
AUR_VERSION=`echo $VERSION | grep -Po "(\d+\.)+\d+"`

# Filepath
# https://downloads.1password.com/linux/debian/${path}
FILEPATH=`curl -s https://downloads.1password.com/linux/debian/dists/edge/main/binary-amd64/Packages | grep -Po "(Filename: )\K(.)*" | head -n 1`

# SHA256
CHECKSUM=`curl -s https://downloads.1password.com/linux/debian/dists/edge/main/binary-amd64/Packages | grep -Po "(SHA256: )\K(.)*" | head -n 1`

echo "
{
    \"aur-version\": \"${AUR_VERSION}\",
    \"version\": \"${VERSION}\",
    \"filebase\": \"https://downloads.1password.com/linux/debian\",
    \"filedeb\": \"${FILEPATH}\",
    \"filepath\": \"https://downloads.1password.com/linux/debian/pool/main/1/1password/1password-${VERSION}.deb\",
    \"sha256\": \"${CHECKSUM}\"
}"

echo "# Maintainer: Anton Palgunov <toxblh@gmail.com>

pkgname=1password-bin
_pkgname=1Password
_binname=1password
pkgver=${AUR_VERSION}
_pkgver=${VERSION}
pkgrel=1
pkgdesc=\"Password manager and secure wallet (development preview)\"
arch=('x86_64')
depends=('libxss' 'gtk3' 'nss')
license=('custom:LicenseRef-1Password-Proprietary')
url='https://1password.com/'
source=(\"https://downloads.1password.com/linux/debian/pool/main/1/1password/1password-\$_pkgver.deb\")
sha256sums=('${CHECKSUM}')
validpgpkeys=('3FEF9748469ADBE15DA7CA80AC2D62742012EA22')

package() {
  bsdtar -xv -C \"\${pkgdir}\" -f \"\${srcdir}/data.tar.xz\"

  chmod 0644 \"\${pkgdir}/usr/share/polkit-1/actions/com.1password.1Password.policy\"
  chmod 4755 \"\${pkgdir}/opt/1Password/chrome-sandbox\" || true

  mkdir -p \"\${pkgdir}/usr/bin/\"
  ln -s \"/opt/\${_pkgname}/\${_binname}\" \"\${pkgdir}/usr/bin\"
}" > 1password-bin/PKGBUILD

echo "\n\nPKGBUILD:\n"

cat 1password-bin/PKGBUILD

echo "pkgbase = 1password-bin
	pkgdesc = Password manager and secure wallet (development preview)
	pkgver = ${AUR_VERSION}
	pkgrel = 1
	url = https://1password.com/
	arch = x86_64
	license = custom:LicenseRef-1Password-Proprietary
	depends = libxss
	depends = gtk3
	depends = nss
	source = https://downloads.1password.com/linux/debian/pool/main/1/1password/1password-${VERSION}.deb
	validpgpkeys = 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
	sha256sums = ${CHECKSUM}

pkgname = 1password-bin
" > 1password-bin/.SRCINFO
