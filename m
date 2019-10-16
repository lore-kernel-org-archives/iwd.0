Content-Type: multipart/mixed; boundary="===============5590538197177216614=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/10] anqp: fix potential NULL pointer dereference
Date: Wed, 16 Oct 2019 15:29:44 -0700
Message-ID: <20191016222953.513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5590538197177216614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/anqp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/anqp.c b/src/anqp.c
index a47530ab..5e867656 100644
--- a/src/anqp.c
+++ b/src/anqp.c
@@ -287,6 +287,9 @@ uint32_t anqp_request(uint32_t ifindex, const uint8_t *=
addr,
 	uint32_t duration =3D 300;
 	struct netdev *netdev =3D netdev_find(ifindex);
 =

+	if (!netdev)
+		return 0;
+
 	/*
 	 * TODO: Netdev dependencies will eventually be removed so we need
 	 * another way to figure out wiphy capabilities.
-- =

2.17.1

--===============5590538197177216614==--

