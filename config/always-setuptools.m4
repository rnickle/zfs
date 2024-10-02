dnl #
dnl # Determine Python package setuptools availability (deprecated)
dnl #
AC_DEFUN([ZFS_AC_CONFIG_ALWAYS_SETUPTOOLS], [
	AC_ARG_ENABLE([setuptools],
		AS_HELP_STRING([--enable-setuptools],
		[use legacy Python setuptools @<:@default=check@:>@]),
		[enable_setuptools=$enableval],
		[enable_setuptools=check])

	dnl #
	dnl # Packages for setuptools specifically enabled/disabled.
	dnl #
	AS_IF([test "x$enable_setuptools" != xcheck], [
		AS_IF([test "x$enable_setuptools" = xyes], [
			DEFINE_SETUPTOOLS='--with setuptools'
		], [
			DEFINE_SETUPTOOLS='--without setuptools'
		])
	], [
		AS_IF([test "$PYTHON" != :], [
			DEFINE_SETUPTOOLS=''
		], [
			enable_setuptools=no
			DEFINE_SETUPTOOLS='--without setuptools'
		])
	])
	AC_SUBST(DEFINE_setuptools)

	dnl #
	dnl # Set enable_setuptools to 'yes' if every check passed
	dnl #
	AS_IF([test "x$enable_setuptools" = xcheck], [enable_setuptools=yes])

	AM_CONDITIONAL([SETUPTOOLS_ENABLED], [test "x$enable_setuptools" = xyes])
	AC_SUBST([SETUPTOOLS_ENABLED], [$enable_setuptools])
	AC_SUBST(pythonsitedir, [$PYTHON_SITE_PKG])

	AC_MSG_CHECKING([whether to enable setuptools: ])
	AC_MSG_RESULT($enable_setuptools)
])
