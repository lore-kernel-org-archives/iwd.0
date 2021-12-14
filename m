Content-Type: multipart/mixed; boundary="===============1168162333098302214=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 02/10] dpp: initial skeleton DPP module
Date: Tue, 14 Dec 2021 10:12:17 -0800
Message-ID: <20211214181225.2308043-2-prestwoj@gmail.com>
In-Reply-To: 20211214181225.2308043-1-prestwoj@gmail.com

--===============1168162333098302214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |   1 +
 src/dpp.c   | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 src/dpp.c

v2:
 * Only create dpp_sm if device is station

diff --git a/Makefile.am b/Makefile.am
index 312081a0..5d14963b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -250,6 +250,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/offchannel.h src/offchannel.c \
 					src/dpp-util.h src/dpp-util.c \
 					src/json.h src/json.c \
+					src/dpp.c \
 					$(eap_sources) \
 					$(builtin_sources)
 =

diff --git a/src/dpp.c b/src/dpp.c
new file mode 100644
index 00000000..d727e639
--- /dev/null
+++ b/src/dpp.c
@@ -0,0 +1,128 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2021  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <ell/ell.h>
+
+#include "src/dbus.h"
+#include "src/netdev.h"
+#include "src/module.h"
+
+static uint32_t netdev_watch;
+
+struct dpp_sm {
+	struct netdev *netdev;
+};
+
+static void dpp_create(struct netdev *netdev)
+{
+	struct l_dbus *dbus =3D dbus_get_bus();
+	struct dpp_sm *dpp =3D l_new(struct dpp_sm, 1);
+
+	dpp->netdev =3D netdev;
+
+	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
+					IWD_DPP_INTERFACE, dpp);
+}
+
+static void dpp_free(struct dpp_sm *dpp)
+{
+	l_free(dpp);
+}
+
+static void dpp_netdev_watch(struct netdev *netdev,
+				enum netdev_watch_event event, void *userdata)
+{
+	if (netdev_get_iftype(netdev) !=3D NETDEV_IFTYPE_STATION)
+		return;
+
+	switch (event) {
+	case NETDEV_WATCH_EVENT_NEW:
+		dpp_create(netdev);
+		break;
+	case NETDEV_WATCH_EVENT_DEL:
+		l_dbus_object_remove_interface(dbus_get_bus(),
+						netdev_get_path(netdev),
+						IWD_DPP_INTERFACE);
+		break;
+	default:
+		break;
+	}
+}
+
+static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+
+	if (!netdev_get_is_up(dpp->netdev))
+		return dbus_error_not_available(message);
+
+	return dbus_error_not_supported(message);
+}
+
+static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	return dbus_error_not_supported(message);
+}
+
+static void dpp_setup_interface(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_method(interface, "StartEnrollee", 0,
+				dpp_dbus_start_enrollee, "", "a{sv}",
+				"uri", "args");
+	l_dbus_interface_method(interface, "Stop", 0,
+				dpp_dbus_stop, "", "");
+}
+
+static void dpp_destroy_interface(void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+
+	dpp_free(dpp);
+}
+
+static int dpp_init(void)
+{
+	netdev_watch =3D netdev_watch_add(dpp_netdev_watch, NULL, NULL);
+
+	l_dbus_register_interface(dbus_get_bus(), IWD_DPP_INTERFACE,
+					dpp_setup_interface,
+					dpp_destroy_interface, false);
+	return 0;
+}
+
+static void dpp_exit(void)
+{
+	l_debug("");
+
+	netdev_watch_remove(netdev_watch);
+}
+
+IWD_MODULE(dpp, dpp_init, dpp_exit);
+IWD_MODULE_DEPENDS(dpp, netdev);
-- =

2.31.1

--===============1168162333098302214==--

