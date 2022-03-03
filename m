Content-Type: multipart/mixed; boundary="===============6229691109113590670=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] knownnetworks: update known frequencies maximum to 7115
Date: Thu, 03 Mar 2022 09:22:34 -0800
Message-ID: <20220303172234.3447411-1-prestwoj@gmail.com>

--===============6229691109113590670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the addition of 6GHz '6000' is no longer the maximum frequency
that could be in .known_network.freq.
---
 src/knownnetworks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 87df8b4d..fc024333 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -856,7 +856,7 @@ static struct l_queue *known_frequencies_from_string(ch=
ar *freq_set_str)
 =

 		t =3D strtoul(freq_set_str, &freq_set_str, 10);
 =

-		if (unlikely(errno =3D=3D ERANGE || !t || t > 6000))
+		if (unlikely(errno =3D=3D ERANGE || !t || t > 7115))
 			goto error;
 =

 		known_freq =3D l_new(struct known_frequency, 1);
-- =

2.34.1

--===============6229691109113590670==--

