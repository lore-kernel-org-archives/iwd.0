Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3403427F758
	for <iwd@lists.linux.dev>; Mon, 19 May 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665578; cv=none; b=O/OE+p0CQZb/V4+2+H9Hl54UQ0Kc3NKEaTUEVbbdTpqk4kIWqidEu2Pz1SWTDz+awBd9nm8QnS+dHYU2e+7BnoyFzSL0Zt/uRK7hPqEaDxH5XfHbfJNv9yHIEp2bMgmXXr49pS393sPGBTbs0HvfqCo6KLeJqcqCq2hr/S6sFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665578; c=relaxed/simple;
	bh=6eI66h2lmUxDmP584oH3o3L1wjtxdBrpQ+fhN/iabdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pl4GEyXl1dqZIzNfCuAhEpqtfkb5Cx0NRD1rE0WKN03LzC3v9iXT5q5ZuxK0u9B+bDmBztYK3CftuxnA5uV0FSZoxt/7jcdYS04OB3ydtYzTi1Yh1q8J1TCJv+3Tw+Hb11d8AV97ZvqMMyl2HkYnGkxkra21C8mkpLUpzSfJY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg6gS58v; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg6gS58v"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f8d8fb211eso8256246d6.3
        for <iwd@lists.linux.dev>; Mon, 19 May 2025 07:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747665576; x=1748270376; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4JY9XfBNaGpa6MsBayfMDot3cLV++Nau4I8N4/eujZs=;
        b=gg6gS58vRLZrXLsKwqU6Bv6NWnrKonvufLY4x3/DJ6v5IjZtWIjPiPnOApJAe30BbX
         /rZ2yqXXNwN4bRvisfYLjC8NrA+myYZjKbmLHKhAvZWRyVFwfY/KtYm9OC8/R0qB/I9o
         CjQ98muwtorCpLHRPd1cPn8jz9I7IvB5ObdPBoPys5vyUjQjT9/ICKbKPHrN2VZNPRZz
         c4WY0ie+IAG0flC+0Gk2mFFWO+c4cYSGhsLF37pmzpLwbvp00BfTJxLDP+KcHCLJ6Ocj
         6F5j38Qkvm5EPO4wkINQFEMV+izJGnw1Sa5THU8OvMlMOlwZOAFrWrVs7Ni/IJi/bLFM
         tejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747665576; x=1748270376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JY9XfBNaGpa6MsBayfMDot3cLV++Nau4I8N4/eujZs=;
        b=DLddUgFq07NnSWr9GdbLG0DgJO57RoYPKhEKC4HY70W5gazPLLebbNKaOe1fIWyo4a
         189RoExc0WuSBc0jFif9lPX7x8ZX2nd81LO1XRZzcqDCEKDT3djN4hoei/aJubnlpPl3
         sfHuPKB3kUEZ2gaXvubx45olgQ69/VvEJA5zY7yVIrV5DrukTdp8Pp+4kpAQMaEruizC
         TQ44lydLSFNJdQSsujGrL6O2cLqKMyzkPGHEO/T23g3vLDuVxcyBCUdDtwxqoVocBwhe
         VX2HETpPPb6KIzIVbVP/KBr4V+2FVk0SuJVJ4wYI2LR4n4nxsAYunyokgMbYr1w/mn0n
         a7OA==
X-Gm-Message-State: AOJu0YwNV+lN+O9Wn+q82ccN4FwduzneGapWDnzVPajM2sVyOeu+075w
	8u6TQ1/WeJk4bqMpO67hv87RuP2JoV+zMCKV+63JAt529Rxl1ADYqQNI2PfrJg==
X-Gm-Gg: ASbGncsJTlacFFFwjLTALGg6G6JvMCAFFa0Ur7QwY++a/lAMJUBMYCYOamjDV84PB9s
	meIo7OOiGS5ET/78sb4kQj3VUGbqAc4lHHKGiej5TSDxkZkh9ZvQF7gbGWfkg7hnzZu2ovN/z4y
	RxsPz36mK5M99+T0qwZJXKobUw1BVJUpPn7JZQR+J7Zv7wdqIl02DcJEQqMuvOB52P6WRwxh0IP
	KmIPUw1BrotMXLE5hyPO40WbVVLWVAlzL7k3f709qFcGy1NIZLH6D7Zqi0prjQnEIOn7nDrsAJE
	Y38oUsyj8j4m7BsH4/VjUXSAbEFEhTo4h9kSKz1hEjSdnwmAvlGCA/73moi4TSHdvVG+IhA7qSC
	huIcDXlf7wg==
