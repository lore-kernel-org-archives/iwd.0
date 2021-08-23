Content-Type: multipart/mixed; boundary="===============1441522365713364080=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/9] handshake: Add HANDSHAKE_EVENT_P2P_IP_REQUEST
Date: Mon, 23 Aug 2021 16:14:22 +0200
Message-ID: <20210823141430.223543-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1441522365713364080==
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
 src/eapol.c     | 17 +++++++++++++++++
 src/handshake.h |  1 +
 src/station.c   |  1 +
 3 files changed, 19 insertions(+)

diff --git a/src/eapol.c b/src/eapol.c
index f78bef2f..5a3ef7a0 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1350,6 +1350,23 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *s=
m)
 		key_data_len +=3D gtk_kde[1] + 2;
 	}
 =

+	if (sm->handshake->support_ip_allocation &&
+			!sm->handshake->client_ip_addr) {
+		handshake_event(sm->handshake, HANDSHAKE_EVENT_P2P_IP_REQUEST);
+
+		/*
+		 * If .support_ip_allocation was set, the
+		 * HANDSHAKE_EVENT_P2P_IP_REQUEST handler is expected to set
+		 * .client_ip_addr if not already set.  Check if the handler
+		 * was successful in allocating an address, if it wasn't we'll
+		 * just skip the IP Address Allocation KDE.  In either case if
+		 * we need to resend message 3/4 the event callback won't be
+		 * triggered again because the condition above will be false.
+		 */
+		if (!sm->handshake->client_ip_addr)
+			sm->handshake->support_ip_allocation =3D false;
+	}
+
 	if (sm->handshake->support_ip_allocation) {
 		/* Wi-Fi P2P Technical Specification v1.7 Table 59 */
 		key_data_buf[key_data_len++] =3D IE_TYPE_VENDOR_SPECIFIC;
diff --git a/src/handshake.h b/src/handshake.h
index a4c54b5a..31dce117 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -57,6 +57,7 @@ enum handshake_event {
 	HANDSHAKE_EVENT_REKEY_FAILED,
 	HANDSHAKE_EVENT_EAP_NOTIFY,
 	HANDSHAKE_EVENT_TRANSITION_DISABLE,
+	HANDSHAKE_EVENT_P2P_IP_REQUEST,
 };
 =

 typedef void (*handshake_event_func_t)(struct handshake_state *hs,
diff --git a/src/station.c b/src/station.c
index d3482e2c..d61e775a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -753,6 +753,7 @@ static void station_handshake_event(struct handshake_st=
ate *hs,
 	case HANDSHAKE_EVENT_COMPLETE:
 	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
 	case HANDSHAKE_EVENT_EAP_NOTIFY:
+	case HANDSHAKE_EVENT_P2P_IP_REQUEST:
 		/*
 		 * currently we don't care about any other events. The
 		 * netdev_connect_cb will notify us when the connection is
-- =

2.30.2

--===============1441522365713364080==--

