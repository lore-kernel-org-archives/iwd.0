Content-Type: multipart/mixed; boundary="===============9083570601755286415=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/9] handshake: Add HANDSHAKE_EVENT_IP_REQUEST
Date: Sat, 07 Aug 2021 04:10:41 +0200
Message-ID: <20210807021048.321664-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210807021048.321664-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9083570601755286415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a handshake event for use by the AP side for mechanisms that
allocate client IPs during the handshake: P2P address allocation and
FILS address assignment.  This is emitted only when EAPOL or the
auth_proto is actually about to send the network configuration data to
the client so that ap.c can skip allocating a DHCP leases altogether if
the client doesn't send the required KDE or IE.
---
 src/eapol.c     | 8 ++++++++
 src/handshake.h | 1 +
 src/station.c   | 1 +
 3 files changed, 10 insertions(+)

diff --git a/src/eapol.c b/src/eapol.c
index f78bef2f..e2892c0e 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1350,6 +1350,14 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *s=
m)
 		key_data_len +=3D gtk_kde[1] + 2;
 	}
 =

+	if (sm->handshake->support_ip_allocation &&
+			!sm->handshake->client_ip_addr) {
+		handshake_event(sm->handshake, HANDSHAKE_EVENT_IP_REQUEST);
+
+		if (!sm->handshake->client_ip_addr)
+			sm->handshake->support_ip_allocation =3D false;
+	}
+
 	if (sm->handshake->support_ip_allocation) {
 		/* Wi-Fi P2P Technical Specification v1.7 Table 59 */
 		key_data_buf[key_data_len++] =3D IE_TYPE_VENDOR_SPECIFIC;
diff --git a/src/handshake.h b/src/handshake.h
index a4c54b5a..1bc1b2fa 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -57,6 +57,7 @@ enum handshake_event {
 	HANDSHAKE_EVENT_REKEY_FAILED,
 	HANDSHAKE_EVENT_EAP_NOTIFY,
 	HANDSHAKE_EVENT_TRANSITION_DISABLE,
+	HANDSHAKE_EVENT_IP_REQUEST,
 };
 =

 typedef void (*handshake_event_func_t)(struct handshake_state *hs,
diff --git a/src/station.c b/src/station.c
index 3db0e65a..803db184 100644
--- a/src/station.c
+++ b/src/station.c
@@ -725,6 +725,7 @@ static void station_handshake_event(struct handshake_st=
ate *hs,
 	case HANDSHAKE_EVENT_COMPLETE:
 	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
 	case HANDSHAKE_EVENT_EAP_NOTIFY:
+	case HANDSHAKE_EVENT_IP_REQUEST:
 		/*
 		 * currently we don't care about any other events. The
 		 * netdev_connect_cb will notify us when the connection is
-- =

2.30.2

--===============9083570601755286415==--

