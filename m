Content-Type: multipart/mixed; boundary="===============4433452404744047012=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 3/7] scan: keep track of OWE Transition element
Date: Thu, 16 Sep 2021 09:30:42 -0700
Message-ID: <20210916163046.30817-3-prestwoj@gmail.com>
In-Reply-To: 20210916163046.30817-1-prestwoj@gmail.com

--===============4433452404744047012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 7 +++++++
 src/scan.h | 3 +++
 2 files changed, 10 insertions(+)

v3:
 * Store SSID length to handle non-utf8 SSIDs

diff --git a/src/scan.c b/src/scan.c
index 1224e18b..b2f199e5 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -936,6 +936,13 @@ static void scan_parse_vendor_specific(struct scan_bss=
 *bss, const void *data,
 		return;
 	}
 =

+	if (is_ie_wfa_ie(data, len, IE_WFA_OI_OWE_TRANSITION)) {
+		ie_parse_owe_transition(data - 2, len + 2, bss->owe_trans_bssid,
+					bss->owe_trans_ssid,
+					&bss->owe_trans_ssid_len);
+		return;
+	}
+
 	if (!ie_parse_network_cost(data, len, &cost_level, &cost_flags)) {
 		bss->cost_level =3D cost_level;
 		bss->cost_flags =3D cost_flags;
diff --git a/src/scan.h b/src/scan.h
index aa3974df..99c66bb8 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -76,6 +76,9 @@ struct scan_bss {
 	uint64_t parent_tsf;
 	uint8_t *wfd;		/* Concatenated WFD IEs */
 	ssize_t wfd_size;	/* Size of Concatenated WFD IEs */
+	uint8_t owe_trans_ssid[32];
+	size_t owe_trans_ssid_len;
+	uint8_t owe_trans_bssid[6];
 	bool mde_present : 1;
 	bool cc_present : 1;
 	bool cap_rm_neighbor_report : 1;
-- =

2.31.1

--===============4433452404744047012==--

