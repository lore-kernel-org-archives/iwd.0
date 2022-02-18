Content-Type: multipart/mixed; boundary="===============0682165854008270499=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/3] hwsim: check if radio name was already set
Date: Fri, 18 Feb 2022 11:55:04 -0800
Message-ID: <20220218195506.2145602-1-prestwoj@gmail.com>

--===============0682165854008270499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was caught by static analysis and shouldn't ever happen.
---
 tools/hwsim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 3ff3faab..8c076f51 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -639,6 +639,9 @@ static void get_radio_callback(struct l_genl_msg *msg, =
void *user_data)
 			break;
 =

 		case HWSIM_ATTR_RADIO_NAME:
+			if (name)
+				return;
+
 			name =3D l_strndup(data, len);
 			break;
 		}
-- =

2.34.1

--===============0682165854008270499==--

