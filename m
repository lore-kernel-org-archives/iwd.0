Content-Type: multipart/mixed; boundary="===============1718542187841113507=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] scan: use signal strength if bss ranks are equal
Date: Mon, 08 Nov 2021 11:39:29 -0800
Message-ID: <20211108193930.1013040-1-prestwoj@gmail.com>

--===============1718542187841113507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If two BSS's end up with the same rank sort them based on signal
strength so IWD still prefers the higher strength BSS.
---
 src/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index da7d129f..38a15c11 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1628,6 +1628,10 @@ int scan_bss_rank_compare(const void *a, const void =
*b, void *user_data)
 {
 	const struct scan_bss *new_bss =3D a, *bss =3D b;
 =

+	if (bss->rank =3D=3D new_bss->rank)
+		return (bss->signal_strength >
+					new_bss->signal_strength) ? 1 : -1;
+
 	return (bss->rank > new_bss->rank) ? 1 : -1;
 }
 =

-- =

2.31.1

--===============1718542187841113507==--

