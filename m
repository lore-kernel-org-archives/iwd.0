Content-Type: multipart/mixed; boundary="===============8716745842743247094=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/15] p2putil: Ensure non-negative index in
 p2p_get_random_string
Date: Fri, 04 Jun 2021 03:50:42 +0200
Message-ID: <20210604015052.163727-5-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8716745842743247094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2putil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/p2putil.c b/src/p2putil.c
index 6ea18b74..5313b34c 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -2637,7 +2637,7 @@ void p2p_get_random_string(char *buf, size_t len)
 	l_getrandom(buf, len);
 =

 	while (len) {
-		int index =3D *buf % set_size;
+		int index =3D (uint8_t) *buf % set_size;
 =

 		*buf++ =3D CHARSET[index];
 		len--;
-- =

2.30.2

--===============8716745842743247094==--

