Content-Type: multipart/mixed; boundary="===============4715009319305665668=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: zero out diagnostic info
Date: Wed, 28 Apr 2021 09:21:13 -0700
Message-ID: <20210428162113.141720-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4715009319305665668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The info struct is on the stack which leads to the potential
for uninitialized data access. Zero out the info struct prior
to calling the get station callback:

=3D=3D141137=3D=3D Conditional jump or move depends on uninitialised value(=
s)
=3D=3D141137=3D=3D    at 0x458A6F: diagnostic_info_to_dict (diagnostic.c:10=
9)
=3D=3D141137=3D=3D    by 0x41200B: station_get_diagnostic_cb (station.c:362=
0)
=3D=3D141137=3D=3D    by 0x405BE1: netdev_get_station_cb (netdev.c:4783)
=3D=3D141137=3D=3D    by 0x4722F9: process_unicast (genl.c:994)
=3D=3D141137=3D=3D    by 0x4722F9: received_data (genl.c:1102)
=3D=3D141137=3D=3D    by 0x46F28B: io_callback (io.c:120)
=3D=3D141137=3D=3D    by 0x46E5AC: l_main_iterate (main.c:478)
=3D=3D141137=3D=3D    by 0x46E65B: l_main_run (main.c:525)
=3D=3D141137=3D=3D    by 0x46E65B: l_main_run (main.c:507)
=3D=3D141137=3D=3D    by 0x46E86B: l_main_run_with_signal (main.c:647)
=3D=3D141137=3D=3D    by 0x403EA8: main (main.c:490)
---
 src/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index e9fa241f..ca38fa27 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4759,6 +4759,8 @@ static void netdev_get_station_cb(struct l_genl_msg *=
msg, void *user_data)
 	if (!l_genl_attr_init(&attr, msg))
 		goto parse_error;
 =

+	memset(&info, 0, sizeof(info));
+
 	while (l_genl_attr_next(&attr, &type, &len, &data)) {
 		switch (type) {
 		case NL80211_ATTR_STA_INFO:
-- =

2.26.2

--===============4715009319305665668==--

