Content-Type: multipart/mixed; boundary="===============5787715087056398046=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] ap: Drop an outdated TODO comment
Date: Thu, 18 Feb 2021 20:55:15 +0100
Message-ID: <20210218195515.503170-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210218195515.503170-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5787715087056398046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index d34b2edd..fd1a9a6b 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2079,11 +2079,6 @@ static void ap_start_cb(struct l_genl_msg *msg, void=
 *user_data)
 		goto failed;
 	}
 =

-	/*
-	 * TODO: Add support for provisioning files where user could configure
-	 * specific DHCP sever settings.
-	 */
-
 	if (ap->server && !l_dhcp_server_start(ap->server)) {
 		l_error("DHCP server failed to start");
 		goto failed;
-- =

2.27.0

--===============5787715087056398046==--

