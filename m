Content-Type: multipart/mixed; boundary="===============2185127591914886745=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/11] main: Add NetworkConfigurationEnabled to
 Daemon.GetInfo()
Date: Mon, 10 May 2021 10:58:05 +0200
Message-ID: <20210510085806.174213-10-andrew.zaborowski@intel.com>
In-Reply-To: <20210510085806.174213-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2185127591914886745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/main.c b/src/main.c
index 01f1be22..992a1233 100644
--- a/src/main.c
+++ b/src/main.c
@@ -218,11 +218,19 @@ static struct l_dbus_message *iwd_dbus_get_info(struc=
t l_dbus *dbus,
 	struct l_dbus_message *reply;
 	struct l_dbus_message_builder *builder;
 	L_AUTO_FREE_VAR(char *, storage_dir) =3D storage_get_path(NULL);
+	bool netconfig_enabled;
+
+	if (!l_settings_get_bool(iwd_config, "General",
+					"EnableNetworkConfiguration",
+					&netconfig_enabled))
+		netconfig_enabled =3D false;
 =

 	reply =3D l_dbus_message_new_method_return(message);
 	builder =3D l_dbus_message_builder_new(reply);
 	l_dbus_message_builder_enter_array(builder, "{sv}");
 =

+	dbus_append_dict_basic(builder, "NetworkConfigurationEnabled", 'b',
+				&netconfig_enabled);
 	dbus_append_dict_basic(builder, "StateDirectory", 's', storage_dir);
 	dbus_append_dict_basic(builder, "Version", 's', VERSION);
 =

-- =

2.27.0

--===============2185127591914886745==--

