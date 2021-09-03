Content-Type: multipart/mixed; boundary="===============6105396263431542246=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] station: Check ie_tlv_iter_next return value
Date: Fri, 03 Sep 2021 22:06:40 +0200
Message-ID: <20210903200640.254482-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210903200640.254482-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6105396263431542246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This can't be false but check it to calm static analysis.
---
 src/station.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 9f00bfb3..afece9eb 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2462,8 +2462,11 @@ static void station_connect_ok(struct station *stati=
on)
 =

 			ie_tlv_iter_init(&iter, hs->fils_ip_resp_ie,
 						hs->fils_ip_resp_ie[1] + 2);
-			ie_tlv_iter_next(&iter);
-			r =3D ie_parse_fils_ip_addr_response(&iter, &info);
+			if (!L_WARN_ON(unlikely(!ie_tlv_iter_next(&iter))))
+				r =3D ie_parse_fils_ip_addr_response(&iter,
+									&info);
+			else
+				r =3D -ENOMSG;
 =

 			if (r !=3D 0)
 				l_debug("Error parsing the FILS IP Address "
-- =

2.30.2

--===============6105396263431542246==--

