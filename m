Content-Type: multipart/mixed; boundary="===============0186832166679754039=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] scan: add scan_passive_full variant
Date: Fri, 15 Nov 2019 10:06:05 -0800
Message-ID: <20191115180608.31564-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0186832166679754039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just like active scans, add an API for passive scans which take in
the full scan_parameters structure.
---
 src/scan.c | 10 ++++++++++
 src/scan.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index a3d6e5d8..ad6d3ad4 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -556,6 +556,16 @@ uint32_t scan_passive(uint64_t wdev_id, struct scan_fr=
eq_set *freqs,
 							userdata, destroy);
 }
 =

+uint32_t scan_passive_full(uint64_t wdev_id,
+			const struct scan_parameters *params,
+			scan_trigger_func_t trigger,
+			scan_notify_func_t notify, void *userdata,
+			scan_destroy_func_t destroy)
+{
+	return scan_common(wdev_id, true, params, trigger,
+				notify, userdata, destroy);
+}
+
 uint32_t scan_active(uint64_t wdev_id, uint8_t *extra_ie, size_t extra_ie_=
size,
 			scan_trigger_func_t trigger,
 			scan_notify_func_t notify, void *userdata,
diff --git a/src/scan.h b/src/scan.h
index 626de80b..6c5133aa 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -102,6 +102,11 @@ static inline bool scan_bss_addr_eq(const struct scan_=
bss *a1,
 uint32_t scan_passive(uint64_t wdev_id, struct scan_freq_set *freqs,
 			scan_trigger_func_t trigger, scan_notify_func_t notify,
 			void *userdata, scan_destroy_func_t destroy);
+uint32_t scan_passive_full(uint64_t wdev_id,
+			const struct scan_parameters *params,
+			scan_trigger_func_t trigger,
+			scan_notify_func_t notify, void *userdata,
+			scan_destroy_func_t destroy);
 uint32_t scan_active(uint64_t wdev_id, uint8_t *extra_ie, size_t extra_ie_=
size,
 			scan_trigger_func_t trigger,
 			scan_notify_func_t notify, void *userdata,
-- =

2.17.1

--===============0186832166679754039==--

