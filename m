Content-Type: multipart/mixed; boundary="===============4461663969357626668=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] scan: allow 'faked' scan_bss results
Date: Wed, 10 Mar 2021 12:27:42 -0800
Message-ID: <20210310202746.28475-2-prestwoj@gmail.com>
In-Reply-To: <20210310202746.28475-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4461663969357626668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a full mac roam occurs IWD has no idea about how the
roam occurred, including any scan results associated with
it. IWD just gets a roam event (basically CMD_CONNECT) and
will need to 'fake' a scan result to provide to station.

To allow this scan_bss_rank_compare was exposed, and
scan_bss_addr_eq was also modified to work with queue's.
This will allow station to insert a 'faked' scan_bss result
into its list as if it did a prior scan. A new frame type
was added, SCAN_BSS_NONE, which will indicate this scan
result was obtained via other means (aka faked). This may
not be strictly required but it makes things clearer
for cleanup, and avoids frame type specific routines.
---
 src/p2p.c  | 3 +++
 src/scan.c | 7 ++++++-
 src/scan.h | 8 ++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 22b28f1c..578b356a 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -2716,6 +2716,9 @@ static bool p2p_peer_get_info(struct p2p_peer *peer,
 =

 		*capability =3D &peer->bss->p2p_beacon_info->capability;
 		break;
+	case SCAN_BSS_NONE:
+		l_error("No source frame type set on BSS");
+		break;
 	}
 =

 	return false;
diff --git a/src/scan.c b/src/scan.c
index 82e6a2ae..f42e1e49 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1147,6 +1147,9 @@ static bool scan_parse_bss_information_elements(struc=
t scan_bss *bss,
 		bss->p2p_probe_resp_info =3D NULL;
 		break;
 	}
+	default:
+		l_error("No source frame type set on BSS");
+		break;
 	}
 =

 	bss->wfd =3D ie_tlv_extract_wfd_payload(data, len, &bss->wfd_size);
@@ -1315,7 +1318,7 @@ static struct scan_bss *scan_parse_result(struct l_ge=
nl_msg *msg,
 	return bss;
 }
 =

-static void scan_bss_compute_rank(struct scan_bss *bss)
+void scan_bss_compute_rank(struct scan_bss *bss)
 {
 	static const double RANK_RSNE_FACTOR =3D 1.2;
 	static const double RANK_WPA_FACTOR =3D 1.0;
@@ -1450,6 +1453,8 @@ void scan_bss_free(struct scan_bss *bss)
 		p2p_clear_beacon(bss->p2p_beacon_info);
 		l_free(bss->p2p_beacon_info);
 		break;
+	default:
+		break;
 	}
 =

 	l_free(bss);
diff --git a/src/scan.h b/src/scan.h
index 355b4b5a..dc7f4688 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -43,6 +43,7 @@ enum scan_bss_frame_type {
 	SCAN_BSS_PROBE_RESP,
 	SCAN_BSS_PROBE_REQ,
 	SCAN_BSS_BEACON,
+	SCAN_BSS_NONE,
 };
 =

 struct scan_bss {
@@ -115,9 +116,11 @@ static inline int scan_bss_addr_cmp(const struct scan_=
bss *a1,
 	return memcmp(a1->addr, a2->addr, sizeof(a1->addr));
 }
 =

-static inline bool scan_bss_addr_eq(const struct scan_bss *a1,
-					const struct scan_bss *a2)
+static inline bool scan_bss_addr_eq(const void *a, const void *b)
 {
+	const struct scan_bss *a1 =3D a;
+	const struct scan_bss *a2 =3D b;
+
 	return !memcmp(a1->addr, a2->addr, sizeof(a1->addr));
 }
 =

@@ -153,6 +156,7 @@ uint64_t scan_get_triggered_time(uint64_t wdev_id, uint=
32_t id);
 =

 void scan_bss_free(struct scan_bss *bss);
 int scan_bss_rank_compare(const void *a, const void *b, void *user);
+void scan_bss_compute_rank(struct scan_bss *bss);
 =

 int scan_bss_get_rsn_info(const struct scan_bss *bss, struct ie_rsn_info *=
info);
 =

-- =

2.26.2

--===============4461663969357626668==--

