Content-Type: multipart/mixed; boundary="===============7024462586380351435=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/10] frame-xchg: fix bug when starting new xchg from callback
Date: Tue, 02 Jun 2020 10:30:12 -0700
Message-ID: <20200602173021.20085-2-prestwoj@gmail.com>
In-Reply-To: <20200602173021.20085-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7024462586380351435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This bug is caused by the following behavior:

 1. Start a frame-xchg, wait for callback
 2. From callback start a new frame-xchg, same prefix.

The new frame-xchg request will detect that there is a duplicate watch,
which is correct behavior. It will then remove this duplicate from the
watchlist. The issue here is that we are in the watchlist notify loop
from the original xchg. This causes that loop to read from the now
freed watchlist item, causing an invalid read.

Instead of freeing the item immediately, check if the notify loop is in
progress and only set 'id' to zero and 'stale_items' to true. This will
allow the notify loop to finish, then the watchlist code will prune out
any stale items. If not in the notify loop the item can be freed as it
was before.
---
 src/frame-xchg.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 4c950fd3..71751ca4 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -532,7 +532,17 @@ static bool frame_watch_check_duplicate(void *data, vo=
id *user_data)
 	}
 =

 drop:
-	/* Drop the existing watch as a duplicate of the new one */
+	/*
+	 * Drop the existing watch as a duplicate of the new one. If we are in
+	 * the watchlist notify loop, just mark this item as stale and it will
+	 * be cleaned up afterwards
+	 */
+	if (watch->group->watches.in_notify) {
+		super->id =3D 0;
+		watch->group->watches.stale_items =3D true;
+		return false;
+	}
+
 	frame_watch_free(&watch->super);
 	return true;
 }
-- =

2.21.1

--===============7024462586380351435==--

