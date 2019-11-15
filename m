Content-Type: multipart/mixed; boundary="===============4571867203686203955=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/7] scan: parse parent TSF value in scan results
Date: Fri, 15 Nov 2019 10:39:25 -0800
Message-ID: <20191115183926.1887-6-prestwoj@gmail.com>
In-Reply-To: <20191115183926.1887-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4571867203686203955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RRM can include this in measurement reports if present in scans
---
 src/scan.c | 6 ++++++
 src/scan.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 8e50052c..e74a69c1 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1072,6 +1072,12 @@ static struct scan_bss *scan_parse_attr_bss(struct l=
_genl_attr *attr)
 								&bss->p2p_size);
 =

 			break;
+		case NL80211_BSS_PARENT_TSF:
+			if (len !=3D sizeof(uint64_t))
+				goto fail;
+
+			bss->parent_tsf =3D l_get_le64(data);
+			break;
 		}
 	}
 =

diff --git a/src/scan.h b/src/scan.h
index cbbbe21a..8fc2aa56 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -67,6 +67,7 @@ struct scan_bss {
 	uint8_t hessid[6];
 	uint8_t *rc_ie;		/* Roaming consortium IE */
 	uint8_t hs20_version;
+	uint64_t parent_tsf;
 	bool mde_present : 1;
 	bool cc_present : 1;
 	bool cap_rm_neighbor_report : 1;
-- =

2.17.1

--===============4571867203686203955==--

