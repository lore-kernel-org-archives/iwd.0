Content-Type: multipart/mixed; boundary="===============3820624489329329266=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/5] station: support full MAC randomization and override
Date: Thu, 19 Mar 2020 15:58:59 -0700
Message-ID: <20200319225902.16249-2-prestwoj@gmail.com>
In-Reply-To: <20200319225902.16249-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3820624489329329266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds two new options to a network provisioning file:

AlwaysRandomizeAddress=3D{true,false}

If true, IWD will randomize the MAC address on each connection to this
network. The address does not persists between connections, any new
connection will result in a different MAC.

AddressOverride=3D<MAC>

If set, the MAC address will be set to <MAC> assuming its a valid MAC
address.

These two options should not be used together, and will only take effect
if [General].AddressRandomization is set to 'network' in the IWD
config file.

If neither of these options are set, and [General].AddressRandomization
is set to 'network', the default behavior remains the same; the MAC
will be generated deterministically on a per-network basis.
---
 src/station.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/src/station.c b/src/station.c
index 36b41f64..ca47568c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -875,6 +875,10 @@ static struct handshake_state *station_handshake_setup=
(struct station *station,
 	struct handshake_state *hs;
 	const char *ssid;
 	uint32_t eapol_proto_version;
+	const char *value;
+	bool full_random;
+	bool override =3D false;
+	uint8_t new_addr[ETH_ALEN];
 =

 	hs =3D netdev_handshake_state_new(station->netdev);
 =

@@ -934,6 +938,42 @@ static struct handshake_state *station_handshake_setup=
(struct station *station,
 				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))
 		hs->erp_cache =3D erp_cache_get(network_get_ssid(network));
 =

+	/*
+	 * We have three possible options here:
+	 * 1. per-network MAC generation (default, no option in network config)
+	 * 2. per-network full MAC randomization
+	 * 3. per-network MAC override
+	 */
+
+	if (!l_settings_get_bool(settings, "Settings",
+					"AlwaysRandomizeAddress",
+					&full_random))
+		full_random =3D false;
+
+	value =3D l_settings_get_value(settings, "Settings",
+					"AddressOverride");
+	if (value) {
+		if (util_string_to_address(value, new_addr) &&
+					util_is_valid_sta_address(new_addr))
+			override =3D true;
+		else
+			l_warn("[Network].AddressOverride is not a valid "
+				"MAC address");
+	}
+
+	if (override && full_random) {
+		l_warn("Cannot use both AlwaysRandomizeAddress and "
+			"AddressOverride concurrently, defaulting to override");
+		full_random =3D false;
+	}
+
+	if (override)
+		handshake_state_set_supplicant_address(hs, new_addr);
+	else if (full_random) {
+		wiphy_generate_random_address(wiphy, new_addr);
+		handshake_state_set_supplicant_address(hs, new_addr);
+	}
+
 	return hs;
 =

 no_psk:
-- =

2.21.1

--===============3820624489329329266==--

