Content-Type: multipart/mixed; boundary="===============5598959583279602627=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] p2p: Send the right UUID-E in probe request WSC IEs
Date: Tue, 25 Aug 2020 04:45:32 +0200
Message-ID: <20200825024534.484304-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5598959583279602627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When building the scan IEs for our provisioning scans, use the UUID-E
based on the Interface Address, not the Device Address, as that is what
wsc.c will be using to in the registration protocol.

Eventually we may have to base the UUID-E on the Device Address or
something else that is persistent, and pass the actual UUID-E to wsc.c,
as the Interface Address is randomly generated on every connect attempt.
IIRC the UUID-E is supposed to be persistent.
---
 src/p2p.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index 3b38f738..7772080b 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -329,6 +329,7 @@ static uint8_t *p2p_build_scan_ies(struct p2p_device *d=
ev, uint8_t *buf,
 	size_t wsc_ie_size;
 	uint8_t wfd_ie[32];
 	size_t wfd_ie_size;
+	const uint8_t *addr;
 =

 	p2p_info.capability =3D dev->capability;
 	memcpy(p2p_info.listen_channel.country, dev->listen_country, 3);
@@ -350,7 +351,14 @@ static uint8_t *p2p_build_scan_ies(struct p2p_device *=
dev, uint8_t *buf,
 	wsc_info.request_type =3D WSC_REQUEST_TYPE_ENROLLEE_INFO;
 	wsc_info.config_methods =3D dev->device_info.wsc_config_methods;
 =

-	if (!wsc_uuid_from_addr(dev->addr, wsc_info.uuid_e))
+	/*
+	 * If we're doing the provisioning scan, we need to use the same UUID-E
+	 * that we'll use in the WSC enrollee registration protocol because the
+	 * GO might validate it.
+	 */
+	addr =3D dev->conn_peer ? dev->conn_addr : dev->addr;
+
+	if (!wsc_uuid_from_addr(addr, wsc_info.uuid_e))
 		return NULL;
 =

 	wsc_info.primary_device_type =3D dev->device_info.primary_device_type;
-- =

2.25.1

--===============5598959583279602627==--

