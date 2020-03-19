Content-Type: multipart/mixed; boundary="===============7664742640092320795=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] station: support full MAC randomization and override
Date: Thu, 19 Mar 2020 13:03:51 -0700
Message-ID: <20200319200353.7001-2-prestwoj@gmail.com>
In-Reply-To: <20200319200353.7001-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7664742640092320795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds two new options to a network provisioning file:

FullAddressRandomization=3D{true,false}

If true, IWD will randomize the MAC address on each connection to this
network. The address does not persists between connections, any new
connection will result in a different MAC.

AddressOverride=3D<MAC>

If set, the MAC address will be set to <MAC> assuming its a valid MAC
address.

These two options cannot be used together, and will only take effect
if [General].AddressRandomization is set to 'network' in the IWD
config file.

If neither of these options are set, and [General].AddressRandomization
is set to 'network', the default behavior remains the same; the MAC
will be generated deterministically on a per-network basis.
---
 src/station.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 1b9a204c..d16f126f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -940,9 +940,44 @@ static struct handshake_state *station_handshake_setup=
(struct station *station,
 						"AddressRandomization");
 	if (addr_setting && !strcmp(addr_setting, "network")) {
 		uint8_t new_addr[6];
+		const char *value;
+		bool full_random;
+		bool override =3D false;
+
+		/*
+		 * A value of 'network' could be one of three scenarios:
+		 * 1. per-network MAC generation (default)
+		 * 2. per-network full MAC randomization
+		 * 3. per-network MAC override
+		 */
+
+		if (!l_settings_get_bool(settings, "Settings",
+						"FullAddressRandomization",
+						&full_random))
+			full_random =3D false;
+
+		value =3D l_settings_get_value(settings, "Settings",
+						"AddressOverride");
+		if (value)
+			override =3D true;
+
+		if (override && full_random) {
+			l_error("Cannot use both FullAddressRandomization and "
+				"AddressOverride concurrently");
+			goto not_supported;
+		}
+
+		if (override) {
+			if (!util_string_to_address(value, new_addr)) {
+				l_error("[Network].AddressOverride is not a "
+					"valid MAC address");
+				goto not_supported;
+			}
+		} else if (full_random)
+			wiphy_generate_random_address(wiphy, new_addr);
+		else
+			wiphy_generate_address_from_ssid(wiphy, ssid, new_addr);
 =

-		wiphy_generate_address_from_ssid(wiphy, (const char *)bss->ssid,
-							new_addr);
 		handshake_state_set_supplicant_address(hs, new_addr);
 	} else
 		handshake_state_set_supplicant_address(hs,
-- =

2.21.1

--===============7664742640092320795==--

