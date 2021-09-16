Content-Type: multipart/mixed; boundary="===============3096354824762492823=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 1/7] ie: add ie_parse_owe_transition_from_data
Date: Thu, 16 Sep 2021 09:30:40 -0700
Message-ID: <20210916163046.30817-1-prestwoj@gmail.com>

--===============3096354824762492823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a parser for the WFA OWE Transition element. For now the
optional band/channel bytes will not be parsed as hostapd does not
yet support these and would also require the 802.11 appendix E-1
to be added to IWD. Because of this OWE Transition networks are
assumed to be on the same channel as their open counterpart.
---
 src/ie.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 src/ie.h |  5 +++++
 2 files changed, 50 insertions(+)

v3:
 * Changed to handle non-utf8 SSIDs

diff --git a/src/ie.c b/src/ie.c
index 1ce1d8a5..3b4564b2 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1343,6 +1343,8 @@ bool is_ie_wfa_ie(const uint8_t *data, uint8_t len, u=
int8_t oi_type)
 		return false;
 	else if (oi_type =3D=3D IE_WFA_OI_HS20_INDICATION && len !=3D 5 && len !=
=3D 7)
 		return false;
+	else if (oi_type =3D=3D IE_WFA_OI_OWE_TRANSITION && len < 12)
+		return false;
 	else if (len < 4) /* OI not handled, but at least check length */
 		return false;
 =

@@ -2492,3 +2494,46 @@ int ie_parse_network_cost(const void *data, size_t l=
en,
 	*flags =3D l_get_le16(ie + 8);
 	return 0;
 }
+
+int ie_parse_owe_transition(const void *data, size_t len,
+				uint8_t bssid[static 6],
+				uint8_t ssid[static 32],
+				size_t *ssid_len)
+{
+	const uint8_t *ie =3D data;
+	size_t slen;
+
+	if (len < 14 || ie[0] !=3D IE_TYPE_VENDOR_SPECIFIC)
+		return -ENOMSG;
+
+	if (!is_ie_wfa_ie(ie + 2, len - 2, IE_WFA_OI_OWE_TRANSITION))
+		return -ENOMSG;
+
+	slen =3D l_get_u8(ie + 12);
+	if (slen > 32)
+		return -ENOMSG;
+
+	/*
+	 * WFA OWE Specification 2.3.1
+	 *
+	 * "Band Info and Channel Info are optional fields. If configured,
+	 * both fields shall be included in an OWE Transition Mode element"
+	 *
+	 * TODO: Support Band/Channel bytes:
+	 * For the time being the OWE transition AP is assumed to be on the same
+	 * channel as the open AP. This means there should be no band/channel
+	 * bytes at the end of the IE. Currently hostapd has no support for this
+	 * so it can be skipped. In addition 802.11 Appendix E-1 needs to be
+	 * encoded as a table to map Country/operating class to channels to make
+	 * any sense of it.
+	 */
+	if (len !=3D slen + 13)
+		return -ENOMSG;
+
+	memcpy(bssid, ie + 6, 6);
+
+	memcpy(ssid, ie + 13, slen);
+	*ssid_len =3D slen;
+
+	return 0;
+}
diff --git a/src/ie.h b/src/ie.h
index 4e1c5433..6d8fb9ca 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -630,3 +630,8 @@ void ie_build_fils_ip_addr_response(
 =

 int ie_parse_network_cost(const void *data, size_t len,
 				uint16_t *flags, uint16_t *level);
+
+int ie_parse_owe_transition(const void *data, size_t len,
+				uint8_t bssid[static 6],
+				uint8_t ssid[static 32],
+				size_t *ssid_len);
-- =

2.31.1

--===============3096354824762492823==--

