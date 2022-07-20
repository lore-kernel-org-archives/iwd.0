Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59774748D
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 22:17:17 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id d7-20020a17090a564700b001f209736b89so3436370pji.0
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Cym2Dk/UPwkyWfaFRs+bMw8sm+2E3/Ymulo/x6MDfU=;
        b=VcRHbBEIjgdx7v0zSLRX+utizK3maFfRLNwFM+6X4wEBzlPiBA8FmNaTfqVtThB5ty
         /kEg9DLuJrSi9wy5xoVBzy0+w1zIF4pmh8FG9ofPGEsahFRvWkfGBVrD6ARNy6wIEvD0
         eMkV3LZTs3bpqfe947S0RQtHh6lgglsmDg+x5UbW2sIEHkZB/MEys9xqX6aq/5uWI/Da
         j2m/pt4+rrtf+bsH+wXiyO8O9TwIXIrIIBhsmUoDePjnHU28imJLRWAb9Yd1hCcrO/uh
         OMp2lSUayTIycEujc/R5DPxp5WKzBwFlWDhd+ZG8vN+FTKPI8RJ8vDavywL0CuD0doSJ
         X7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Cym2Dk/UPwkyWfaFRs+bMw8sm+2E3/Ymulo/x6MDfU=;
        b=oPVujeqVqmmSfPIlAKTWO5k7aHa9vh2gzKBRjFq++6iX2FLgHYrWulgIp3ad7PtlkD
         GdQuRtCctmjwre1A0EbuDa/SxUz2PpOokVuYTCK1T8107VOsPsFXiPbxpr3v51OJOf/u
         khEVm0YNzPmVWJ4aG1lrFk4mT77FWVjZc6VW/xiD+BkHGF1Sj9xCt6x3FgBqBwdx8vPe
         YkdGKTc8rnnjNKeFBa7511WFWRmWkbt/tYVQSpl2WbJOictY1ZtULP1ofs9R/7XmKrJm
         MdNTq2m65W3QaFu5oVIKNwiCOWTuLU3i1BZXVJrlaRHO0yVQO+D6aGpSWcunExS266xI
         WALg==
X-Gm-Message-State: AJIora8BSgE/ze3Z/ykSrxMIFeakvYF9dE1H+gwkjNRRkKjwOwm3kC73
	sLvfR+G0g+ZFqOvZ6imhiKekdMGRTKE=
X-Google-Smtp-Source: AGRyM1ulUwhFIhUh9CRtoVs/U/1KOZHKJkJ6+70eEjVGuI9iAReuTxtpIpCpFeJ+MLSON0DnJRnd1Q==
X-Received: by 2002:a17:90b:4a07:b0:1ef:b0f6:210f with SMTP id kk7-20020a17090b4a0700b001efb0f6210fmr8189538pjb.152.1658355436613;
        Wed, 20 Jul 2022 15:17:16 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id q10-20020a170903204a00b0016a1e2d148csm75859pla.32.2022.07.20.15.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:17:16 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 5/5] unit: add HE tests to test-band
Date: Wed, 20 Jul 2022 15:15:07 -0700
Message-Id: <20220720221507.886811-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720221507.886811-1-prestwoj@gmail.com>
References: <20220720221507.886811-1-prestwoj@gmail.com>
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
 unit/test-band.c | 243 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/unit/test-band.c b/unit/test-band.c
index 0dd9b67b..90b48f9f 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -32,6 +32,8 @@
 #include <ell/ell.h>
 
 #include "src/band.h"
+#include "src/netdev.h"
+#include "src/ie.h"
 
 static struct band *new_band()
 {
@@ -284,6 +286,228 @@ static void band_test_vht_1(const void *data)
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
+	assert(ie_validate_he_capabilities(he_data->he_capabilities + 2,
+					he_data->he_capabilities[0]));
+
+	ret = band_estimate_he_rx_rate(band, he_data->he_capabilities + 2,
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
@@ -436,6 +660,25 @@ int main(int argc, char *argv[])
 
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

