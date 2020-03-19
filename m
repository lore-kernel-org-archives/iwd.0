Content-Type: multipart/mixed; boundary="===============5671499977342003553=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/5] netdev: honor handshake->spa if set
Date: Thu, 19 Mar 2020 15:59:00 -0700
Message-ID: <20200319225902.16249-3-prestwoj@gmail.com>
In-Reply-To: <20200319225902.16249-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5671499977342003553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to support AlwaysRandomizeAddress and AddressOverride, station will
set the desired address into the handshake object. Then, netdev checks if
this was done and will use that address rather than generate one.
---
 src/netdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index e1c775be..e1afeb63 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2560,8 +2560,13 @@ static int netdev_start_powered_mac_change(struct ne=
tdev *netdev,
 	struct rtnl_data *req;
 	uint8_t new_addr[6];
 =

-	wiphy_generate_address_from_ssid(netdev->wiphy, (const char *)bss->ssid,
+	/* No address set in handshake, use per-network MAC generation */
+	if (util_mem_is_zero(netdev->handshake->spa, ETH_ALEN))
+		wiphy_generate_address_from_ssid(netdev->wiphy,
+						(const char *)bss->ssid,
 						new_addr);
+	else
+		memcpy(new_addr, netdev->handshake->spa, ETH_ALEN);
 =

 	/*
 	 * MAC has already been changed previously, no need to again
-- =

2.21.1

--===============5671499977342003553==--

