# Maintainer: Alexander Bruegmann <mail[at]abruegmann[dot]eu>
# Contributor: Anton Palgunov <toxblh@gmail.com>

pkgname=1password-bin
_pkgname=1Password
_binname=1password
pkgver=0.8.5
pkgrel=1
pkgdesc="Password manager and secure wallet"
arch=('x86_64')
license=('custom:LicenseRef-1Password-Proprietary')
#options=(!strip)
url='https://1password.com/'
source=("https://onepassword.s3.amazonaws.com/linux/debian/pool/main/1/1password/1password-$pkgver.deb")
sha256sums=('dd1d500254e9758d358113072136e67cbff3a8c6d8961730b3019cc91e90b479')

package() {
  bsdtar -xv -C "${pkgdir}" -f "${srcdir}/data.tar.xz"

  mkdir -p "${pkgdir}/usr/bin/"
  ln -s "/opt/${_pkgname}/${_binname}" "${pkgdir}/usr/bin"/
}
