Content-Type: multipart/mixed; boundary="===============8045716569256380303=="
MIME-Version: 1.0
From: Louis Whitburn <whitburnlg@gmail.com>
Subject: [PATCH] eap-tls-common.c: Fixed EAP-TLS connections when
 EAP-TLS-CACert option omitted
Date: Tue, 10 Mar 2020 10:19:34 +1300
Message-ID: <CAN37f0eHSrVL5KB3XdzGz_ScP9rr6w_d1mgAT6t8WMSNEpf0+g@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8045716569256380303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

iwd would fail to connect using EAP-TLS when no CA certificate was provided
as it checked for successful loading of the CA certificate instead of the c=
lient
certificate when attempting to load the client certificate.

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index d62d7ca5..a6125969 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -1138,7 +1138,7 @@ bool eap_tls_common_settings_load(struct eap_state *e=
ap,
        if (value) {
                eap_tls->client_cert =3D eap_tls_load_client_cert(settings,
                                                                value);
-               if (!eap_tls->ca_cert) {
+               if (!eap_tls->client_cert) {
                        l_error("Could not load ClientCert %s", value);
                        goto load_error;
                }
--===============8045716569256380303==--

