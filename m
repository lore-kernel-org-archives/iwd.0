Content-Type: multipart/mixed; boundary="===============0539055115780909049=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2] wsc: Check capability before adding .SimpleConfiguration
 interface
Date: Wed, 06 Nov 2019 18:50:59 -0500
Message-ID: <20191106235059.17825-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0539055115780909049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wsc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/wsc.c b/src/wsc.c
index bac6e0cc..1050aefd 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -1108,6 +1108,13 @@ static void wsc_add_interface(struct netdev *netdev)
 	struct l_dbus *dbus =3D dbus_get_bus();
 	struct wsc *wsc;
 =

+	if (!wiphy_get_max_scan_ie_len(netdev_get_wiphy(netdev))) {
+		l_debug("Simple Configuration isn't supported by ifindex %u",
+						netdev_get_ifindex(netdev));
+
+		return;
+	}
+
 	wsc =3D l_new(struct wsc, 1);
 	wsc->netdev =3D netdev;
 =

-- =

2.21.0

--===============0539055115780909049==--

