Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A04E1420DC
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062531; cv=none; b=GWD8kDE8pNHA4Tr2TBsjy1XL0+mNIcWVHMPelz7DrZZeLBhf7MPT3vu9/UhNH90cVH4K+N+HGHYMSFUMcwXkFWydMScCx8EmYFkiXfg/vm5VfiZJ28MIE7sPa371PwGxkkNWat34SkE75pO77iJsvJZIm4NA+dR8VzuWbyE+75Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062531; c=relaxed/simple;
	bh=V6qQafy+OjoMhSvxG67+T1gKSOGXGvwQT8zg5Ly/p1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z03k1rZRC3hijnU3vemkM4aiHNtybnsjLILeTOsyMvTvllSs1pEWgibAT/fdnyxXd2zPQT15sLIIet/Q88GsnSlNTZkT/sRfgSS8RmxTBrwFWtGumkG9UknD2cjV4MCdrezJz58FR4iCP7t1NXbCDV8JJmD4Lh1Sc032CDenwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9aXejZm; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9aXejZm"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4affeacaff9so1038953e0c.3
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 11:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709062526; x=1709667326; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLWjcwCaTI1vG0jrfo9VjlUnIPc63dUFSWEHuabP718=;
        b=O9aXejZmJedkXpBGUlEz2XboaHNW76WYhnlvk4fFuZlLM5ai7ARLcEfSsTFVTZjkE+
         kv3lEv+mwAucC5vce/plWA+FJ78Tg5Eyl6JxGuAPbXCDT/8F/ysAWPDcKKZIruJ5t6bA
         AHqVanw8NbGmaBCb6YVNj+bm676CeRXZT73A3F07j0xCsRKgDLfLW7qGNyX9RLJwythe
         RXgTGMrh6RjbtzAc4DutPqrFpvyLVc5Mb7J3oktbEW4x7WtSvIx3ZZB3c0NjkPcOCyzD
         np1FE1qM+1PcVEIafiu94fI0s7sWsinJ+vdaYRGi+/ofjiB5RQ9F+vllkhhukuu705cM
         9fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062526; x=1709667326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLWjcwCaTI1vG0jrfo9VjlUnIPc63dUFSWEHuabP718=;
        b=vcub0tJoGRhFSgorwASjoZFT3Vv+oRbzhgxeIe6kJgHyIZMCazgVz6c8/GP3EbUXGm
         fkNEMDz6WxXkB6KdYpx8Do2zYa3g2hY2vguXZxsx71+KK84RYI9uJwrorqx8FBw2O4BK
         vIMPsInuqWLVTEa0/ra5R+Eg0I4KNMw8UJnmRytPYfHlsht8dsElVyDH1kvAnrEpAXts
         32MTuyfg47WGBt/h37EMf0/eYgVC6UcKgJffz208+YXlfsESFWra09pn/Dx7fUWvzSOb
         x2RLKCo25w8RXnfk9M0fyi0Ph/zKOd5n+ws3H3kkM7RWljIMU5aEVssXBn0pjxFXwdGq
         +Agw==
X-Gm-Message-State: AOJu0YyMlmMI7CRatSkHAvOlTgR7lvfg2gQOJhjsiIEZEe3yWd/AQqti
	Ql+l6j7qaaq5/+abRi7R7lwJkFjOytxtniRp1aqqAAy1oR56wBfbBqrARzvz
X-Google-Smtp-Source: AGHT+IH6+018xqtbnSvmLbrzZPYAtJyKubTSFtDU64Nzi500FUv+Qnp3qPq8AEmxq27+vX2RXdG70Q==
X-Received: by 2002:a1f:db84:0:b0:4cc:5529:5806 with SMTP id s126-20020a1fdb84000000b004cc55295806mr7581550vkg.11.1709062526152;
        Tue, 27 Feb 2024 11:35:26 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3866239qtb.4.2024.02.27.11.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:35:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] crypto: fix uninitialized variable coverity warning
Date: Tue, 27 Feb 2024 11:35:21 -0800
Message-Id: <20240227193521.304643-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227193521.304643-1-prestwoj@gmail.com>
References: <20240227193521.304643-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some encrypt operations DPP passes no AD iovecs (both are
NULL/0). But since the iovec itself is on the stack 'ad' is a
valid pointer from within aes_siv_encrypt. This causes memcpy
to be called which coverity complains about. Since the copy
length is zero it was effectively a no-op, but check num_ad to
prevent the call.
---
 src/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/crypto.c b/src/crypto.c
index 3128b2a5..7235e3c2 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -331,7 +331,7 @@ bool aes_siv_encrypt(const void *key, size_t key_len, const void *in,
 	struct iovec iov[num_ad + 1];
 	uint8_t v[16];
 
-	if (ad)
+	if (ad && num_ad)
 		memcpy(iov, ad, sizeof(struct iovec) * num_ad);
 
 	iov[num_ad].iov_base = (void *)in;
-- 
2.34.1

