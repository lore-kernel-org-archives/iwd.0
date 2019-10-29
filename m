Content-Type: multipart/mixed; boundary="===============4712673382095785199=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] knownnetworks: Check result of setting getter
Date: Tue, 29 Oct 2019 16:31:40 -0700
Message-ID: <20191029233140.11777-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4712673382095785199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Set the value of 'is_hidden' if necessary.
---
 src/knownnetworks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index e5cbc01b..d8d6947d 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -338,7 +338,7 @@ void known_network_update(struct network_info *network,
 					struct l_settings *settings,
 					uint64_t connected_time)
 {
-	bool is_hidden =3D false;
+	bool is_hidden;
 	bool is_autoconnectable;
 =

 	if (network->connected_time !=3D connected_time) {
@@ -354,7 +354,8 @@ void known_network_update(struct network_info *network,
 =

 	network->connected_time =3D connected_time;
 =

-	l_settings_get_bool(settings, "Settings", "Hidden", &is_hidden);
+	if (!l_settings_get_bool(settings, "Settings", "Hidden", &is_hidden))
+		is_hidden =3D false;
 =

 	if (network->is_hidden !=3D is_hidden) {
 		if (network->is_hidden && !is_hidden)
-- =

2.13.6

--===============4712673382095785199==--

