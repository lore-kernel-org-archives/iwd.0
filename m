Content-Type: multipart/mixed; boundary="===============4669932530050787578=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/7] ap: Don't use L_AUTO_FREE_VAR with l_settings
Date: Fri, 26 Feb 2021 17:17:22 +0100
Message-ID: <20210226161728.677701-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4669932530050787578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

L_AUTO_FREE_VAR only causes l_free to be called on the variable that is
freed and may leak the rest of the l_settings object's memory.
---
 src/ap.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index fd1a9a6b..f7b1cf9f 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2544,8 +2544,8 @@ static int ap_load_profile_and_dhcp(struct ap_state *=
ap, bool *wait_dhcp)
 {
 	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
 	char *passphrase;
-	L_AUTO_FREE_VAR(struct l_settings *, settings) =3D NULL;
-	int err;
+	struct l_settings *settings =3D NULL;
+	int err =3D -EINVAL;
 =

 	/* No profile or DHCP settings */
 	if (!ap->config->profile && !pool.used)
@@ -2555,7 +2555,7 @@ static int ap_load_profile_and_dhcp(struct ap_state *=
ap, bool *wait_dhcp)
 		settings =3D l_settings_new();
 =

 		if (!l_settings_load_from_file(settings, ap->config->profile))
-			return -EINVAL;
+			goto cleanup;
 =

 		passphrase =3D l_settings_get_string(settings, "Security",
 							"Passphrase");
@@ -2564,7 +2564,7 @@ static int ap_load_profile_and_dhcp(struct ap_state *=
ap, bool *wait_dhcp)
 				l_error("[Security].Passphrase must not exceed "
 						"63 characters");
 				l_free(passphrase);
-				return -EINVAL;
+				goto cleanup;
 			}
 =

 			strcpy(ap->config->passphrase, passphrase);
@@ -2573,7 +2573,8 @@ static int ap_load_profile_and_dhcp(struct ap_state *=
ap, bool *wait_dhcp)
 =

 		if (!l_settings_has_group(settings, "IPv4")) {
 			*wait_dhcp =3D false;
-			return 0;
+			err =3D 0;
+			goto cleanup;
 		}
 	}
 =

@@ -2587,21 +2588,22 @@ static int ap_load_profile_and_dhcp(struct ap_state=
 *ap, bool *wait_dhcp)
 =

 		if (!ap->rtnl_add_cmd) {
 			l_error("Failed to add IPv4 address");
-			return -EIO;
+			err =3D -EIO;
+			goto cleanup;
 		}
 =

 		ap->cleanup_ip =3D true;
 =

 		*wait_dhcp =3D true;
-
-		return 0;
+		err =3D 0;
 	/* Selected address already set, continue normally */
 	} else if (err =3D=3D -EALREADY) {
 		*wait_dhcp =3D false;
-
-		return 0;
+		err =3D 0;
 	}
 =

+cleanup:
+	l_settings_free(settings);
 	return err;
 }
 =

-- =

2.27.0

--===============4669932530050787578==--

