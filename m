Content-Type: multipart/mixed; boundary="===============0838428629524872282=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] manager: remove warning for AddressRandomization option
Date: Wed, 18 Mar 2020 11:54:18 -0700
Message-ID: <20200318185420.11432-2-prestwoj@gmail.com>
In-Reply-To: <20200318185420.11432-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0838428629524872282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the 'network' value is handled inside netdev we don't want this warni=
ng
being printed.
---
 src/manager.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index a63f35ee..533975d2 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -759,9 +759,6 @@ static int manager_init(void)
 			randomize =3D true;
 		else if (!strcmp(randomize_str, "disabled"))
 			randomize =3D false;
-		else
-			l_warn("Invalid [General].AddressRandomization"
-				" value: %s", randomize_str);
 	}
 =

 	if (!l_settings_get_bool(config, "General",
-- =

2.21.1

--===============0838428629524872282==--

