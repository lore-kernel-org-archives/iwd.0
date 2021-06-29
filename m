Content-Type: multipart/mixed; boundary="===============7130962098529304460=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: [PATCH] Add capability for port in restricted range.
Date: Tue, 29 Jun 2021 17:07:00 +0100
Message-ID: <20210629160700.133768-1-mjohnson459@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7130962098529304460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes an issue where the udp port was not being opened due to a
permission denied error. The result of this was the dhcp client would
fail to send the renewal request and so the dhcp lease would expire.

The addition of the CAP_NET_BIND_SERVICE capability allows the service
to open sockets in the restricted port range (<1024) which is required
for dhcp.
---
 src/iwd.service.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/iwd.service.in b/src/iwd.service.in
index 96e4abac..ab0a5da7 100644
--- a/src/iwd.service.in
+++ b/src/iwd.service.in
@@ -11,7 +11,7 @@ ExecStart=3D@libexecdir@/iwd
 NotifyAccess=3Dmain
 LimitNPROC=3D1
 Restart=3Don-failure
-CapabilityBoundingSet=3DCAP_NET_ADMIN CAP_NET_RAW
+CapabilityBoundingSet=3DCAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE
 PrivateTmp=3Dtrue
 NoNewPrivileges=3Dtrue
 DevicePolicy=3Dclosed
-- =

2.25.1

--===============7130962098529304460==--

