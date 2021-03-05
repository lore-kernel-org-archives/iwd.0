Content-Type: multipart/mixed; boundary="===============5191629436121716430=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/10] ap: Add missing ap_config_free() in error path
Date: Fri, 05 Mar 2021 16:09:28 +0100
Message-ID: <20210305150936.868546-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210305150936.868546-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5191629436121716430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index 677ba8fa..589f6059 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3036,8 +3036,10 @@ static struct l_dbus_message *ap_dbus_start_profile(=
struct l_dbus *dbus,
 		return dbus_error_invalid_format(message);
 =

 	ap_if->ap =3D ap_start(ap_if->netdev, config, &ap_dbus_ops, &err, ap_if);
-	if (!ap_if->ap)
+	if (!ap_if->ap) {
+		ap_config_free(config);
 		return dbus_error_from_errno(err, message);
+	}
 =

 	ap_if->pending =3D l_dbus_message_ref(message);
 	return NULL;
-- =

2.27.0

--===============5191629436121716430==--

