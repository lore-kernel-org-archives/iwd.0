Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C5132492
	for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729949; cv=none; b=miP0LzResRX/szHQvDhZd3Ve7R3/iLmgqlCKfMhSOb1QXRLoiqSeXBpRNqSVOrQthfl06PkyrMIx2Lz6jp42lZ5xI5PD2zJz8AXT4iAvH45oacqXYUIbEjkbsehwzxpdKZvCo69yRuPmqGI1DLwGGgD5z1dqfC8qXAIi4D9tbaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729949; c=relaxed/simple;
	bh=3IEsrY88d6tHZcrsaVSfzv/mQCfcsr4KGigeFa3Kg0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiCrYc85k2XQUxRogFZwfimlTD87xwMet0ebyXM+I1AAqIjyXUq+uTteB8J1+kgT4WRcZfk/UgB0nA7yuf6w9z1Zk+08Ah+cjNY5t8NymrgXc52RGO3YtdA4n+D6XqFzxKu4+DdcpxUG25Smc2TiO0QR2O6Sf0ieeRTIqQUt+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcU8jRI3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcU8jRI3"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-797a7f9b552so373834885a.0
        for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718729946; x=1719334746; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTeXdgdUGKZQc2ceKeiP2hzPvKWpUvuiSPcGMW871oQ=;
        b=VcU8jRI3QQCMJwl87O02NfUAOq49Q/fSpOA+iDHHyH/FEv1gmz6ElmS9rzRveboh5E
         cmq5MvWb3Gowmsl6V9r0P4HQLpHD/3zuddWiEiAB1Bv+eAlR/6XRxHsn+D61E+Vw+2gX
         aL5eQeYT+50p4lGwrmd/143BK5dZ/UXIKZvKX0m+KnFw/vwiQddQxC8we8QGI68TxLsp
         Y9jZXU0QxyCLisoyP2giyRBH4rcUByxQBO8iQFtCEGfbQuzwctR6gmXmHZ+q085kqTZ2
         rk2tx4eRY1xJsPMN7YRXiqkF1jxtYev9GvNEEUw2AcPmnpO2lb+ydyprzOmjinuwM3Kl
         O2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729946; x=1719334746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTeXdgdUGKZQc2ceKeiP2hzPvKWpUvuiSPcGMW871oQ=;
        b=FesLbeOJuAhUHiA6jHX3GnjQsobwUHNMbJS55TMzqn98r/X4Ilh+DIxIaZWZgIUKg4
         ME4aeEmO+Kgbb4QenFDCSo8bGveMaQDpKuXY+Niwk6EF7j1kWC2/T4XTep+D7k2rcV3T
         vuqCEu1yGulMDq6Wfe417zdw2tup5+foTk2Fk/OxWqTeTeo6wRhwm+9YhQq7Dux5sofJ
         yFWvkPxUQLppCmh54djedQwj7mw5v8X9dK9CG0rdx716J1hnuAcsUqGxFXZXMFS7B5rT
         7hIPU9cvEO0xwJUvKbw9GPEA9IJ5+TxPQ54zBJMRceYHGOCvA5IWrjL27aAnrS767vZi
         AShw==
X-Gm-Message-State: AOJu0YzRuYjMr20DfQW+ItZk76exSxpLO5YAZRSaAVfW0mBDx2UxBwnC
	kLXLzvkETVzD2h4piUXGOnCd06DVK5hI3hz0uyjom0P9ibh02gZYO2R/4Q==
X-Google-Smtp-Source: AGHT+IHUOj6cdRmaaG4vrekFjiWlZN1rYHZOpgZ8U4p9sEPDV0ZOiZ9QzIuijTK4vW9UqidQuHceyQ==
X-Received: by 2002:a05:620a:4614:b0:793:1a75:177e with SMTP id af79cd13be357-79bb3ed48b2mr29226085a.50.1718729946321;
        Tue, 18 Jun 2024 09:59:06 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b49e4c82sm533688785a.88.2024.06.18.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:59:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/10] unit: add simple test for nl80211util
