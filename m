Content-Type: multipart/mixed; boundary="===============0457014203958139232=="
MIME-Version: 1.0
From: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
Subject: [PATCH 2/2] ap: update for new _auto_ destructors
Date: Fri, 14 May 2021 18:34:14 +0200
Message-ID: <20210514163414.304860-2-Marc-Antoine@Perennou.com>
In-Reply-To: <20210514163414.304860-1-Marc-Antoine@Perennou.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0457014203958139232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
---
 src/ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index 7eac07d7..82bdf34d 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3298,7 +3298,7 @@ static struct l_dbus_message *ap_dbus_start_profile(s=
truct l_dbus *dbus,
 {
 	struct ap_if_data *ap_if =3D user_data;
 	const char *ssid;
-	_auto_(l_settings_free) struct l_settings *config =3D NULL;
+	_auto_(l_settings) config =3D NULL;
 	char *config_path;
 	int err;
 =

-- =

2.30.0

--===============0457014203958139232==--

