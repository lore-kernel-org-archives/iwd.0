Content-Type: multipart/mixed; boundary="===============3849510038979856342=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] ap: return error from GetDiagnostics if not started
Date: Mon, 01 Feb 2021 14:05:14 -0800
Message-ID: <20210201220518.36975-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3849510038979856342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 37dd05b9..fddf0255 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3200,6 +3200,9 @@ static struct l_dbus_message *ap_dbus_get_diagnostics=
(struct l_dbus *dbus,
 	struct diagnostic_data *data;
 	int ret;
 =

+	if (!ap_if->ap)
+		return dbus_error_not_found(message);
+
 	data =3D l_new(struct diagnostic_data, 1);
 	data->pending =3D l_dbus_message_ref(message);
 =

-- =

2.26.2

--===============3849510038979856342==--

