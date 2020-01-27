Content-Type: multipart/mixed; boundary="===============7964137765681376717=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] manager: Make sure all interface are processed after dump
Date: Mon, 27 Jan 2020 15:16:44 +0100
Message-ID: <20200127141646.316-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7964137765681376717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In manager_interface_dump_done use l_queue_foreach_remove instead of
l_queue_remove_if to make sure we process all of the interfaces.
---
 src/manager.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index a5de2842..a89bfc57 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -470,9 +470,9 @@ static void manager_interface_dump_callback(struct l_ge=
nl_msg *msg,
 	manager_get_interface_cb(msg, state);
 }
 =

-static bool manager_check_create_interfaces(const void *a, const void *b)
+static bool manager_check_create_interfaces(void *data, void *user_data)
 {
-	struct wiphy_setup_state *state =3D (void *) a;
+	struct wiphy_setup_state *state =3D data;
 =

 	wiphy_create_complete(state->wiphy);
 =

@@ -491,7 +491,7 @@ static bool manager_check_create_interfaces(const void =
*a, const void *b)
 =

 static void manager_interface_dump_done(void *user_data)
 {
-	l_queue_remove_if(pending_wiphys,
+	l_queue_foreach_remove(pending_wiphys,
 				manager_check_create_interfaces, NULL);
 }
 =

-- =

2.20.1

--===============7964137765681376717==--

