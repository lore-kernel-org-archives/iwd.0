Content-Type: multipart/mixed; boundary="===============7740987394795502339=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] netdev: better handle associate timeouts with auth_protos
Date: Mon, 29 Mar 2021 13:17:14 -0700
Message-ID: <20210329201716.716947-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7740987394795502339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Any auth proto which did not implement the assoc_timeout handler
could end up getting 'stuck' forever if there was an associate
timeout. This is because in the event of an associate timeout IWD
only sets a few flags and relies on the connect event to actually
handle the failure. The problem is a connect event never comes
when using CMD_AUTH/ASSOC directly.

To fix this we can explicitly fail the connection if the auth
proto has not implemented assoc_timeout or if it returns false.
---
 src/netdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 8d3f4a08..d5bad57e 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2339,6 +2339,16 @@ static void netdev_associate_event(struct l_genl_msg=
 *msg,
 	return;
 =

 assoc_failed:
+	/*
+	 * There will be no connect event when using Auth/Assoc directly so
+	 * the failed connection must be explicitly initiated here.
+	 */
+	if (netdev->ap) {
+		netdev_connect_failed(netdev, NETDEV_RESULT_ASSOCIATION_FAILED,
+					status_code);
+		return;
+	}
+
 	netdev->result =3D NETDEV_RESULT_ASSOCIATION_FAILED;
 	netdev->last_code =3D status_code;
 	netdev->expect_connect_failure =3D true;
-- =

2.26.2

--===============7740987394795502339==--

