Content-Type: multipart/mixed; boundary="===============4558787100358873602=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 05/13] network: set handshake SSID based on BSS, not network
Date: Wed, 15 Sep 2021 10:36:16 -0700
Message-ID: <20210915173624.11917-5-prestwoj@gmail.com>
In-Reply-To: 20210915173624.11917-1-prestwoj@gmail.com

--===============4558787100358873602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is being added to support OWE transition mode. For these
type of networks the OWE BSS may contain a different SSID than
that of the network, but the WFA spec requires this be hidden
from the user. This means we need to set the handshake SSID based
on the BSS rather than the network object.
---
 src/network.c | 5 ++---
 src/network.h | 2 +-
 src/station.c | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/network.c b/src/network.c
index d81a201d..4a6cf3ae 100644
--- a/src/network.c
+++ b/src/network.c
@@ -465,7 +465,7 @@ static int network_set_handshake_secrets_psk(struct net=
work *network,
 	return 0;
 }
 =

-int network_handshake_setup(struct network *network,
+int network_handshake_setup(struct network *network, struct scan_bss *bss,
 						struct handshake_state *hs)
 {
 	struct station *station =3D network->station;
@@ -492,8 +492,7 @@ int network_handshake_setup(struct network *network,
 		return -ENOTSUP;
 	}
 =

-	handshake_state_set_ssid(hs, (void *) network->ssid,
-						strlen(network->ssid));
+	handshake_state_set_ssid(hs, bss->ssid, bss->ssid_len);
 =

 	if (settings && l_settings_get_uint(settings, "EAPoL",
 						"ProtocolVersion",
diff --git a/src/network.h b/src/network.h
index 39375703..5451815b 100644
--- a/src/network.h
+++ b/src/network.h
@@ -50,7 +50,7 @@ bool network_set_psk(struct network *network, const uint8=
_t *psk);
 int network_set_transition_disable(struct network *network,
 					const uint8_t *td, size_t len);
 =

-int network_handshake_setup(struct network *network,
+int network_handshake_setup(struct network *network, struct scan_bss *bss,
 						struct handshake_state *hs);
 =

 void network_sync_settings(struct network *network);
diff --git a/src/station.c b/src/station.c
index a6140766..2846d3d2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -935,7 +935,7 @@ static struct handshake_state *station_handshake_setup(=
struct station *station,
 =

 	handshake_state_set_authenticator_rsnxe(hs, bss->rsnxe);
 =

-	if (network_handshake_setup(network, hs) < 0)
+	if (network_handshake_setup(network, bss, hs) < 0)
 		goto not_supported;
 =

 	vendor_ies =3D network_info_get_extra_ies(info, bss, &iov_elems);
-- =

2.31.1

--===============4558787100358873602==--

