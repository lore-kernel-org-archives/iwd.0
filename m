Content-Type: multipart/mixed; boundary="===============1034636538063899870=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 5/5] doc: add RateType's on diagnostic interface
Date: Thu, 14 Jan 2021 12:54:42 -0800
Message-ID: <20210114205442.84552-5-prestwoj@gmail.com>
In-Reply-To: <20210114205442.84552-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1034636538063899870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/diagnostics.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/diagnostics.txt b/doc/diagnostics.txt
index f94ef6f8..10bf470b 100644
--- a/doc/diagnostics.txt
+++ b/doc/diagnostics.txt
@@ -23,10 +23,16 @@ Methods		dict GetDiagnostics()
 =

 			RSSI [optional] - The RSSI of the currently connected BSS.
 =

+			RxMode [optional] -	The phy technology being used
+						(802.11n, 802.11ac or 802.11ax).
+
 			RxRate [optional] - Receive rate in 100kbit/s
 =

 			RxMCS [optional] - Receiving MCS index
 =

+			TxMode [optional] -	Same meaning as RxMode, just for
+						transmission.
+
 			TxRate [optional] - Transmission rate in 100kbit/s
 =

 			TxMCS [optional] - Transmitting MCS index
-- =

2.26.2

--===============1034636538063899870==--

