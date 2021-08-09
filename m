Content-Type: multipart/mixed; boundary="===============7608660421254850390=="
MIME-Version: 1.0
From: Matt Oberle <matt.r.oberle@gmail.com>
Subject: [PATCH 2/3] knownnetworks: stat fallback for unknown d_type
Date: Mon, 09 Aug 2021 01:27:25 -0400
Message-ID: <20210809052726.177038-2-matt.r.oberle@gmail.com>
In-Reply-To: <20210809052726.177038-1-matt.r.oberle@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7608660421254850390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Utilize 'storage_is_file' when readdir returns DT_UNKNOWN to ensure
features like autoconnect work on filesystems that don't return a d_type
(eg. XFS).
---
 src/knownnetworks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 85648ead..5c3f432a 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -1071,8 +1071,12 @@ static int known_networks_init(void)
 		struct l_settings *settings;
 		L_AUTO_FREE_VAR(char *, full_path) =3D NULL;
 =

-		if (dirent->d_type !=3D DT_REG && dirent->d_type !=3D DT_LNK)
+		if (dirent->d_type =3D=3D DT_UNKNOWN) {
+			if (!storage_is_file(dirent->d_name))
+				continue;
+		} else if (dirent->d_type !=3D DT_REG && dirent->d_type !=3D DT_LNK) {
 			continue;
+		}
 =

 		ssid =3D storage_network_ssid_from_path(dirent->d_name,
 							&security);
-- =

2.32.0

--===============7608660421254850390==--

