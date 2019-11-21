Content-Type: multipart/mixed; boundary="===============1150737084370431725=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] unit: Update p2p_free_* function names
Date: Thu, 21 Nov 2019 21:15:55 +0100
Message-ID: <20191121201557.16506-2-andrew.zaborowski@intel.com>
In-Reply-To: <20191121201557.16506-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1150737084370431725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-p2p.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/unit/test-p2p.c b/unit/test-p2p.c
index 6638b5d9..08495e78 100644
--- a/unit/test-p2p.c
+++ b/unit/test-p2p.c
@@ -277,8 +277,8 @@ static void p2p_test_parse_beacon(const void *data)
 				attrs2.notice_of_absence.descriptors,
 				p2p_noa_desc_cmp));
 =

-	p2p_free_beacon(&attrs1);
-	p2p_free_beacon(&attrs2);
+	p2p_clear_beacon(&attrs1);
+	p2p_clear_beacon(&attrs2);
 }
 =

 static void p2p_test_build_beacon(const void *data)
@@ -301,7 +301,7 @@ static void p2p_test_build_beacon(const void *data)
 	}
 =

 	ies =3D p2p_build_beacon(&attrs2, &ies_len);
-	p2p_free_beacon(&attrs2);
+	p2p_clear_beacon(&attrs2);
 =

 	assert(p2p_payload_cmd(ies, ies_len, test->ies, test->ies_len));
 	l_free(ies);
@@ -407,7 +407,7 @@ static void p2p_test_parse_probe_req(const void *data)
 	assert(l_queue_length(attrs.service_hashes) =3D=3D
 		l_queue_length(test->data.service_hashes));
 =

-	p2p_free_probe_req(&attrs);
+	p2p_clear_probe_req(&attrs);
 }
 =

 static void p2p_test_build_probe_req(const void *data)
@@ -617,8 +617,8 @@ static void p2p_test_parse_probe_resp(const void *data)
 	assert(l_queue_length(attrs1.advertised_svcs) =3D=3D
 		l_queue_length(attrs2.advertised_svcs));
 =

-	p2p_free_probe_resp(&attrs1);
-	p2p_free_probe_resp(&attrs2);
+	p2p_clear_probe_resp(&attrs1);
+	p2p_clear_probe_resp(&attrs2);
 }
 =

 static void p2p_test_build_probe_resp(const void *data)
@@ -641,7 +641,7 @@ static void p2p_test_build_probe_resp(const void *data)
 	}
 =

 	ies =3D p2p_build_probe_resp(&attrs2, &ies_len);
-	p2p_free_probe_resp(&attrs2);
+	p2p_clear_probe_resp(&attrs2);
 =

 	assert(p2p_payload_cmd(ies, ies_len, test->ies, test->ies_len));
 	l_free(ies);
@@ -738,8 +738,8 @@ static void p2p_test_parse_association_req(const void *=
data)
 	assert(l_queue_length(attrs1.interface.interface_addrs) =3D=3D
 		l_queue_length(attrs2.interface.interface_addrs));
 =

-	p2p_free_association_req(&attrs1);
-	p2p_free_association_req(&attrs2);
+	p2p_clear_association_req(&attrs1);
+	p2p_clear_association_req(&attrs2);
 }
 =

 static void p2p_test_build_association_req(const void *data)
@@ -808,8 +808,8 @@ static void p2p_test_parse_association_resp(const void =
*data)
 	assert(attrs1.listen_availability.avail_interval_ms =3D=3D
 		attrs2.listen_availability.avail_interval_ms);
 =

-	p2p_free_association_resp(&attrs1);
-	p2p_free_association_resp(&attrs2);
+	p2p_clear_association_resp(&attrs1);
+	p2p_clear_association_resp(&attrs2);
 }
 =

 static void p2p_test_build_association_resp(const void *data)
@@ -976,8 +976,8 @@ static void p2p_test_parse_provision_disc_req(const voi=
d *data)
 =

 	assert(attrs1.wsc_config_method =3D=3D attrs2.wsc_config_method);
 =

-	p2p_free_provision_disc_req(&attrs1);
-	p2p_free_provision_disc_req(&attrs2);
+	p2p_clear_provision_disc_req(&attrs1);
+	p2p_clear_provision_disc_req(&attrs2);
 }
 =

 static void p2p_test_build_provision_disc_req(const void *data)
@@ -1114,8 +1114,8 @@ static void p2p_test_parse_provision_disc_resp(const =
void *data)
 =

 	assert(attrs1.wsc_config_method =3D=3D attrs2.wsc_config_method);
 =

-	p2p_free_provision_disc_resp(&attrs1);
-	p2p_free_provision_disc_resp(&attrs2);
+	p2p_clear_provision_disc_resp(&attrs1);
+	p2p_clear_provision_disc_resp(&attrs2);
 }
 =

 int main(int argc, char *argv[])
-- =

2.20.1

--===============1150737084370431725==--

