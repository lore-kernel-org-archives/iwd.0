Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E97482
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 21:31:42 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 72so17607499pge.0
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Cym2Dk/UPwkyWfaFRs+bMw8sm+2E3/Ymulo/x6MDfU=;
        b=L1olZftlCiN6hEeY95FyuAr3Exx2bREqBFrd78avy8i5cz08HXzoBuBJOdOlvCBtiY
         85OvIUE4oA+Eah9Nj0ROWU6cQbyqidMCIE6IQTgDtROwBuYdTqdF++KFlthLKOJW8md2
         P7ZNgqtMQNDF8wFGt/415cwydI4Wr6ar4kmX+dalvJpBPLLnnXIm4XZtasPbySUgDZ/M
         pHl97vTWiQOyOVsahEpgwFe0J6CHo7xzvwL9Wd+etpNobd4Mpr9odX6sVntK3Dr/0n/A
         QPKAdZRM3+aa4EWdcxY+8JhdU/Y8LnvuYlcYWbk6sgl5asNDqxRMBQuyanMIzll+YlDt
         MHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Cym2Dk/UPwkyWfaFRs+bMw8sm+2E3/Ymulo/x6MDfU=;
        b=u1wwnN4a76GPnm8tzu8clT6Vt4kLxcMA14Siu4qIjR+mFOKYZRbuWI9xklEDJ9937N
         eG4DU0i+2bIMmzBFMa7Rcw3yCo1uGBrFHyXSJpejfXtgpuJYq4m7P1FSTCxz4HedF1d/
         1mbEdH9yZ5RkdQGrZNWhLO0g3IWmVR+fS9p1umlb9OF/u9FpEYDaTFD6eRaKdRdwAReo
         nJTv1Rq09/Fe7J6CC0ctpE5rBKXJBdKUxew7plV3ouWfqZ/Fx0KxnYzDUh4Piz8r2qUk
         G+o2ta7DaoZI0/ZDjeMTAaOAcJtAGaalVUq7Eot7CzdL1eZdZ4s6jNz/KzRw4JKl/71k
         gJUw==
X-Gm-Message-State: AJIora/sXUkWdR5n3bACzJqJbXSIK37nkkH3AAK9s8v61XZFAXjtymnQ
	ddw/YkWeHVO9xikrgYm9mWUwO/Tj9xA=
X-Google-Smtp-Source: AGRyM1u+egWUObXPPvLvSbob47kNZ2t8LbmOWEpxYOnu4Vg8fAa10FMY+nwwCmz3ocr77KB6bl/gOQ==
X-Received: by 2002:aa7:80d3:0:b0:52b:9237:a355 with SMTP id a19-20020aa780d3000000b0052b9237a355mr8620008pfn.73.1658352701454;
        Wed, 20 Jul 2022 14:31:41 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b0016c5306917fsm41475plr.53.2022.07.20.14.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:31:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 5/5] unit: add HE tests to test-band
Date: Wed, 20 Jul 2022 14:29:32 -0700
Message-Id: <20220720212932.873353-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720212932.873353-1-prestwoj@gmail.com>
References: <20220720212932.873353-1-prestwoj@gmail.com>
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

