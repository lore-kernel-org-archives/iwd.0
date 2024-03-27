Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05D3A8E4
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552808; cv=none; b=SXSx5UuvmloCNlYvuYFae8DpHMuSKJSZBVosM0ra3hw+RbhcElaQ7/e87GrEi7ZpieTHpZN6bHvw2MGPVSfc1ZiG4sIsju0PvzLFIUKPAN8m1VCPKb1eVV3rpMBh9xahlHojjBkh1ETLrvhuH3xEGsgmZL0G4hNamJFETRIvIuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552808; c=relaxed/simple;
	bh=lb9/VaPQdNylr3CnZS/warLCHD/03kqFpnOXWC0cQeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMqGXgMkNwazWPGN+gV74TeKrSAvaP0kdCVU7Mct/MYZWfWSfbU2fTpov9uefIPD55X0vAiT2KDpbzQsCWWQx5chGXfN6ccwUUSZYXwcm0tP10SEyriIPKtDwrblOodX7sRzGNi2irhAIRgRfGAoGuAxJ7/gXB+UxIwfXaBB8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGdqFnxs; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGdqFnxs"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-690de619293so41902146d6.0
        for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711552805; x=1712157605; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfggQUFqh8R0OL7pLM6apbCSjclCuBMPEFy6joovcww=;
        b=bGdqFnxsBqMdD+f+3Urh/Kof8pEt4sUo4Z+mxXRdupEY9uU50AWIZl8yufkPOu0OF3
         gaVlSfMW5EGqvnsFQBPtvatp0TAVpFl/7AcQ8hpuE3+9/aoDkQ4bPJGuMfstZMkpDk+Q
         NDmbd3atkxOSmJA+YoAYXuKREXBDsCp/1/Dn1KObO4wogQD1Q5m968fiQ2aWwh+UaNEE
         fz/t+KkTN+YE5e/tCv3+vmipSJl0uSBpVlJnyqlV3/fC5zWZ5FalGigEZMkucGxDZmax
         kScRXrgOv0WYAlXXWYl01+koZyGNIvF8QPss+TVTIvKw6CtbAzyHxZ5KUdo7gUEAKwK8
         e3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552805; x=1712157605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfggQUFqh8R0OL7pLM6apbCSjclCuBMPEFy6joovcww=;
        b=keP/MDaDdE1fjOwrNb2arjKx3hI/3S6/OPemi9QpdnTU9rFan1kFWn60xUgu52fKUG
         tHRhc6qJnS3CuOt4zin/S+ZqjDrpxuFnmEttq0/+/so0Kz2Qk+nO6yOIMqINp2VRlzIJ
         h3hDa0ggjTxj7ikDgdRsxOMyFEHkjrJaTEj2S8GLrvXjJ2mGOVX6NxrXfle5MhiHgsN7
         6nwZR+pDEroSTYx9Flq0bSY9WPA1v7eErpWKmxP291EV+ixFSnhCBkP0+hvrKJLjf7qV
         tG9HiPl6X0+lGE7FW2W1NfSs49QDFrQNKLqHvGqa589YB70LFojPugU2sqipSxJKrYQ8
         bBIg==
X-Gm-Message-State: AOJu0YwybdzXpA6U2NHXko7PYrUrmL3S61Mo5cBOhgaW87IYEccP5NTh
	fEKiwIhxBpcm/qsgO63w1psyjIlXGTKEWvLK1Yba9Jg1KVeJTv/edAGCur7T
X-Google-Smtp-Source: AGHT+IH+DI5AkaUkwX100hC82MKw3Ag9kFlupsU6GXlMs9jceXW9T4BeZS79fvPp9dBi/Wtp8zRrVw==
X-Received: by 2002:ad4:5e8c:0:b0:696:8a5d:8e79 with SMTP id jl12-20020ad45e8c000000b006968a5d8e79mr5870477qvb.30.1711552805081;
        Wed, 27 Mar 2024 08:20:05 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 7-20020a056214202700b006968ce99b7esm3520782qvf.34.2024.03.27.08.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:20:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/9] dpp-util: add dpp_append_point
Date: Wed, 27 Mar 2024 08:19:51 -0700
Message-Id: <20240327151957.1446149-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327151957.1446149-1-prestwoj@gmail.com>
References: <20240327151957.1446149-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any time DPP needs to append a point it has to use a temporary
buffer to copy into, then copy that into the message buffer.
Instead of this add a special purpose API to add the type/length
then copy the data directly into the message buffer.
---
 src/dpp-util.c | 13 +++++++++++++
 src/dpp-util.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index ada7ed96..81f34047 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -697,6 +697,19 @@ size_t dpp_append_wrapped_data(const uint8_t *frame, size_t frame_len,
 	return attrs_len + 4 + 16;
 }
 
+size_t dpp_append_point(uint8_t *to, enum dpp_attribute_type type,
+				struct l_ecc_point *point)
+{
+	const struct l_ecc_curve *c = l_ecc_point_get_curve(point);
+	size_t len = l_ecc_curve_get_scalar_bytes(c) * 2;
+
+	l_put_le16(type, to);
+	l_put_le16(len, to + 2);
+	l_ecc_point_get_data(point, to + 4, len);
+
+	return len + 4;
+}
+
 /*
  * EasyConnect 2.0 Table 3. Key and Nonce Length Dependency on Prime Length
  */
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 387750aa..1ff9004d 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -151,6 +151,8 @@ size_t dpp_append_attr(uint8_t *to, enum dpp_attribute_type type,
 size_t dpp_append_wrapped_data(const uint8_t *frame, size_t frame_len,
 				uint8_t *to, const void *key, size_t key_len,
 				size_t num_attrs, ...);
+size_t dpp_append_point(uint8_t *to, enum dpp_attribute_type type,
+				struct l_ecc_point *point);
 
 char *dpp_generate_uri(const uint8_t *asn1, size_t asn1_len, uint8_t version,
 			const uint8_t *mac, const uint32_t *freqs,
-- 
2.34.1

