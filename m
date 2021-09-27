Content-Type: multipart/mixed; boundary="===============0515086859701218744=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/3] monitor: print FT Request/Response frames
Date: Mon, 27 Sep 2021 15:41:36 -0700
Message-ID: <20210927224136.312226-3-prestwoj@gmail.com>
In-Reply-To: 20210927224136.312226-1-prestwoj@gmail.com

--===============0515086859701218744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 monitor/nlmon.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 060316f7..728d7857 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -4767,6 +4767,68 @@ static void print_rm_action_frame(unsigned int level=
, const uint8_t *body,
 	}
 }
 =

+static void print_ft_request(unsigned int level,
+				const uint8_t *body, size_t body_len)
+{
+	struct ie_tlv_iter iter;
+
+	switch (body[0]) {
+	case 1:
+		if (body_len < 13)
+			return;
+
+		print_attr(level + 1, "FT Request");
+		break;
+	case 2:
+		if (body_len < 15)
+			return;
+
+		print_attr(level + 1, "FT Response");
+		break;
+	case 3:
+		/* FT Confirm/Ack are not yet supported */
+		print_attr(level + 1, "FT Confirm");
+		return;
+	case 4:
+		print_attr(level + 1, "FT ACK");
+		return;
+	}
+
+	print_attr(level + 1, "STA Address: "MAC, MAC_STR(body + 1));
+	print_attr(level + 1, "Target AP Address: "MAC, MAC_STR(body + 7));
+
+	if (body[0] =3D=3D 2) {
+		print_attr(level + 1, "Status: %u", l_get_le16(body + 13));
+		body +=3D 15;
+		body_len -=3D 15;
+	} else {
+		body +=3D 13;
+		body_len -=3D 15;
+	}
+
+	ie_tlv_iter_init(&iter, body, body_len);
+
+	while (ie_tlv_iter_next(&iter)) {
+		uint8_t tag =3D ie_tlv_iter_get_tag(&iter);
+		size_t len =3D ie_tlv_iter_get_length(&iter);
+		const void *data =3D ie_tlv_iter_get_data(&iter);
+
+		switch (tag) {
+		case IE_TYPE_RSN:
+			print_ie_rsn(level + 1, "RSN", data, len);
+			break;
+		case IE_TYPE_MOBILITY_DOMAIN:
+			print_mobility_domain(level + 1, "Mobility Domain",
+						data, len);
+			break;
+		case IE_TYPE_FAST_BSS_TRANSITION:
+			print_fast_bss_transition(level + 1,
+						"Fast BSS Transition",
+						data, len);
+			break;
+		}
+	}
+}
 static void print_action_mgmt_frame(unsigned int level,
 					const struct mmpdu_header *mmpdu,
 					size_t total_len, bool no_ack)
@@ -4829,6 +4891,9 @@ static void print_action_mgmt_frame(unsigned int leve=
l,
 		if (!memcmp(oui, wifi_alliance_oui, 3) && oui[3] =3D=3D 0x09)
 			print_p2p_action_frame(level + 1, body + 5,
 						body_len - 5);
+	} else if (body[0] =3D=3D 6) {
+		print_ft_request(level, body + 1, body_len - 1);
+		return;
 	}
 =

 	print_mpdu_frame_control(level + 1, &mmpdu->fc);
-- =

2.31.1

--===============0515086859701218744==--

