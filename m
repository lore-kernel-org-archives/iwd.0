Content-Type: multipart/mixed; boundary="===============0416971016316525862=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] p2p: Fix the WSC Config Methods in GO Negotiation Response
Date: Tue, 25 Aug 2020 04:45:33 +0200
Message-ID: <20200825024534.484304-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200825024534.484304-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0416971016316525862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When we send our GO Negotiation Response, send the Configuration Method
selected for the current connection rather than the accepted methods mask
that we hold in dev->device_info.
---
 src/p2p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/p2p.c b/src/p2p.c
index 7772080b..f8ed88db 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1840,6 +1840,7 @@ respond:
 =

 	p2p_device_fill_channel_list(dev, &resp_info.channel_list);
 	resp_info.device_info =3D dev->device_info;
+	resp_info.device_info.wsc_config_methods =3D dev->conn_config_method;
 	resp_info.device_password_id =3D dev->conn_password_id;
 =

 	if (dev->conn_own_wfd) {
-- =

2.25.1

--===============0416971016316525862==--

