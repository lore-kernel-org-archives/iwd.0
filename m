Content-Type: multipart/mixed; boundary="===============8824239469993069228=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 12/17] ap: Accept P2P wildcard SSIDs in probe requests
Date: Wed, 09 Sep 2020 01:49:28 +0200
Message-ID: <20200908234933.301439-12-andrew.zaborowski@intel.com>
In-Reply-To: <20200908234933.301439-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8824239469993069228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the special case "DIRECT-" SSID, called the P2P Wildcard SSID, in
ap_probe_req_cb so as not to reject those Probe Requests on the basis of
ssid mismatch.  I'd have preferred to keep all the P2P-specific bits in
p2p.c but in this case there's little point in adding a generic
config setting for SSID-matching quirks.
---
 src/ap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index fab7c20e..3579d30f 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1683,6 +1683,9 @@ static void ap_probe_req_cb(const struct mmpdu_header=
 *hdr, const void *body,
 	else if (ssid && ssid_len =3D=3D strlen(ap->config->ssid) && /* One SSID =
*/
 			!memcmp(ssid, ap->config->ssid, ssid_len))
 		match =3D true;
+	else if (ssid && ssid_len =3D=3D 7 && !memcmp(ssid, "DIRECT-", 7) &&
+			!memcmp(ssid, ap->config->ssid, 7)) /* P2P wildcard */
+		match =3D true;
 	else if (ssid_list) { /* SSID List */
 		ie_tlv_iter_init(&iter, ssid_list, ssid_list_len);
 =

-- =

2.25.1

--===============8824239469993069228==--

