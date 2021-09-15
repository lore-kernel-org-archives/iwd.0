Content-Type: multipart/mixed; boundary="===============7948058603822968858=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 4/7] network: fix pending hidden OWE scan logic
Date: Wed, 15 Sep 2021 16:05:45 -0700
Message-ID: <20210915230548.179425-4-prestwoj@gmail.com>
In-Reply-To: 20210915230548.179425-1-prestwoj@gmail.com

--===============7948058603822968858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was actually broken if triggered because __network_connect
checks if network->connect_after_owe_hidden is set and returns
already in progress. We want to keep this behavior though for
obvious reasons.

To fix this station_connect_network can be called directly which
bypasses the check. This is essentially how ANQP avoids this
problem as well.
---
 src/network.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/network.c b/src/network.c
index 48314a05..4768b872 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1955,11 +1955,9 @@ static void event_watch_changed(enum station_event s=
tate,
 		if (!network->connect_after_owe_hidden)
 			return;
 =

-		reply =3D __network_connect(network,
+		station_connect_network(network->station, network,
 					network_bss_select(network, true),
 					network->connect_after_owe_hidden);
-		if (reply)
-			l_dbus_send(dbus_get_bus(), reply);
 =

 		l_dbus_message_unref(network->connect_after_owe_hidden);
 		network->connect_after_owe_hidden =3D NULL;
-- =

2.31.1

--===============7948058603822968858==--

