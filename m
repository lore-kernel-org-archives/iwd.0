Content-Type: multipart/mixed; boundary="===============2629567377757988856=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] resolve: fix runtime error if netconfig is not enabled
Date: Wed, 13 Nov 2019 09:45:36 -0800
Message-ID: <20191113174536.15680-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2629567377757988856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the resolve module was not enabled in the config file, IWD fails
to start since resolve_init was returning -EINVAL. Since netconfig
is optional, we just return successfully here.
---
 src/resolve.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/resolve.c b/src/resolve.c
index 83ac3547..fea9c2bd 100644
--- a/src/resolve.c
+++ b/src/resolve.c
@@ -427,8 +427,9 @@ void __resolve_set_config(struct l_settings *config)
 =

 static int resolve_init(void)
 {
+	/* This module is not enabled in config */
 	if (!method.ops)
-		return -EINVAL;
+		return 0;
 =

 	if (method.ops->init)
 		method.data =3D method.ops->init();
-- =

2.17.1

--===============2629567377757988856==--

