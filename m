Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C70328BC
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ9fu91K"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4ac023c8f82so2437648e0c.1
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 09:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699464120; x=1700068920; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baBHlgeWoEeHHkzdXBsF7vv7Ib3zJzqzJRDqOKc/rbE=;
        b=gJ9fu91KfZNSQdZ2cCQRSGBjxiRZWewihWSGYG4JiNSEDYTDExc1f8zs+JguzZ0ILo
         VUtxr7hJGWAUOEy+5EdIPz8Jr5/KFqLf7I+4rkSzBb9ZDWWtGG7f//8LL6N+z8Hq2pQx
         Ttql8M3JxYaulcqt6ckfZqzPbTbHD1tGP46U+ZAJT/2/34p46sm4/t9W1spZKj7RlMo6
         DyE1AnoaJysn8LIzFRmseQjO+b4zOoM2ZGz+CykqbwkCdPcYkE5Fuoo8fQItWH7WMb0Q
         An5L9K89DugrH6VgNPxpWjrsnAB78XvkPtXQNnQA3HXe5IPHyyg0D+Al00AzJoKT1Bep
         tG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464120; x=1700068920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baBHlgeWoEeHHkzdXBsF7vv7Ib3zJzqzJRDqOKc/rbE=;
        b=pif1qCSEHj8vuCkn9rwnyWNuzwYRCkpb0BfgQoRkhxVAtW8T5xuMLMLePvFenZwUr5
         7VrBX47qTLMHo8nk6sltYcDg7er4OAx/Kr2bTJQ8bHz0qkyRCsl9Yijxi20A7D8jvkaf
         uq/9RVTkRpITZVAhOSBEZYKLBJCFk7X/WrVqBuV94srGuw0SwbjMEAqUaQRBc6uFk3gy
         G3AISy5L5i5CDazN5/wra+alteB+7+lmUYs8BNT4DHDikPPrTkq/4lXioU1AcuDbLaFN
         YgFR/ILJLiS7RL4cBujH1t4be4rnNN6pw+JY35VTpWQBIVyFnDBVOf82ddYYvlIg6Py5
         iROw==
X-Gm-Message-State: AOJu0YxSl9rpecwH2caOKhJ3Rg1mzf71jjOUMZAKx3IfxxH/teZhjOIG
	vC3RJMoz+IT4WJ7/GKz3GLnhpy7YtHo=
X-Google-Smtp-Source: AGHT+IFrBzsfviAvwhhiN1j/kitZz+o3hG8UimLN93/4QNg7a80HhDgGgmj/c+X5irAbSeH3fRGs9w==
X-Received: by 2002:a1f:a812:0:b0:490:e790:a15b with SMTP id r18-20020a1fa812000000b00490e790a15bmr2514837vke.10.1699464119896;
        Wed, 08 Nov 2023 09:21:59 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id qb1-20020ad44701000000b0065d03eae7a0sm1277003qvb.82.2023.11.08.09.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:21:59 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 01/10] dpp-util: fix typo, 'REQUST'
Date: Wed,  8 Nov 2023 09:21:46 -0800
Message-Id: <20231108172155.2129509-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108172155.2129509-1-prestwoj@gmail.com>
References: <20231108172155.2129509-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/dpp-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dpp-util.h b/src/dpp-util.h
index 5f9a2ff4..053caf8c 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -40,7 +40,7 @@ enum dpp_frame_type {
 	/* 3 - 4 reserved */
 	DPP_FRAME_PEER_DISCOVERY_REQUEST	= 5,
 	DPP_FRAME_PEER_DISCOVERY_RESPONSE	= 6,
-	DPP_FRAME_PKEX_VERSION1_XCHG_REQUST	= 7,
+	DPP_FRAME_PKEX_VERSION1_XCHG_REQUEST	= 7,
 	DPP_FRAME_PKEX_XCHG_RESPONSE		= 8,
 	DPP_FRAME_PKEX_COMMIT_REVEAL_REQUEST	= 9,
 	DPP_FRAME_PKEX_COMMIT_REVEAL_RESPONSE	= 10,
-- 
2.25.1

