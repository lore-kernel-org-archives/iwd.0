Content-Type: multipart/mixed; boundary="===============3869331686847989715=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] network: fix double whitespace
Date: Mon, 24 Jan 2022 11:18:02 -0800
Message-ID: <20220124191802.2970092-1-prestwoj@gmail.com>

--===============3869331686847989715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/network.c b/src/network.c
index 68049c54..2d3c9bbc 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1358,7 +1358,7 @@ static struct l_dbus_message *network_connect_psk(str=
uct network *network,
 	 */
 	bool need_passphrase =3D bss_is_sae(bss);
 =

-	if  (!network_settings_load(network)) {
+	if (!network_settings_load(network)) {
 		network->settings =3D l_settings_new();
 		network->ask_passphrase =3D true;
 	} else if (!network->ask_passphrase)
-- =

2.31.1

--===============3869331686847989715==--

