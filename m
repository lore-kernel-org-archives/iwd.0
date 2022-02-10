Content-Type: multipart/mixed; boundary="===============1778686101949604629=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v6 2/6] hotspot: implement hotspot profile encryption
Date: Thu, 10 Feb 2022 11:03:16 -0800
Message-ID: <20220210190320.848755-2-prestwoj@gmail.com>
In-Reply-To: 20220210190320.848755-1-prestwoj@gmail.com

--===============1778686101949604629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using __storage_open() hotspot can also support profile encyption.
The hotspot consortium name is used as the 'ssid' since this stays
consistent between hotspot networks for any profile.
---
 src/hotspot.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/src/hotspot.c b/src/hotspot.c
index 21f50690..832d7a31 100644
--- a/src/hotspot.c
+++ b/src/hotspot.c
@@ -95,12 +95,18 @@ static struct l_settings *hotspot_network_open(struct n=
etwork_info *info)
 =

 	settings =3D l_settings_new();
 =

-	if (!l_settings_load_from_file(settings, config->filename)) {
-		l_settings_free(settings);
-		return NULL;
-	}
+	if (!l_settings_load_from_file(settings, config->filename))
+		goto error;
+
+	if (!__storage_open(settings, config->filename, SECURITY_8021X,
+				config->name))
+		goto error;
 =

 	return settings;
+
+error:
+	l_settings_free(settings);
+	return NULL;
 }
 =

 static void hotspot_network_sync(struct network_info *info,
@@ -111,7 +117,12 @@ static void hotspot_network_sync(struct network_info *=
info,
 	struct hs20_config *config =3D l_container_of(info, struct hs20_config,
 							super);
 =

-	data =3D l_settings_to_data(settings, &length);
+	data =3D __storage_encrypt(settings, config->name, &length);
+	if (!data) {
+		l_error("Unable to sync profile %s", config->filename);
+		return;
+	}
+
 	write_file(data, length, true, "%s", config->filename);
 	l_free(data);
 }
@@ -338,6 +349,11 @@ static struct hs20_config *hs20_config_new(struct l_se=
ttings *settings,
 		goto free_values;
 	}
 =

+	if (!__storage_open(settings, filename, SECURITY_8021X, name)) {
+		l_error("Could not open hotspot profile %s", filename);
+		goto free_values;
+	}
+
 	config =3D l_new(struct hs20_config, 1);
 =

 	if (hessid_str) {
-- =

2.34.1

--===============1778686101949604629==--

