Content-Type: multipart/mixed; boundary="===============7272343107503397215=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: fix leak on parse_neighbor_report
Date: Fri, 29 Jan 2021 15:21:07 -0800
Message-ID: <20210129232107.129592-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7272343107503397215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 55368472..14a3d171 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1998,8 +1998,11 @@ static void parse_neighbor_report(struct station *st=
ation,
 		scan_freq_set_add(freq_set_no_md, current_freq);
 		*set =3D freq_set_no_md;
 		scan_freq_set_free(freq_set_md);
-	} else
+	} else {
+		scan_freq_set_free(freq_set_no_md);
+		scan_freq_set_free(freq_set_md);
 		*set =3D NULL;
+	}
 }
 =

 static void station_neighbor_report_cb(struct netdev *netdev, int err,
-- =

2.26.2

--===============7272343107503397215==--

