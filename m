Content-Type: multipart/mixed; boundary="===============1290783402338838345=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 7/8] rrm: React to IFTYPE_CHANGE events
Date: Tue, 20 Apr 2021 11:35:18 -0500
Message-ID: <20210420163519.12375-7-denkenz@gmail.com>
In-Reply-To: <20210420163519.12375-1-denkenz@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1290783402338838345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a netdev iftype is changed, all frame registrations are removed.
Make sure to re-register for the appropriate frame notifications in case
our iftype is switched back to 'station'.  In any other iftype, no frame
watches are registered and rrm_state object is effectively dormant.
---
 src/rrm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/rrm.c b/src/rrm.c
index 71442abb105f..889402561c8a 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -835,7 +835,15 @@ static void rrm_netdev_watch(struct netdev *netdev,
 			l_free(rrm);
 		}
 =

-		return;
+		break;
+	case NETDEV_WATCH_EVENT_IFTYPE_CHANGE:
+		rrm =3D l_queue_find(states, match_ifindex,
+						L_UINT_TO_PTR(ifindex));
+
+		if (rrm && netdev_get_iftype(netdev) =3D=3D NETDEV_IFTYPE_STATION)
+			rrm_add_frame_watches(rrm);
+
+		break;
 	default:
 		break;
 	}
-- =

2.26.3

--===============1290783402338838345==--

