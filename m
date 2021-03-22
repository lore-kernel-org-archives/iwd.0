Content-Type: multipart/mixed; boundary="===============0559057532716229417=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/6] wiphy: check SAE offload in wiphy_can_connect
Date: Mon, 22 Mar 2021 09:01:53 -0700
Message-ID: <20210322160156.392256-3-prestwoj@gmail.com>
In-Reply-To: <20210322160156.392256-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0559057532716229417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows this wiphy_can_connect to pass for an SAE BSS
if the hardware does not support user space SAE, but does
support SAE offload.
---
 src/wiphy.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 89186ce3..676f236c 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -411,15 +411,7 @@ bool wiphy_can_connect(struct wiphy *wiphy, struct sca=
n_bss *bss)
 		switch (rsn_info.akm_suites) {
 		case IE_RSN_AKM_SUITE_SAE_SHA256:
 		case IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256:
-			/*
-			 * if the AP ONLY supports SAE/WPA3, then we can only
-			 * connect if the wiphy feature is supported. Otherwise
-			 * the AP may list SAE as one of the AKM's but also
-			 * support PSK (hybrid). In this case we still want to
-			 * allow a connection even if SAE is not supported.
-			 */
-			if (!wiphy_has_feature(wiphy, NL80211_FEATURE_SAE) ||
-						!wiphy->support_cmds_auth_assoc)
+			if (!wiphy_can_connect_sae(wiphy))
 				return false;
 =

 			break;
-- =

2.26.2

--===============0559057532716229417==--

