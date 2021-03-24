Content-Type: multipart/mixed; boundary="===============0152999495523488404=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] doc: document AKMSuite diagnostic value
Date: Wed, 24 Mar 2021 16:05:35 -0700
Message-ID: <20210324230538.583325-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0152999495523488404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/station-diagnostic-api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/station-diagnostic-api.txt b/doc/station-diagnostic-api.txt
index b5a73b5d..6470fa56 100644
--- a/doc/station-diagnostic-api.txt
+++ b/doc/station-diagnostic-api.txt
@@ -23,6 +23,8 @@ Methods		dict GetDiagnostics()
 =

 			Frequency - Frequency of currently connected BSS.
 =

+			AKMSuite - The chosen AKM for the current connection.
+
 			RSSI [optional] - The RSSI of the currently connected BSS.
 =

 			AverageRSSI [optional] - Average RSSI of currently connected BSS.
-- =

2.26.2

--===============0152999495523488404==--

