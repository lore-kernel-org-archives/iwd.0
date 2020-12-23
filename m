Content-Type: multipart/mixed; boundary="===============5036589878659952270=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] eap-tls: Dump server certificate when IWD_TLS_DEBUG set
Date: Thu, 24 Dec 2020 00:22:14 +0100
Message-ID: <20201223232215.1078347-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5036589878659952270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-tls-common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index c3eb5ab3..68e2a10c 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -583,9 +583,12 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
 		return false;
 	}
 =

-	if (getenv("IWD_TLS_DEBUG"))
+	if (getenv("IWD_TLS_DEBUG")) {
 		l_tls_set_debug(eap_tls->tunnel, eap_tls_tunnel_debug, eap,
 									NULL);
+		l_tls_set_cert_dump_path(eap_tls->tunnel,
+					"/tmp/iwd-tls-debug-server-cert.pem");
+	}
 =

 	if (eap_tls->client_cert || eap_tls->client_key) {
 		if (!l_tls_set_auth_data(eap_tls->tunnel, eap_tls->client_cert,
-- =

2.27.0

--===============5036589878659952270==--

