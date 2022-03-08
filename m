Content-Type: multipart/mixed; boundary="===============7092496715501525508=="
MIME-Version: 1.0
From: VAUTRIN Emmanuel (Canal Plus Prestataire) <Emmanuel.VAUTRIN at
 cpexterne.org>
To: iwd at lists.01.org
Subject: [PATCH] network: Hide hidden networks on passphrase error
Date: Tue, 08 Mar 2022 10:59:56 +0000
Message-ID: <
 <MRZP264MB1544C0BDFAF731AC2E61806693099@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>>
In-Reply-To: 20220308105408.226598-1-Emmanuel.VAUTRIN@cpexterne.org

--===============7092496715501525508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a user connection fails on a freshly scanned psk hidden network,
during passphrase request, it shall be removed from the network list.
Otherwise, it would be possible to directly connect to that known
network, which will appear as not hidden.

Commit 06ca8e20a9b0 ("station: Hide forgotten hidden networks")
---
 src/network.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/network.c b/src/network.c
index d7f472be97d2..ef3df96bab42 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1204,6 +1204,7 @@ static void passphrase_callback(enum agent_result res=
ult,
 	struct network *network =3D user_data;
 	struct station *station =3D network->station;
 	struct scan_bss *bss;
+	bool was_hidden;
 =

 	l_debug("result %d", result);
 =

@@ -1242,6 +1243,13 @@ static void passphrase_callback(enum agent_result re=
sult,
 	return;
 =

 err:
+	if (!network->settings || !l_settings_get_bool(network->settings,
+						NET_HIDDEN, &was_hidden))
+		was_hidden =3D false;
+
+	if (was_hidden)
+		station_hide_network(station, network);
+
 	network_settings_close(network);
 }
 =

-- =

2.25.1


--===============7092496715501525508==--

