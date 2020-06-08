Content-Type: multipart/mixed; boundary="===============0346574984230133998=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH v3] scan: refactor start_next_scan_request to not send
 duplicate requests
Date: Mon, 08 Jun 2020 10:42:07 +0200
Message-ID: <20200608084207.151665-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0346574984230133998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If start_scan_next_request() is called while a scan request
(NL80211_CMD_TRIGGER_SCAN) is still running, the same scan request will
be sent again. Add a check in the function to avoid sending a request if
one is already in progress. For consistency, check also that scan
results are not being requested (NL80211_CMD_GET_SCAN), before trying to
send the next scan request. Finally, remove similar checks at
start_next_scan_request() callsites to simplify the code.

This also fixes a crash that occurs if the following conditions are met:
  - the duplicated request is the only request in the scan request
    queue, and
  - both scan requests fail with an error not EBUSY.

In this case, the first callback to scan_request_triggered() will delete
the request from the scan request queue. The second callback will find
an empty queue and consequently pass a NULL scan_request pointer to
scan_request_failed(), causing a segmentation fault.
---
 src/scan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 8fc1f026..83804e57 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -842,6 +842,9 @@ static bool start_next_scan_request(struct scan_context=
 *sc)
 	if (sc->state !=3D SCAN_STATE_NOT_RUNNING)
 		return true;
 =

+	if (sc->start_cmd_id || sc->get_scan_cmd_id)
+		return true;
+
 	while (sr) {
 		if (!scan_request_send_trigger(sc, sr))
 			return true;
@@ -1668,7 +1671,7 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 			/* An external scan may have flushed our results */
 			if (sc->started && scan_parse_flush_flag_from_msg(msg))
 				scan_finished(sc, -EAGAIN, NULL, sr);
-			else if (sr && !sc->start_cmd_id)
+			else
 				send_next =3D true;
 =

 			sr =3D NULL;
@@ -1719,7 +1722,7 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 			sc->triggered =3D false;
 =

 			scan_finished(sc, -ECANCELED, NULL, sr);
-		} else if (sr && !sc->start_cmd_id && !sc->get_scan_cmd_id) {
+		} else {
 			/*
 			 * If this was an external scan that got aborted
 			 * we may be able to now queue our own scan although
-- =

2.26.2

--===============0346574984230133998==--

