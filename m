Content-Type: multipart/mixed; boundary="===============3196666932777075580=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/11] anqp: utilize IWD_MODULE
Date: Fri, 11 Oct 2019 10:24:10 -0700
Message-ID: <20191011172417.23328-4-prestwoj@gmail.com>
In-Reply-To: <20191011172417.23328-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3196666932777075580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This converts anqp into an IWD module.
---
 src/anqp.c | 12 ++++++++----
 src/anqp.h |  3 ---
 src/main.c |  2 --
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/src/anqp.c b/src/anqp.c
index 9f006bd6..a47530ab 100644
--- a/src/anqp.c
+++ b/src/anqp.c
@@ -474,11 +474,11 @@ static void anqp_mlme_notify(struct l_genl_msg *msg, =
void *user_data)
 	}
 }
 =

-bool anqp_init(struct l_genl_family *in)
+static int anqp_init(void)
 {
 	struct l_genl *genl =3D iwd_get_genl();
 =

-	nl80211 =3D in;
+	nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
 =

 	anqp_requests =3D l_queue_new();
 =

@@ -492,13 +492,14 @@ bool anqp_init(struct l_genl_family *in)
 								NULL, NULL))
 		l_error("Registering for MLME notification failed");
 =

-	return true;
+	return 0;
 }
 =

-void anqp_exit(void)
+static void anqp_exit(void)
 {
 	struct l_genl *genl =3D iwd_get_genl();
 =

+	l_genl_family_free(nl80211);
 	nl80211 =3D NULL;
 =

 	l_queue_destroy(anqp_requests, anqp_destroy);
@@ -507,3 +508,6 @@ void anqp_exit(void)
 =

 	l_genl_remove_unicast_watch(genl, unicast_watch);
 }
+
+IWD_MODULE(anqp, anqp_init, anqp_exit);
+IWD_MODULE_DEPENDS(anqp, netdev);
diff --git a/src/anqp.h b/src/anqp.h
index 62d097d1..998277dd 100644
--- a/src/anqp.h
+++ b/src/anqp.h
@@ -38,6 +38,3 @@ uint32_t anqp_request(uint32_t ifindex, const uint8_t *ad=
dr,
 			struct scan_bss *bss, const uint8_t *anqp, size_t len,
 			anqp_response_func_t cb, void *user_data,
 			anqp_destroy_func_t destroy);
-
-bool anqp_init(struct l_genl_family *in);
-void anqp_exit(void);
diff --git a/src/main.c b/src/main.c
index 2e8d4a6d..4619a84c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -153,7 +153,6 @@ static void nl80211_appeared(const struct l_genl_family=
_info *info,
 	}
 =

 	manager_init(nl80211, interfaces, nointerfaces);
-	anqp_init(nl80211);
 =

 	if (!wiphy_init(nl80211, phys, nophys))
 		l_error("Unable to init wiphy functionality");
@@ -491,7 +490,6 @@ int main(int argc, char *argv[])
 =

 	if (nl80211) {
 		manager_exit();
-		anqp_exit();
 		wiphy_exit();
 		l_genl_family_free(nl80211);
 	}
-- =

2.17.1

--===============3196666932777075580==--

