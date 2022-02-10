Content-Type: multipart/mixed; boundary="===============1751913356408428845=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v7 2/8] knownnetworks: add dependency on storage
Date: Thu, 10 Feb 2022 14:58:36 -0800
Message-ID: <20220210225842.895962-2-prestwoj@gmail.com>
In-Reply-To: 20220210225842.895962-1-prestwoj@gmail.com

--===============1751913356408428845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hotspot should be ok since its dependent on knownnetworks
---
 src/knownnetworks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 30426fe6..56aec5b4 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -1123,6 +1123,7 @@ static void known_networks_exit(void)
 }
 =

 IWD_MODULE(known_networks, known_networks_init, known_networks_exit)
+IWD_MODULE_DEPENDS(known_networks, storage);
 =

 static void known_frequencies_exit(void)
 {
-- =

2.34.1

--===============1751913356408428845==--

