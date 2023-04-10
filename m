Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9F79D9
	for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 22:01:43 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id c3so6850846pjg.1
        for <iwd@lists.linux.dev>; Mon, 10 Apr 2023 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681164103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNA9Oj0M6msydbKlLkZNs9CH8dYLnbdvvQuG+sEfTsk=;
        b=QuZsius6JDa+LGnT7xkjJDIGQyQvOvKvY1dYhYjRMMHco91czeV8D+Kd9asawED3B9
         2eBV1wxS/gixO1L5V3NSn/2awArfEfytAN5xpJKHKtwg1zs4sU1bnVjCpbTwPC+D54GN
         v5tXIQAo1Jf+R2QIXQiWrxzwpzwQMWBCZbMANf71zWvPR4SI+Ll+35zZM5ebh/aN16fy
         G6SfQPQzUm6q1pYejlCopBhZ7cPZcXvz3U62lpMXDJE8D0b3hp4NpZhU+jrRbOqjTMVM
         fYOo30yUbH45eTSJxDIjHVhMvig0vHuSsuukOlaX9Dk4fYXdXMsC8OK3v7wgA6EzrlZt
         6q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681164103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNA9Oj0M6msydbKlLkZNs9CH8dYLnbdvvQuG+sEfTsk=;
        b=VrLKpaOsrLEllSIAtFUefzf+n7UADSJLyflB7aMmyC+OpszBM+C2FZ/CEzciPUQSGg
         MXPDJbZXn7FAjzxJp7XaoHRsSJ8cFO1a2wb1pYY4wZcI1pSNsbKwtLrvwzn1EVNQJFA0
         DrwhGmkcK4G2B+k2qzSqbiPuUK2fzV6zQQAS1OF9dZOrmBE8eCYu2vOwd01/4nDPJ+cG
         7szaOs+QM2lXmK0MyY46vTDb8X50Haj7tJXO5w8XxY695p9LKEujXH5r0lua+kWC6pUp
         D54jAR52DA8/WJvtGckMtcLYPOm7GTMazTwEbJ5wuGFwJoJ1ySghPMkGDdqVTzrurl3D
         ieBQ==
X-Gm-Message-State: AAQBX9cs2jJbc2cA0Ldgs/MyxjQTrGI2VEaL81ZA8R9ni30WxP6AKR0E
	Hhk7dWxZy+M0koMCc3yvUcFXctxIwhCFhQ==
X-Google-Smtp-Source: AKy350a9Ulc3W+tS+sfeViVT5lzrf10S9zbXk7BsNCRhxJwB0ci5TZ1xE1lVBzOcNdABJIs5B3GWZw==
X-Received: by 2002:a17:902:cece:b0:1a1:e364:3452 with SMTP id d14-20020a170902cece00b001a1e3643452mr17780255plg.29.1681164102852;
        Mon, 10 Apr 2023 15:01:42 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a2806ae2f7sm8263372plr.83.2023.04.10.15.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:01:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/9] crypto: add hmac_sha384 support for PMKID derivation
Date: Mon, 10 Apr 2023 15:01:29 -0700
Message-Id: <20230410220135.373872-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410220135.373872-1-prestwoj@gmail.com>
References: <20230410220135.373872-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SHA384 is required by several AKMs
---
 src/crypto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/crypto.c b/src/crypto.c
index f8aba7d8..6b8a7b1e 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -1132,6 +1132,8 @@ bool crypto_derive_pmkid(const uint8_t *pmk, size_t key_len,
 		return hmac_sha1(pmk, key_len, data, 20, out_pmkid, 16);
 	case L_CHECKSUM_SHA256:
 		return hmac_sha256(pmk, key_len, data, 20, out_pmkid, 16);
+	case L_CHECKSUM_SHA384:
+		return hmac_sha384(pmk, key_len, data, 20, out_pmkid, 16);
 	default:
 		l_error("Checksum type %u is not valid", checksum);
 		return false;
-- 
2.25.1

