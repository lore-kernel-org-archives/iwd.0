Content-Type: multipart/mixed; boundary="===============7965199454363285640=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ap: fixup incorrect return
Date: Mon, 02 Nov 2020 12:17:52 -0800
Message-ID: <20201102201752.2585008-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7965199454363285640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If an RTNL address change fails -EIO should be returned, not
false (aka "success").
---
 src/ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index bfa9d47e..bebd7295 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2412,7 +2412,7 @@ static int ap_load_profile_and_dhcp(struct ap_state *=
ap, bool *wait_dhcp)
 =

 		if (!ap->rtnl_add_cmd) {
 			l_error("Failed to add IPv4 address");
-			return false;
+			return -EIO;
 		}
 =

 		ap->cleanup_ip =3D true;
-- =

2.26.2

--===============7965199454363285640==--

