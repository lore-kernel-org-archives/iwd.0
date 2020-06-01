Content-Type: multipart/mixed; boundary="===============4116669235707536026=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH v2 2/2] scan: refactor scan_common to not scan while scanning
 is suspended
Date: Mon, 01 Jun 2020 19:11:17 +0200
Message-ID: <20200601171117.122574-2-alsi@bang-olufsen.dk>
In-Reply-To: <20200601171117.122574-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4116669235707536026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If scanning is suspended, have scan_common() queue its scan request
rather than issuing it immediately. This respects the assumption that
scans are not requested while sc->suspended is true.
---
 src/scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 106fa81c..e10c5447 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -546,6 +546,9 @@ static uint32_t scan_common(uint64_t wdev_id, bool pass=
ive,
 	if (!l_queue_isempty(sc->requests))
 		goto done;
 =

+	if (sc->suspended)
+		goto done;
+
 	if (sc->state !=3D SCAN_STATE_NOT_RUNNING)
 		goto done;
 =

-- =

2.26.2

--===============4116669235707536026==--

