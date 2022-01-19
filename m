Content-Type: multipart/mixed; boundary="===============6416187861258653498=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] dpp: free nl80211 object on exit
Date: Wed, 19 Jan 2022 15:04:51 -0800
Message-ID: <20220119230452.2306995-1-prestwoj@gmail.com>

--===============6416187861258653498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 78e8ffc5..6889bef9 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1931,6 +1931,9 @@ static void dpp_exit(void)
 	l_genl_family_unregister(nl80211, mlme_watch);
 	mlme_watch =3D 0;
 =

+	l_genl_family_free(nl80211);
+	nl80211 =3D NULL;
+
 	l_queue_destroy(dpp_list, (l_queue_destroy_func_t) dpp_free);
 }
 =

-- =

2.31.1

--===============6416187861258653498==--

