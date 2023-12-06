Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B013EA88
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaGeufBi"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77d895c298eso418079785a.3
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875240; x=1702480040; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVf/gROVm2ZHExMma5TWOl1N+2Pjgf0quNzQMceKAWQ=;
        b=eaGeufBi011VT8JWWsLR+7vSypTqh6H6I92l+uElz9dJThirLd+sztWIHyyllt+nea
         PmEZpmj9ji8CmEv0ynfVdLb7d1Ksq9EZW3JAAh/7aCuPyohtTQN9OXbEFVDyKEn3LCuj
         vPPFBMk7vv/wQmVHPufy49lC77EAqIpE1q/uAPVJ4XYzzVeWKWVMwXGyBSzVZVEeqMQ8
         exDI+4bP9bIzG4Zy1vP+ngZKS1Kyt3F6TmhenJr6tfQH4/+uOdp6M9bu7w1rOs29SKmu
         F/Oq03lkR9iEM2/bjZnCtjent5ovDUh8/28cKWhytCTci979LtThJhTCPfWEn1JZ7Mny
         fYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875240; x=1702480040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVf/gROVm2ZHExMma5TWOl1N+2Pjgf0quNzQMceKAWQ=;
        b=fBREgCMeA+WFLXYZpuQOBCQyIbqOQZu3u5Jjr1Vne0zTknZgZTjB2+XCwFRmfjJTO1
         FCCL349bdgAmk+NCOkSCiFCvP18fLwOY+XVQHC4RTTcHJb8TyS9GwNMXLH5MFB4M5+zb
         fjF/cOgFWu2ETgwAkz6WRQW2qVVwuIT9mdVjzd5BCBqTWkZLXl3NB8ykMFFtuqiY7ExV
         HUVQ0nUKwoUAEjkWEd3dEutNwBVEp2jsXy+mPQ6KCntEse2pEkDYluYpATfD377DbdXj
         VLANWou94M1S/qUai7GnntXaRNlfiQcX74UOO99LZkQB0CRAKhi0aamPgCaD4N4L0FDa
         X/iQ==
X-Gm-Message-State: AOJu0YwMuFHbiYceMmLfsHlLYqdYulBtjq6DlwRSH6Q/tmO+kOksiRJt
	gLj5OqO0UpurpQhGw7aEtfnjG0AQin0=
X-Google-Smtp-Source: AGHT+IEe7qMk/JgLxUjQVBE4RV6Ho05fDYWnTW/N8M9IaEN/PbpbjHr6KNRxlj8byef3N7YeJG1g8Q==
X-Received: by 2002:a05:620a:2790:b0:77f:319b:a100 with SMTP id g16-20020a05620a279000b0077f319ba100mr851279qkp.59.1701875240050;
        Wed, 06 Dec 2023 07:07:20 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id vy22-20020a05620a491600b0077d66277e9asm11506qkn.116.2023.12.06.07.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:19 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/9] ft: add ft_handshake_setup
Date: Wed,  6 Dec 2023 07:07:04 -0800
Message-Id: <20231206150708.2080336-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206150708.2080336-1-prestwoj@gmail.com>
References: <20231206150708.2080336-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be called from station after FT-authentication has
finished. It sets up the handshake object to perform reassociation.

This is essentially a copy-paste of ft_associate without sending
the actual frame.
---
 src/ft.c | 32 ++++++++++++++++++++++++++++++++
 src/ft.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index 358a4594..738e08c3 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1276,6 +1276,38 @@ int ft_associate(uint32_t ifindex, const uint8_t *addr)
 	return ret;
 }
 
+int ft_handshake_setup(uint32_t ifindex, const uint8_t *target)
+{
+	struct netdev *netdev = netdev_find(ifindex);
+	struct handshake_state *hs = netdev_get_handshake(netdev);
+	struct ft_info *info;
+
+	info = ft_info_find(ifindex, target);
+	if (!info)
+		return -ENOENT;
+
+	/*
+	 * Either failed or no response. This may have been an FT-over-DS
+	 * attempt so clear out the entry so FT-over-Air can try again.
+	 */
+	if (info->status != 0) {
+		int status = info->status;
+
+		l_queue_remove(info_list, info);
+		ft_info_destroy(info);
+
+		return status;
+	}
+
+	if (L_WARN_ON(!ft_prepare_handshake(info, hs)))
+		return -EINVAL;
+
+	/* After this no previous auths will be valid */
+	ft_clear_authentications(ifindex);
+
+	return 0;
+}
+
 static bool remove_ifindex(void *data, void *user_data)
 {
 	struct ft_info *info = data;
diff --git a/src/ft.h b/src/ft.h
index 51bbe3bc..23d0136e 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -39,6 +39,8 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len);
 void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
 				size_t frame_len);
 
+int ft_handshake_setup(uint32_t ifindex, const uint8_t *target);
+
 void ft_clear_authentications(uint32_t ifindex);
 int ft_action(uint32_t ifindex, uint32_t freq, const struct scan_bss *target);
 int ft_associate(uint32_t ifindex, const uint8_t *addr);
-- 
2.34.1

