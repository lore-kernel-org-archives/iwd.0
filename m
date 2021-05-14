Content-Type: multipart/mixed; boundary="===============7962993629579482472=="
MIME-Version: 1.0
From: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
Subject: [PATCH] network: use L_AUTO_FREE_VAR
Date: Fri, 14 May 2021 18:36:40 +0200
Message-ID: <20210514163640.305070-1-Marc-Antoine@Perennou.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7962993629579482472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
---
 src/network.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index 9e858663..0eb3687e 100644
--- a/src/network.c
+++ b/src/network.c
@@ -380,10 +380,10 @@ static int network_load_psk(struct network *network, =
bool need_passphrase)
 	size_t psk_len;
 	uint8_t *psk =3D l_settings_get_bytes(network->settings, "Security",
 						"PreSharedKey", &psk_len);
-	_auto_(l_free) char *passphrase =3D
+	L_AUTO_FREE_VAR(char *, passphrase) =3D
 			l_settings_get_string(network->settings,
 						"Security", "Passphrase");
-	_auto_(l_free) char *path =3D
+	L_AUTO_FREE_VAR(char *, path) =3D
 		storage_get_network_file_path(security, ssid);
 	int r;
 =

-- =

2.30.0

--===============7962993629579482472==--

