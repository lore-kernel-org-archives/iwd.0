Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D39BB673
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956651; cv=none; b=G9jmvjsBnpga9pLc9OVIfKueRotD/lAfH+qfhvqPEM3CGK4gCIJaXYeaiVbZzEvC3OTYwzSi2sf56Nxn1sQ+umge5qP0pkFaCUPfu3UMHYA+Ufg1i2clcWVzpispKFQNaglfLm/4bdAVO4TEx2nfBTbWtg1VSNLkJObSy+mcoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956651; c=relaxed/simple;
	bh=c6SY4E9wmMW/mE0KPPLBr2qFnzdmzHOyEjXrpu0iqtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lyvq5Ii/XL/nHw9M2chgVvebP55QyrXm0XA+v1difj5AnW8TPuduJIc6Yd4XBHU4zMiXfE/Is5tBy2KvYB2QKkb8QwdLonNzpcePnTJH9t0FUotDPBa8bn4ufFF9OKfHV60EpEMAQEeoxqTJPMunXgTk6wVWkN4r4w9LCoKR608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COaDIFP2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COaDIFP2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec4b2400b6so9104725ad.3
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956649; x=1715561449; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SxEZPUTntS6l0z3SFOZC+kHiFFzrVFOqbytO/m/LnI=;
        b=COaDIFP2g+NiF2aD9o15YgpTjDHwnsWUnh6OZ+Doj5vzLQLFGiHRpLiRy4UDKsmhJw
         71gUTNfIN9/GH5u9dzJmwIv8Jh4j6Kt8zjS3fJ4SXclQbd8Ux40VHSl0L+tixi+b8YGZ
         9nFsdF8HAJo81tNoN47o/AAX9ocxanx3Loz+cvBw1ME9rVHwY+ARMH312+EAli8h7ZlH
         IcmJuUXbQ6TQsS3/UM8LVhvjX/x7JFTZduj2xSnKBHNkeRaNzvq6lerGDVBJfaENichZ
         3oA6R3UBx5dL9rNG8/6jIwfS63KCV4JV3KFhtjOqBAWZAFrS7J4B8b1ZpJ3UHbqkV4my
         txRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956649; x=1715561449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SxEZPUTntS6l0z3SFOZC+kHiFFzrVFOqbytO/m/LnI=;
        b=V8SGxY+1/9TvG2M7amkv2Mv+tltPhgGIC9+u6PMJInr1bu4u08SMDD52tIj9UY6f72
         d4OuCmGaYZhp8KHP8RKSQ7RKwK1F9XFTglUA7/WcbMLCQ1zRD8AmluHBABCNr1Ihk1vp
         lqIFIYGbgGwpv+PEDp5wiCgeV4uXle/Shn4POFw5tu6sjMLLaB0H89gZREUQwfT/baEs
         jO3jW3MkcO6x/OPdwYllCGyG8doUYv9jwJOWn8DBZPF8122HSynS+dZjhPSDa8W9q9eR
         kbvh1QsxDlnspwqcN63jdkaNGyVwuR3oMQIdSI3HlGSv5GtCi/n8xzKjvaiXVXfBijXz
         Rv0Q==
X-Gm-Message-State: AOJu0Yym6kT8/7KrxF4ylEyzZ/gyB+KoUpPsutscvPF2+UBXs6IJOamE
	fFjYwaS0Ck0fcxHsv+uSFry3fIWHxXA4yZ03tguCVUsqHtfhQnTbbUCA4g==
X-Google-Smtp-Source: AGHT+IEXv/NgNgn+0jtUPtCJRhdZ/nnLZz2EcySLffEsIxfY8X94JGUFW7uxglZH3ppLca+i7tDmbA==
X-Received: by 2002:a17:902:f815:b0:1ea:5aff:c8ce with SMTP id ix21-20020a170902f81500b001ea5affc8cemr7049875plb.29.1714956649282;
        Sun, 05 May 2024 17:50:49 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id jw5-20020a170903278500b001e26ba8882fsm7019286plb.287.2024.05.05.17.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:50:49 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 16/18] eapol: include IGTK in 4-way handshake as AP
Date: Sun,  5 May 2024 17:30:39 -0700
Message-ID: <20240506003518.320176-17-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506003518.320176-1-brandtwjohn@gmail.com>
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SAE with MFP is being used, include the IGTK in message 3 of the
4-way handshake.
---
 src/eapol.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/eapol.c b/src/eapol.c
index 524a26c9..8b21b886 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1454,6 +1454,18 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *sm)
 		key_data_len += gtk_kde[1] + 2;
 	}
 
+	if (sm->handshake->mfp) {
+		enum crypto_cipher group_management_cipher = ie_rsn_cipher_suite_to_cipher(
+				sm->handshake->group_management_cipher);
+		uint8_t *igtk_kde = key_data_buf + key_data_len;
+
+		handshake_util_build_igtk_kde(group_management_cipher,
+						sm->handshake->igtk,
+						sm->handshake->igtk_index,
+						igtk_kde);
+		key_data_len += igtk_kde[1] + 2;
+	}
+
 	if (sm->handshake->support_ip_allocation &&
 			!sm->handshake->client_ip_addr) {
 		handshake_event(sm->handshake, HANDSHAKE_EVENT_P2P_IP_REQUEST);
-- 
2.45.0

