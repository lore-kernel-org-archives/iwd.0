Content-Type: multipart/mixed; boundary="===============0865189584618354469=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] scan: parse BSS_SIGNAL_UNSPEC, fix potential zero signal
Date: Tue, 25 Jan 2022 10:02:06 -0800
Message-ID: <20220125180206.3098383-1-prestwoj@gmail.com>

--===============0865189584618354469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A select few drivers send this instead of SIGNAL_MBM. The docs say this
value is the signal 'in unspecified units, scaled to 0..100'. The range
for SIGNAL_MBM is -10000..0 so this can be scaled to the MBM range easy
enough...

Now, this isn't exactly correct because this value ultimately gets
returned from GetOrderedNetworks() and is documented as 100 * dBm where
in reality its just a unit-less signal strength value. Its not ideal, but
this patch at least will fix BSS ranking for these few drivers.
---
 src/scan.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

I am fine leaving this on the list until we get an answer from the original
thread about what driver this happened with:

https://lists.01.org/hyperkitty/list/iwd(a)lists.01.org/thread/PLYNHZWEENY3=
RIMUNAWDDPHHPHRDCJOR/

If its not one of these drivers, and not related to SIGNAL_UNSPEC, we
will need to investigate further.

diff --git a/src/scan.c b/src/scan.c
index de507ba3..99813952 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1372,6 +1372,22 @@ static bool scan_parse_bss_information_elements(stru=
ct scan_bss *bss,
 	return have_ssid;
 }
 =

+/*
+ * Maps 0..100 values to -10000..0
+ *
+ * This isn't really mapping to mBm since the input is unit-less and we ha=
ve no
+ * idea what the driver itself does to come up with this 'strength' value =
but
+ * this is really the best that can be done for these drivers (its only 4 =
in
+ * tree drivers after all).
+ */
+static int32_t signal_unspec_to_mbm(uint8_t strength)
+{
+	if (L_WARN_ON(strength > 100))
+		return 0;
+
+	return ((int32_t)strength * 100) - 10000;
+}
+
 static struct scan_bss *scan_parse_attr_bss(struct l_genl_attr *attr,
 						struct wiphy *wiphy,
 						uint32_t *out_seen_ms_ago)
@@ -1414,6 +1430,13 @@ static struct scan_bss *scan_parse_attr_bss(struct l=
_genl_attr *attr,
 =

 			bss->signal_strength =3D *((int32_t *) data);
 			break;
+		case NL80211_BSS_SIGNAL_UNSPEC:
+			if (len !=3D 1)
+				goto fail;
+
+			bss->signal_strength =3D
+					signal_unspec_to_mbm(l_get_u8(data));
+			break;
 		case NL80211_BSS_INFORMATION_ELEMENTS:
 			ies =3D data;
 			ies_len =3D len;
-- =

2.31.1

--===============0865189584618354469==--

