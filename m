Content-Type: multipart/mixed; boundary="===============2482060743974163245=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 13/16] wsc: Declare the credentials structure in wsc.h
Date: Mon, 28 Oct 2019 15:05:05 +0100
Message-ID: <20191028140508.13518-13-andrew.zaborowski@intel.com>
In-Reply-To: <20191028140508.13518-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2482060743974163245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |  2 +-
 src/wsc.c   | 12 ++----------
 src/wsc.h   | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 11 deletions(-)
 create mode 100644 src/wsc.h

diff --git a/Makefile.am b/Makefile.am
index 823b7d02..7b66c06d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -202,7 +202,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/agent.h src/agent.c \
 					src/storage.h src/storage.c \
 					src/network.h src/network.c \
-					src/wsc.c \
+					src/wsc.h src/wsc.c \
 					src/backtrace.h src/backtrace.c \
 					src/knownnetworks.h \
 					src/knownnetworks.c \
diff --git a/src/wsc.c b/src/wsc.c
index bac6e0cc..a5141346 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -44,6 +44,7 @@
 #include "src/storage.h"
 #include "src/iwd.h"
 #include "src/network.h"
+#include "src/wsc.h"
 =

 #define WALK_TIME 120
 =

@@ -60,16 +61,7 @@ struct wsc {
 	uint32_t scan_id;
 	struct scan_bss *target;
 	uint32_t station_state_watch;
-	struct {
-		char ssid[33];
-		enum security security;
-		union {
-			uint8_t psk[32];
-			char passphrase[64];
-		};
-		uint8_t addr[6];
-		bool has_passphrase;
-	} creds[3];
+	struct wsc_credentials_info creds[3];
 	uint32_t n_creds;
 	struct l_settings *eap_settings;
 =

diff --git a/src/wsc.h b/src/wsc.h
new file mode 100644
index 00000000..b0e6f24a
--- /dev/null
+++ b/src/wsc.h
@@ -0,0 +1,32 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
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
+struct wsc_credentials_info {
+	char ssid[33];
+	enum security security;
+	union {
+		uint8_t psk[32];
+		char passphrase[64];
+	};
+	uint8_t addr[6];
+	bool has_passphrase;
+};
-- =

2.20.1

--===============2482060743974163245==--

