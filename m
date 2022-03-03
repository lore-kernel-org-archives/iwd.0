Content-Type: multipart/mixed; boundary="===============4360381674866530968=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2] knownnetworks: use band_freq_to_channel to verify known
 freqs
Date: Thu, 03 Mar 2022 12:09:55 -0800
Message-ID: <20220303200955.3454945-1-prestwoj@gmail.com>

--===============4360381674866530968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the addition of 6GHz '6000' is no longer the maximum frequency
that could be in .known_network.freq. For more robustness
band_freq_to_channel is used to validate the frequency.
---
 src/knownnetworks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 87df8b4d..bc603048 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -45,6 +45,7 @@
 #include "src/scan.h"
 #include "src/util.h"
 #include "src/watchlist.h"
+#include "src/band.h"
 =

 static struct l_queue *known_networks;
 static size_t num_known_hidden_networks;
@@ -856,7 +857,8 @@ static struct l_queue *known_frequencies_from_string(ch=
ar *freq_set_str)
 =

 		t =3D strtoul(freq_set_str, &freq_set_str, 10);
 =

-		if (unlikely(errno =3D=3D ERANGE || !t || t > 6000))
+		if (unlikely(errno =3D=3D ERANGE || !t ||
+					!band_freq_to_channel(t, NULL)))
 			goto error;
 =

 		known_freq =3D l_new(struct known_frequency, 1);
-- =

2.34.1

--===============4360381674866530968==--

