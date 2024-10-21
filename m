Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E71F4FCF
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514558; cv=none; b=VwBnC8ZAEB1NPtyHvaOb5xGuhSm+lwFSY/iAf1pni5II2Eo7yuAb33IPw3Bb8szsLmFsahumMaB3hoeruhEynEu1NuURbzZ9vux8RjocXu/bbid/6HBp9GFqcjOe3ViMmM4rCz7mRWQ4P/Wr77778b48j2gMbrLNOIKx5oW9EV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514558; c=relaxed/simple;
	bh=4DOtYiMfCbG1A38aiVlei5pT0CL+e8Gcpgz+b7PcmRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RC7fa09nLu74oimfZWFN05RY8SHDFZRf/TgVLuY5ao8X4s5yPFDNspFB6ca6C4zbURO5miDFBg+zZaIAiipWfiZ4+90BuA5kJH5PgWiBLpoxMgF9L6IQR7dpviokLvIF0UZtTe50rzYvU5dEwfuoxSsi6noU0Ib/Mv49q6I/Ako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSSD+8+r; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSSD+8+r"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7181285c7c4so1871089a34.0
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729514555; x=1730119355; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHLsa4gcU83rgazUAcF5LIdA4oeDmboQeAARMvulF9E=;
        b=JSSD+8+rKokueiZlP0MEkwKtGbz893CKu5rd/hAC0qgBHQAzQFIecQOr2aFiToOH3Z
         cFfougkMJjk46tQxWMPXQUfo2j0tlHLO2XCpCRZRFOdRJh+o3XaSco9Oa+ktnaA4YB5u
         4waIy17yZZknXcJEE1me7EtpUnjg8KBLwWAepj7+RAZ5zKph9IEGkie8C0coPnERW7C9
         OwB9j5fyJhwYcAQSSUfRpBxVDC8xUz8YUZTOhw9X94M0etANOzXqrU0K2etzkEkkDBI+
         Y3RgyFLtbYwcya5cc0Ry552/ZICeD+bbz+kyqp6+S3x2WMSiH2I5kkB0hhmuYTHydZSH
         IlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514555; x=1730119355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHLsa4gcU83rgazUAcF5LIdA4oeDmboQeAARMvulF9E=;
        b=IhVASbVZtbqiRYaW5VeTQJmdG/ygjGQ9FStsy4I5tY4rSkHmCoG9fUWGZNeeuBLTeP
         9nLI+mEyg1mNNO8xhEfj8BwHUdxkn/ZCpfU/undBxFV9OCwWd7e1sN3BkuEk/zupZTAf
         3e13XMTcl59frlZr+dBxg8SLgCfvliT/jrfZyLhbeB+tr5b0Rho35h6StDIsj5nVVNFn
         LOTBcy2KK/9bceFcEBd3Hs8zhRyaKaiI+XdnKgFHsBz7VeFgK7qxGDvbKQTxlpXhJF6H
         z6VlZQEkTIZETNRGm+eNW72GFhBgQ7zP+q17V4SL2jUOROmcU82BEYQ3NU98eGGkfJxN
         +wqQ==
X-Gm-Message-State: AOJu0YxKg1kNsJRCcA4y9KgdwjbCpvg5mrCVdwHl+QkVAup0Oz727iaJ
	xqec/5PhLPqj7/2NnpKwoCNpYqHeyghpYP1lVMkeNwEo3WTzRbhsXIS41w==
X-Google-Smtp-Source: AGHT+IGpMyDSXWrtV4vqBlLPNn7un73F5tbAdpGeKGBMDCvKekCa4MdOQPfTNi1mg0qSOC9nwls/hQ==
X-Received: by 2002:a05:6830:6504:b0:709:396c:f295 with SMTP id 46e09a7af769-7181a8d8097mr7553769a34.32.1729514555462;
        Mon, 21 Oct 2024 05:42:35 -0700 (PDT)
Received: from LOCLAP699.localdomain ([72.46.116.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00999ab0sm17006586d6.93.2024.10.21.05.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:42:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] frame-xchg: add DPP frame group
Date: Mon, 21 Oct 2024 05:42:27 -0700
Message-Id: <20241021124228.145516-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021124228.145516-1-prestwoj@gmail.com>
References: <20241021124228.145516-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/frame-xchg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index 3f1e0e55..7ca6e9b7 100644
--- a/src/frame-xchg.h
+++ b/src/frame-xchg.h
@@ -41,6 +41,7 @@ enum frame_xchg_group {
 	FRAME_GROUP_DEFAULT = 0,
 	FRAME_GROUP_P2P_LISTEN,
 	FRAME_GROUP_P2P_CONNECT,
+	FRAME_GROUP_DPP,
 };
 
 bool frame_watch_add(uint64_t wdev_id, uint32_t group, uint16_t frame_type,
-- 
2.34.1

