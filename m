Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08045225DA
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2z9EHVy"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-66d0f945893so39645286d6.1
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 09:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699898047; x=1700502847; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0IaM11PGjpSMIA8LGJWDHa5sFHSD9xFTGQTRwr6uRk=;
        b=S2z9EHVyUPhycm2PBjc+M9slto5aYjCSCoH9MNJMXKfl9joomiDPFdlWNX0y4bN97L
         IZPAZHd5pgMsIiS44pHfWfPgOh/nxLc8E2IpHN9jwJiTOTSl5U7vTmeOpl9ZikcdH1LI
         0S77O9zfU+nGJe/yuXBh/F7u22TVwgdvfpoxITBKT6HrOrbyOqHNUIO9IncZ+0MS52tO
         7qCpiKi7BvqitpPjLhJnKgjAQpXWLVo2LBeH632XT4hsOrFMocPyKbAAeJ4HIAv3dfSr
         Fag2p33EsmHyuXBh962nVMHJAkM2aRBJL1B8HE2nQMbGZCa4wqoOd/JTVQEm88PByEpf
         L+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699898047; x=1700502847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0IaM11PGjpSMIA8LGJWDHa5sFHSD9xFTGQTRwr6uRk=;
        b=CYKyk538u4YckeHuBJvfebbPDli1rtY5kwsNdBSqJ4WyRMutgJlEhTIvs+hfcrL03W
         3e2xVJqwMQnwqyN1+wgBG81/vr7B1CrGf0qEgGGe5oaeGTA11f46arOEaZxkG7zfutVP
         VNR5X58iqpGHHWCeTfXJQwMDL1RGhLItPrVHFOYx6b0ixXZio4Z/xmzlVySNLjIuu4d1
         mYH1qKofD/gScGlvsdW8OnvfgR1c59510dtJOfoKMMTDs+k+f4lNo/VPARxEvXzz7Nwc
         XYBkEBrTD52KpkYH5xFqbZv1hFlxfetksZne6TCUo1XHGMhZdvamu6DCobXVGL4Q30zZ
         O0WA==
X-Gm-Message-State: AOJu0Yz18LPTpVg9qH6c2MQ3P7RD99gcnlMzFxZuajaXYMmUXMI7NvOz
	B2Vv59vvmym0yKzumVeE9yAmk+uZVEU=
X-Google-Smtp-Source: AGHT+IETPEjT/wpN+SvFf/awgfOs+CrjCikJjpL3IPFArAIKcZT+c2z+1vu+lKq8xkgrcHVn1RNj6Q==
X-Received: by 2002:ad4:4aea:0:b0:66d:13b5:ca16 with SMTP id cp10-20020ad44aea000000b0066d13b5ca16mr304583qvb.27.1699898047478;
        Mon, 13 Nov 2023 09:54:07 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id n11-20020a05620a294b00b007756c0853a5sm2010975qkp.58.2023.11.13.09.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 09:54:07 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] dpp: fix fragile scan/connecting logic
Date: Mon, 13 Nov 2023 09:54:00 -0800
Message-Id: <20231113175401.343239-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113175401.343239-1-prestwoj@gmail.com>
References: <20231113175401.343239-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The post-DPP connection was never done quite right due to station's
state being unknown. The state is now tracked in DPP by a previous
patch but the scan path in DPP is still wrong.

It relies on station autoconnect logic which has the potential to
connect to a different network than what was configured with DPP.
Its unlikely but still could happen in theory. In addition the scan
was not selectively filtering results by the SSID that DPP
configured.

This fixes the above problems by first filtering the scan by the
SSID. Then setting the scan results into station without triggering
autoconnect. And finally using network_autoconnect() directly
instead of relying on station to choose the SSID.
---
 src/dpp.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 06ae2929..a95f93e2 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -853,13 +853,42 @@ static bool dpp_scan_results(int err, struct l_queue *bss_list,
 {
 	struct dpp_sm *dpp = userdata;
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	struct scan_bss *bss;
+	char ssid[33];
+	struct network *network;
 
 	if (err < 0)
-		return false;
+		goto reset;
+
+	if (!bss_list || l_queue_length(bss_list) == 0)
+		goto reset;
+
+	/*
+	 * The station watch _should_ detect this and reset, which cancels the
+	 * scan. But just in case...
+	 */
+	if (L_WARN_ON(station_get_connected_network(station)))
+		goto reset;
+
+	/* Purely for grabbing the SSID */
+	bss = l_queue_peek_head(bss_list);
 
-	station_set_scan_results(station, bss_list, freqs, true);
+	memcpy(ssid, bss->ssid, bss->ssid_len);
+	ssid[bss->ssid_len] = '\0';
+
+	station_set_scan_results(station, bss_list, freqs, false);
+
+	network = station_network_find(station, ssid, SECURITY_PSK);
+
+	dpp_reset(dpp);
+
+	bss = network_bss_select(network, true);
+	network_autoconnect(network, bss);
 
 	return true;
+
+reset:
+	return false;
 }
 
 static void dpp_scan_destroy(void *userdata)
@@ -898,6 +927,7 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	struct network *network = NULL;
 	struct scan_bss *bss = NULL;
 	char ssid[33];
+	size_t ssid_len;
 
 	if (dpp->state != DPP_STATE_CONFIGURING)
 		return;
@@ -1027,6 +1057,7 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	 */
 	if (station) {
 		memcpy(ssid, config->ssid, config->ssid_len);
+		ssid_len = config->ssid_len;
 		ssid[config->ssid_len] = '\0';
 
 		network = station_network_find(station, ssid, SECURITY_PSK);
@@ -1045,7 +1076,14 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 		__station_connect_network(station, network, bss,
 						STATION_STATE_CONNECTING);
 	else if (station) {
-		dpp->connect_scan_id = scan_active(dpp->wdev_id, NULL, 0,
+		struct scan_parameters params = {0};
+
+		params.ssid = (void *) ssid;
+		params.ssid_len = ssid_len;
+
+		l_debug("Scanning for %s", ssid);
+
+		dpp->connect_scan_id = scan_active_full(dpp->wdev_id, &params,
 						dpp_scan_triggered,
 						dpp_scan_results, dpp,
 						dpp_scan_destroy);
-- 
2.25.1

