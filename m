Content-Type: multipart/mixed; boundary="===============1140732827908916828=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH] scan: don't send the same scan request twice
Date: Fri, 29 May 2020 15:54:51 +0200
Message-ID: <20200529135451.21290-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1140732827908916828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If start_scan_next_request() is called while a scan request
(NL80211_CMD_GET_SCAN) is still running, the same scan request will be
sent again by mistake. Add a check in the function to avoid sending a
request if one is already in progress.

This also fixes a crash that occurs if the following conditions are met:
  - the duplicated request is the only request in the scan request
    queue, and
  - both scan requests fail with an error not EBUSY.

In this case, the first callback to scan_request_triggered() will delete
the request from the scan request queue. The second callback will find
an empty queue and consequently pass a NULL scan_request pointer to
scan_request_failed(), causing a segmentation fault.
---
 src/scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 718f7497..106fa81c 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -839,6 +839,9 @@ static bool start_next_scan_request(struct scan_context=
 *sc)
 	if (sc->state !=3D SCAN_STATE_NOT_RUNNING)
 		return true;
 =

+	if (sc->start_cmd_id)
+		return true;
+
 	while (sr) {
 		if (!scan_request_send_trigger(sc, sr))
 			return true;
-- =

2.26.2

--===============1140732827908916828==--

