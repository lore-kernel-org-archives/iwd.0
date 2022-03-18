Content-Type: multipart/mixed; boundary="===============6138799022744535656=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 6/6] wired: check return of l_settings_load_from_file
Date: Fri, 18 Mar 2022 09:44:20 -0700
Message-ID: <20220318164420.739968-6-prestwoj@gmail.com>
In-Reply-To: 20220318164420.739968-1-prestwoj@gmail.com

--===============6138799022744535656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Caught by static analysis
---
 wired/network.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/wired/network.c b/wired/network.c
index 64dcb4be..6ff0e708 100644
--- a/wired/network.c
+++ b/wired/network.c
@@ -133,7 +133,10 @@ struct l_settings *network_lookup_security(const char =
*network)
 	l_debug("Loading %s", path);
 =

 	conf =3D l_settings_new();
-	l_settings_load_from_file(conf, path);
+	if (!l_settings_load_from_file(conf, path)) {
+		l_settings_free(conf);
+		conf =3D NULL;
+	}
 =

 	l_free(path);
 =

-- =

2.34.1

--===============6138799022744535656==--

