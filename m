Content-Type: multipart/mixed; boundary="===============1192343006388639355=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] p2p: Fix adding peers from Probe Request info
Date: Tue, 29 Sep 2020 18:37:08 +0200
Message-ID: <20200929163717.754459-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1192343006388639355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure dev->peer_list is non-NULL before using l_queue_push_tail()
same as we do when the peer info comes from a Probe Response (active
scan in Find Phase).  Otherwise peers discovered through Probe Requests
before any Probe Responses are received will be lost.
---
 src/p2p.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index 6182cda9..662fdb61 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -3747,6 +3747,9 @@ static void p2p_device_probe_cb(const struct mmpdu_he=
ader *mpdu,
 	 */
 	peer->device_addr =3D bss->addr;
 =

+	if (!dev->peer_list)
+		dev->peer_list =3D l_queue_new();
+
 	if (!p2p_device_peer_add(dev, peer))
 		p2p_peer_free(peer);
 =

-- =

2.25.1

--===============1192343006388639355==--

