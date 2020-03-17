Content-Type: multipart/mixed; boundary="===============4737854326552203915=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/7] station: print error message if setting MAC failed
Date: Tue, 17 Mar 2020 10:38:54 -0700
Message-ID: <20200317173855.19680-6-prestwoj@gmail.com>
In-Reply-To: <20200317173855.19680-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4737854326552203915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is to provide a better hint to a user of exactly what went
wrong since the error is not related to the actual connection
attmempt, and rather some kind of kernel problem.
---
 src/station.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/station.c b/src/station.c
index 6ec7eb4b..cd93b97c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2251,6 +2251,10 @@ static void station_connect_cb(struct netdev *netdev=
, enum netdev_result result,
 			return;
 =

 		break;
+	case NETDEV_RESULT_SET_MAC_FAILED:
+		l_error("failed to set MAC address during connection, try "
+			" turning off AddressRandomization=3Dnetwork option");
+		break;
 	default:
 		break;
 	}
-- =

2.21.1

--===============4737854326552203915==--

