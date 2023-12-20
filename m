Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3FD25541
	for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia6xTvCT"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ba0dfc9001so2084461b6e.2
        for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 05:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703077933; x=1703682733; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGa/niltCdochZCsnG/npuCftI6ucY1Yl9oYnXxqKh0=;
        b=ia6xTvCTzIJH9kzLVtXRX8H3GJzwamHH7fMQ04+iHPmyFbBLTKDuHc88++nuD9h024
         kOWOqeKlnPFgnQ7p9UO31d+d4fSfwuzWQYgoDQuqcmMmwiP+MKn3u3x2VMBv8Oi8vnxh
         1A7mgoLvvIbZbRWkLPqF6fPLLrqZHT7QFhqPduLsljDDd8pejgtRSZnA3hPbKa9O6nnF
         yzuAmxcqH+79gLOSSO6puKI7FDV10FrKOFMASR2Yg5/h5rDr700qE7xONJvDvf+cb/Rx
         Y+AYh+ZOtod1FYf5oHeeZyr/UeEjaHSProG3tTmjyCJDsYBmJw2MUp3Y56DsXvDpzKTr
         bQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077933; x=1703682733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGa/niltCdochZCsnG/npuCftI6ucY1Yl9oYnXxqKh0=;
        b=BnTviRSMuCVm15IMaopIUQ85ymiGjN22w+ulFhbaGaIhuPlmaIsTK7klk7Qf3rcsK2
         bh6CH2aE/26nrONQgLwYUNZkxz5sl0LmZzpmDWs/2+SONw3xzyzmLbdcseS4kAzl5/19
         BVCmtcP1V0L8vlbXXzyG4l4ySdszUR/O+FCVv4pJZcUJhJu63XBEprn1EjeLRVRMY7yI
         D3S7yFVOXWY7hHnGrNEpmbF7UI2zNnqcTtG8lWdN8/nTLH0dOldqRcA0JQjZr3uOACnj
         XpejJHeNQzx7IN0pFgClCb+puPDbZJN5q/CVEyBkrcVCAO4lBTzg1We1r0UPecIN2iEY
         VvDA==
X-Gm-Message-State: AOJu0Yw9s+IxtQ7v0HvoXxY4gdCg0anv9WOT2DJhBaynpXXQOzhqrXY3
	xaNtmSheRO3dmx9g6PHPvU3eo7L81V4=
X-Google-Smtp-Source: AGHT+IF4MNdBQqbxV31b8xGHzhKadKOiAFCmoiA9BWq6CzL20PmxDRtJBhWZSHvTgSyXvpqXIeLFww==
X-Received: by 2002:a05:6808:10c3:b0:3b8:b063:8949 with SMTP id s3-20020a05680810c300b003b8b0638949mr13777562ois.87.1703077933060;
        Wed, 20 Dec 2023 05:12:13 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id j15-20020aca170f000000b003ba3a9c553esm2109591oii.30.2023.12.20.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:12:12 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/7] network: add network_roamed
Date: Wed, 20 Dec 2023 05:11:57 -0800
Message-Id: <20231220131200.267489-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220131200.267489-1-prestwoj@gmail.com>
References: <20231220131200.267489-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows known frequencies to include the roam BSS frequency and
sync.
---
 src/network.c | 9 +++++++++
 src/network.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/src/network.c b/src/network.c
index f4496c25..04d1bf82 100644
--- a/src/network.c
+++ b/src/network.c
@@ -204,6 +204,15 @@ void network_connected(struct network *network, struct scan_bss *bss)
 	network->provisioning_hidden = false;
 }
 
+void network_roamed(struct network *network, struct scan_bss *bss)
+{
+	if (network->info) {
+		known_network_add_connected_frequency(network->info,
+							bss->frequency);
+		known_network_frequency_sync(network->info);
+	}
+}
+
 void network_disconnected(struct network *network)
 {
 	network_settings_close(network);
diff --git a/src/network.h b/src/network.h
index e7638899..323f64a5 100644
--- a/src/network.h
+++ b/src/network.h
@@ -32,6 +32,7 @@ struct handshake_state;
 struct erp_cache_entry;
 
 void network_connected(struct network *network, struct scan_bss *bss);
+void network_roamed(struct network *network, struct scan_bss *bss);
 void network_disconnected(struct network *network);
 bool network_rankmod(const struct network *network, double *rankmod);
 
-- 
2.34.1

