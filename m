Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7973CCFD
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSw+zGLK"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7788fb06997so102995685a.0
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352033; x=1698956833; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSvt6ZDaBum2UHDFAGyA7QBLUBxP0Owt66+RsftU13Q=;
        b=BSw+zGLKhbrCYxGHCz2F5UYHRvVXu6QpWXQO04lsUOQ7GgaDBrvypl6N3uOaeP7Sqo
         pHt3spm81egbkBzZ6Hvu0fXzteTiuV2KDdsrztDV5x1EvHEYBPkb0fBGphuPFALFExmB
         dFYPuEx4l6CZxzBJZX7WYsRlc0BSiLp8ZNWnsR9Z+OTvjeOgoTCOJ5LPyNCCDchLupZd
         GRDAkMlbuynVymi01ByxO15MFxegdEtYVFnhnzmolUajppCpnOS5bJIaIC6zGwUCFtCq
         2V+e6GEEyVqb19SgGBEfPkp1KAIT+Ud5epEO6+Gy4FkyAZUrrf5zzZpYbU3VpDru8feF
         //4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352033; x=1698956833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSvt6ZDaBum2UHDFAGyA7QBLUBxP0Owt66+RsftU13Q=;
        b=DaBjQv/Ie66HNphIvxgKg+3IfgSBDljfttzYybtsYqth2viq3WcZgSZY4fBJgpZAQw
         O7JbIqxkvoF+YWyn+QX9yZAjDevsSMoaVRSLPy21/sNddSVh4Q6DBMCXPxB0u7H31NFJ
         noNTogSDHrhEiEwe6qaMBFMQAbZp3VC2gF0f9/Zns+qsGjpC2gYSC8Hiwf6ad29pvo2S
         bvafwIZxsuzXdndbsr0XVMNByqBSW7R4+0HxtXBbVNNERIFME5le2oeo8vHHyLMsoB5p
         CLWuauIZk7QTlqXT2xDRiDf4pQ8KLPkyc2vD/8vU0hglglXI2iTLI9J6AHwww+arSzRB
         vs5Q==
X-Gm-Message-State: AOJu0YwK7meyRruNuQ3WgSOHsOFx1Plv2q3sCb98d4o9DBe9zlDt/h2+
	xfzEG5yLyYGKCqJsn3/eYPVYE2pxxcI=
X-Google-Smtp-Source: AGHT+IGwDTogpnYgqDzXwi99oP30BnZJw7CjmRsDsDz4Mi3U3tVA0qO5T1rjoQUtFsLZ7e047IqEaw==
X-Received: by 2002:a05:620a:2890:b0:774:17f5:471e with SMTP id j16-20020a05620a289000b0077417f5471emr486786qkp.46.1698352033346;
        Thu, 26 Oct 2023 13:27:13 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:13 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 05/15] dpp: fix config request header check
Date: Thu, 26 Oct 2023 13:26:47 -0700
Message-Id: <20231026202657.183591-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026202657.183591-1-prestwoj@gmail.com>
References: <20231026202657.183591-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check for the header was incorrect according to the spec.
Table 58 indicates that the "Query Response Info" should be set
to 0x00 for the configuration request. The frame handler was
expecting 0x7f which is the value for the config response frame.

Unfortunately wpa_supplicant also gets this wrong and uses 0x7f
in all cases which is likely why this value was set incorrectly
in IWD. The issue is that IWD's config request is correct which
means IWD<->IWD configuration is broken. (and wpa_supplicant as
a configurator likely doesn't validate the config request).

Fix this by checking both 0x7f and 0x00 to handle both
supplicants.
---
 src/dpp.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index dff0ecaf..6fd37272 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -887,6 +887,21 @@ static void dpp_send_config_response(struct dpp_sm *dpp, uint8_t status)
 	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 
+static bool dpp_check_config_header(const uint8_t *ptr)
+{
+	/*
+	 * Table 58. General Format of DPP Configuration Request frame
+	 *
+	 * Unfortunately wpa_supplicant hard codes 0x7f as the Query Response
+	 * Info so we need to handle both cases.
+	 */
+	return ptr[0] != IE_TYPE_ADVERTISEMENT_PROTOCOL ||
+			ptr[1] != 0x08 ||
+			(ptr[2] != 0x7f || ptr[2] != 0x00) ||
+			ptr[3] != IE_TYPE_VENDOR_SPECIFIC ||
+			ptr[4] != 5;
+}
+
 static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
 				const void *body, size_t body_len,
 				int rssi, void *user_data)
@@ -904,8 +919,6 @@ static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
 	const uint8_t *e_nonce = NULL;
 	size_t wrapped_len = 0;
 	_auto_(l_free) uint8_t *unwrapped = NULL;
-	uint8_t hdr_check[] = { IE_TYPE_ADVERTISEMENT_PROTOCOL, 0x08, 0x7f,
-				IE_TYPE_VENDOR_SPECIFIC, 5 };
 	struct json_iter jsiter;
 	_auto_(l_free) char *tech = NULL;
 	_auto_(l_free) char *role = NULL;
@@ -932,10 +945,10 @@ static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
 
 	dpp->diag_token = *ptr++;
 
-	if (memcmp(ptr, hdr_check, sizeof(hdr_check)))
+	if (!dpp_check_config_header(ptr))
 		return;
 
-	ptr += sizeof(hdr_check);
+	ptr += 5;
 
 	if (memcmp(ptr, wifi_alliance_oui, sizeof(wifi_alliance_oui)))
 		return;
-- 
2.25.1

