Content-Type: multipart/mixed; boundary="===============3460514792601083776=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/7] ap: Fix an inet_aton error check
Date: Thu, 25 Feb 2021 22:27:20 +0100
Message-ID: <20210225212725.656746-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210225212725.656746-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3460514792601083776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

inet_aton return 0 on error, no a negative number.
---
 src/ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index f7b1cf9f..d9443097 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -213,7 +213,7 @@ static const char *broadcast_from_ip(const char *ip)
 	struct in_addr ia;
 	uint32_t bcast;
 =

-	if (inet_aton(ip, &ia) < 0)
+	if (inet_aton(ip, &ia) !=3D 1)
 		return NULL;
 =

 	bcast =3D ntohl(ia.s_addr);
-- =

2.27.0

--===============3460514792601083776==--

