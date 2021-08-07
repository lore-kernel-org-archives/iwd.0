Content-Type: multipart/mixed; boundary="===============8742557204287198393=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/9] eapol: Store IP address in network byte order
Date: Sat, 07 Aug 2021 04:10:40 +0200
Message-ID: <20210807021048.321664-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8742557204287198393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Switch handshake_state's .client_ip_addr, .subnet_mask and .go_ip_addr
from host byte order to network by order.
---
 src/eapol.c | 12 ++++++------
 src/p2p.c   |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 5754d79d..f78bef2f 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1356,11 +1356,11 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *=
sm)
 		key_data_buf[key_data_len++] =3D 4 + 12;
 		l_put_be32(HANDSHAKE_KDE_IP_ADDRESS_ALLOC,
 				key_data_buf + key_data_len + 0);
-		l_put_be32(sm->handshake->client_ip_addr,
+		l_put_u32(sm->handshake->client_ip_addr,
 				key_data_buf + key_data_len + 4);
-		l_put_be32(sm->handshake->subnet_mask,
+		l_put_u32(sm->handshake->subnet_mask,
 				key_data_buf + key_data_len + 8);
-		l_put_be32(sm->handshake->go_ip_addr,
+		l_put_u32(sm->handshake->go_ip_addr,
 				key_data_buf + key_data_len + 12);
 		key_data_len +=3D 4 + 12;
 	}
@@ -1810,9 +1810,9 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm *=
sm,
 		hs->support_ip_allocation =3D ip_alloc_kde !=3D NULL;
 =

 		if (ip_alloc_kde) {
-			hs->client_ip_addr =3D l_get_be32(ip_alloc_kde);
-			hs->subnet_mask =3D l_get_be32(ip_alloc_kde + 4);
-			hs->go_ip_addr =3D l_get_be32(ip_alloc_kde + 8);
+			hs->client_ip_addr =3D l_get_u32(ip_alloc_kde);
+			hs->subnet_mask =3D l_get_u32(ip_alloc_kde + 4);
+			hs->go_ip_addr =3D l_get_u32(ip_alloc_kde + 8);
 		} else
 			l_debug("Authenticator ignored our IP Address Request");
 	}
diff --git a/src/p2p.c b/src/p2p.c
index 4c059173..6790caef 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1441,7 +1441,7 @@ static void p2p_netdev_event(struct netdev *netdev, e=
num netdev_event event,
 =

 static const char *p2p_ip_to_string(uint32_t addr)
 {
-	struct in_addr ia =3D { .s_addr =3D L_CPU_TO_BE32(addr) };
+	struct in_addr ia =3D { .s_addr =3D addr };
 =

 	return inet_ntoa(ia);
 }
-- =

2.30.2

--===============8742557204287198393==--

