Content-Type: multipart/mixed; boundary="===============5034368358974768292=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 1/5] handshake: update TK installer/builder to take key
 index
Date: Fri, 08 Oct 2021 11:07:22 -0700
Message-ID: <20211008180726.2599788-1-prestwoj@gmail.com>

--===============5034368358974768292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handshake.c | 2 +-
 src/handshake.h | 1 +
 src/netdev.c    | 9 +++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index ea1c5e4b..8b08379d 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -666,7 +666,7 @@ void handshake_state_install_ptk(struct handshake_state=
 *s)
 =

 		handshake_event(s, HANDSHAKE_EVENT_SETTING_KEYS);
 =

-		install_tk(s, handshake_get_tk(s), cipher);
+		install_tk(s, s->active_tk_index, handshake_get_tk(s), cipher);
 	}
 }
 =

diff --git a/src/handshake.h b/src/handshake.h
index 4cf2ec63..6d56dadd 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -68,6 +68,7 @@ typedef void (*handshake_event_func_t)(struct handshake_s=
tate *hs,
 =

 typedef bool (*handshake_get_nonce_func_t)(uint8_t nonce[]);
 typedef void (*handshake_install_tk_func_t)(struct handshake_state *hs,
+					uint8_t key_index,
 					const uint8_t *tk, uint32_t cipher);
 typedef void (*handshake_install_gtk_func_t)(struct handshake_state *hs,
 					uint16_t key_index,
diff --git a/src/netdev.c b/src/netdev.c
index de155da1..de2f3d58 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1735,9 +1735,9 @@ static struct l_genl_msg *netdev_build_cmd_new_key_pa=
irwise(
 							uint32_t cipher,
 							const uint8_t *aa,
 							const uint8_t *tk,
-							size_t tk_len)
+							size_t tk_len,
+							uint8_t key_id)
 {
-	uint8_t key_id =3D 0;
 	struct l_genl_msg *msg;
 =

 	msg =3D l_genl_msg_new_sized(NL80211_CMD_NEW_KEY, 512);
@@ -1775,7 +1775,7 @@ static void netdev_group_timeout_cb(struct l_timeout =
*timeout, void *user_data)
 	netdev_connect_ok(nhs->netdev);
 }
 =

-static void netdev_set_tk(struct handshake_state *hs,
+static void netdev_set_tk(struct handshake_state *hs, uint8_t key_index,
 				const uint8_t *tk, uint32_t cipher)
 {
 	struct netdev_handshake_state *nhs =3D
@@ -1823,7 +1823,8 @@ static void netdev_set_tk(struct handshake_state *hs,
 		goto invalid_key;
 =

 	msg =3D netdev_build_cmd_new_key_pairwise(netdev, cipher, addr, tk_buf,
-						crypto_cipher_key_len(cipher));
+						crypto_cipher_key_len(cipher),
+						key_index);
 	nhs->pairwise_new_key_cmd_id =3D
 		l_genl_family_send(nl80211, msg, netdev_new_pairwise_key_cb,
 						nhs, NULL);
-- =

2.31.1

--===============5034368358974768292==--