Date: Tue, 18 Jun 2024 09:58:51 -0700
Message-Id: <20240618165854.113598-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618165854.113598-1-prestwoj@gmail.com>
References: <20240618165854.113598-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am             |  9 +++++-
 unit/test-nl80211util.c | 63 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 unit/test-nl80211util.c

diff --git a/Makefile.am b/Makefile.am
index 0ef4f965..0c152216 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -433,7 +433,7 @@ unit_tests += unit/test-cmac-aes \
 		unit/test-ie unit/test-util unit/test-ssid-security \
 		unit/test-arc4 unit/test-wsc unit/test-eap-mschapv2 \
 		unit/test-eap-sim unit/test-sae unit/test-p2p unit/test-band \
-		unit/test-dpp unit/test-json
+		unit/test-dpp unit/test-json unit/test-nl80211util
 endif
 
 if CLIENT
@@ -582,6 +582,13 @@ unit_test_dpp_LDADD = $(ell_ldadd)
 
 unit_test_json_SOURCES = unit/test-json.c src/json.h src/json.c shared/jsmn.h
 unit_test_json_LDADD = $(ell_ldadd)
+
+unit_test_nl80211util_SOURCES = unit/test-nl80211util.c \
+				src/nl80211util.h src/nl80211util.c \
+				src/band.h src/band.c \
+				src/ie.h src/ie.c \
+				src/util.h src/util.c
+unit_test_nl80211util_LDADD = $(ell_ldadd)
 endif
 
 if CLIENT
diff --git a/unit/test-nl80211util.c b/unit/test-nl80211util.c
new file mode 100644
index 00000000..34a7c2a4
--- /dev/null
+++ b/unit/test-nl80211util.c
@@ -0,0 +1,63 @@
+
+#include <assert.h>
+#include <ell/ell.h>
+#include "src/nl80211util.h"
+#include "linux/nl80211.h"
+
+static void test_parse_attrs(const void *data)
+{
+	struct l_genl_msg *msg = l_genl_msg_new(NL80211_CMD_NEW_INTERFACE);
+	uint32_t ifindex = 1;
+	uint32_t freq = 2;
+	int ret;
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &freq);
+
+	ret = nl80211_parse_attrs(msg, NL80211_ATTR_IFINDEX, &ifindex,
+					NL80211_ATTR_WIPHY_FREQ, &freq,
+					NL80211_ATTR_UNSPEC);
+	l_genl_msg_unref(msg);
+	assert(ret == 0);
+}
+
+static void test_parse_nested(const void *data)
+{
+	struct l_genl_msg *msg = l_genl_msg_new(NL80211_CMD_NEW_INTERFACE);
+	uint32_t ifindex = 1;
+	uint32_t freq = 2;
+	uint8_t noise = 3;
+	uint8_t noise_out;
+	struct l_genl_attr nested;
+	int ret;
+	int ret_nested;
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &freq);
+
+	l_genl_msg_enter_nested(msg, NL80211_ATTR_SURVEY_INFO);
+	l_genl_msg_append_attr(msg, NL80211_SURVEY_INFO_NOISE, 1, &noise);
+	l_genl_msg_leave_nested(msg);
+
+	ret = nl80211_parse_attrs(msg, NL80211_ATTR_IFINDEX, &ifindex,
+					NL80211_ATTR_WIPHY_FREQ, &freq,
+					NL80211_ATTR_SURVEY_INFO, &nested,
+					NL80211_ATTR_UNSPEC);
+	ret_nested = nl80211_parse_nested(&nested, NL80211_ATTR_SURVEY_INFO,
+					NL80211_SURVEY_INFO_NOISE, &noise_out,
+					NL80211_ATTR_UNSPEC);
+	l_genl_msg_unref(msg);
+	assert(ret == 0);
+	assert(ret_nested == 0);
+	assert(noise_out == noise);
+}
+
+int main(int argc, char *argv[])
+{
+	l_test_init(&argc, &argv);
+
+	l_test_add("/nl80211util parse attrs", test_parse_attrs, NULL);
+	l_test_add("/nl80211util parse nested", test_parse_nested, NULL);
+
+	return l_test_run();
+}
-- 
2.34.1

