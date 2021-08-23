Content-Type: multipart/mixed; boundary="===============8252173641987503135=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/9] ap: Expire client's leases on disconnect
Date: Mon, 23 Aug 2021 16:14:25 +0200
Message-ID: <20210823141430.223543-4-andrew.zaborowski@intel.com>
In-Reply-To: <20210823141430.223543-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8252173641987503135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If netconfig is enabled tell the DHCP server to expire any leases owned
by the client that is disconnecting by using l_dhcp_server_expire_by_mac
to return the IPs to the IP pool.  They're added to the expired list
so they'd only be used if there are no other addresses left in the pool
and can be reactivated if the client comes back before the address is
used by somebody else.

This should ensure that we're always able to offer an address to a new
client as long as there are fewer concurrent clients than addresses in
the configured subnet or IP range.
---
 src/ap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index c4473c66..e91f8b00 100644
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

--===============8252173641987503135==--

