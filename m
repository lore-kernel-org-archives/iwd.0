Content-Type: multipart/mixed; boundary="===============5059138065155861106=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 3/4] rrm: fix non-ascii character in comment
Date: Thu, 21 Nov 2019 12:09:00 -0800
Message-ID: <20191121200901.25826-3-prestwoj@gmail.com>
In-Reply-To: <20191121200901.25826-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5059138065155861106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/rrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rrm.c b/src/rrm.c
index ca30a7f7..660565eb 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -274,7 +274,7 @@ static size_t build_report_for_bss(struct rrm_beacon_re=
q_info *beacon,
 	 * 802.11 9.4.2.22.7 Beacon report
 	 *
 	 * "The Parent TSF field contains the lower 4 octets of the measuring
-	 *  STA=E2=80=99s TSF timer value"
+	 *  STA's TSF timer value"
 	 */
 	l_put_le32((uint32_t)(bss->parent_tsf & 0xffffffff), to);
 	to +=3D 4;
-- =

2.17.1

--===============5059138065155861106==--

