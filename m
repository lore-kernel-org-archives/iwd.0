Content-Type: multipart/mixed; boundary="===============2209656148642520433=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] frame-watch: Actually unregister removed groups
Date: Tue, 04 Feb 2020 12:23:04 +0100
Message-ID: <20200204112305.31540-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2209656148642520433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Actually close the sockets for removed groups an free resources
---
 src/frame-xchg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 0a6c1fc6..4c8b4a9f 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -362,8 +362,10 @@ static bool frame_watch_group_remove_wdev(void *data, =
void *user_data)
 	struct watch_group *group =3D data;
 	const uint64_t *wdev_id =3D user_data;
 =

-	if (group->wdev_id =3D=3D *wdev_id)
+	if (group->wdev_id =3D=3D *wdev_id) {
+		frame_watch_group_destroy(group);
 		return true;
+	}
 =

 	if (group->id !=3D 0)
 		return false;
-- =

2.20.1

--===============2209656148642520433==--

