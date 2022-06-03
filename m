Content-Type: multipart/mixed; boundary="===============4829940546606977517=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] network: fix handling of
 AlwaysRandomizeAddress/AddressOverride
Date: Fri, 03 Jun 2022 13:54:27 -0700
Message-ID: <20220603205427.216954-1-prestwoj@gmail.com>

--===============4829940546606977517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For network configuration files the man pages (iwd.network) state
that [General].{AlwaysRandomizeAddress,AddressOverride} are only
used if main.conf has [General].AddressRandomization=3Dnetwork.

This actually was not being enforced and both iwd.network settings
were still taken into account regardless of what AddressRandomization
was set to (even disabled).

The handshake setup code now checks the AddressRandomization value
and if anything other than 'network' skips the randomization.
---
 src/network.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/network.c b/src/network.c
index 7bc97121..70cb925c 100644
--- a/src/network.c
+++ b/src/network.c
@@ -485,10 +485,12 @@ int network_handshake_setup(struct network *network, =
struct scan_bss *bss,
 	struct station *station =3D network->station;
 	struct wiphy *wiphy =3D station_get_wiphy(station);
 	struct l_settings *settings =3D network->settings;
+	const struct l_settings *config =3D iwd_get_config();
 	struct network_info *info =3D network->info;
 	uint32_t eapol_proto_version;
 	uint8_t new_addr[ETH_ALEN];
 	int r;
+	const char *str;
 =

 	switch (network->security) {
 	case SECURITY_PSK:
@@ -523,6 +525,15 @@ int network_handshake_setup(struct network *network, s=
truct scan_bss *bss,
 		handshake_state_set_protocol_version(hs, eapol_proto_version);
 	}
 =

+	/*
+	 * The randomization options in the provisioning file are dependent on
+	 * main.conf: [General].AddressRandomization=3Dnetwork. Any other value
+	 * should disqualify the three network-specific settings below.
+	 */
+	str =3D l_settings_get_value(config, "General", "AddressRandomization");
+	if (!(str && !strcmp(str, "network")))
+		return 0;
+
 	/*
 	 * We have three possible options here:
 	 * 1. per-network MAC generation (default, no option in network config)
-- =

2.34.1

--===============4829940546606977517==--

