Content-Type: multipart/mixed; boundary="===============1564083842900196463=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] doc: add Frequency to station diagnostics
Date: Wed, 03 Feb 2021 09:20:43 -0800
Message-ID: <20210203172045.180677-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1564083842900196463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/station-diagnostic-api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/station-diagnostic-api.txt b/doc/station-diagnostic-api.txt
index 78f08ac1..af82229b 100644
--- a/doc/station-diagnostic-api.txt
+++ b/doc/station-diagnostic-api.txt
@@ -21,6 +21,8 @@ Methods		dict GetDiagnostics()
 =

 			ConnectedBss - MAC address of currently connected BSS.
 =

+			Frequency - Frequency of currently connected BSS.
+
 			RSSI [optional] - The RSSI of the currently connected BSS.
 =

 			RxMode [optional] -	The phy technology being used
-- =

2.26.2

--===============1564083842900196463==--

