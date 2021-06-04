Content-Type: multipart/mixed; boundary="===============0609405951250715914=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/15] p2p: As GO delay connect success until client gets IP
Date: Fri, 04 Jun 2021 03:50:47 +0200
Message-ID: <20210604015052.163727-10-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0609405951250715914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Don't signal the connected state until the client has obtained a DHCP
lease and we can set the ConnectedIP property.  From now on that
property is always set when there's a connection.
---
 src/p2p.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 22ce7042..c7c8d785 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -659,10 +659,11 @@ static void p2p_connection_reset(struct p2p_device *d=
ev)
 		netconfig_destroy(dev->conn_netconfig);
 		dev->conn_netconfig =3D NULL;
 		l_settings_free(dev->conn_netconfig_settings);
-		l_free(dev->conn_peer_ip);
-		dev->conn_peer_ip =3D NULL;
 	}
 =

+	l_free(dev->conn_peer_ip);
+	dev->conn_peer_ip =3D NULL;
+
 	if (dev->conn_new_intf_cmd_id)
 		/*
 		 * Note this may result in the interface being created
@@ -948,8 +949,8 @@ static void p2p_group_event(enum ap_event_type type, co=
nst void *event_data,
 			p2p_extract_wfd_properties(wfd_data, wfd_data_len,
 							dev->conn_peer->wfd);
 =

-		dev->conn_peer_added =3D true;
-		p2p_peer_connect_done(dev);
+		/* Setup is progressing so re-arm the timeout */
+		l_timeout_modify(dev->conn_dhcp_timeout, p2p_dhcp_timeout_val);
 		break;
 	}
 =

@@ -968,6 +969,28 @@ static void p2p_group_event(enum ap_event_type type, c=
onst void *event_data,
 		break;
 	case AP_EVENT_PBC_MODE_EXIT:
 		break;
+
+	case AP_EVENT_DHCP_NEW_LEASE:
+	{
+		const struct l_dhcp_lease *lease =3D event_data;
+
+		if (dev->conn_peer_added)
+			break;
+
+		dev->conn_peer_added =3D true;
+		dev->conn_peer_ip =3D l_dhcp_lease_get_address(lease);
+		l_timeout_remove(dev->conn_dhcp_timeout);
+		p2p_peer_connect_done(dev);
+		break;
+	}
+
+	case AP_EVENT_DHCP_LEASE_EXPIRED:
+		/*
+		 * Only one DHCP lease allowed for now, as soon as it expires
+		 * the connection is considered to be down.
+		 */
+		p2p_connect_failed(dev);
+		break;
 	};
 =

 	return;
@@ -1242,7 +1265,8 @@ static void p2p_group_start(struct p2p_device *dev)
 =

 	l_settings_set_bytes(config, "Security", "PreSharedKey", psk, 32);
 =

-	l_settings_add_group(config, "IPv4");
+	/* Enable netconfig, set maximum usable DHCP lease time */
+	l_settings_set_uint(config, "IPv4", "LeaseTime", 0x7fffffff);
 =

 	dev->capability.group_caps |=3D P2P_GROUP_CAP_GO;
 	dev->capability.group_caps |=3D P2P_GROUP_CAP_GROUP_FORMATION;
@@ -4757,7 +4781,7 @@ static bool p2p_peer_get_connected_ip(struct l_dbus *=
dbus,
 {
 	struct p2p_peer *peer =3D user_data;
 =

-	if (!p2p_peer_operational(peer) || !peer->dev->conn_peer_ip)
+	if (!p2p_peer_operational(peer))
 		return false;
 =

 	l_dbus_message_builder_append_basic(builder, 's', peer->dev->conn_peer_ip=
);
-- =

2.30.2

--===============0609405951250715914==--

