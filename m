Content-Type: multipart/mixed; boundary="===============4683997272788119687=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/9] ie: add OCI support in build_fast_bss_transition
Date: Mon, 27 Sep 2021 10:03:57 -0700
Message-ID: <20210927170404.1292107-2-prestwoj@gmail.com>
In-Reply-To: 20210927170404.1292107-1-prestwoj@gmail.com

--===============4683997272788119687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ie.c | 7 +++++++
 src/ie.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index 7d5222ae..11746c5c 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1870,6 +1870,13 @@ bool ie_build_fast_bss_transition(const struct ie_ft=
_info *info,
 =

 	L_WARN_ON(info->igtk_len); /* Not implemented */
 =

+	if (info->oci_present) {
+		to[0] =3D 5;
+		to[1] =3D 3;
+		memcpy(to + 2, info->oci, sizeof(info->oci));
+		*len +=3D 5;
+	}
+
 	return true;
 }
 =

diff --git a/src/ie.h b/src/ie.h
index c912d6c3..f6b15abb 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -435,6 +435,8 @@ struct ie_ft_info {
 	uint8_t igtk_ipn[6];
 	uint8_t igtk_len;
 	uint8_t igtk[24];
+	bool oci_present:1;
+	uint8_t oci[3];
 };
 =

 /* See chapter 8.4.2.47 for radio measurement capability details */
-- =

2.31.1

--===============4683997272788119687==--

