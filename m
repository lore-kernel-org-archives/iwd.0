Content-Type: multipart/mixed; boundary="===============5183933219564916301=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] netdev: better handle associate timeouts with
 auth_protos
Date: Mon, 29 Mar 2021 13:43:49 -0700
Message-ID: <20210329204351.718429-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5183933219564916301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Any auth proto which did not implement the assoc_timeout handler
could end up getting 'stuck' forever if there was an associate
timeout. This is because in the event of an associate timeout IWD
only sets a few flags and relies on the connect event to actually
handle the failure. The problem is a connect event never comes
if the failure was a timeout.

To fix this we can explicitly fail the connection if the auth
proto has not implemented assoc_timeout or if it returns false.
---
 src/netdev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

v2:
 * Moved the failure into the actual timeout case as the
   connect event *does* come unless there was a timeout

diff --git a/src/netdev.c b/src/netdev.c
index 8d3f4a08..fcbb7d88 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2280,7 +2280,15 @@ static void netdev_associate_event(struct l_genl_msg=
 *msg,
 			if (auth_proto_assoc_timeout(netdev->ap))
 				return;
 =

-			goto assoc_failed;
+			/*
+			 * There will be no connect event when Associate times
+			 * out. The failed connection must be explicitly
+			 * initiated here.
+			 */
+			netdev_connect_failed(netdev,
+					NETDEV_RESULT_ASSOCIATION_FAILED,
+					status_code);
+			return;
 =

 		case NL80211_ATTR_FRAME:
 			frame =3D data;
-- =

2.26.2

--===============5183933219564916301==--

