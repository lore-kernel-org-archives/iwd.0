Content-Type: multipart/mixed; boundary="===============1058924951235521325=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] scan: Address uninitialized scalars reported by coverity
Date: Tue, 15 Oct 2019 10:40:19 -0700
Message-ID: <20191015174019.13088-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1058924951235521325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 790232bb..ec964893 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1360,9 +1360,9 @@ static void scan_notify(struct l_genl_msg *msg, void =
*user_data)
 	const void *data;
 	uint8_t cmd;
 	uint64_t uninitialized_var(attr_wdev_id);
-	bool have_wdev_id;
+	bool have_wdev_id =3D false;
 	uint32_t uninitialized_var(attr_wiphy);
-	bool have_wiphy;
+	bool have_wiphy =3D false;
 	struct scan_context *sc;
 	bool active_scan =3D false;
 =

-- =

2.13.6

--===============1058924951235521325==--

