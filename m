Content-Type: multipart/mixed; boundary="===============3843983053185077028=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/5] dpp: don't allow StartEnrollee while connected
Date: Fri, 07 Jan 2022 14:31:09 -0800
Message-ID: <20220107223112.715855-2-prestwoj@gmail.com>
In-Reply-To: 20220107223112.715855-1-prestwoj@gmail.com

--===============3843983053185077028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While connected the driver ends up choosing quite small ROC
durations leading to excessive calls to ROC. This also will
negatively effect any wireless performance for the current
network and possibly lead to missed DPP frames.
---
 src/dpp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 61c6b36d..5d52e007 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1638,10 +1638,16 @@ static struct l_dbus_message *dpp_dbus_start_enroll=
ee(struct l_dbus *dbus,
 	struct dpp_sm *dpp =3D user_data;
 	uint32_t freq =3D band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
 	struct l_dbus_message *reply;
+	struct station *station =3D station_find(netdev_get_ifindex(dpp->netdev));
 =

 	if (dpp->state !=3D DPP_STATE_NOTHING)
 		return dbus_error_busy(message);
 =

+	if (!station || station_get_connected_network(station)) {
+		l_warn("cannot be enrollee while connected, please disconnect");
+		return dbus_error_busy(message);
+	}
+
 	dpp->uri =3D dpp_generate_uri(dpp->pub_asn1, dpp->pub_asn1_len, 2,
 					netdev_get_address(dpp->netdev), &freq,
 					1, NULL, NULL);
-- =

2.31.1

--===============3843983053185077028==--

