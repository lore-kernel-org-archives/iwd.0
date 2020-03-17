Content-Type: multipart/mixed; boundary="===============7505280564233028505=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] manager: add 'network' option to AddressRandomization
Date: Tue, 17 Mar 2020 10:38:53 -0700
Message-ID: <20200317173855.19680-5-prestwoj@gmail.com>
In-Reply-To: <20200317173855.19680-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7505280564233028505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To enable per-network address randomization a new value was added to
the AddressRandomization option. Providing a value of 'network' will
cause the device to generate and set a new MAC address based on the
SSID of the network being connected to.
---
 src/manager.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/manager.c b/src/manager.c
index 05f61b6f..994e70e4 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -748,6 +748,8 @@ static int manager_init(void)
 			mac_type =3D NETDEV_SET_MAC_ONCE;
 		else if (!strcmp(randomize_str, "disabled"))
 			mac_type =3D NETDEV_SET_MAC_DISABLED;
+		else if (!strcmp(randomize_str, "network"))
+			mac_type =3D NETDEV_SET_MAC_NETWORK;
 		else
 			l_warn("Invalid [General].AddressRandomization"
 				" value: %s", randomize_str);
-- =

2.21.1

--===============7505280564233028505==--

