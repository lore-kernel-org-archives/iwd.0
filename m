Content-Type: multipart/mixed; boundary="===============7319632277374521695=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] dpp: unregister interface on exit
Date: Tue, 15 Feb 2022 13:16:46 -0800
Message-ID: <20220215211646.1328388-1-prestwoj@gmail.com>

--===============7319632277374521695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes a cleanup issue where DPP tries to cleanup both on
dpp_exit() and when netdev goes down.
---
 src/dpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index d95217c5..f6ccb926 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1941,6 +1941,8 @@ static void dpp_exit(void)
 {
 	l_debug("");
 =

+	l_dbus_unregister_interface(dbus_get_bus(), IWD_DPP_INTERFACE);
+
 	netdev_watch_remove(netdev_watch);
 =

 	l_genl_family_unregister(nl80211, mlme_watch);
-- =

2.34.1

--===============7319632277374521695==--

