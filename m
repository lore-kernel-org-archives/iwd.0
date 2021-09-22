Content-Type: multipart/mixed; boundary="===============4854743170218942655=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/6] ie: add info struct for OWE transition
Date: Wed, 22 Sep 2021 11:26:50 -0700
Message-ID: <20210922182655.46220-1-prestwoj@gmail.com>

--===============4854743170218942655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These members are currently stored in scan_bss but with the
addition of operating class/band info this will become 5
separate members. This is a bit excessive to store in scan_bss
separately so instead this structure can hold everything related
to the OWE transition IE.
---
 src/ie.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/ie.h b/src/ie.h
index f64072b3..02892724 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -488,6 +488,12 @@ struct ie_fils_ip_addr_response_info {
 	uint8_t ipv6_lifetime;		/* Zero if not provided */
 };
 =

+struct ie_owe_transition_info {
+	uint8_t bssid[6];
+	uint8_t ssid[32];
+	size_t ssid_len;
+};
+
 extern const unsigned char ieee_oui[3];
 extern const unsigned char microsoft_oui[3];
 extern const unsigned char wifi_alliance_oui[3];
-- =

2.31.1

--===============4854743170218942655==--

