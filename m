Content-Type: multipart/mixed; boundary="===============1407427249252139922=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] ap: make APRanges optional
Date: Tue, 03 Nov 2020 11:06:38 -0800
Message-ID: <20201103190641.2736204-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1407427249252139922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If EnableNetworkConfiguration was enabled ap.c required that
APRanges also be set. This prevents IWD from starting which
effects a perfectly valid station configuration. Instead if
APRanges is not provided IWD still allows ap_init to pass but
DHCP just will not be enabled.
---
 src/ap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index bebd7295..4d0d5686 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3028,9 +3028,14 @@ static int ap_init(void)
 =

 		ip_prefix =3D l_settings_get_string(settings, "General",
 							"APRanges");
+		/*
+		 * In this case its assumed the user only cares about station
+		 * netconfig so we let ap_init pass but DHCP will not be
+		 * enabled.
+		 */
 		if (!ip_prefix) {
-			l_error("[General].APRanges must be set for DHCP");
-			return -EINVAL;
+			l_warn("[General].APRanges must be set for DHCP");
+			return 0;
 		}
 =

 		if (!ip_pool_create(ip_prefix))
-- =

2.26.2

--===============1407427249252139922==--