X-Google-Smtp-Source: AGHT+IHZfw70PJDXLTBt9SMdjZW+lcwcyH9aveBQQG7TXSffRei7tI0u80xMp4o9wbcA4Gnsz2YLdw==
X-Received: by 2002:a05:6214:62c:b0:6f4:c742:7a7b with SMTP id 6a1803df08f44-6f8b08e5baamr192668006d6.43.1747665575746;
        Mon, 19 May 2025 07:39:35 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b08be302sm57525966d6.54.2025.05.19.07.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:39:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ap: implement pre-scanning to "unlock" frequencies
Date: Mon, 19 May 2025 07:39:30 -0700
Message-Id: <20250519143930.182695-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers/hardware are more strict about limiting use of
certain frequencies on startup until the regulatory domain has
been set. For most cards the only way to set the regulatory domain
is to scan and see BSS's nearby that advertise the country they
reside in.

This is particularly important for AP mode since AP's are always
emitting radiation from beacons and will not start until the desired
frequency is both enabled and allows IR. To make this process
seamless in IWD we will first check that the desired frequency is
enabled/IR and if not issue a scan to (hopefully) get the regulatory
domain set.
---
 src/ap.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index d52b7e55..af6a1709 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -109,6 +109,8 @@ struct ap_state {
 	struct l_timeout *rekey_timeout;
 	unsigned int rekey_time;
 
+	uint32_t pre_scan_cmd_id;
+
 	bool started : 1;
 	bool gtk_set : 1;
 	bool netconfig_set_addr4 : 1;
@@ -354,6 +356,12 @@ static void ap_reset(struct ap_state *ap)
 		l_timeout_remove(ap->rekey_timeout);
 		ap->rekey_timeout = NULL;
 	}
+
+	if (ap->pre_scan_cmd_id) {
+		scan_cancel(netdev_get_wdev_id(ap->netdev),
+				ap->pre_scan_cmd_id);
+		ap->pre_scan_cmd_id = 0;
+	}
 }
 
 static bool ap_event_done(struct ap_state *ap, bool prev_in_event)
@@ -3852,6 +3860,70 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 	return 0;
 }
 
+static void ap_pre_scan_trigger(int err, void *user_data)
+{
+	struct ap_state *ap = user_data;
+
+	if (err < 0) {
+		l_error("AP pre-scan failed: %i", err);
+		ap_start_failed(ap, err);
+		return;
+	}
+}
+
+static bool ap_check_channel(struct ap_state *ap)
+{
+	const struct band_freq_attrs *freq_attr;
+
+	freq_attr = wiphy_get_frequency_info(netdev_get_wiphy(ap->netdev),
+				band_channel_to_freq(ap->channel, ap->band));
+	if (L_WARN_ON(!freq_attr))
+		return false;
+
+	/* Check if disabled/no-IR */
+	if (freq_attr->disabled || freq_attr->no_ir)
+		return false;
+
+	return true;
+}
+
+static bool ap_pre_scan_notify(int err, struct l_queue *bss_list,
+				const struct scan_freq_set *freqs,
+				void *user_data)
+{
+	struct ap_state *ap = user_data;
+
+	if (!ap_check_channel(ap)) {
+		l_error("Unable to channel %u even after pre-scan",
+			ap->channel);
+		goto error;
+	}
+
+	if (ap_start_send(ap))
+		return false;
+
+error:
+	ap_start_failed(ap, -ENOTSUP);
+	return false;
+}
+
+static void ap_pre_scan_destroy(void *user_data)
+{
+	struct ap_state *ap = user_data;
+
+	ap->pre_scan_cmd_id = 0;
+}
+
+static bool ap_pre_scan(struct ap_state *ap)
+{
+	ap->pre_scan_cmd_id = scan_passive(netdev_get_wdev_id(ap->netdev),
+						NULL, ap_pre_scan_trigger,
+						ap_pre_scan_notify,
+						ap, ap_pre_scan_destroy);
+
+	return ap->pre_scan_cmd_id != 0;
+}
+
 /*
  * Start a simple independent WPA2 AP on given netdev.
  *
@@ -3962,6 +4034,20 @@ struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 		return ap;
 	}
 
+	if (!ap_check_channel(ap)) {
+		l_debug("Channel %u is disabled/no-IR, pre-scanning",
+			ap->channel);
+
+		if (ap_pre_scan(ap)) {
+			if (err_out)
+				*err_out = 0;
+
+			return ap;
+		}
+
+		goto error;
+	}
+
 	if (ap_start_send(ap)) {
 		if (err_out)
 			*err_out = 0;
-- 
2.34.1

