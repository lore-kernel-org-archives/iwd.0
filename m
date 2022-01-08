Content-Type: multipart/mixed; boundary="===============1931945901775669646=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/6] dpp: don't allow StartEnrollee while connected
Date: Fri, 07 Jan 2022 16:13:29 -0800
Message-ID: <20220108001333.723634-2-prestwoj@gmail.com>
In-Reply-To: 20220108001333.723634-1-prestwoj@gmail.com

--===============1931945901775669646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While connected the driver ends up choosing quite small ROC
durations leading to excessive calls to ROC. This also will
negatively effect any wireless performance for the current
network and possibly lead to missed DPP frames.
---
 src/dpp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 61c6b36d..de897266 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1638,10 +1638,21 @@ static struct l_dbus_message *dpp_dbus_start_enroll=
ee(struct l_dbus *dbus,
 	struct dpp_sm *dpp =3D user_data;
 	uint32_t freq =3D band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
 	struct l_dbus_message *reply;
+	struct station *station =3D station_find(netdev_get_ifindex(dpp->netdev));
 =

 	if (dpp->state !=3D DPP_STATE_NOTHING)
 		return dbus_error_busy(message);
 =

+	/*
+	 * Station isn't actually required for DPP itself, although this will
+	 * prevent connecting to the network once configured.
+	 */
+	if (station && station_get_connected_network(station)) {
+		l_warn("cannot be enrollee while connected, please disconnect");
+		return dbus_error_busy(message);
+	} else
+		l_debug("No station device, continuing anyways...");
+
 	dpp->uri =3D dpp_generate_uri(dpp->pub_asn1, dpp->pub_asn1_len, 2,
 					netdev_get_address(dpp->netdev), &freq,
 					1, NULL, NULL);
-- =

2.31.1

--===============1931945901775669646==--

