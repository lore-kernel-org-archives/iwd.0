Content-Type: multipart/mixed; boundary="===============1482064712519670421=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/17] p2putil: Add p2p_random_char
Date: Wed, 09 Sep 2020 01:49:24 +0200
Message-ID: <20200908234933.301439-8-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1482064712519670421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a utility to select random characters from the set defined in P2P
v1.7 Section 3.2.1.
---
 src/p2putil.c | 26 ++++++++++++++++++++++++++
 src/p2putil.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/src/p2putil.c b/src/p2putil.c
index d0f3a444..99ab4ca0 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -2611,3 +2611,29 @@ uint8_t *p2p_build_go_disc_req(size_t *out_len)
 	return p2p_build_action_frame(false, P2P_ACTION_GO_DISCOVERABILITY_REQ,
 					0, NULL, NULL, NULL, 0, out_len);
 }
+
+/*
+ * Select a random char from the set defined in section 3.2.1:
+ *
+ * "Following "DIRECT-" the SSID shall contain two ASCII characters "xy",
+ * randomly selected with a uniform distribution from the following
+ * character set: upper case letters, lower case letters and numbers."
+ *
+ * "The WPA2-Personal pass-phrase shall contain at least eight ASCII
+ * characters randomly selected with a uniform distribution from the
+ * following character set: upper case letters, lower case letters and
+ * numbers."
+ */
+char p2p_random_char(void)
+{
+#define CHARSET "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "abcdefghijklmnopqrstuvwxyz" \
+		"0123456789"
+	static const int set_size =3D strlen(CHARSET);
+	static const uint32_t limit =3D -(0x100000000LL % set_size);
+	uint32_t index;
+
+	while ((index =3D l_getrandom_uint32()) >=3D limit);
+
+	return CHARSET[index % set_size];
+#undef CHARSET
+}
diff --git a/src/p2putil.h b/src/p2putil.h
index 6aad5574..e1fb786b 100644
--- a/src/p2putil.h
+++ b/src/p2putil.h
@@ -603,3 +603,5 @@ uint8_t *p2p_build_presence_req(const struct p2p_presen=
ce_req *data,
 uint8_t *p2p_build_presence_resp(const struct p2p_presence_resp *data,
 					size_t *out_len);
 uint8_t *p2p_build_go_disc_req(size_t *out_len);
+
+char p2p_random_char(void);
-- =

2.25.1

--===============1482064712519670421==--

