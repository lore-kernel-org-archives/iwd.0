Content-Type: multipart/mixed; boundary="===============4409783674220476836=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/13] p2p: Set p2p_own_wfd->available by default
Date: Fri, 31 Jul 2020 03:31:30 +0200
Message-ID: <20200731013136.65057-7-andrew.zaborowski@intel.com>
In-Reply-To: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4409783674220476836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to set this flag true when the WFD service is first registered
as there's no WFD session and we're available for a new session.
---
 src/p2p.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/p2p.c b/src/p2p.c
index 06416bd8..da98f2a7 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -4327,6 +4327,9 @@ static struct l_dbus_message *p2p_wfd_register(struct=
 l_dbus *dbus,
 	if (p2p_own_wfd)
 		return dbus_error_already_exists(message);
 =

+	/* Available for WFD Session by default */
+	props.available =3D true;
+
 	p2p_wfd_disconnect_watch =3D l_dbus_add_disconnect_watch(dbus,
 					l_dbus_message_get_sender(message),
 					p2p_wfd_disconnect_watch_cb, NULL,
-- =

2.25.1

--===============4409783674220476836==--

