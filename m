Content-Type: multipart/mixed; boundary="===============2627846191518074799=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] doc: document new AverageRSSI diagnostics key
Date: Tue, 16 Mar 2021 08:38:33 -0700
Message-ID: <20210316153836.218175-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2627846191518074799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/station-diagnostic-api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/station-diagnostic-api.txt b/doc/station-diagnostic-api.txt
index af82229b..b5a73b5d 100644
--- a/doc/station-diagnostic-api.txt
+++ b/doc/station-diagnostic-api.txt
@@ -25,6 +25,8 @@ Methods		dict GetDiagnostics()
 =

 			RSSI [optional] - The RSSI of the currently connected BSS.
 =

+			AverageRSSI [optional] - Average RSSI of currently connected BSS.
+
 			RxMode [optional] -	The phy technology being used
 						(802.11n, 802.11ac or 802.11ax).
 =

-- =

2.26.2

--===============2627846191518074799==--

