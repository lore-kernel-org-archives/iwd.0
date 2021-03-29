Content-Type: multipart/mixed; boundary="===============8141796916690276444=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] doc: document Security diagnostic value
Date: Mon, 29 Mar 2021 10:33:07 -0700
Message-ID: <20210329173310.706671-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8141796916690276444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/station-diagnostic-api.txt | 2 ++
 1 file changed, 2 insertions(+)

v3:
 * Updated AKMSuite to Security

diff --git a/doc/station-diagnostic-api.txt b/doc/station-diagnostic-api.txt
index b5a73b5d..d1a340ad 100644
--- a/doc/station-diagnostic-api.txt
+++ b/doc/station-diagnostic-api.txt
@@ -23,6 +23,8 @@ Methods		dict GetDiagnostics()
 =

 			Frequency - Frequency of currently connected BSS.
 =

+			Security - The chosen security for the connection.
+
 			RSSI [optional] - The RSSI of the currently connected BSS.
 =

 			AverageRSSI [optional] - Average RSSI of currently connected BSS.
-- =

2.26.2

--===============8141796916690276444==--

