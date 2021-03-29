Content-Type: multipart/mixed; boundary="===============7502250245041962193=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] netdev: remove unneeded goto/return code
Date: Mon, 29 Mar 2021 13:43:51 -0700
Message-ID: <20210329204351.718429-3-prestwoj@gmail.com>
In-Reply-To: <20210329204351.718429-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7502250245041962193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All possible paths led to the same result so it was
simplified to remove two goto's and a return call.
---
 src/netdev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index fcbb7d88..914f6479 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2234,12 +2234,7 @@ static void netdev_authenticate_event(struct l_genl_=
msg *msg,
 			return;
 		else if (ret > 0)
 			status_code =3D (uint16_t)ret;
-
-		goto auth_error;
-	} else
-		goto auth_error;
-
-	return;
+	}
 =

 auth_error:
 	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
-- =

2.26.2

--===============7502250245041962193==--

