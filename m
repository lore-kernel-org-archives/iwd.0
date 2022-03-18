Content-Type: multipart/mixed; boundary="===============5594863596840328577=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/6] json: call va_end in error case
Date: Fri, 18 Mar 2022 09:44:17 -0700
Message-ID: <20220318164420.739968-3-prestwoj@gmail.com>
In-Reply-To: 20220318164420.739968-1-prestwoj@gmail.com

--===============5594863596840328577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Caught by static analysis
---
 src/json.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/json.c b/src/json.c
index a2144a7c..4cd404ab 100644
--- a/src/json.c
+++ b/src/json.c
@@ -279,6 +279,8 @@ done:
 	return true;
 =

 error:
+	va_end(va);
+
 	l_queue_destroy(args, l_free);
 	return false;
 }
-- =

2.34.1

--===============5594863596840328577==--

