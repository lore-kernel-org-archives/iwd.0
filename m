Content-Type: multipart/mixed; boundary="===============3548641359302497995=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2] peap: Adjust V0 not to close tunnel on Success of Phase2
Date: Mon, 11 Nov 2019 16:19:21 -0800
Message-ID: <20191112001921.1752-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3548641359302497995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Despite that PEAPv0 spec indicates that TLS tunnel needs to be torn
down after the transmission of a secure Result response, some servers
treat this TLS close alert as a failure. This patch changes the above
behavior to explicitly torn the tunnel only in the case of
authentication failure and leave it open after the success.
---
 src/eap-peap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index c8949ca2..16ab0319 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -182,14 +182,14 @@ static void eap_extensions_handle_request(struct eap_=
state *eap,

 	eap_peap_phase2_send_response(response, sizeof(response), eap);

-	eap_tls_common_tunnel_close(eap);
-
 	eap_discard_success_and_failure(eap, false);
 	eap_tls_common_set_completed(eap);

 	if (r !=3D EAP_EXTENSIONS_RESULT_SUCCCESS) {
 		eap_tls_common_set_phase2_failed(eap);

+		eap_tls_common_tunnel_close(eap);
+
 		return;
 	}

--

v2: Add description

2.13.6

--===============3548641359302497995==--

