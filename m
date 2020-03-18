Content-Type: multipart/mixed; boundary="===============1904836523007248390=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/12] frame-xchg: Actually free duplicate watches
Date: Wed, 18 Mar 2020 15:45:23 +0100
Message-ID: <20200318144531.30613-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200318144531.30613-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1904836523007248390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a potential leak when we need to drop an existing watch because it's
being replaced with a new one.
---
 src/frame-xchg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 3719ed6c..68bd6168 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -524,6 +524,7 @@ static bool frame_watch_check_duplicate(void *data, voi=
d *user_data)
 	}
 =

 	/* Drop the existing watch as a duplicate of the new one */
+	frame_watch_free(&watch->super);
 	return true;
 }
 =

-- =

2.20.1

--===============1904836523007248390==--

