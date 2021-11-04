Content-Type: multipart/mixed; boundary="===============4828191872890985493=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/5] scan: parse Proxy ARP bit from extended capabilities
Date: Thu, 04 Nov 2021 10:57:54 -0700
Message-ID: <20211104175758.532953-1-prestwoj@gmail.com>

--===============4828191872890985493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/scan.c | 17 +++++++++++++++++
 src/scan.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index be5953ad..2a96943b 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1252,6 +1252,23 @@ static bool scan_parse_bss_information_elements(stru=
ct scan_bss *bss,
 			bss->rc_ie =3D l_memdup(iter.data - 2, iter.len + 2);
 =

 			break;
+
+		case IE_TYPE_EXTENDED_CAPABILITIES:
+			/* 802.11-2020 9.4.2.26
+			 *
+			 * "The length of the Extended Capabilities field is
+			 * variable. If fewer bits are received in an Extended
+			 * Capabilities field than shown in Table 9-153, the
+			 * rest of the Extended Capabilities field bits are
+			 * assumed to be zero"
+			 *
+			 * Currently only Proxy ARP bit (12) is checked, and if
+			 * not found, this is not a fatal error.
+			 */
+			if (iter.len < 2)
+				break;
+
+			bss->proxy_arp =3D test_bit(iter.data, 12);
 		}
 	}
 =

diff --git a/src/scan.h b/src/scan.h
index 22981585..0378ccca 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -86,6 +86,7 @@ struct scan_bss {
 	bool anqp_capable : 1;
 	bool hs20_capable : 1;
 	bool force_default_sae_group : 1;
+	bool proxy_arp : 1;
 	uint8_t cost_level : 3;
 	uint8_t cost_flags : 4;
 };
-- =

2.31.1

--===============4828191872890985493==--

