Content-Type: multipart/mixed; boundary="===============7686783990426294406=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/6] rrm: include actual parent TSF value
Date: Wed, 20 Nov 2019 09:31:43 -0800
Message-ID: <20191120173146.21452-3-prestwoj@gmail.com>
In-Reply-To: <20191120173146.21452-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7686783990426294406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the scan results included a parent TSF value use it.
---
 src/rrm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/rrm.c b/src/rrm.c
index 73cf01f2..2b0a22fb 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -270,8 +270,13 @@ static size_t build_report_for_bss(struct rrm_beacon_r=
eq_info *beacon,
 	to +=3D 6;
 	/* Antenna identifier unknown */
 	*to++ =3D 0;
-	/* Parent TSF - zero */
-	memset(to, 0, 4);
+	/*
+	 * 802.11 9.4.2.22.7 Beacon report
+	 *
+	 * "The Parent TSF field contains the lower 4 octets of the measuring
+	 *  STA=E2=80=99s TSF timer value"
+	 */
+	l_put_le32((uint32_t)(bss->parent_tsf & 0xffffffff), to);
 	to +=3D 4;
 =

 	/*
-- =

2.17.1

--===============7686783990426294406==--

