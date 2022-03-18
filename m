Content-Type: multipart/mixed; boundary="===============5061011714245457852=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/6] wired: check return of modify_membership
Date: Fri, 18 Mar 2022 09:44:19 -0700
Message-ID: <20220318164420.739968-5-prestwoj@gmail.com>
In-Reply-To: 20220318164420.739968-1-prestwoj@gmail.com

--===============5061011714245457852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This could fail and was not being checked. It was minimally changed to
take the ifindex directly (this was the only thing needed from the ethdev)
which allows checking prior to initializing the ethdev.
---
 wired/ethdev.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/wired/ethdev.c b/wired/ethdev.c
index db5a9ac9..e5353582 100644
--- a/wired/ethdev.c
+++ b/wired/ethdev.c
@@ -391,7 +391,7 @@ static char *read_devtype_from_uevent(const char *ifnam=
e)
 	return devtype;
 }
 =

-static int modify_membership(struct ethdev *dev, int optname)
+static int modify_membership(uint32_t index, int optname)
 {
 	struct packet_mreq mreq;
 	int fd;
@@ -401,7 +401,7 @@ static int modify_membership(struct ethdev *dev, int op=
tname)
 		return -1;
 =

 	memset(&mreq, 0, sizeof(mreq));
-	mreq.mr_ifindex =3D dev->index;
+	mreq.mr_ifindex =3D index;
 	mreq.mr_type =3D PACKET_MR_MULTICAST;
 	mreq.mr_alen =3D ETH_ALEN;
 	memcpy(mreq.mr_address, pae_group_addr, ETH_ALEN);
@@ -415,7 +415,8 @@ static void ethdev_free(void *data)
 =

 	l_debug("Freeing device %s", dev->ifname);
 =

-	modify_membership(dev, PACKET_DROP_MEMBERSHIP);
+	if (modify_membership(dev->index, PACKET_DROP_MEMBERSHIP) < 0)
+		l_error("Failed to drop membership");
 =

 	l_queue_destroy(dev->eapol_sessions, eapol_free);
 =

@@ -521,6 +522,11 @@ static void newlink_notify(const struct ifinfomsg *ifi=
, int bytes)
 			}
 		}
 =

+		if (modify_membership(index, PACKET_ADD_MEMBERSHIP) < 0) {
+			l_error("Failed to add membership");
+			return;
+		}
+
 		dev =3D l_new(struct ethdev, 1);
 		dev->index =3D index;
 		dev->active =3D active;
@@ -532,8 +538,6 @@ static void newlink_notify(const struct ifinfomsg *ifi,=
 int bytes)
 =

 		l_debug("Creating device %u", dev->index);
 =

-		modify_membership(dev, PACKET_ADD_MEMBERSHIP);
-
 		l_dbus_object_add_interface(dbus_app_get(), dev->path,
 						ADAPTER_INTERFACE, dev);
 =

-- =

2.34.1

--===============5061011714245457852==--

