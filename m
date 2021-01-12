Content-Type: multipart/mixed; boundary="===============3304001294984054987=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 8/8] doc: update diagnostics with [optional] tags
Date: Tue, 12 Jan 2021 09:17:23 -0800
Message-ID: <20210112171723.3025-8-prestwoj@gmail.com>
In-Reply-To: <20210112171723.3025-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3304001294984054987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some elements, though unlikely, are not required to be included
with the GET_STATION call that GetDiagnostics relies on. mac80211
based drivers include most of these, but other drivers may not.
To be on the safe side all properties except ConnectedBss are now
optional and may not be included.
---
 doc/diagnostics.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/diagnostics.txt b/doc/diagnostics.txt
index c6d2aef0..f94ef6f8 100644
--- a/doc/diagnostics.txt
+++ b/doc/diagnostics.txt
@@ -21,15 +21,15 @@ Methods		dict GetDiagnostics()
 =

 			ConnectedBss - MAC address of currently connected BSS.
 =

-			RSSI -	The RSSI of the currently connected BSS.
+			RSSI [optional] - The RSSI of the currently connected BSS.
 =

-			RxRate - Receive rate in 100kbit/s
+			RxRate [optional] - Receive rate in 100kbit/s
 =

-			RxMCS - Receiving MCS index
+			RxMCS [optional] - Receiving MCS index
 =

-			TxRate - Transmission rate in 100kbit/s
+			TxRate [optional] - Transmission rate in 100kbit/s
 =

-			TxMCS - Transmitting MCS index
+			TxMCS [optional] - Transmitting MCS index
 =

 			Possible errors: net.connman.iwd.Busy
 					 net.connman.iwd.Failed
-- =

2.26.2

--===============3304001294984054987==--

