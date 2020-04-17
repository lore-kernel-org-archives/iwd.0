Content-Type: multipart/mixed; boundary="===============2803271304462773238=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/2] device: Fix init return type
Date: Fri, 17 Apr 2020 10:20:52 -0700
Message-ID: <20200417172053.14320-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2803271304462773238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index c24d7ed1..171a11b6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -420,7 +420,7 @@ static int device_init(void)
 					IWD_DEVICE_INTERFACE,
 					setup_device_interface,
 					destroy_device_interface, false))
-		return false;
+		return -EPERM;
 =

 	netdev_watch =3D netdev_watch_add(device_netdev_notify, NULL, NULL);
 =

-- =

2.13.6

--===============2803271304462773238==--

