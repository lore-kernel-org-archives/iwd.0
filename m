Content-Type: multipart/mixed; boundary="===============6074086430304885682=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] ap: free passphrase on error
Date: Mon, 08 Feb 2021 12:19:57 -0800
Message-ID: <20210208201958.607049-4-prestwoj@gmail.com>
In-Reply-To: <20210208201958.607049-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6074086430304885682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ap.c b/src/ap.c
index 8ea26a0d..162b456b 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -2568,6 +2568,7 @@ static int ap_load_profile_and_dhcp(struct ap_state *=
ap, bool *wait_dhcp)
 			if (strlen(passphrase) > 63) {
 				l_error("[Security].Passphrase must not exceed "
 						"63 characters");
+				l_free(passphrase);
 				return -EINVAL;
 			}
 =

-- =

2.26.2

--===============6074086430304885682==--

