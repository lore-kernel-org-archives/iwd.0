Content-Type: multipart/mixed; boundary="===============5925015913678042133=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/16] handshake: Drop NULL event params passed to
 handshake_event
Date: Mon, 28 Oct 2019 15:04:59 +0100
Message-ID: <20191028140508.13518-7-andrew.zaborowski@intel.com>
In-Reply-To: <20191028140508.13518-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5925015913678042133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eapol.c     | 4 ++--
 src/handshake.c | 2 +-
 src/netdev.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index e7ee9fe8..dbef66f5 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -970,7 +970,7 @@ static void __send_eapol_start(struct eapol_sm *sm, boo=
l noencrypt)
 	uint8_t buf[sizeof(struct eapol_frame)];
 	struct eapol_frame *frame =3D (struct eapol_frame *) buf;
 =

-	handshake_event(sm->handshake, HANDSHAKE_EVENT_STARTED, NULL);
+	handshake_event(sm->handshake, HANDSHAKE_EVENT_STARTED);
 =

 	frame->header.protocol_version =3D EAPOL_PROTOCOL_VERSION_2001;
 	frame->header.packet_type =3D 1;
@@ -1181,7 +1181,7 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *=
sm,
 			 * layers that we need to do a full reauth
 			 */
 			handshake_event(sm->handshake,
-					HANDSHAKE_EVENT_REKEY_FAILED, NULL);
+					HANDSHAKE_EVENT_REKEY_FAILED);
 			return;
 		}
 =

diff --git a/src/handshake.c b/src/handshake.c
index a3e236bb..bb4663c7 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -558,7 +558,7 @@ void handshake_state_install_ptk(struct handshake_state=
 *s)
 		uint32_t cipher =3D ie_rsn_cipher_suite_to_cipher(
 							s->pairwise_cipher);
 =

-		handshake_event(s, HANDSHAKE_EVENT_SETTING_KEYS, NULL);
+		handshake_event(s, HANDSHAKE_EVENT_SETTING_KEYS);
 =

 		install_tk(s, handshake_get_tk(s), cipher);
 	}
diff --git a/src/netdev.c b/src/netdev.c
index da75fe48..9816f68d 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1094,7 +1094,7 @@ static void try_handshake_complete(struct netdev_hand=
shake_state *nhs)
 	if (nhs->ptk_installed && nhs->gtk_installed && nhs->igtk_installed &&
 			!nhs->complete) {
 		nhs->complete =3D true;
-		handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE, NULL);
+		handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE);
 =

 		netdev_connect_ok(nhs->netdev);
 	}
@@ -1388,7 +1388,7 @@ static void netdev_group_timeout_cb(struct l_timeout =
*timeout, void *user_data)
 			nhs->netdev->index);
 =

 	nhs->complete =3D true;
-	handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE, NULL);
+	handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE);
 =

 	netdev_connect_ok(nhs->netdev);
 }
-- =

2.20.1

--===============5925015913678042133==--

