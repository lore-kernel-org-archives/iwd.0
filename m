Content-Type: multipart/mixed; boundary="===============1449345691488612778=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/3] build: generate tls config for unit tests
Date: Mon, 07 Oct 2019 11:11:57 -0700
Message-ID: <20191007181158.16091-2-prestwoj@gmail.com>
In-Reply-To: <20191007181158.16091-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1449345691488612778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To test embedded certs we need a settings file containing the same
PEMs that we generate during build time. In the same fashion generate
tls-settings.8021x file using the previously generated PEMs.
---
 Makefile.am | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-v3:
 * Escape each $(file operation newline

diff --git a/Makefile.am b/Makefile.am
index 7f01689a..5d835735 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -441,7 +441,8 @@ unit_test_eapol_DEPENDENCIES =3D $(ell_dependencies) \
 				unit/cert-server.pem \
 				unit/cert-server-key-pkcs8.pem \
 				unit/cert-client.pem \
-				unit/cert-client-key-pkcs8.pem
+				unit/cert-client-key-pkcs8.pem \
+				unit/tls-settings.8021x
 =

 unit_test_util_SOURCES =3D src/util.h src/util.c \
 				unit/test-util.c
@@ -576,6 +577,21 @@ unit/cert-client.pem: unit/cert-client.csr unit/cert-c=
a.pem unit/gencerts.cnf
 			-CAserial $(builddir)/unit/cert-ca.srl \
 			-CAcreateserial -sha256 -days 10000 -out $@ $($(AM_V_P)_redirect_openss=
l)
 =

+unit/tls-settings.8021x: unit/cert-ca.pem unit/cert-client.pem unit/cert-c=
lient-key-pkcs8.pem
+	$(AM_V_GEN) \
+	$(file >$@,[Security]) \
+	$(file >>$@,EAP-Method=3DTLS) \
+	$(file >>$@,EAP-Identity=3Dabc(a)example.com) \
+	$(file >>$@,EAP-TLS-CACert=3Dembed:ca_cert) \
+	$(file >>$@,EAP-TLS-ClientCert=3Dembed:client_cert) \
+	$(file >>$@,EAP-TLS-ClientKey=3Dembed:client_key) \
+	$(file >>$@,[@pem(a)ca_cert]) \
+	$(shell cat unit/cert-ca.pem >> $@) \
+	$(file >>$@,[@pem(a)client_cert]) \
+	$(shell cat unit/cert-client.pem >> $@) \
+	$(file >>$@,[@pem(a)client_key]) \
+	$(shell cat unit/cert-client-key-pkcs8.pem >> $@)
+
 BUILT_SOURCES =3D $(ell_built_sources) src/builtin.h
 =

 ell/internal: Makefile
@@ -627,7 +643,7 @@ endif
 endif
 =

 clean-local:
-	-rm -f unit/cert-*.pem unit/cert-*.csr unit/cert-*.srl
+	-rm -f unit/cert-*.pem unit/cert-*.csr unit/cert-*.srl unit/*-settings.80=
21x
 =

 maintainer-clean-local:
 	-rm -rf build-aux ell
-- =

2.17.1

--===============1449345691488612778==--

