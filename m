Content-Type: multipart/mixed; boundary="===============7433540518227033262=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 1/3] station: send debug "roam-scan-triggered" event
Date: Wed, 19 Jan 2022 14:26:50 -0800
Message-ID: <20220119222652.2299217-1-prestwoj@gmail.com>

--===============7433540518227033262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.c b/src/station.c
index 38d0757c..d9eb8d09 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2246,6 +2246,8 @@ static void station_roam_scan_triggered(int err, void=
 *user_data)
 		return;
 	}
 =

+	station_debug_event(station, "roam-scan-triggered");
+
 	/*
 	 * Do not update the Scanning property as we won't be updating the
 	 * list of networks.
-- =

2.31.1

--===============7433540518227033262==--

