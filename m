Content-Type: multipart/mixed; boundary="===============7342285205411576804=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 10/11] iwmon: parse ATTR_REG_RULES
Date: Fri, 25 Feb 2022 09:58:09 -0800
Message-ID: <20220225175810.2914413-10-prestwoj@gmail.com>
In-Reply-To: 20220225175810.2914413-1-prestwoj@gmail.com

--===============7342285205411576804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This parses out the regulatory rules and prints them.
---
 monitor/nlmon.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 6ded9aa2..fe967922 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -5455,6 +5455,93 @@ static void print_wiphy_bands(unsigned int level, co=
nst char *label,
 	}
 }
 =

+static void print_reg_rule_flags(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	uint32_t flag;
+
+	flag =3D l_get_u32(data);
+
+	if (!flag)
+		return;
+
+	print_attr(level, "%s: len %u", label, size);
+
+	if (flag & NL80211_RRF_NO_OFDM)
+		print_attr(level + 1, "No ODFM");
+	if (flag & NL80211_RRF_NO_CCK)
+		print_attr(level + 1, "No CCK");
+	if (flag & NL80211_RRF_NO_INDOOR)
+		print_attr(level + 1, "No Indoor");
+	if (flag & NL80211_RRF_NO_OUTDOOR)
+		print_attr(level + 1, "No Outdoor");
+	if (flag & NL80211_RRF_DFS)
+		print_attr(level + 1, "DFS");
+	if (flag & NL80211_RRF_PTP_ONLY)
+		print_attr(level + 1, "PTP Only");
+	if (flag & NL80211_RRF_PTMP_ONLY)
+		print_attr(level + 1, "PTMP Only");
+	if (flag & NL80211_RRF_NO_IR)
+		print_attr(level + 1, "No IR");
+	if (flag & __NL80211_RRF_NO_IBSS)
+		print_attr(level + 1, "No IBSS");
+	if (flag & NL80211_RRF_AUTO_BW)
+		print_attr(level + 1, "Auto BW");
+	if (flag & NL80211_RRF_IR_CONCURRENT)
+		print_attr(level + 1, "IR Concurrent");
+	if (flag & NL80211_RRF_NO_HT40MINUS)
+		print_attr(level + 1, "No HT40-");
+	if (flag & NL80211_RRF_NO_HT40PLUS)
+		print_attr(level + 1, "No HT40+");
+	if (flag & NL80211_RRF_NO_80MHZ)
+		print_attr(level + 1, "No 80MHz");
+	if (flag & NL80211_RRF_NO_160MHZ)
+		print_attr(level + 1, "No 160MHz");
+	if (flag & NL80211_RRF_NO_HE)
+		print_attr(level + 1, "No HE");
+}
+
+static void print_u32_div_1000(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	uint32_t val =3D l_get_u32(data) / 1000;
+
+	print_attr(level, "%s: %u MHz", label, val);
+}
+
+static const struct attr_entry reg_rule_table[] =3D {
+	{ NL80211_ATTR_REG_RULE_FLAGS, "Flags", ATTR_CUSTOM,
+					{ .function =3D print_reg_rule_flags } },
+	{ NL80211_ATTR_FREQ_RANGE_START, "Frequency Start", ATTR_CUSTOM,
+					{ .function =3D print_u32_div_1000 } },
+	{ NL80211_ATTR_FREQ_RANGE_END, "Frequency End", ATTR_CUSTOM,
+					{ .function =3D print_u32_div_1000 } },
+	{ NL80211_ATTR_FREQ_RANGE_MAX_BW, "Frequency Range Max BW", ATTR_CUSTOM,
+					{ .function =3D print_u32_div_1000 } },
+	{ NL80211_ATTR_POWER_RULE_MAX_ANT_GAIN, "Max Antenna Gain", ATTR_U32 },
+	{ NL80211_ATTR_POWER_RULE_MAX_EIRP, "Max EIRP", ATTR_U32 },
+	{ NL80211_ATTR_DFS_CAC_TIME, "DFS CAC Time", ATTR_U32 },
+	{ }
+};
+
+static void print_reg_rules(unsigned int level, const char *label,
+					const void *data, uint16_t size)
+{
+	const struct nlattr *nla;
+	uint16_t nla_type;
+
+	print_attr(level, "%s: len %u", label, size);
+
+	for (nla =3D data; NLA_OK(nla, size); nla =3D NLA_NEXT(nla, size)) {
+		nla_type =3D nla->nla_type & NLA_TYPE_MASK;
+		print_attr(level + 1, "Rule %u: len %u", nla_type,
+							NLA_PAYLOAD(nla));
+
+		print_attributes(level + 2, reg_rule_table,
+					NLA_DATA(nla), NLA_PAYLOAD(nla));
+	}
+}
+
 static void print_eapol_key(unsigned int level, const void *data, uint32_t=
 size)
 {
 	const struct eapol_key *ek =3D (struct eapol_key *)data;
@@ -6004,7 +6091,8 @@ static const struct attr_entry attr_table[] =3D {
 	{ NL80211_ATTR_REG_ALPHA2,
 			"Regulatory Alpha2", ATTR_STRING },
 	{ NL80211_ATTR_REG_RULES,
-			"Regulatory Rules" },
+			"Regulatory Rules", ATTR_CUSTOM,
+				{ .function =3D print_reg_rules } },
 	{ NL80211_ATTR_MESH_CONFIG,
 			"Mesh Configuration" },
 	{ NL80211_ATTR_BSS_BASIC_RATES,
-- =

2.34.1

--===============7342285205411576804==--

