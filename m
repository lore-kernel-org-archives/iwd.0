Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1226D7465
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 19:36:01 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id f11so17297309pgj.7
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+BjzA9RvwRed9Cx/pYAD18MWWdW4i1PQPQG/GlENJ/8=;
        b=GC2vWdp54QX0/bdLXN4kUBIx18trYnKzz6ekzJo2QT0LgcRyBRqBy/KQgcOHDWD4Gv
         81ggCKk38v0WvALyE2cmHG8JQ1dtX/84WAC0c9Suq6vMccXusEUA4stCYQ3iCew/xurT
         Zcdr1EyS7oQUKULKfhSE/y5mX7Mk8zngcoY6PhO/wlVvOvP0CJi2+7wAz9zIIM3NNdCP
         Qb+U734H4tB+7F/VAoWZdHtUP5xqgL3JVJL7U99ozoGFQ58y4kQccGnFn57TdGL/lebA
         YSWGv0Y2VbqZ2hkNVXPboeYrV5q3Vf6r7rDWChCjyGo8Yxwl8o3LkV0wJpnqyB8bbDSq
         I6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+BjzA9RvwRed9Cx/pYAD18MWWdW4i1PQPQG/GlENJ/8=;
        b=GrPFKK+iatf1tBT9iTf5dmqURdX4a8XnBhB6GyyUoMkI9+kv+7LPCVbF4DEBpsFtE9
         wvxwRKvVHA7foz46F2m5YG/WcvAhXWqeLK9CnlvyUmGsjr1gOel+lcEdB6cWN2bPz63g
         U7nmkG6XCEckPQ5e1CoA2h2d9ygOvPnhuZFD4l7h06pRKU59aTuo6U1J8wwMwcINnyIs
         /cNmNyYnCMiPLeXAXLKPOgSQLtvaVDXD0fLv8zGuZB7CRxobF+tt8co/+D5ujZ1woDKW
         attazsnU4SCAVvRazzK+uqh1VFQf4ArmvTCeJJJ2BWEL2J2q38+3QCd/IoO9TwftPhjg
         SRlA==
X-Gm-Message-State: AJIora8OOsgurOEZ4WaGVJFqnczMi4M1XanLR3TwV2PpcajE+Ngelo0U
	VUrASZQYxYHMaIQS8qzvTvayOXvNuJA=
X-Google-Smtp-Source: AGRyM1uEA+bjL8JwPakQ8e8VyT6wexryl0dxzu+6VA5MRn5VE1uf3coDttV2mhbQ/U1Dxii7QZlabQ==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id l15-20020a056a00140f00b004e069959c48mr40475700pfu.59.1658345760318;
        Wed, 20 Jul 2022 12:36:00 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ecc300b0016be4d78792sm14244601plh.257.2022.07.20.12.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:36:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/3] unit: add HE tests to test-band
Date: Wed, 20 Jul 2022 12:33:52 -0700
Message-Id: <20220720193352.806339-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720193352.806339-1-prestwoj@gmail.com>
References: <20220720193352.806339-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tests for all the possible widths selected in 2.4 and 5/6GHz,
as well as some failure tests.
---
 unit/test-band.c | 240 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/unit/test-band.c b/unit/test-band.c
index 0dd9b67b..8a927339 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -32,6 +32,8 @@
 #include <ell/ell.h>
 
 #include "src/band.h"
+#include "src/netdev.h"
+#include "src/ie.h"
 
 static struct band *new_band()
 {
@@ -284,6 +286,225 @@ static void band_test_vht_1(const void *data)
 	band_free(band);
 }
 
