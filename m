Content-Type: multipart/mixed; boundary="===============1147981786445609098=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] network: free psk on error
Date: Mon, 08 Feb 2021 14:09:11 -0800
Message-ID: <20210208220911.616583-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1147981786445609098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c | 2 ++
 1 file changed, 2 insertions(+)

v2:
 * Free psk in all cases as its never used past this point

diff --git a/src/network.c b/src/network.c
index 7cae413f..5a8d93ee 100644
--- a/src/network.c
+++ b/src/network.c
@@ -399,6 +399,8 @@ static int network_load_psk(struct network *network, bo=
ol need_passphrase)
 			return 0;
 		}
 =

+		l_free(psk);
+
 		path =3D storage_get_network_file_path(security, ssid);
 		l_error("%s: invalid PreSharedKey format", path);
 		l_free(path);
-- =

2.26.2

--===============1147981786445609098==--

