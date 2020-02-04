Content-Type: multipart/mixed; boundary="===============4977510045750727789=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] frame-watch: Fix an l_queue_foreach_remove call
Date: Tue, 04 Feb 2020 12:23:05 +0100
Message-ID: <20200204112305.31540-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200204112305.31540-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4977510045750727789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A pointer to the wdev_id is expected in this call inside
frame_watch_group_remove_wdev instead of a pointer to the pointer.
---
 src/frame-xchg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 4c8b4a9f..31d9c229 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -375,8 +375,7 @@ static bool frame_watch_group_remove_wdev(void *data, v=
oid *user_data)
 	 * internals.
 	 */
 	l_queue_foreach_remove(group->watches.items,
-				frame_watch_item_remove_wdev,
-				&wdev_id);
+				frame_watch_item_remove_wdev, user_data);
 	return false;
 }
 =

-- =

2.20.1

--===============4977510045750727789==--

