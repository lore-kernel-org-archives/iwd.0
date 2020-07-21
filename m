Content-Type: multipart/mixed; boundary="===============6251216244973380317=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/4] frame-xchg: Drop the BSSID check for incoming frames
Date: Tue, 21 Jul 2020 02:45:40 +0200
Message-ID: <20200721004540.399351-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200721004540.399351-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6251216244973380317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The BSSID (address_3) in response frames was being checked to be the
same as in the request frame, or all-zeros for faulty drivers.  At least
one Wi-Fi Display device sends a GO Negotiation Response with the BSSID
different from its Device Address (by 1 bit) and I didn't see an easy
way to obtain that address beforhand so we can "whitelist" it for this
check, so just drop that check for now.

ANQP didn't have this check before it started using frame-xchg so it
shouldn't be critical.
---
 src/frame-xchg.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 53bda4b4..3c1fc279 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -992,14 +992,11 @@ static bool frame_xchg_resp_handle(const struct mmpdu=
_header *mpdu,
 		return false;
 =

 	/*
-	 * Is the received frame's BSSID same as the transmitted frame's
-	 * BSSID, may have to be moved to the user callback if there are
-	 * usages where this is false.  Some drivers (brcmfmac) can't
-	 * report the BSSID so check for all-zeros too.
+	 * BSSID (address_3) check not practical because some Linux
+	 * drivers report all-zero values and some remote devices send
+	 * wrong addresses.  But the frame callback is free to perform
+	 * its own check.
 	 */
-	if (memcmp(mpdu->address_3, fx->tx_mpdu->address_3, 6) &&
-			!util_mem_is_zero(mpdu->address_3, 6))
-		return false;
 =

 	for (entry =3D l_queue_get_entries(fx->rx_watches);
 			entry; entry =3D entry->next) {
-- =

2.25.1

--===============6251216244973380317==--

