Content-Type: multipart/mixed; boundary="===============1476434945098109424=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] test-runner: fix crash for tests using radius_server
Date: Mon, 16 Mar 2020 12:22:40 -0700
Message-ID: <20200316192242.15588-2-prestwoj@gmail.com>
In-Reply-To: <20200316192242.15588-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1476434945098109424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tests which use a standalone RADIUS server may crash due to
the wiphy array not taking into account the 'radius_server'
key which is skipped during setup.
---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 42bd60e2..1f0bc4dd 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1373,7 +1373,7 @@ static bool configure_hostapd_instances(struct l_sett=
ings *hw_settings,
 =

 	hostapd_config_file_paths =3D l_new(char *, i + 1);
 	wiphys =3D alloca(sizeof(struct wiphy *) * (i + 1));
-	wiphys[i] =3D NULL;
+	memset(wiphys, 0, sizeof(struct wiphy *) * (i + 1));
 =

 	hostapd_pids_out[0] =3D -1;
 =

-- =

2.21.1

--===============1476434945098109424==--

