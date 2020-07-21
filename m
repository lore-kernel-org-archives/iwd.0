Content-Type: multipart/mixed; boundary="===============5840079940884074804=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] p2p: Update call after frame-xchg changes
Date: Tue, 21 Jul 2020 02:45:38 +0200
Message-ID: <20200721004540.399351-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200721004540.399351-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5840079940884074804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index 92e3c65d..58027fc6 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -3186,7 +3186,7 @@ static void p2p_device_send_probe_resp(struct p2p_dev=
ice *dev,
 =

 	freq =3D scan_channel_to_freq(dev->listen_channel, SCAN_BAND_2_4_GHZ);
 	frame_xchg_start(dev->wdev_id, iov, freq, 0, 0, false, 0,
-				p2p_probe_resp_done, dev, NULL);
+				p2p_probe_resp_done, dev, NULL, NULL);
 	l_debug("Probe Response tx queued");
 =

 	l_free(p2p_ie);
-- =

2.25.1

--===============5840079940884074804==--

