Content-Type: multipart/mixed; boundary="===============0520671270597077637=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/9] ap: Expire client's leases on disconnect
Date: Sat, 07 Aug 2021 04:10:46 +0200
Message-ID: <20210807021048.321664-7-andrew.zaborowski@intel.com>
In-Reply-To: <20210807021048.321664-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0520671270597077637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If netconfig is enabled tell the DHCP server to expire any leases owned
by the client that is disconnecting by using l_dhcp_server_expire_by_mac
to add the IPs back to the IP pool.  They're added to the expired list
so they'd only be used if there are no other addresses left in the pool
and can be reactivated if the client comes back before the address is
used by somebody else.

This should ensure that we're always able to offer an address to a new
client when there are fewer concurrent clients than addresses in the
configured subnet or IP range.
---
 src/ap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 052cd0c3..09fb2467 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -268,6 +268,17 @@ static void ap_del_station(struct sta_state *sta, uint=
16_t reason,
 =

 	ap_stop_handshake(sta);
 =

+	/*
+	 * Expire any DHCP leases owned by this client when it disconnects to
+	 * make it harder for somebody to DoS the IP pool.  If the client
+	 * comes back and the lease is still in the expired leases list they
+	 * will get their IP back.
+	 */
+	if (ap->netconfig_dhcp) {
+		sta->ip_alloc_lease =3D NULL;
+		l_dhcp_server_expire_by_mac(ap->netconfig_dhcp, sta->addr);
+	}
+
 	/*
 	 * If the event handler tears the AP down, we've made sure above that
 	 * a subsequent ap_sta_free(sta) has no need to access sta->ap.
-- =

2.30.2

--===============0520671270597077637==--

