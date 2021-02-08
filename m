Content-Type: multipart/mixed; boundary="===============7900643594079213036=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] network: free psk on error
Date: Mon, 08 Feb 2021 13:18:12 -0800
Message-ID: <20210208211812.612391-3-prestwoj@gmail.com>
In-Reply-To: <20210208211812.612391-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7900643594079213036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/network.c b/src/network.c
index 7cae413f..8f129718 100644
--- a/src/network.c
+++ b/src/network.c
@@ -403,8 +403,10 @@ static int network_load_psk(struct network *network, b=
ool need_passphrase)
 		l_error("%s: invalid PreSharedKey format", path);
 		l_free(path);
 =

-		if (!passphrase)
+		if (!passphrase) {
+			l_free(psk);
 			return -EINVAL;
+		}
 	}
 =

 	network->psk =3D l_malloc(32);
-- =

2.26.2

--===============7900643594079213036==--

