Content-Type: multipart/mixed; boundary="===============0818685993360464272=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/4] eap-tls-common: Address PEAPv0 interoperability with
 Windows
Date: Fri, 31 Jan 2020 14:25:14 -0800
Message-ID: <20200131222517.8182-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0818685993360464272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Windows Server 2008 - Network Policy Server (NPS) generates an invalid
Compound MAC for Cryptobinding TLV when is used within PEAPv0 due to
incorrect parsing of the message containing TLS Client Hello.
Setting L bit and including TLS Message Length field, even for the
packets that do not require fragmentation, corrects the issue. The
redundant TLS Message Length field in unfragmented packets doesn't
seem to effect the other server implementations.
---
 src/eap-tls-common.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 080e4f27..d62d7ca5 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -112,6 +112,7 @@ struct eap_tls_state {
 	size_t tx_frag_last_len;
 =

 	bool expecting_frag_ack:1;
+	bool tunnel_ready:1;
 =

 	struct l_queue *ca_cert;
 	struct l_certchain *client_cert;
@@ -128,6 +129,7 @@ static void __eap_tls_common_state_reset(struct eap_tls=
_state *eap_tls)
 	eap_tls->method_completed =3D false;
 	eap_tls->phase2_failed =3D false;
 	eap_tls->expecting_frag_ack =3D false;
+	eap_tls->tunnel_ready =3D false;
 =

 	if (eap_tls->tunnel) {
 		l_tls_free(eap_tls->tunnel);
@@ -244,6 +246,8 @@ static void eap_tls_tunnel_ready(const char *peer_ident=
ity, void *user_data)
 	 */
 	eap_start_complete_timeout(eap);
 =

+	eap_tls->tunnel_ready =3D true;
+
 	if (!eap_tls->variant_ops->tunnel_ready)
 		return;
 =

@@ -261,6 +265,7 @@ static void eap_tls_tunnel_disconnected(enum l_tls_aler=
t_desc reason,
 			eap_get_method_name(eap), l_tls_alert_to_str(reason));
 =

 	eap_tls->method_completed =3D true;
+	eap_tls->tunnel_ready =3D false;
 }
 =

 static bool eap_tls_validate_version(struct eap_state *eap,
@@ -325,11 +330,32 @@ static void eap_tls_send_fragment(struct eap_state *e=
ap)
 	eap_tls->tx_frag_last_len =3D len;
 }
 =

+static bool needs_workaround(struct eap_state *eap)
+{
+	struct eap_tls_state *eap_tls =3D eap_get_data(eap);
+
+	/*
+	 * Windows Server 2008 - Network Policy Server (NPS) generates an
+	 * invalid Compound MAC for Cryptobinding TLV when is used within PEAPv0
+	 * due to incorrect parsing of the message containing TLS Client Hello.
+	 * Setting L bit and including TLS Message Length field, even for the
+	 * packets that do not require fragmentation, corrects the issue. The
+	 * redundant TLS Message Length field in unfragmented packets doesn't
+	 * seem to effect the other server implementations.
+	 */
+	return eap_get_method_type(eap) =3D=3D EAP_TYPE_PEAP &&
+			eap_tls->version_negotiated =3D=3D EAP_TLS_VERSION_0 &&
+			!eap_tls->tunnel_ready;
+}
+
 static void eap_tls_send_response(struct eap_state *eap,
 					const uint8_t *pdu, size_t pdu_len)
 {
 	struct eap_tls_state *eap_tls =3D eap_get_data(eap);
 	size_t msg_len =3D EAP_TLS_HEADER_LEN + pdu_len;
+	bool set_tls_msg_len =3D needs_workaround(eap);
+
+	msg_len +=3D set_tls_msg_len ? 4 : 0;
 =

 	if (msg_len <=3D eap_get_mtu(eap)) {
 		uint8_t *buf;
@@ -345,6 +371,15 @@ static void eap_tls_send_response(struct eap_state *ea=
p,
 		buf[EAP_TLS_HEADER_OCTET_FLAGS + extra] =3D
 						eap_tls->version_negotiated;
 =

+		if (set_tls_msg_len) {
+			buf[extra + EAP_TLS_HEADER_OCTET_FLAGS] |=3D
+								EAP_TLS_FLAG_L;
+			l_put_be32(pdu_len,
+				   &buf[extra + EAP_TLS_HEADER_OCTET_FRAG_LEN]);
+
+			extra +=3D 4;
+		}
+
 		memcpy(buf + EAP_TLS_HEADER_LEN + extra, pdu, pdu_len);
 =

 		eap_send_response(eap, eap_get_method_type(eap), buf, msg_len);
-- =

2.13.6

--===============0818685993360464272==--

