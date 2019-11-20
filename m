Content-Type: multipart/mixed; boundary="===============4322351811442161505=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/6] rrm: include actual scan start time in report
Date: Wed, 20 Nov 2019 09:31:45 -0800
Message-ID: <20191120173146.21452-5-prestwoj@gmail.com>
In-Reply-To: <20191120173146.21452-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4322351811442161505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/rrm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/rrm.c b/src/rrm.c
index 2b0a22fb..a231f7e9 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -249,8 +249,7 @@ static size_t build_report_for_bss(struct rrm_beacon_re=
q_info *beacon,
 =

 	*to++ =3D beacon->oper_class;
 	*to++ =3D scan_freq_to_channel(bss->frequency, NULL);
-	/* skip start time */
-	memset(to, 0, 8);
+	l_put_le64(bss->start_time_tsf, to);
 	to +=3D 8;
 	l_put_le16(beacon->duration, to);
 	to +=3D 2;
-- =

2.17.1

--===============4322351811442161505==--

