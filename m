Content-Type: multipart/mixed; boundary="===============7908176661112529003=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 3/6] wiphy: integrate offchannel module
Date: Wed, 17 Jun 2020 10:56:42 -0700
Message-ID: <20200617175645.31197-3-prestwoj@gmail.com>
In-Reply-To: <20200617175645.31197-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7908176661112529003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tie wiphy creation/destruction to offchannel
---
 src/wiphy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index aef39549..7e58a402 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -53,6 +53,7 @@
 #include "src/watchlist.h"
 #include "src/nl80211util.h"
 #include "src/nl80211cmd.h"
+#include "src/offchannel.h"
 =

 #define EXT_CAP_LEN 10
 =

@@ -1235,6 +1236,9 @@ void wiphy_create_complete(struct wiphy *wiphy)
 	wiphy_get_reg_domain(wiphy);
 =

 	wiphy_print_basic_info(wiphy);
+
+	if (wiphy->offchannel_tx_ok)
+		offchan_create_from_wiphy(wiphy);
 }
 =

 bool wiphy_destroy(struct wiphy *wiphy)
@@ -1247,6 +1251,9 @@ bool wiphy_destroy(struct wiphy *wiphy)
 	if (wiphy->registered)
 		l_dbus_unregister_object(dbus_get_bus(), wiphy_get_path(wiphy));
 =

+	if (wiphy->offchannel_tx_ok)
+		offchan_destroy(wiphy);
+
 	wiphy_free(wiphy);
 	return true;
 }
-- =

2.21.1

--===============7908176661112529003==--

