Content-Type: multipart/mixed; boundary="===============1841525003353556088=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/7] iwmon: Update to use NL80211_ATTR_SOCKET_OWNER
Date: Thu, 05 Dec 2019 04:22:39 +0100
Message-ID: <20191205032244.5957-2-andrew.zaborowski@intel.com>
In-Reply-To: <20191205032244.5957-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1841525003353556088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

NL80211_ATTR_IFACE_SOCKET_OWNER was renamed to NL80211_ATTR_SOCKET_OWNER.
---
 monitor/nlmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 82acb533..6b0afef8 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -5522,8 +5522,8 @@ static const struct attr_entry attr_table[] =3D {
 			"Max AP Assoc Station" },
 	{ NL80211_ATTR_TDLS_PEER_CAPABILITY,
 			"TDLS Peer Capability", ATTR_U32 },
-	{ NL80211_ATTR_IFACE_SOCKET_OWNER,
-			"Interface Socket Owner", ATTR_FLAG },
+	{ NL80211_ATTR_SOCKET_OWNER,
+			"Socket Owns Interface/Connection", ATTR_FLAG },
 	{ NL80211_ATTR_CSA_C_OFFSETS_TX,
 			"CSA C Offsets TX" },
 	{ NL80211_ATTR_MAX_CSA_COUNTERS,
-- =

2.20.1

--===============1841525003353556088==--

