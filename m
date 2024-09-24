Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C317BED2
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179504; cv=none; b=GW7Ad55j9nl/6ZlWTDGnz5PoZdj4JY0SvILXrdmbSLhStjAuBO1n3R8twci4g2HGdxY3h5K2r0UbNS5JgoaR2+59TjSH1s82X3doyFI8D+I2T2jM2QKustKnmPkw1IyhNNglATbKc5HGDm6pmCgo7X+5xGCL/pireHx0NC8yTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179504; c=relaxed/simple;
	bh=n5TzOevuzyu4chNUnnvBVYsHz9V+iImR+WMOprPRZmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4CiugqTimLg6rkVT7mUq4FDHsQs5BmrWUfffhC5BWCSn7go/mm1yDiMJ8M8jfreOJQmkqxqFwwSIo3/HubuB+G1v7g1euqyhIcmaGl+07x9G+HCXplbwX2XVFLElJrQScleaomFQMKSBOu5nVSkWSXbCnty6z7OQCdx6twKErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBCfPcbG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBCfPcbG"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c353f2f954so41903136d6.3
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179501; x=1727784301; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP4OsRCnhcCR79gzwA2W1zQiq7C514LA0zuV1FZxDeQ=;
        b=eBCfPcbGIqbwXDc7zX+m7aGSCRQSu04Dx3SWVUtwz1p0xs2q+88Uejr4c/5COk8SWI
         XNxjyNaSdO0H3HNonsOmOnOeF4qYPwhdn0l8n0owP9okuoh0Its6O7qu3wo5pgl0POsP
         FDTYsDEpX6kZcCpOm885XpcF3cSRCub1h4kFozq/tQv4sazNelu+iVYOt8GgEnDjHHjm
         gt27Urt+Q/LLkYLZVvOIB52PcifwIHN4+7M+zo1FQEK0AnrxV98sbeVx3QbRI80fZS3I
         tSxOZipQ7TNHf0OhCNPBh9whwt/s8hD3+ON+0NdVUMHXNzo0zH+7r18lzeAaTUGIaFLZ
         wwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179501; x=1727784301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LP4OsRCnhcCR79gzwA2W1zQiq7C514LA0zuV1FZxDeQ=;
        b=hNQzHRyJKVJYDhrI2vNffwpASKQ3Lt2G7gSATN3UsRhbYSLb5ILxJKD31MVOFWTLXL
         VnLICPMkGLrr0k7kwfeHPz8qdmD2DnnC/F4GVU6KofoMsZmViTSYYwLkXXJpnvuf+F1f
         20QaFtd6hgpQW9fq/vIyVppm4PR29Hp5JemPzzumI/N0KoPTpLFTyj7RAeEUdAQBDUSV
         obvJEuH61LCybn5WvxJSdQTYNKiR7eqIyOqlPG5YG+ASBZTvgMBuhdKM0JsX9oXLPb20
         R2FFVqQmUWVTlB3pNRcAzsEYsuvbAFUPT5sNoBTMxGAFj4qTF+N/ZpMa33WbrZQ7X2j4
         750Q==
X-Gm-Message-State: AOJu0YxEZRE7vLFJ1JCwFZCkqnq1kssFCFfbxLseW+o2T/ahTPIFtYax
	tVQ3DelrQOVasMExZ8BcHEq3V0Yi+0dCcHH8ppJnT4HZjhERUCKllxIN8Q==
X-Google-Smtp-Source: AGHT+IE6ktU440ELzflVi84VLhz9I+9oZ3iHwDUgecIzXu9y+h7oSVrt7OJN2NbcRwM5f768S9nTdg==
X-Received: by 2002:a05:6214:5684:b0:6c3:53d4:8554 with SMTP id 6a1803df08f44-6c7bd6024d6mr193295386d6.48.1727179501153;
        Tue, 24 Sep 2024 05:05:01 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/16] dpp: refactor dpp_send_config_response to take JSON as a parameter
Date: Tue, 24 Sep 2024 05:04:36 -0700
Message-Id: <20240924120447.251761-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924120447.251761-1-prestwoj@gmail.com>
References: <20240924120447.251761-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The future 802.1x config is too complicated for this to handle
internally so it will now be passed in as an argument.
---
 src/dpp.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 41e56197..19d10daa 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1163,13 +1163,13 @@ static void dpp_handle_config_response_frame(const struct mmpdu_header *frame,
 	dpp_reset(dpp);
 }
 
-static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
+static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status,
+					const char *json)
 {
-	_auto_(l_free) char *json = NULL;
 	struct iovec iov[3];
 	uint8_t hdr[41];
-	uint8_t attrs[512];
-	size_t json_len;
+	size_t json_len = json ? strlen(json) : 0;
+	uint8_t attrs[256 + json_len];
 	uint8_t *ptr = hdr + 24;
 
 	memset(hdr, 0, sizeof(hdr));
@@ -1211,10 +1211,7 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 	 * included. For now IWD's basic DPP implementation will assume
 	 * STATUS_CONFIGURE_FAILURE which only includes the E-Nonce.
 	 */
-	if (status == DPP_STATUS_OK) {
-		json = dpp_psk_config_to_json(dpp->config);
-		json_len = strlen(json);
-
+	if (status == DPP_STATUS_OK)
 		ptr += dpp_append_wrapped_data(attrs + 2, ptr - attrs - 2,
 						NULL, 0, ptr, sizeof(attrs),
 						dpp->ke, dpp->key_len, 2,
@@ -1222,7 +1219,7 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 						dpp->nonce_len, dpp->e_nonce,
 						DPP_ATTR_CONFIGURATION_OBJECT,
 						json_len, json);
-	} else
+	else
 		ptr += dpp_append_wrapped_data(attrs + 2, ptr - attrs - 2,
 						NULL, 0, ptr, sizeof(attrs),
 						dpp->ke, dpp->key_len, 2,
@@ -1272,6 +1269,7 @@ static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
 	struct json_iter jsiter;
 	_auto_(l_free) char *tech = NULL;
 	_auto_(l_free) char *role = NULL;
+	_auto_(l_free) char *config_object = NULL;
 
 	if (dpp->state != DPP_STATE_AUTHENTICATING) {
 		l_debug("Configuration request in wrong state");
@@ -1398,12 +1396,13 @@ static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
 
 	dpp->state = DPP_STATE_CONFIGURING;
 
-	dpp_send_config_response(dpp, DPP_STATUS_OK);
+	config_object = dpp_psk_config_to_json(dpp->config);
+	dpp_send_config_response(dpp, DPP_STATUS_OK, config_object);
 
 	return;
 
 configure_failure:
-	dpp_send_config_response(dpp, DPP_STATUS_CONFIGURE_FAILURE);
+	dpp_send_config_response(dpp, DPP_STATUS_CONFIGURE_FAILURE, NULL);
 	/*
 	 * The other peer is still authenticated, and can potentially send
 	 * additional requests so keep this session alive.
-- 
2.34.1

