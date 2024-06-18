Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42D1CA80
	for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729955; cv=none; b=B+N5/ds/J5Ygmv6A3Zdaza3NYT34YoJjPQ4LVS2A10zhILxN4qX+VAi82jVu0/Avpgvo9Z/dY6XNsEiPMDD9+1snPOHfIMhg7FWaLm2PGZL09qa+1RgNeuC3frveBTtZ6f/Wdq3bT/2djVRfPvICi/UY0EOUAg4sVcrVNliGRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729955; c=relaxed/simple;
	bh=uoLh7ZThrih6ndfpJ1BfPHhyxIzr+KFOvg3V89yDoAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGrk6lvNVbI475Pe7BEly3NUmqRfU4BL9LU5trTCNIbBNAMPRGToS/jFd26t28ry71BKfsjO+QOPDfK7XQqGFwM4Fcg7scilA5fZMgDBp9uG3ag01OyrxBCIgR8Je+4xzOp6mi4EMXrr49M4dqxoJfzglBMeENKgTvYsbFrmhPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpPyJpS5; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpPyJpS5"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-797b24b8944so533297985a.0
        for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718729952; x=1719334752; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfKh5Zksqm4ttq/9eaP7c7Ayyv0YPlHKaWrWdMb3sGc=;
        b=lpPyJpS50Uz3MGi9i0AkY4Iw3gIhWfafFPX/z0J5FXaABpi7pBulde/v9+i3resmo8
         z9FV1Ri1V45feCnqhzp7F2qtFJJzFxEEdJoUIndBde5A3XpBeSrtPKAXexkOBEE9+MT5
         jVJd2TDG2LzoxJ2IdvvYppu3qrxMHOkd05Cu+BsIkoF/mP8W5XioUBo64ETvcFxF0RA3
         Octmt/pjdMeNnw+SXiMEG4QYx9IH82KWn/TuQL9hfZxY2IqKn2U1fK0v7Ny6GB/Ra1Ye
         9FxO7jxg6vUdIqu6VYtQndcHawqNg33MFcKBLntDOK/vista2OXTK83dNcCwQDZoLaPS
         7xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729952; x=1719334752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfKh5Zksqm4ttq/9eaP7c7Ayyv0YPlHKaWrWdMb3sGc=;
        b=GBpgKOfMD7Txt9pIRRU5HrI0RSK9ga6hnRY7F4c2yiMtA4QarjhTe7PQ7pH60FS6i0
         I/ro+gqwPGTRkwH+bPe3tpX8pK+1Iq2sQXPGYtfTZQ1pPrBUfApC3QcgMfdeUCk6Qcxw
         /VI63EsZfHyVT85pFR16TpnPGipJZU1OP8/PETDozyz7iRacoE7f4zXPRj0jvXQ0ApOM
         n+aVq+TP2bdoKsU8j2ORYSxnX0dP5nMWyBJEX2vVmxe+Ig3VgNmv1lp8FSOLNeMwtzcX
         yVn0Jbi9IxoLOSbXTs9K3qEyFAcvILjd8nxrENEHq0CBaiqW6DZ+RWuWlFowJXA9e9om
         bmPA==
X-Gm-Message-State: AOJu0YyZPHvMN7XMwpX3sUtxvO0hL3BUh/ETuNlvtrEMyA3lQ5/aC1Hr
	ATK3j/c9wnLem1Z59MqP3GBfAWzCy5T0XEcQEFcepeqGlZ81Ml0UnX5x2A==
X-Google-Smtp-Source: AGHT+IGmBOJNqxO72EZV9p4S5TRPuZiiMR2IHOLBMW7EV5GgUEriIzgOFXf3NhV8Kj8CF+087VIbNA==
X-Received: by 2002:a05:620a:3906:b0:795:22e7:6fe9 with SMTP id af79cd13be357-79bb3edfe78mr28987485a.63.1718729952264;
        Tue, 18 Jun 2024 09:59:12 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b49e4c82sm533688785a.88.2024.06.18.09.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:59:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/10] station: refactor the printing of scan results, print SNR/load
Date: Tue, 18 Jun 2024 09:58:54 -0700
Message-Id: <20240618165854.113598-10-prestwoj@gmail.com>
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

There are a few values which are nice to see in debug logs. Namely
the BSS load and SNR. Both of these values may not be available
either due to the AP or local hardware limiations. Rather than print
dummy values for these refactor the print so append the values only
if they are set in the scan result.
---
 src/station.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/src/station.c b/src/station.c
index 641068cc..2e5febee 100644
--- a/src/station.c
+++ b/src/station.c
@@ -402,6 +402,27 @@ static int bss_signal_strength_compare(const void *a, const void *b, void *user)
 	return (bss->signal_strength > new_bss->signal_strength) ? 1 : -1;
 }
 
+static void station_print_scan_bss(const struct scan_bss *bss)
+{
+	uint32_t kbps100 = DIV_ROUND_CLOSEST(bss->data_rate, 100000);
+	char optional[64] = {0};
+	char *ptr = optional;
+
+	if (bss->have_snr)
+		ptr += sprintf(ptr, ", snr: %d", bss->snr);
+
+	if (bss->have_utilization)
+		ptr += sprintf(ptr, ", load: %u/255", bss->utilization);
+
+	l_debug("Processing BSS '%s' with SSID: %s, freq: %u, rank: %u, "
+			"strength: %i, data_rate: %u.%u%s",
+			util_address_to_string(bss->addr),
+			util_ssid_to_utf8(bss->ssid_len, bss->ssid),
+			bss->frequency, bss->rank, bss->signal_strength,
+			kbps100 / 10, kbps100 % 10,
+			optional);
+}
+
 /*
  * Returns the network object the BSS was added to or NULL if ignored.
  */
@@ -412,14 +433,8 @@ static struct network *station_add_seen_bss(struct station *station,
 	enum security security;
 	const char *path;
 	char ssid[33];
-	uint32_t kbps100 = DIV_ROUND_CLOSEST(bss->data_rate, 100000);
 
-	l_debug("Processing BSS '%s' with SSID: %s, freq: %u, rank: %u, "
-			"strength: %i, data_rate: %u.%u",
-			util_address_to_string(bss->addr),
-			util_ssid_to_utf8(bss->ssid_len, bss->ssid),
-			bss->frequency, bss->rank, bss->signal_strength,
-			kbps100 / 10, kbps100 % 10);
+	station_print_scan_bss(bss);
 
 	if (util_ssid_is_hidden(bss->ssid_len, bss->ssid)) {
 		l_debug("BSS has hidden SSID");
@@ -2655,15 +2670,9 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 
 	while ((bss = l_queue_pop_head(bss_list))) {
 		double rank;
-		uint32_t kbps100 = DIV_ROUND_CLOSEST(bss->data_rate, 100000);
 		struct roam_bss *rbss;
 
-		l_debug("Processing BSS '%s' with SSID: %s, freq: %u, rank: %u,"
-				" strength: %i, data_rate: %u.%u",
-				util_address_to_string(bss->addr),
-				util_ssid_to_utf8(bss->ssid_len, bss->ssid),
-				bss->frequency, bss->rank, bss->signal_strength,
-				kbps100 / 10, kbps100 % 10);
+		station_print_scan_bss(bss);
 
 		/* Skip the BSS we are connected to */
 		if (!memcmp(bss->addr, station->connected_bss->addr, 6))
-- 
2.34.1

