Content-Type: multipart/mixed; boundary="===============6232058211547780255=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 08/13] station: add OWE_HIDDEN_STARTED/FINISHED events
Date: Wed, 15 Sep 2021 10:36:19 -0700
Message-ID: <20210915173624.11917-8-prestwoj@gmail.com>
In-Reply-To: 20210915173624.11917-1-prestwoj@gmail.com

--===============6232058211547780255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.h b/src/station.h
index fabdd922..67d22f03 100644
--- a/src/station.h
+++ b/src/station.h
@@ -48,6 +48,8 @@ enum station_state {
 enum station_event {
 	STATION_EVENT_ANQP_STARTED,
 	STATION_EVENT_ANQP_FINISHED,
+	STATION_EVENT_OWE_HIDDEN_STARTED,
+	STATION_EVENT_OWE_HIDDEN_FINISHED,
 };
 =

 typedef void (*station_foreach_func_t)(struct station *, void *data);
-- =

2.31.1

--===============6232058211547780255==--

