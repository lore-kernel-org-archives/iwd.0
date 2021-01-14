Content-Type: multipart/mixed; boundary="===============8807584362610164381=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 4/5] test: update get-diagnostics with RateTypes
Date: Thu, 14 Jan 2021 10:58:32 -0800
Message-ID: <20210114185833.76477-4-prestwoj@gmail.com>
In-Reply-To: <20210114185833.76477-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8807584362610164381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/get-diagnostics | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/get-diagnostics b/test/get-diagnostics
index 7cb777b3..6596955a 100755
--- a/test/get-diagnostics
+++ b/test/get-diagnostics
@@ -8,8 +8,10 @@ import dbus
 unit_map =3D {
     "ConnectedBss" : None,
     "RSSI" : "dBm",
+    "RxRateType" : None,
     "RxBitrate" : lambda k : str(100 * int(k)) + ' Kbps',
     "RxMCS" : lambda i : str(int(i)),
+    "TxRateType" : None,
     "TxBitrate" : lambda k : str(100 * int(k)) + ' Kbps',
     "TxMCS" : lambda i : str(int(i)),
     "ExpectedThroughput" : "Kbps"
-- =

2.26.2

--===============8807584362610164381==--

