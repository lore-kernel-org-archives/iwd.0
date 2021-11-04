Content-Type: multipart/mixed; boundary="===============3820700684231097712=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/5] scan: keep track of HS20 DGAF Disable bit in scan_bss
Date: Thu, 04 Nov 2021 10:57:56 -0700
Message-ID: <20211104175758.532953-3-prestwoj@gmail.com>
In-Reply-To: 20211104175758.532953-1-prestwoj@gmail.com

--===============3820700684231097712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 4 +++-
 src/scan.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index 815cb3f2..da7d129f 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1058,6 +1058,7 @@ static void scan_parse_vendor_specific(struct scan_bs=
s *bss, const void *data,
 {
 	uint16_t cost_level;
 	uint16_t cost_flags;
+	bool dgaf_disable;
 =

 	if (!bss->wpa && is_ie_wpa_ie(data, len)) {
 		bss->wpa =3D l_memdup(data - 2, len + 2);
@@ -1072,9 +1073,10 @@ static void scan_parse_vendor_specific(struct scan_b=
ss *bss, const void *data,
 	if (is_ie_wfa_ie(data, len, IE_WFA_OI_HS20_INDICATION)) {
 		if (ie_parse_hs20_indication_from_data(data - 2, len + 2,
 					&bss->hs20_version, NULL, NULL,
-					NULL) < 0)
+					&dgaf_disable) < 0)
 			return;
 =

+		bss->hs20_dgaf_disable =3D dgaf_disable;
 		bss->hs20_capable =3D true;
 		return;
 	}
diff --git a/src/scan.h b/src/scan.h
index 0378ccca..2920a1d2 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -87,6 +87,7 @@ struct scan_bss {
 	bool hs20_capable : 1;
 	bool force_default_sae_group : 1;
 	bool proxy_arp : 1;
+	bool hs20_dgaf_disable : 1;
 	uint8_t cost_level : 3;
 	uint8_t cost_flags : 4;
 };
-- =

2.31.1

--===============3820700684231097712==--

