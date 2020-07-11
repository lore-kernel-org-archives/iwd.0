Content-Type: multipart/mixed; boundary="===============7200461304949855522=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/18] scan: Extract WFD IE payload into struct bss
Date: Sat, 11 Jul 2020 03:00:43 +0200
Message-ID: <20200711010053.224223-8-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7200461304949855522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 2 ++
 src/scan.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 673200ae..d131b1f4 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1102,6 +1102,8 @@ static bool scan_parse_bss_information_elements(struc=
t scan_bss *bss,
 	}
 	}
 =

+	bss->wfd =3D ie_tlv_extract_wfd_payload(data, len, &bss->wfd_size);
+
 	return have_ssid;
 }
 =

diff --git a/src/scan.h b/src/scan.h
index df0cc17c..61d7550f 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -82,6 +82,8 @@ struct scan_bss {
 	uint8_t *rc_ie;		/* Roaming consortium IE */
 	uint8_t hs20_version;
 	uint64_t parent_tsf;
+	uint8_t *wfd;		/* Concatenated WFD IEs */
+	ssize_t wfd_size;	/* Size of Concatenated WFD IEs */
 	bool mde_present : 1;
 	bool cc_present : 1;
 	bool cap_rm_neighbor_report : 1;
-- =

2.25.1

--===============7200461304949855522==--

