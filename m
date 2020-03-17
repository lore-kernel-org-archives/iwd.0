Content-Type: multipart/mixed; boundary="===============5106208866630353147=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] wiphy: add _generate_address_from_ssid
Date: Tue, 17 Mar 2020 10:38:51 -0700
Message-ID: <20200317173855.19680-3-prestwoj@gmail.com>
In-Reply-To: <20200317173855.19680-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5106208866630353147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This API is being added to support per-network MAC address
generation. The MAC is generated based on the network SSID
and the adapters permanent address using HMAC-SHA256. The
SHA digest is then constrained to make it MAC address
compliant.

Generating the MAC address like this will ensure that the
MAC remains the same each time a given SSID is connected to.
---
 src/wiphy.c | 36 ++++++++++++++++++++++++++++++++----
 src/wiphy.h |  2 ++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index e0929c09..101e94d0 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -435,12 +435,10 @@ const uint8_t *wiphy_get_rm_enabled_capabilities(stru=
ct wiphy *wiphy)
 	return wiphy->rm_enabled_capabilities;
 }
 =

-void wiphy_generate_random_address(struct wiphy *wiphy, uint8_t addr[stati=
c 6])
+static void wiphy_address_constrain(struct wiphy *wiphy, uint8_t addr[stat=
ic 6])
 {
 	switch (mac_randomize_bytes) {
 	case 6:
-		l_getrandom(addr, 6);
-
 		/* Set the locally administered bit */
 		addr[0] |=3D 0x2;
 =

@@ -448,7 +446,6 @@ void wiphy_generate_random_address(struct wiphy *wiphy,=
 uint8_t addr[static 6])
 		addr[0] &=3D 0xfe;
 		break;
 	case 3:
-		l_getrandom(addr + 3, 3);
 		memcpy(addr, wiphy->permanent_addr, 3);
 		break;
 	}
@@ -464,6 +461,37 @@ void wiphy_generate_random_address(struct wiphy *wiphy=
, uint8_t addr[static 6])
 		addr[5] =3D 0x01;
 }
 =

+void wiphy_generate_random_address(struct wiphy *wiphy, uint8_t addr[stati=
c 6])
+{
+	switch (mac_randomize_bytes) {
+	case 6:
+		l_getrandom(addr, 6);
+		break;
+	case 3:
+		l_getrandom(addr + 3, 3);
+		break;
+	}
+
+	wiphy_address_constrain(wiphy, addr);
+}
+
+void wiphy_generate_address_from_ssid(struct wiphy *wiphy, const char *ssi=
d,
+					uint8_t addr[static 6])
+{
+	switch (mac_randomize_bytes) {
+	case 6:
+		hmac_sha256(ssid, strlen(ssid), wiphy->permanent_addr,
+				sizeof(wiphy->permanent_addr), addr, ETH_ALEN);
+		break;
+	case 3:
+		hmac_sha256(ssid, strlen(ssid), wiphy->permanent_addr,
+				sizeof(wiphy->permanent_addr), addr + 3, 3);
+		break;
+	}
+
+	wiphy_address_constrain(wiphy, addr);
+}
+
 bool wiphy_constrain_freq_set(const struct wiphy *wiphy,
 						struct scan_freq_set *set)
 {
diff --git a/src/wiphy.h b/src/wiphy.h
index dff0e1bd..4d2a4e8f 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -82,6 +82,8 @@ const uint8_t *wiphy_get_extended_capabilities(struct wip=
hy *wiphy,
 const uint8_t *wiphy_get_rm_enabled_capabilities(struct wiphy *wiphy);
 =

 void wiphy_generate_random_address(struct wiphy *wiphy, uint8_t addr[stati=
c 6]);
+void wiphy_generate_address_from_ssid(struct wiphy *wiphy, const char *ssi=
d,
+					uint8_t addr[static 6]);
 =

 uint32_t wiphy_state_watch_add(struct wiphy *wiphy,
 				wiphy_state_watch_func_t func, void *user_data,
-- =

2.21.1

--===============5106208866630353147==--

