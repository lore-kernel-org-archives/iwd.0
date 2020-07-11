Content-Type: multipart/mixed; boundary="===============9183628034055739619=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/18] p2p: Initialize dev->discovery_users in
 p2p_device_request_discovery
Date: Sat, 11 Jul 2020 03:00:38 +0200
Message-ID: <20200711010053.224223-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9183628034055739619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure dev->discovery_users points at a queue before we try adding
user records to it.
---
 src/p2p.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index c043f4c9..c3e4d8dd 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -3416,6 +3416,9 @@ static struct l_dbus_message *p2p_device_request_disc=
overy(struct l_dbus *dbus,
 				l_dbus_message_get_sender(message)))
 		return dbus_error_already_exists(message);
 =

+	if (!dev->discovery_users)
+		dev->discovery_users =3D l_queue_new();
+
 	user =3D l_new(struct p2p_discovery_user, 1);
 	user->client =3D l_strdup(l_dbus_message_get_sender(message));
 	user->dev =3D dev;
-- =

2.25.1

--===============9183628034055739619==--

