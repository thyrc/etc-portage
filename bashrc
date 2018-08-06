case "$EBUILD_PHASE" in
    preinst )
        save_configure
	[[ "${CATEGORY}/${PN}" == "dev-lang/rust" ]] && save_rust_distfiles
        ;;
    * )
        :
        ;;
esac

# printf "\n EBUILD_PHASE=$EBUILD_PHASE : Package %s/%s (%s) \n\n" ${CATEGORY} ${PN} ${T}

save_configure() {
    grep -Ee '^(.*/)configure' "${T}/build.log" >"/var/log/emerge/${P}-configure.log"
    [[ ! -s "/var/log/emerge/${P}-configure.log" ]] && rm "/var/log/emerge/${P}-configure.log"
}

save_rust_distfiles() {
    printf "\n EBUILD_PHASE=$EBUILD_PHASE : Package %s/%s (%s) \n\n" ${CATEGORY} ${PN} ${T}
    echo -e "\n ## Extracting rust distribution archives ... ##\n\n"
    [[ ! -e /tmp/dist ]] && mkdir /tmp/dist
    [[ -d /tmp/dist ]] && find "${S}/build/dist/" -type f -name '*.tar.xz' -exec cp {} /tmp/dist \;
}
