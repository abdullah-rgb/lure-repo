name="eta-touchdrv"
version="0.2.0"
release=1
epoch=1
desc="Touchscreen driver for Vestel 14MB24A (IRTOUCH)"
architectures=("all")
homepage="https://github.com/abdullah-rgb/eta-touchdrv"
license="custom"
deps=(dkms usbutils systemd)
deps_debian=(dkms usbutils systemd)
deps_fedora=(dkms usbutils systemd)
build_deps=(git)
build_deps_debian=(git build-essential)
build_deps_fedora=(git)
maintainer="Abdullah C <deneme@deneme.deneme>"

prepare() {
	git clone "${homepage}"
}

build() {
	cd "$srcdir/eta-touchdrv/usr/src/eta-touchdrv/touch2"
	sudo make
	cd ../touch4
	sudo make
	cd ../
	sudo dkms install .
}

package() {
	# binary files
	$(install -Dm755 $srcdir/eta-touchdrv/usr/bin/* -t $pkgdir/usr/bin/)
	
	# lib files
	$(install -Dm755 $srcdir/eta-touchdrv/usr/lib/systemd/system/* -t $pkgdir/usr/lib/systemd/system/)
	$(install -Dm755 $srcdir/eta-touchdrv/usr/lib/udev/rules.d/* -t $pkgdir/usr/lib/udev/rules.d/)
	
	# src files
	$(install -Dm755 $srcdir/eta-touchdrv/usr/src/eta-touchdrv/touch2/* -t $pkgdir/usr/src/eta-touchdrv/touch2/)
	$(install -Dm755 $srcdir/eta-touchdrv/usr/src/eta-touchdrv/touch4/* -t $pkgdir/usr/src/eta-touchdrv/touch4/)
	$(install -Dm755 $srcdir/eta-touchdrv/usr/src/eta-touchdrv/dkms.conf -t $pkgdir/usr/src/eta-touchdrv/)
	$(install -Dm755 $srcdir/eta-touchdrv/usr/src/eta-touchdrv/version -t $pkgdir/usr/src/eta-touchdrv/)
	
	# share/doc files
	$(install -Dm755 $srcdir/eta-touchdrv/usr/share/doc/eta-touchdrv/* -t $pkgdir/usr/share/doc/eta-touchdrv/)
	$(install -Dm755 $srcdir/eta-touchdrv/usr/share/lintian/overrides/* -t $pkgdir/usr/share/lintian/overrides/)
}
