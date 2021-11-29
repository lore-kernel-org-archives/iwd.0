Content-Type: multipart/mixed; boundary="===============8506135765700601154=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/6] scan: parse configurator connectivity element
Date: Mon, 29 Nov 2021 15:12:56 -0800
Message-ID: <20211129231300.108873-2-prestwoj@gmail.com>
In-Reply-To: 20211129231300.108873-1-prestwoj@gmail.com

--===============8506135765700601154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This element has no data and indicates the AP supports configuring
stations via DPP while also serving current stations.
---
 src/scan.c | 3 +++
 src/scan.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 38a15c11..b602c8be 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1097,6 +1097,9 @@ static void scan_parse_vendor_specific(struct scan_bs=
s *bss, const void *data,
 		return;
 	}
 =

+	if (is_ie_wfa_ie(data, len, IE_WFA_OI_CONFIGURATOR_CONNECTIVITY))
+		bss->dpp_configurator =3D true;
+
 	if (!ie_parse_network_cost(data, len, &cost_level, &cost_flags)) {
 		bss->cost_level =3D cost_level;
 		bss->cost_flags =3D cost_flags;
diff --git a/src/scan.h b/src/scan.h
index 2920a1d2..66e38410 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -90,6 +90,7 @@ struct scan_bss {
 	bool hs20_dgaf_disable : 1;
 	uint8_t cost_level : 3;
 	uint8_t cost_flags : 4;
+	bool dpp_configurator : 1;
 };
 =

 struct scan_parameters {
-- =

2.31.1

--===============8506135765700601154==--

