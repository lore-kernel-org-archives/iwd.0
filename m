Content-Type: multipart/mixed; boundary="===============0700843471218411893=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 5/5] doc: add RateType's on diagnostic interface
Date: Thu, 14 Jan 2021 10:58:33 -0800
Message-ID: <20210114185833.76477-5-prestwoj@gmail.com>
In-Reply-To: <20210114185833.76477-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0700843471218411893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/diagnostics.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/diagnostics.txt b/doc/diagnostics.txt
index f94ef6f8..630af503 100644
--- a/doc/diagnostics.txt
+++ b/doc/diagnostics.txt
@@ -23,10 +23,19 @@ Methods		dict GetDiagnostics()
 =

 			RSSI [optional] - The RSSI of the currently connected BSS.
 =

+			RxRateType -	The phy technology being use (Legacy, 802.11n,
+					802.11ac or 802.11ax). The MCS values (not
+					present in Legacy case) have a different
+					meaning depending on RateType, e.g. 802.11n
+					will use HT MCS values, 802.11ac use VHT etc.
+
 			RxRate [optional] - Receive rate in 100kbit/s
 =

 			RxMCS [optional] - Receiving MCS index
 =

+			TxRateType -	Same meaning as RxRateType, just for
+					transmission.
+
 			TxRate [optional] - Transmission rate in 100kbit/s
 =

 			TxMCS [optional] - Transmitting MCS index
-- =

2.26.2

--===============0700843471218411893==--

