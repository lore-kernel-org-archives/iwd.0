Content-Type: multipart/mixed; boundary="===============3801787805900333366=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3] p2p: Build our Probe Response using connection data
Date: Tue, 25 Aug 2020 04:45:34 +0200
Message-ID: <20200825024534.484304-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200825024534.484304-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3801787805900333366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When we're sending our probe response to the same peer that we're
currently connected or connecting to, use current WSC Configuration
Methods, UUID-E and WFD IE selected for this connection attempt, not the
ones we'd use when discovering peers or being discovered by peers.
In the case of the WFD IE, the "Available for WFD Session" flag is going
to differ between the two cases -- we may be unavailable for other peers
but we're still available for the peer we're trying to start the WFD
session with.
---
 src/p2p.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index f8ed88db..34ff94bf 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -3115,7 +3115,8 @@ static void p2p_probe_resp_done(int error, void *user=
_data)
 }
 =

 static void p2p_device_send_probe_resp(struct p2p_device *dev,
-					const uint8_t *dest_addr)
+					const uint8_t *dest_addr,
+					bool to_conn_peer)
 {
 	uint8_t resp_buf[64] __attribute__ ((aligned));
 	size_t resp_len =3D 0;
@@ -3181,14 +3182,21 @@ static void p2p_device_send_probe_resp(struct p2p_d=
evice *dev,
 		return;
 	}
 =

-	wsc_info.state =3D WSC_STATE_CONFIGURED;
-	wsc_info.response_type =3D WSC_RESPONSE_TYPE_ENROLLEE_OPEN_8021X;
-	wsc_info.uuid_e[15] =3D 0x01;
+	if (to_conn_peer) {
+		wsc_info.device_password_id =3D dev->conn_password_id;
+		wsc_info.config_methods =3D dev->conn_config_method;
+		wsc_uuid_from_addr(dev->conn_addr, wsc_info.uuid_e);
+	} else {
+		wsc_info.config_methods =3D dev->device_info.wsc_config_methods;
+		wsc_uuid_from_addr(dev->addr, wsc_info.uuid_e);
+	}
+
+	wsc_info.state =3D WSC_STATE_NOT_CONFIGURED;
+	wsc_info.response_type =3D WSC_RESPONSE_TYPE_ENROLLEE_INFO;
 	wsc_info.serial_number[0] =3D '0';
 	wsc_info.primary_device_type =3D dev->device_info.primary_device_type;
 	l_strlcpy(wsc_info.device_name, dev->device_info.device_name,
 			sizeof(wsc_info.device_name));
-	wsc_info.config_methods =3D dev->device_info.wsc_config_methods;
 	wsc_info.rf_bands =3D 0x01;	/* 2.4GHz */
 	wsc_info.version2 =3D true;
 =

@@ -3220,7 +3228,12 @@ static void p2p_device_send_probe_resp(struct p2p_de=
vice *dev,
 	iov[iov_len].iov_len =3D wsc_ie_size;
 	iov_len++;
 =

-	if (p2p_own_wfd) {
+	if (to_conn_peer && dev->conn_own_wfd) {
+		iov[iov_len].iov_base =3D wfd_ie;
+		iov[iov_len].iov_len =3D p2p_build_wfd_ie(dev->conn_own_wfd,
+							wfd_ie);
+		iov_len++;
+	} else if (p2p_own_wfd) {
 		iov[iov_len].iov_base =3D wfd_ie;
 		iov[iov_len].iov_len =3D p2p_build_wfd_ie(p2p_own_wfd, wfd_ie);
 		iov_len++;
@@ -3308,7 +3321,8 @@ static void p2p_device_probe_cb(const struct mmpdu_he=
ader *mpdu,
 		 * DSSS Channel etc. in the Probe Request, and to build the
 		 * Response body.
 		 */
-		p2p_device_send_probe_resp(dev, mpdu->address_2);
+		p2p_device_send_probe_resp(dev, mpdu->address_2,
+						from_conn_peer);
 		goto p2p_free;
 	}
 =

-- =

2.25.1

--===============3801787805900333366==--

