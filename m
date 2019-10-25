Content-Type: multipart/mixed; boundary="===============7405865270366151804=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] network: add L_WARN for known network lookup failure
Date: Fri, 25 Oct 2019 12:53:21 -0400
Message-ID: <20191025165321.19718-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7405865270366151804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When updating the network ranking there was a potential out of bounds
array access. The condition was if known_network_offset returned a
negative value, indicating the known network was not found. Since
network->info is only set for known networks this should not ever
happen as network->info is checked prior.

Though this is likely impossible, knownnetworks is complex enough that
its better to just be paranoid and put an L_WARN_ON to check the
return.
---
 src/network.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/network.c b/src/network.c
index 3270b57c..0f29022b 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1376,6 +1376,8 @@ void network_rank_update(struct network *network, boo=
l connected)
 	if (network->info->connected_time !=3D 0) {
 		int n =3D known_network_offset(network->info);
 =

+		L_WARN_ON(n < 0);
+
 		if (n >=3D (int) L_ARRAY_SIZE(rankmod_table))
 			n =3D L_ARRAY_SIZE(rankmod_table) - 1;
 =

-- =

2.21.0

--===============7405865270366151804==--

