Content-Type: multipart/mixed; boundary="===============0830889705827801390=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/8] p2putil: Add p2p_get_random_string
Date: Fri, 11 Sep 2020 21:50:58 +0200
Message-ID: <20200911195103.385070-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200911195103.385070-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0830889705827801390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a utility to select random characters from the set defined in P2P
v1.7 Section 3.2.1.  In this version the assumption is that we're only
actually using this for the two SSID characters.
---
 src/p2putil.c | 33 +++++++++++++++++++++++++++++++++
 src/p2putil.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/src/p2putil.c b/src/p2putil.c
index d0f3a444..6ea18b74 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -2611,3 +2611,36 @@ uint8_t *p2p_build_go_disc_req(size_t *out_len)
 	return p2p_build_action_frame(false, P2P_ACTION_GO_DISCOVERABILITY_REQ,
 					0, NULL, NULL, NULL, 0, out_len);
 }
+
+/*
+ * Select a string of random characters from the set defined in section
+ * 3.2.1:
+ *
+ * "Following "DIRECT-" the SSID shall contain two ASCII characters "xy",
+ * randomly selected with a uniform distribution from the following
+ * character set: upper case letters, lower case letters and numbers."
+ *
+ * "The WPA2-Personal pass-phrase shall contain at least eight ASCII
+ * characters randomly selected with a uniform distribution from the
+ * following character set: upper case letters, lower case letters and
+ * numbers."
+ *
+ * Our random distribution is not uniform but close enough for use in
+ * the SSID.
+ */
+void p2p_get_random_string(char *buf, size_t len)
+{
+#define CHARSET "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "abcdefghijklmnopqrstuvwxyz" \
+		"0123456789"
+	static const int set_size =3D strlen(CHARSET);
+
+	l_getrandom(buf, len);
+
+	while (len) {
+		int index =3D *buf % set_size;
+
+		*buf++ =3D CHARSET[index];
+		len--;
+	}
+#undef CHARSET
+}
diff --git a/src/p2putil.h b/src/p2putil.h
index 6aad5574..23bf1dae 100644
--- a/src/p2putil.h
+++ b/src/p2putil.h
@@ -603,3 +603,5 @@ uint8_t *p2p_build_presence_req(const struct p2p_presen=
ce_req *data,
 uint8_t *p2p_build_presence_resp(const struct p2p_presence_resp *data,
 					size_t *out_len);
 uint8_t *p2p_build_go_disc_req(size_t *out_len);
+
+void p2p_get_random_string(char *buf, size_t len);
-- =

2.25.1

--===============0830889705827801390==--

