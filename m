Content-Type: multipart/mixed; boundary="===============8123993866495327217=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/8] ft: add ft_over_ds_handshake_new
Date: Thu, 15 Apr 2021 15:45:03 -0700
Message-ID: <20210415224508.1823614-3-prestwoj@gmail.com>
In-Reply-To: <20210415224508.1823614-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8123993866495327217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FT-over-DS will be refactored to better handle the initial
action frame stage which can be done prior to needing to
roam. To do this a new handshake object needs to be created
as we cannot change the existing handshake since its needed
for rekeys. Much of the existing handshake is kept as it
contains all the keys negotiated during the initial association.
When IWD is ready, this new handshake can be used to reassociate
to a new AP.
---
 src/ft.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/ft.h |  7 +++++++
 2 files changed, 49 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index 08e6cdeb..9e6935e8 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -32,6 +32,9 @@
 #include "src/ft.h"
 #include "src/mpdu.h"
 #include "src/auth-proto.h"
+#include "src/scan.h"
+#include "src/netdev.h"
+#include "src/util.h"
 =

 struct ft_sm {
 	struct auth_proto ap;
@@ -769,6 +772,45 @@ static bool ft_start(struct auth_proto *ap)
 	return true;
 }
 =

+struct handshake_state *ft_over_ds_handshake_new(struct netdev *netdev,
+						struct scan_bss *target)
+{
+	uint8_t mde[5];
+	struct handshake_state *old =3D netdev_get_handshake(netdev);
+	struct handshake_state *hs =3D netdev_handshake_state_new(netdev);
+
+	/* copy info that will remain the same between handshakes */
+	handshake_state_set_supplicant_address(hs, old->spa);
+	handshake_state_set_supplicant_ie(hs, old->supplicant_ie);
+	handshake_state_set_ssid(hs, old->ssid, old->ssid_len);
+
+	if (old->settings_8021x)
+		handshake_state_set_8021x_config(hs, old->settings_8021x);
+
+	handshake_state_set_kh_ids(hs, old->r0khid, old->r0khid_len, old->r1khid);
+	memcpy(hs->pmk_r0, old->pmk_r0, sizeof(hs->pmk_r0));
+	memcpy(hs->pmk_r1, old->pmk_r1, sizeof(hs->pmk_r1));
+	memcpy(hs->pmk_r0_name, old->pmk_r0_name, sizeof(hs->pmk_r0_name));
+	memcpy(hs->pmk_r1_name, old->pmk_r1_name, sizeof(hs->pmk_r1_name));
+
+	handshake_state_set_pmk(hs, old->pmk, old->pmk_len);
+
+	mde[0] =3D IE_TYPE_MOBILITY_DOMAIN;
+	mde[1] =3D 3;
+	memcpy(mde + 2, target->mde, 3);
+
+	handshake_state_set_mde(hs, mde);
+
+	/* prepare new handshake for target BSS */
+	handshake_state_new_snonce(hs);
+	handshake_state_set_authenticator_address(hs, target->addr);
+
+	if (target->rsne)
+		handshake_state_set_authenticator_ie(hs, target->rsne);
+
+	return hs;
+}
+
 static struct auth_proto *ft_sm_new(struct handshake_state *hs,
 				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
diff --git a/src/ft.h b/src/ft.h
index f24b3b5e..50090a03 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -20,6 +20,10 @@
  *
  */
 =

+struct scan_bss;
+struct netdev;
+struct handshake_state;
+
 typedef void (*ft_tx_authenticate_func_t)(struct iovec *iov, size_t iov_le=
n,
 					void *user_data);
 typedef void (*ft_tx_associate_func_t)(struct iovec *ie_iov, size_t iov_le=
n,
@@ -29,6 +33,9 @@ bool ft_build_authenticate_ies(struct handshake_state *hs,
 				const uint8_t *new_snonce, uint8_t *buf,
 				size_t *len);
 =

+struct handshake_state *ft_over_ds_handshake_new(struct netdev *netdev,
+						struct scan_bss *target);
+
 struct auth_proto *ft_over_air_sm_new(struct handshake_state *hs,
 				ft_tx_authenticate_func_t tx_auth,
 				ft_tx_associate_func_t tx_assoc,
-- =

2.26.2

--===============8123993866495327217==--

