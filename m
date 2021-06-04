Content-Type: multipart/mixed; boundary="===============8841698840514799859=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/15] ap: Warn about APRanges having been deprecated
Date: Fri, 04 Jun 2021 03:50:39 +0200
Message-ID: <20210604015052.163727-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8841698840514799859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index f0a38bb6..20422d4e 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3547,6 +3547,9 @@ static int ap_init(void)
 			}
 		} else if (l_settings_get_value(settings,
 						"General", "APRanges")) {
+			l_warn("The [General].APRanges setting is deprecated, "
+				"use [IPv4].APAddressPool instead");
+
 			global_addr4_strs =3D l_settings_get_string_list(settings,
 								"General",
 								"APRanges",
-- =

2.30.2

--===============8841698840514799859==--

