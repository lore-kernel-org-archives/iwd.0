Content-Type: multipart/mixed; boundary="===============0449790205938846962=="
MIME-Version: 1.0
From: John Zimmermann <me@johnnynator.dev>
Subject: [PATCH] resolve: allow setting default DNS resolver at compile time
Date: Tue, 27 Oct 2020 22:31:06 +0100
Message-ID: <20201027213106.30028-1-me@johnnynator.dev>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0449790205938846962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 configure.ac  | 15 +++++++++++++++
 src/resolve.c |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 78db15e9..0adddd10 100644
--- a/configure.ac
+++ b/configure.ac
@@ -250,6 +250,21 @@ if (test "${enable_systemd_service}" !=3D "no" && test=
 -z "${path_systemd_modloadd
 fi
 AC_SUBST(SYSTEMD_MODLOADDIR, [${path_systemd_modloaddir}])
 =

+AC_ARG_WITH(resolver, AC_HELP_STRING([--with-resolver=3D(systemd|resolvcon=
f)],
+			[Set default DNS resolver [default=3Dsystemd]]),,
+		[with_resolver=3Dsystemd])
+
+case "x$with_resolver" in
+	"xsystemd")
+		AC_DEFINE(DEFAULT_RESOLVER, "systemd", ["Default DNS resolver"])
+	;;
+	"xresolvconf")
+		AC_DEFINE(DEFAULT_RESOLVER, "resolvconf", ["Default DNS resolver"])
+	;;
+	*) AC_MSG_ERROR([Wrong value for --with-resolver: $with_resolver])
+	;;
+esac
+
 AC_ARG_ENABLE([external_ell], AC_HELP_STRING([--enable-external-ell],
 				[enable external Embedded Linux library]),
 					[enable_external_ell=3D${enableval}])
diff --git a/src/resolve.c b/src/resolve.c
index 066e4c87..8949edad 100644
--- a/src/resolve.c
+++ b/src/resolve.c
@@ -553,8 +553,8 @@ static int resolve_init(void)
 		if (method_name)
 			l_warn("[General].dns_resolve_method is deprecated, "
 				"use [Network].NameResolvingService");
-		else /* Default to systemd-resolved service. */
-			method_name =3D "systemd";
+		else /* Default to compile time option (default: systemd-resolved) */
+			method_name =3D DEFAULT_RESOLVER;
 	}
 =

 	for (i =3D 0; resolve_method_ops_list[i].name; i++) {
-- =

2.29.0

--===============0449790205938846962==--

