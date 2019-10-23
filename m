Content-Type: multipart/mixed; boundary="===============2836516172903402535=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 6/8] hwsim: Fix potential memory leak
Date: Wed, 23 Oct 2019 13:24:01 -0700
Message-ID: <20191023202403.9690-6-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191023202403.9690-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2836516172903402535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If msg has multiple RADIO NAME attributes, memory leak occurs.
---
 tools/hwsim.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index e9ba1f95..500762db 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -312,11 +312,12 @@ static void list_callback(struct l_genl_msg *msg, voi=
d *user_data)
 			break;
 =

 		case HWSIM_ATTR_RADIO_NAME:
-			hwname =3D l_malloc(len + 1);
-			if (hwname) {
+			if (!hwname) {
+				hwname =3D l_new(char, len + 1);
+
 				strncpy(hwname, data, len);
-				hwname[len] =3D '\0';
 			}
+
 			break;
 =

 		default:
-- =

2.13.6

--===============2836516172903402535==--

