DESCRIPTION="Lightweight non-interactive sh(1)-like scripting language"
HOMEPAGE="http://www.skarnet.org/software/execline/"
SRC_URI="http://www.skarnet.org/software/execline/${P}.tar.gz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=dev-libs/skalibs-1.3.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/admin/${P}"
DESTDIR="/package/admin/${P}"

src_unpack() {
unpack ${A}
cd "${S}"
echo "strip -R .note -R .comment -R .note.GNU-stack" \
> conf-compile/conf-stripbins
}

src_compile() {

package/compile || die "build failed"
}



src_install() {

dodoc doc/*.txt
dohtml doc/*.html

diropts -m1755
dodir /package
diropts -m0755

dosym "${P}" /package/admin/"${PN}"

insinto "${DSTDIR}"/include
doins include/*
insinto "${DSTDIR}"/library
doins library/*

insinto /command
insopts -m0755
doins command/*

}

