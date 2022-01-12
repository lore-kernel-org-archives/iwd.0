Content-Type: multipart/mixed; boundary="===============8616631308190800443=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 04/10] dpp: put no station device print behind else if
Date: Tue, 11 Jan 2022 16:55:52 -0800
Message-ID: <20220112005558.1158405-4-prestwoj@gmail.com>
In-Reply-To: 20220112005558.1158405-1-prestwoj@gmail.com

--===============8616631308190800443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The previous (incorrect) else was removed since it ended up
printing in most cases since the if clause returned. This should
have been an else if conditional from the start and only print if the
station device was not found.
---
 src/dpp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index c10ec978..5e07a61a 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1717,9 +1717,8 @@ static struct l_dbus_message *dpp_dbus_start_enrollee=
(struct l_dbus *dbus,
 	if (station && station_get_connected_network(station)) {
 		l_warn("cannot be enrollee while connected, please disconnect");
 		return dbus_error_busy(message);
-	}
-
-	l_debug("No station device, continuing anyways...");
+	} else if (!station)
+		l_debug("No station device, continuing anyways...");
 =

 	dpp->uri =3D dpp_generate_uri(dpp->pub_asn1, dpp->pub_asn1_len, 2,
 					netdev_get_address(dpp->netdev), &freq,
-- =

2.31.1

--===============8616631308190800443==--

