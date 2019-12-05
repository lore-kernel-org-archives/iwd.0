Content-Type: multipart/mixed; boundary="===============5188024738738860952=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 4/4] client: Use full include path for local includes
Date: Thu, 05 Dec 2019 13:52:41 -0800
Message-ID: <20191205215241.31283-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191205215241.31283-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5188024738738860952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 client/ad-hoc.c         |  8 ++++----
 client/adapter.c        |  8 ++++----
 client/agent-manager.c  |  6 +++---
 client/agent.c          |  8 ++++----
 client/ap.c             |  8 ++++----
 client/command.c        |  4 ++--
 client/dbus-proxy.c     |  8 ++++----
 client/device.c         | 12 ++++++------
 client/display.c        |  6 +++---
 client/known-networks.c | 10 +++++-----
 client/main.c           |  6 +++---
 client/network.c        |  6 +++---
 client/properties.c     |  2 +-
 client/station.c        | 10 +++++-----
 client/wsc.c            |  8 ++++----
 15 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/client/ad-hoc.c b/client/ad-hoc.c
index 9fba9c96..41d5e2aa 100644
--- a/client/ad-hoc.c
+++ b/client/ad-hoc.c
@@ -26,10 +26,10 @@
 =

 #include <ell/ell.h>
 =

-#include "command.h"
-#include "dbus-proxy.h"
-#include "device.h"
-#include "display.h"
+#include "client/command.h"
+#include "client/dbus-proxy.h"
+#include "client/device.h"
+#include "client/display.h"
 =

 struct ad_hoc {
 	bool started;
diff --git a/client/adapter.c b/client/adapter.c
index e815a39b..6a0d3455 100644
--- a/client/adapter.c
+++ b/client/adapter.c
@@ -26,10 +26,10 @@
 =

 #include <ell/ell.h>
 =

-#include "command.h"
-#include "dbus-proxy.h"
-#include "display.h"
-#include "properties.h"
+#include "client/command.h"
+#include "client/dbus-proxy.h"
+#include "client/display.h"
+#include "client/properties.h"
 =

 struct adapter {
 	bool powered;
diff --git a/client/agent-manager.c b/client/agent-manager.c
index 98a78436..91cde8c4 100644
--- a/client/agent-manager.c
+++ b/client/agent-manager.c
@@ -27,9 +27,9 @@
 #include <ell/ell.h>
 #include <unistd.h>
 =

-#include "agent.h"
-#include "dbus-proxy.h"
-#include "command.h"
+#include "client/agent.h"
+#include "client/dbus-proxy.h"
+#include "client/command.h"
 =

 #define IWD_AGENT_MANAGER_PATH		"/net/connman/iwd"
 =

diff --git a/client/agent.c b/client/agent.c
index 16bc3c4f..b804b50d 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -26,10 +26,10 @@
 =

 #include <ell/ell.h>
 =

-#include "agent.h"
-#include "dbus-proxy.h"
-#include "display.h"
-#include "command.h"
+#include "client/agent.h"
+#include "client/dbus-proxy.h"
+#include "client/display.h"
+#include "client/command.h"
 =

 #define IWD_AGENT_INTERFACE "net.connman.iwd.Agent"
 =

diff --git a/client/ap.c b/client/ap.c
index bf55d07f..a6a2681b 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -26,10 +26,10 @@
 =

 #include <ell/ell.h>
 =

-#include "command.h"
-#include "dbus-proxy.h"
-#include "device.h"
-#include "display.h"
+#include "client/command.h"
+#include "client/dbus-proxy.h"
+#include "client/device.h"
+#include "client/display.h"
 =

 struct ap {
 	bool started;
diff --git a/client/command.c b/client/command.c
index 5441188a..74f11c4a 100644
--- a/client/command.c
+++ b/client/command.c
@@ -31,8 +31,8 @@
 #include <ell/ell.h>
 #include <readline/readline.h>
 =

-#include "command.h"
-#include "display.h"
+#include "client/command.h"
+#include "client/display.h"
 =

 static struct l_queue *command_families;
 static struct l_queue *command_options;
diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index a8cfca55..313cd5a6 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -27,10 +27,10 @@
 #include <stdio.h>
 #include <ell/ell.h>
 =

-#include "dbus-proxy.h"
-#include "display.h"
-#include "command.h"
-#include "properties.h"
+#include "client/dbus-proxy.h"
+#include "client/display.h"
+#include "client/command.h"
+#include "client/properties.h"
 =

 #define IWD_SERVICE		"net.connman.iwd"
 #define IWD_ROOT_PATH		"/"
diff --git a/client/device.c b/client/device.c
index ef109c84..5b971883 100644
--- a/client/device.c
+++ b/client/device.c
@@ -26,12 +26,12 @@
 =

 #include <ell/ell.h>
 =

-#include "command.h"
-#include "dbus-proxy.h"
-#include "device.h"
-#include "display.h"
-#include "network.h"
-#include "properties.h"
+#include "client/command.h"
+#include "client/dbus-proxy.h"
+#include "client/device.h"
+#include "client/display.h"
+#include "client/network.h"
+#include "client/properties.h"
 =

 struct device {
 	bool powered;
diff --git a/client/display.c b/client/display.c
index 10c87b2a..349eb503 100644
--- a/client/display.c
+++ b/client/display.c
@@ -32,9 +32,9 @@
 #include <readline/readline.h>
 #include <ell/ell.h>
 =

-#include "agent.h"
-#include "command.h"
-#include "display.h"
+#include "client/agent.h"
+#include "client/command.h"
+#include "client/display.h"
 =

 #define IWD_PROMPT COLOR_GREEN "[iwd]" COLOR_OFF "# "
 #define LINE_LEN 81
diff --git a/client/known-networks.c b/client/known-networks.c
index 7cfc2ecf..45f60af2 100644
--- a/client/known-networks.c
+++ b/client/known-networks.c
@@ -29,11 +29,11 @@
 #include <time.h>
 #include <ell/ell.h>
 =

-#include "command.h"
-#include "dbus-proxy.h"
-#include "display.h"
-#include "properties.h"
-#include "network.h"
+#include "client/command.h"
+#include "client/dbus-proxy.h"
+#include "client/display.h"
+#include "client/properties.h"
+#include "client/network.h"
 =

 struct known_network {
 	char *identity;
diff --git a/client/main.c b/client/main.c
index 54d4cb31..8ca45a15 100644
--- a/client/main.c
+++ b/client/main.c
@@ -28,9 +28,9 @@
 #include <signal.h>
 #include <ell/ell.h>
 =

-#include "command.h"
-#include "display.h"
-#include "dbus-proxy.h"
+#include "client/command.h"
+#include "client/display.h"
+#include "client/dbus-proxy.h"
 =

 static void signal_handler(uint32_t signo, void *user_data)
 {
diff --git a/client/network.c b/client/network.c
index fdeeef67..6b79bcd1 100644
--- a/client/network.c
+++ b/client/network.c
@@ -26,9 +26,9 @@
 =

 #include <ell/ell.h>
 =

-#include "dbus-proxy.h"
-#include "display.h"
-#include "network.h"
+#include "client/dbus-proxy.h"
+#include "client/display.h"
+#include "client/network.h"
 =

 struct network {
 	bool connected;
diff --git a/client/properties.c b/client/properties.c
index 8838f4f0..dadf660d 100644
--- a/client/properties.c
+++ b/client/properties.c
@@ -26,7 +26,7 @@
 =

 #include <ell/ell.h>
 =

-#include "properties.h"
+#include "client/properties.h"
 =

 const char *properties_on_off_opts[3] =3D { "on", "off", NULL };
 const char *properties_yes_no_opts[3] =3D { "yes", "no", NULL };
diff --git a/client/station.c b/client/station.c
index dbcfa88f..b6b59239 100644
--- a/client/station.c
+++ b/client/station.c
@@ -26,11 +26,11 @@
 =

 #include <ell/ell.h>
 =

-#include "command.h"
-#include "dbus-proxy.h"
-#include "device.h"
-#include "network.h"
-#include "display.h"
+#include "client/command.h"
+#include "client/dbus-proxy.h"
+#include "client/device.h"
+#include "client/network.h"
+#include "client/display.h"
 =

 struct station {
 	bool scanning;
diff --git a/client/wsc.c b/client/wsc.c
index ffbb54aa..39950453 100644
--- a/client/wsc.c
+++ b/client/wsc.c
@@ -26,10 +26,10 @@
 =

 #include <ell/ell.h>
 =

-#include "command.h"
-#include "dbus-proxy.h"
-#include "device.h"
-#include "display.h"
+#include "client/command.h"
+#include "client/dbus-proxy.h"
+#include "client/device.h"
+#include "client/display.h"
 =

 static struct proxy_interface_type wsc_interface_type =3D {
 	.interface =3D IWD_WSC_INTERFACE,
-- =

2.13.6

--===============5188024738738860952==--

