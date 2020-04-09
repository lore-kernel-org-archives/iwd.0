Content-Type: multipart/mixed; boundary="===============9036808853988906487=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/3] storage: Refactor dirs creation logic to cleanup on
 failure
Date: Wed, 08 Apr 2020 18:44:15 -0700
Message-ID: <20200409014417.10029-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9036808853988906487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/storage.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/storage.c b/src/storage.c
index a075d31d..00d93933 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -200,16 +200,24 @@ bool storage_create_dirs(void)
 	}
 =

 	storage_path =3D l_strdup(state_dirs[0]);
-	storage_hotspot_path =3D l_strdup_printf("%s/hotspot/", state_dirs[0]);
 	l_strv_free(state_dirs);
 =

 	if (create_dirs(storage_path)) {
 		l_error("Failed to create %s", storage_path);
+
+		l_free(storage_path);
+
 		return false;
 	}
 =

+	storage_hotspot_path =3D l_strdup_printf("%s/hotspot/", storage_path);
+
 	if (create_dirs(storage_hotspot_path)) {
 		l_error("Failed to create %s", storage_hotspot_path);
+
+		l_free(storage_path);
+		l_free(storage_hotspot_path);
+
 		return false;
 	}
 =

-- =

2.13.6

--===============9036808853988906487==--

