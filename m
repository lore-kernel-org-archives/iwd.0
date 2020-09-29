Content-Type: multipart/mixed; boundary="===============5453037527746852724=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/6] p2p: Respond to Probe Requests when in discovery
Date: Tue, 29 Sep 2020 18:37:09 +0200
Message-ID: <20200929163717.754459-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5453037527746852724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since our DBus API and our use cases only support initiating connections
and not accepting incoming connections we don't really need to reply to
Probe Requests on the P2P-Device interface.  Start doing it firstly so
that we can test the scenario where we get discovered and pre-authorized
to connect in an autotest (wpa_supplicant doesn't seem to have a way to
authorize everyone, which is probably why most Wi-Fi Display dongles
don't do it and instead reply with "Fail: Information not available" and
then restart connection from their side) and secondly because the spec
wants us to do it.
---
 src/p2p.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 662fdb61..417ce3d6 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -3554,6 +3554,20 @@ static void p2p_device_send_probe_resp(struct p2p_de=
vice *dev,
 	resp_info.capability =3D dev->capability;
 	resp_info.device_info =3D dev->device_info;
 =

+	/*
+	 * Note the SSID and resp_info.group_clients are not updated with
+	 * our group information because we generally won't be in the
+	 * Listen State on the P2P Device when running a group.  Otherwise
+	 * we'd be sending two Probe Responses, one from the P2P Interface
+	 * and another from the P2P Device.  According to this part in
+	 * Wi-Fi P2P Technical Specification v1.7 section 3.2.2 it seems
+	 * only the P2P Interface is supposed to be sending Probe
+	 * Responses in that situation:
+	 * "In all Probe Responses that it sends, a P2P Group Owner shall
+	 * set the SSID to the SSID of the group, and shall set the SA and
+	 * BSSID to its P2P Interface Address."
+	 */
+
 	p2p_ie =3D p2p_build_probe_resp(&resp_info, &p2p_ie_size);
 	if (!p2p_ie) {
 		l_error("Can't build our Probe Response P2P IE");
@@ -3686,23 +3700,10 @@ static void p2p_device_probe_cb(const struct mmpdu_=
header *mpdu,
 	}
 =

 	/*
-	 * We don't currently have a use case for replying to Probe Requests
-	 * except when waiting for a GO Negotiation Request from our target
-	 * peer.  Some of those peers (seemingly running ancient and/or
-	 * hw-manufacturer-provided versions of wpa_s) will only send us GO
-	 * Negotiation Requests each time they receive our Probe Response
-	 * frame, even if that frame's body is unparsable.
+	 * TODO: use ap.c code to check if we match the SSID, BSSID, DSSS
+	 * Channel etc. in the Probe Request, and to build the Response body.
 	 */
-	if (from_conn_peer) {
-		/*
-		 * TODO: use ap.c code to check if we match the SSID, BSSID,
-		 * DSSS Channel etc. in the Probe Request, and to build the
-		 * Response body.
-		 */
-		p2p_device_send_probe_resp(dev, mpdu->address_2,
-						from_conn_peer);
-		goto p2p_free;
-	}
+	p2p_device_send_probe_resp(dev, mpdu->address_2, from_conn_peer);
 =

 	/*
 	 * The peer's listen frequency may be different from ours.
-- =

2.25.1

--===============5453037527746852724==--

