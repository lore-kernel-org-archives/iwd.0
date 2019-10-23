Content-Type: multipart/mixed; boundary="===============6443019272393232306=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 5/8] hotspot Eliminate double assignment of variable
Date: Wed, 23 Oct 2019 13:24:00 -0700
Message-ID: <20191023202403.9690-5-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191023202403.9690-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6443019272393232306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hotspot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/hotspot.c b/src/hotspot.c
index 8d2bb04a..a101cbb0 100644
--- a/src/hotspot.c
+++ b/src/hotspot.c
@@ -320,7 +320,7 @@ static struct hs20_config *hs20_config_new(struct l_set=
tings *settings,
 	char **nai_realms =3D NULL;
 	const char *rc_str;
 	char *name;
-	bool autoconnect =3D true;
+	bool autoconnect;
 =

 	/* One of HESSID, NAI realms, or Roaming Consortium must be included */
 	hessid_str =3D l_settings_get_string(settings, "Hotspot", "HESSID");
@@ -330,7 +330,9 @@ static struct hs20_config *hs20_config_new(struct l_set=
tings *settings,
 =

 	rc_str =3D l_settings_get_value(settings, "Hotspot", "RoamingConsortium");
 =

-	l_settings_get_bool(settings, "Settings", "Autoconnect", &autoconnect);
+	if (!l_settings_get_bool(settings, "Settings", "Autoconnect",
+								&autoconnect))
+		autoconnect =3D true;
 =

 	name =3D l_settings_get_string(settings, "Hotspot", "Name");
 =

-- =

2.13.6

--===============6443019272393232306==--

