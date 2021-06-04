Content-Type: multipart/mixed; boundary="===============8503053820996528973=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/15] wscutil: Fix a return statement
Date: Fri, 04 Jun 2021 03:50:41 +0200
Message-ID: <20210604015052.163727-4-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8503053820996528973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes: 8d58f5b679b5 ('wscutil: Move DeviceType parsing from p2p & eap-wsc t=
o a function')
---
 src/wscutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wscutil.c b/src/wscutil.c
index a48d2aa5..dac10f73 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -3073,7 +3073,7 @@ bool wsc_device_type_from_setting_str(const char *val=
ue,
 	 * DeviceType=3D1-0050f204-1
 	 */
 	if (wsc_device_type_from_subcategory_str(out, value))
-		true;
+		return true;
 =

 	u =3D strtoull(value, &endp, 0);
 =

-- =

2.30.2

--===============8503053820996528973==--

