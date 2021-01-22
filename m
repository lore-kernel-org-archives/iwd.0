Content-Type: multipart/mixed; boundary="===============1317557112240025450=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/7] diagnostic: commonize the building of diagnostic dict
Date: Fri, 22 Jan 2021 10:14:29 -0800
Message-ID: <20210122181434.644707-2-prestwoj@gmail.com>
In-Reply-To: <20210122181434.644707-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1317557112240025450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AP mode will use the same structure for its diagnostic interface
and mostly the same dictionary keys. Apart from ConnectedBss and
Address being different, the remainder are the same so the
diagnostic_station_info to DBus dictionary conversion has been made
common so both station and AP can use it to build its diagnostic
dictionaries.
---
 Makefile.am      |   1 +
 src/diagnostic.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++
 src/diagnostic.h |   3 ++
 3 files changed, 113 insertions(+)
 create mode 100644 src/diagnostic.c

v3:
 * Moved this into its own file/module

diff --git a/Makefile.am b/Makefile.am
index b1771bc8..a0701c97 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -239,6 +239,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/frame-xchg.h src/frame-xchg.c \
 					src/eap-wsc.c src/eap-wsc.h \
 					src/wscutil.h src/wscutil.c \
+					src/diagnostic.h src/diagnostic.c \
 					$(eap_sources) \
 					$(builtin_sources)
 =

diff --git a/src/diagnostic.c b/src/diagnostic.c
new file mode 100644
index 00000000..1c2d6d18
--- /dev/null
+++ b/src/diagnostic.c
@@ -0,0 +1,109 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
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
+#include "src/diagnostic.h"
+#include "src/dbus.h"
+
+/*
+ * Appends values from diagnostic_station_info into a DBus dictionary. This
+ * assumes the DBus dictionary array has already been 'entered', and expec=
ts the
+ * caller to 'leave' once called. This does not append the station address
+ * since the dictionary key name may be different depending on the caller.
+ */
+bool diagnostic_info_to_dict(const struct diagnostic_station_info *info,
+				struct l_dbus_message_builder *builder)
+{
+	int16_t rssi =3D (int16_t)info->cur_rssi;
+
+	if (info->have_cur_rssi)
+		dbus_append_dict_basic(builder, "RSSI", 'n', &rssi);
+
+	if (info->have_rx_mcs) {
+		switch (info->rx_mcs_type) {
+		case DIAGNOSTIC_MCS_TYPE_HT:
+			dbus_append_dict_basic(builder, "RxMode", 's',
+						"802.11n");
+			dbus_append_dict_basic(builder, "RxMCS", 'y',
+						&info->rx_mcs);
+			break;
+		case DIAGNOSTIC_MCS_TYPE_VHT:
+			dbus_append_dict_basic(builder, "RxMode", 's',
+						"802.11ac");
+			dbus_append_dict_basic(builder, "RxMCS", 'y',
+						&info->rx_mcs);
+			break;
+		case DIAGNOSTIC_MCS_TYPE_HE:
+			dbus_append_dict_basic(builder, "RxMode", 's',
+						"802.11ax");
+			dbus_append_dict_basic(builder, "RxMCS", 'y',
+						&info->rx_mcs);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (info->have_tx_mcs) {
+		switch (info->tx_mcs_type) {
+		case DIAGNOSTIC_MCS_TYPE_HT:
+			dbus_append_dict_basic(builder, "TxMode", 's',
+						"802.11n");
+			dbus_append_dict_basic(builder, "TxMCS", 'y',
+						&info->tx_mcs);
+			break;
+		case DIAGNOSTIC_MCS_TYPE_VHT:
+			dbus_append_dict_basic(builder, "TxMode", 's',
+						"802.11ac");
+			dbus_append_dict_basic(builder, "TxMCS", 'y',
+						&info->tx_mcs);
+			break;
+		case DIAGNOSTIC_MCS_TYPE_HE:
+			dbus_append_dict_basic(builder, "TxMode", 's',
+						"802.11ax");
+			dbus_append_dict_basic(builder, "TxMCS", 'y',
+						&info->tx_mcs);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (info->have_tx_bitrate)
+		dbus_append_dict_basic(builder, "TxBitrate", 'u',
+					&info->tx_bitrate);
+
+	if (info->have_rx_bitrate)
+		dbus_append_dict_basic(builder, "RxBitrate", 'u',
+					&info->rx_bitrate);
+
+	if (info->have_expected_throughput)
+		dbus_append_dict_basic(builder, "ExpectedThroughput", 'u',
+					&info->expected_throughput);
+
+	return true;
+}
diff --git a/src/diagnostic.h b/src/diagnostic.h
index 8292d192..e66dd782 100644
--- a/src/diagnostic.h
+++ b/src/diagnostic.h
@@ -47,3 +47,6 @@ struct diagnostic_station_info {
 	bool have_tx_bitrate : 1;
 	bool have_expected_throughput : 1;
 };
+
+bool diagnostic_info_to_dict(const struct diagnostic_station_info *info,
+				struct l_dbus_message_builder *builder);
-- =

2.26.2

--===============1317557112240025450==--

