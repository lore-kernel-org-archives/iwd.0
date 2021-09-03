Content-Type: multipart/mixed; boundary="===============5423236845352500536=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] netconfig: Actually use the DNS override values
Date: Fri, 03 Sep 2021 22:06:39 +0200
Message-ID: <20210903200640.254482-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5423236845352500536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In netconfig_load_settings apply the DNS overrides strings we've loaded
instead of leaking them.

Fixes: ad228461abbf ("netconfig: Move loading settings to new method, refac=
tor")
---
 src/netconfig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/netconfig.c b/src/netconfig.c
index 9bbaece5..c748630b 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1293,6 +1293,8 @@ bool netconfig_load_settings(struct netconfig *netcon=
fig,
 							mac_address, ETH_ALEN);
 =

 	netconfig->active_settings =3D active_settings;
+	netconfig->dns4_overrides =3D dns4_overrides;
+	netconfig->dns6_overrides =3D dns6_overrides;
 	return true;
 =

 err_v6_addr:
-- =

2.30.2

--===============5423236845352500536==--

