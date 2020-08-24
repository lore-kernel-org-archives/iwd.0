Content-Type: multipart/mixed; boundary="===============8109683147663196995=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] unit: Fix a typo in test-eapol
Date: Tue, 25 Aug 2020 00:34:23 +0200
Message-ID: <20200824223426.475779-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200824223426.475779-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8109683147663196995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-eapol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-eapol.c b/unit/test-eapol.c
index 08c1085e..08740a8e 100644
--- a/unit/test-eapol.c
+++ b/unit/test-eapol.c
@@ -3571,7 +3571,7 @@ static void test_ap_sta_run(struct test_ap_sta_data *=
s)
 	s->sta_success =3D false;
 	s->to_sta_msg_cnt =3D 0;
 	s->to_ap_msg_cnt =3D 0;
-	s->to_sta_data_len =3D 0,
+	s->to_sta_data_len =3D 0;
 =

 	s->ap_sm =3D eapol_sm_new(s->ap_hs);
 	eapol_register(s->ap_sm);
-- =

2.25.1

--===============8109683147663196995==--

