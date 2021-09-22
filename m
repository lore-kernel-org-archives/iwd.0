Content-Type: multipart/mixed; boundary="===============3111088601462257545=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/4] scan: validate OWE transition operating class/channel
Date: Wed, 22 Sep 2021 12:34:16 -0700
Message-ID: <20210922193418.13072-2-prestwoj@gmail.com>
In-Reply-To: 20210922193418.13072-1-prestwoj@gmail.com

--===============3111088601462257545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the IE's operating class and channel doesn't validate don't bother
storing the IE at all.
---
 src/scan.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 54a7bc84..3f36ea3e 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1063,11 +1063,19 @@ static void scan_parse_vendor_specific(struct scan_=
bss *bss, const void *data,
 		bss->owe_trans =3D l_new(struct ie_owe_transition_info, 1);
 =

 		if (ie_parse_owe_transition(data - 2, len + 2,
-						bss->owe_trans) < 0) {
-			l_free(bss->owe_trans);
-			bss->owe_trans =3D NULL;
-		}
+						bss->owe_trans) < 0)
+			goto free_owe_trans;
+
+		if (bss->owe_trans->oper_class && oci_to_frequency(
+						bss->owe_trans->oper_class,
+						bss->owe_trans->channel) < 0)
+			goto free_owe_trans;
+
+		return;
 =

+free_owe_trans:
+		l_free(bss->owe_trans);
+		bss->owe_trans =3D NULL;
 		return;
 	}
 =

-- =

2.31.1

--===============3111088601462257545==--

