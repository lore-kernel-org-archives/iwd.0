Content-Type: multipart/mixed; boundary="===============7442136969227296619=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/7] wiphy: integrate radio management module
Date: Thu, 25 Jun 2020 11:56:40 -0700
Message-ID: <20200625185645.30122-3-prestwoj@gmail.com>
In-Reply-To: <20200625185645.30122-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7442136969227296619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tie wiphy creation/destruction to radio management
---
 src/wiphy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index aef39549..49215fe3 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -53,6 +53,7 @@
 #include "src/watchlist.h"
 #include "src/nl80211util.h"
 #include "src/nl80211cmd.h"
+#include "src/radio_mgmt.h"
 =

 #define EXT_CAP_LEN 10
 =

@@ -1235,6 +1236,8 @@ void wiphy_create_complete(struct wiphy *wiphy)
 	wiphy_get_reg_domain(wiphy);
 =

 	wiphy_print_basic_info(wiphy);
+
+	radio_mgmt_create_from_wiphy(wiphy);
 }
 =

 bool wiphy_destroy(struct wiphy *wiphy)
@@ -1247,6 +1250,8 @@ bool wiphy_destroy(struct wiphy *wiphy)
 	if (wiphy->registered)
 		l_dbus_unregister_object(dbus_get_bus(), wiphy_get_path(wiphy));
 =

+	radio_mgmt_destroy(wiphy);
+
 	wiphy_free(wiphy);
 	return true;
 }
-- =

2.21.1

--===============7442136969227296619==--

