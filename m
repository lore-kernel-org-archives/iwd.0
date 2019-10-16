Content-Type: multipart/mixed; boundary="===============6071502702320562214=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/2] hotspot: check if HESSID parses correctly
Date: Wed, 16 Oct 2019 16:21:51 -0700
Message-ID: <20191016232151.11778-2-prestwoj@gmail.com>
In-Reply-To: <20191016232151.11778-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6071502702320562214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hotspot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/hotspot.c b/src/hotspot.c
index ad8af37c..e3a7a07a 100644
--- a/src/hotspot.c
+++ b/src/hotspot.c
@@ -342,7 +342,11 @@ static struct hs20_config *hs20_config_new(struct l_se=
ttings *settings,
 	config =3D l_new(struct hs20_config, 1);
 =

 	if (hessid_str) {
-		util_string_to_address(hessid_str, config->hessid);
+		if (!util_string_to_address(hessid_str, config->hessid)) {
+			l_error("Invalid HESSID in settings");
+			goto free_values;
+		}
+
 		l_free(hessid_str);
 	}
 =

-- =

2.17.1

--===============6071502702320562214==--