+struct he_test_data {
+	enum band_freq freq;
+	int32_t rssi;
+	uint64_t expected_rate;
+	int expected_return;
+	/* Own capabilities */
+	struct band_he_capabilities capabilities;
+	/* Peer HE Capabilities IE */
+	uint8_t he_capabilities[31];
+
+};
+
+/* IWD doesn't look at this */
+#define HE_MAC_CAPA 0, 0, 0, 0, 0, 0
+/* IWD only cares about the width set byte */
+#define HE_PHY_CAPA(wset) wset, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+
+#define MCS7		0
+#define MCS9		1
+#define MCS11		2
+#define MCS_UNSUP	0xff, 0xff
+/* A readable macro for defining MCS sets */
+#define HE_MCS_SET(mcs, nss) \
+	(nss >= 1 ? mcs << 0 : 3 << 0) | \
+	(nss >= 2 ? mcs << 2 : 3 << 2) | \
+	(nss >= 3 ? mcs << 4 : 3 << 4) | \
+	(nss >= 4 ? mcs << 6 : 3 << 6),  \
+	(nss >= 5 ? mcs << 0 : 3 << 0) | \
+	(nss >= 6 ? mcs << 2 : 3 << 2) | \
+	(nss >= 7 ? mcs << 4 : 3 << 4) | \
+	(nss >= 8 ? mcs << 6 : 3 << 6)
+
+/* 2.4GHz, 20MHz, MCS 7, NSS 1 */
+const struct he_test_data he_test_2_4_20mhz_mcs_7_nss_1 = {
+	.freq = BAND_FREQ_2_4_GHZ,
+	.rssi = -20,
+	.expected_rate = 86000000ULL,
+	.capabilities = {
+		.he_mcs_set = { HE_MCS_SET(MCS7, 1), MCS_UNSUP },
+		.he_phy_capa = { HE_PHY_CAPA(0x00) },
+		.iftypes = 1 << NETDEV_IFTYPE_STATION,
+	},
+	.he_capabilities = {
+		22, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
+		HE_PHY_CAPA(0x00), MCS_UNSUP, HE_MCS_SET(MCS7, 1),
+	},
+};
+
+/* 2.4GHz, 40MHz, MCS 7, NSS 1 */
+const struct he_test_data he_test_2_4_40mhz_mcs_7_nss_1 = {
+	.freq = BAND_FREQ_2_4_GHZ,
+	.rssi = -20,
+	.expected_rate = 172000000ULL,
+	.capabilities = {
+		.he_mcs_set = { HE_MCS_SET(MCS7, 1), MCS_UNSUP },
+		.he_phy_capa = { HE_PHY_CAPA(0x02) },
+		.iftypes = 1 << NETDEV_IFTYPE_STATION,
+	},
+	.he_capabilities = {
+		22, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
+		HE_PHY_CAPA(0x02), MCS_UNSUP, HE_MCS_SET(MCS7, 1),
+	},
+};
+
+/* 5GHz, 20MHz, MCS 7, NSS 1 */
+const struct he_test_data he_test_5_20mhz_mcs_7_nss_1 = {
+	.freq = BAND_FREQ_5_GHZ,
+	.rssi = -20,
+	.expected_rate = 86000000ULL,
+	.capabilities = {
+		.he_mcs_set = { HE_MCS_SET(MCS7, 1), MCS_UNSUP },
+		.he_phy_capa = { HE_PHY_CAPA(0x00) },
+		.iftypes = 1 << NETDEV_IFTYPE_STATION,
+	},
+	.he_capabilities = {
+		22, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
+		HE_PHY_CAPA(0x00), MCS_UNSUP, HE_MCS_SET(MCS7, 1)
+	},
+};
+
+/* 5GHz, 80MHz, MCS 7, NSS 1 */
+const struct he_test_data he_test_5_80mhz_mcs_7_nss_1 = {
+	.freq = BAND_FREQ_5_GHZ,
+	.rssi = -20,
+	.expected_rate = 360300000ULL,
+	.capabilities = {
+		.he_mcs_set = { HE_MCS_SET(MCS7, 1), MCS_UNSUP },
+		.he_phy_capa = { HE_PHY_CAPA(0x04) },
+		.iftypes = 1 << NETDEV_IFTYPE_STATION,
+	},
+	.he_capabilities = {
+		22, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
+		HE_PHY_CAPA(0x04), MCS_UNSUP, HE_MCS_SET(MCS7, 1)
+	},
+};
+
+/* 5GHz, 160MHz, MCS 7, NSS 1 */
+const struct he_test_data he_test_5_160mhz_mcs_7_nss_1 = {
+	.freq = BAND_FREQ_5_GHZ,
+	.rssi = -20,
+	.expected_rate = 720600000ULL,
+	.capabilities = {
+		.he_mcs_set = { HE_MCS_SET(MCS7, 1), MCS_UNSUP,
+				HE_MCS_SET(MCS7, 1), MCS_UNSUP },
+		.he_phy_capa = { HE_PHY_CAPA(0x0c) },
+		.iftypes = 1 << NETDEV_IFTYPE_STATION,
+	},
+	.he_capabilities = {
+		26, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
+		HE_PHY_CAPA(0x0c), MCS_UNSUP, HE_MCS_SET(MCS7, 1),
+				MCS_UNSUP, HE_MCS_SET(MCS7, 1)
+	},
+};
+
+/* 5GHz, 160/80+80MHz, MCS 7, NSS 1 */
+const struct he_test_data he_test_5_160_80_P_80_mhz_mcs_7_nss_1 = {
+	.freq = BAND_FREQ_5_GHZ,
+	.rssi = -20,
+	.expected_rate = 720600000ULL,
+	.capabilities = {
+		.he_mcs_set = { HE_MCS_SET(MCS7, 1), MCS_UNSUP,
+				HE_MCS_SET(MCS7, 1), MCS_UNSUP,
+				HE_MCS_SET(MCS7, 1), MCS_UNSUP },
+		.he_phy_capa = { HE_PHY_CAPA(0x1c) },
+		.iftypes = 1 << NETDEV_IFTYPE_STATION,
+	},
+	.he_capabilities = {
+		30, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
+		HE_PHY_CAPA(0x1c), MCS_UNSUP, HE_MCS_SET(MCS7, 1),
+				MCS_UNSUP, HE_MCS_SET(MCS7, 1),
+				MCS_UNSUP, HE_MCS_SET(MCS7, 1)
+	},
+};
+
+/* 5GHz, max data rate */
+const struct he_test_data he_test_5_max_data_rate = {
+	.freq = BAND_FREQ_5_GHZ,
+	.rssi = -20,
+	.expected_rate = 1201000000ULL * 8ULL,
+	.capabilities = {
+		.he_mcs_set = { HE_MCS_SET(MCS11, 8), MCS_UNSUP,
+				HE_MCS_SET(MCS11, 8), MCS_UNSUP,
+				HE_MCS_SET(MCS11, 8), MCS_UNSUP },
+		.he_phy_capa = { HE_PHY_CAPA(0x1c) },
+		.iftypes = 1 << NETDEV_IFTYPE_STATION,
+	},
+	.he_capabilities = {
+		30, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
+		HE_PHY_CAPA(0x1c), MCS_UNSUP, HE_MCS_SET(MCS11, 8),
+				MCS_UNSUP, HE_MCS_SET(MCS11, 8),
+				MCS_UNSUP, HE_MCS_SET(MCS11, 8)
+	},
+};
+
+const struct he_test_data he_all_mcs_unsupported = {
+	.freq = BAND_FREQ_5_GHZ,
+	.rssi = -20,
+	.expected_rate = 1201000000ULL * 8ULL,
+	.expected_return = -EBADMSG,
+	.capabilities = {
+		.he_mcs_set = { MCS_UNSUP, MCS_UNSUP,
+				MCS_UNSUP, MCS_UNSUP,
+				MCS_UNSUP, MCS_UNSUP },
+		.he_phy_capa = { HE_PHY_CAPA(0x1c) },
+		.iftypes = 1 << NETDEV_IFTYPE_STATION,
+	},
+	.he_capabilities = {
+		30, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
+		HE_PHY_CAPA(0x1c), MCS_UNSUP, MCS_UNSUP,
+				MCS_UNSUP, MCS_UNSUP,
+				MCS_UNSUP, MCS_UNSUP
+	},
+};
+
+/* 5GHz, max data rate, low-rssi */
+const struct he_test_data he_test_5_low_rssi = {
+	.freq = BAND_FREQ_5_GHZ,
+	.rssi = -80, /* Should force 20MHz/MCS0 width to be used */
+	.expected_rate = 8600000ULL * 8ULL,
+	.capabilities = {
+		.he_mcs_set = { HE_MCS_SET(MCS11, 8), MCS_UNSUP,
+				HE_MCS_SET(MCS11, 8), MCS_UNSUP,
+				HE_MCS_SET(MCS11, 8), MCS_UNSUP },
+		.he_phy_capa = { HE_PHY_CAPA(0x1c) },
+		.iftypes = 1 << NETDEV_IFTYPE_STATION,
+	},
+	.he_capabilities = {
+		30, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
+		HE_PHY_CAPA(0x1c), MCS_UNSUP, HE_MCS_SET(MCS11, 8),
+				MCS_UNSUP, HE_MCS_SET(MCS11, 8),
+				MCS_UNSUP, HE_MCS_SET(MCS11, 8)
+	},
+};
+
+static void band_test_he(const void *data)
+{
+	const struct he_test_data *he_data = data;
+	struct band *band;
+	uint64_t rate = 0;
+	int ret;
+
+	band = new_band();
+	band->freq = he_data->freq;
+	band->he_capabilities = l_queue_new();
+
+	l_queue_push_tail(band->he_capabilities,
+				(void*)&(he_data->capabilities));
+
+	ret = band_estimate_he_rx_rate(band, he_data->he_capabilities,
+					he_data->rssi, &rate);
+	assert(ret == he_data->expected_return);
+
+	if (ret == 0)
+		assert(rate == he_data->expected_rate);
+
+	l_queue_destroy(band->he_capabilities, NULL);
+	l_free(band);
+}
+
 struct oci2freq_data {
 	unsigned int op;
 	unsigned int chan;
@@ -436,6 +657,25 @@ int main(int argc, char *argv[])
 
 	l_test_add("/band/VHT/test1", band_test_vht_1, NULL);
 
+	l_test_add("/band/HE/test/2.4GHz/20MHz/MCS7/NSS1", band_test_he,
+					&he_test_2_4_20mhz_mcs_7_nss_1);
+	l_test_add("/band/HE/test/2.4GHz/40MHz/MCS7/NSS1", band_test_he,
+					&he_test_2_4_40mhz_mcs_7_nss_1);
+	l_test_add("/band/HE/test/5GHz/20MHz/MCS7/NSS1", band_test_he,
+					&he_test_5_20mhz_mcs_7_nss_1);
+	l_test_add("/band/HE/test/5GHz/80MHz/MCS7/NSS1", band_test_he,
+					&he_test_5_80mhz_mcs_7_nss_1);
+	l_test_add("/band/HE/test/5GHz/160MHz/MCS7/NSS1", band_test_he,
+					&he_test_5_160mhz_mcs_7_nss_1);
+	l_test_add("/band/HE/test/5GHz/160/80+80MHz/MCS7/NSS1", band_test_he,
+					&he_test_5_160_80_P_80_mhz_mcs_7_nss_1);
+	l_test_add("/band/HE/test/5GHz/max data rate", band_test_he,
+					&he_test_5_max_data_rate);
+	l_test_add("/band/HE/test/all MCS unsupported", band_test_he,
+					&he_all_mcs_unsupported);
+	l_test_add("/band/HE/test/low RSSI", band_test_he,
+					&he_test_5_low_rssi);
+
 	l_test_add("/band/oci2freq 1", test_oci2freq, &oci2freq_data_1);
 	l_test_add("/band/oci2freq 2", test_oci2freq, &oci2freq_data_2);
 	l_test_add("/band/oci2freq 3", test_oci2freq, &oci2freq_data_3);
-- 
2.34.1

