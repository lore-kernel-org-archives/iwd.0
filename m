Content-Type: multipart/mixed; boundary="===============8604726393702868945=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/5] netdev: force SAE group 19 if BSS requires
Date: Wed, 25 Aug 2021 10:12:57 -0700
Message-ID: <20210825171258.764596-4-prestwoj@gmail.com>
In-Reply-To: <20210825171258.764596-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8604726393702868945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 513e22d9..54856f6a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3485,6 +3485,9 @@ static void netdev_connect_common(struct netdev *netd=
ev,
 			}
 		}
 =

+		if (bss->force_default_sae_group)
+			sae_sm_set_force_group_19(netdev->ap);
+
 		break;
 	case IE_RSN_AKM_SUITE_OWE:
 		netdev->ap =3D owe_sm_new(hs, netdev_owe_tx_authenticate,
-- =

2.31.1

--===============8604726393702868945==--

