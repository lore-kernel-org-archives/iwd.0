Content-Type: multipart/mixed; boundary="===============8387137854616794940=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2] peap: Adjust V0 not to close tunnel on Success of Phase2
Date: Tue, 05 Nov 2019 16:42:26 -0800
Message-ID: <20191106004226.11438-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8387137854616794940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-peap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index c8949ca2..e7d23dca 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -182,17 +182,19 @@ static void eap_extensions_handle_request(struct eap_=
state *eap,
 =

 	eap_peap_phase2_send_response(response, sizeof(response), eap);
 =

-	eap_tls_common_tunnel_close(eap);
-
 	eap_discard_success_and_failure(eap, false);
 	eap_tls_common_set_completed(eap);
 =

 	if (r !=3D EAP_EXTENSIONS_RESULT_SUCCCESS) {
 		eap_tls_common_set_phase2_failed(eap);
 =

+		eap_tls_common_tunnel_close(eap);
+
 		return;
 	}
 =

+	eap_tls_common_send_empty_response(eap);
+
 	eap_method_success(eap);
 }
 =

-- =

2.13.6

--===============8387137854616794940==--

