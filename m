Content-Type: multipart/mixed; boundary="===============6593335281933723555=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/7] scan: keep track of OWE Transition element
Date: Wed, 15 Sep 2021 16:05:43 -0700
Message-ID: <20210915230548.179425-2-prestwoj@gmail.com>
In-Reply-To: 20210915230548.179425-1-prestwoj@gmail.com

--===============6593335281933723555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 6 ++++++
 src/scan.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index cdc14dbd..5e31c308 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -936,6 +936,12 @@ static void scan_parse_vendor_specific(struct scan_bss=
 *bss, const void *data,
 		return;
 	}
 =

+	if (is_ie_wfa_ie(data, len, IE_WFA_OI_OWE_TRANSITION)) {
+		ie_parse_owe_transition(data - 2, len + 2, bss->owe_trans_bssid,
+					bss->owe_trans_ssid);
+		return;
+	}
+
 	if (!ie_parse_network_cost(data, len, &cost_level, &cost_flags)) {
 		bss->cost_level =3D cost_level;
 		bss->cost_flags =3D cost_flags;
diff --git a/src/scan.h b/src/scan.h
index be8912e6..23de472b 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -76,6 +76,8 @@ struct scan_bss {
 	uint64_t parent_tsf;
 	uint8_t *wfd;		/* Concatenated WFD IEs */
 	ssize_t wfd_size;	/* Size of Concatenated WFD IEs */
+	char owe_trans_ssid[33];
+	uint8_t owe_trans_bssid[6];
 	bool mde_present : 1;
 	bool cc_present : 1;
 	bool cap_rm_neighbor_report : 1;
-- =

2.31.1

--===============6593335281933723555==--

