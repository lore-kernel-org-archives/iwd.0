Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42967E1
	for <iwd@lists.linux.dev>; Sat, 12 Nov 2022 01:19:43 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id j15so8440963wrq.3
        for <iwd@lists.linux.dev>; Fri, 11 Nov 2022 17:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLTtOKdZG26UccwureudqveN8iVP6Rg0ABZRI/A4IUI=;
        b=AtCp6yo9MMlR3HBgwxBeIy91X63HLi9UwGTC2ide38kj5jidM1ZbS0vDpWUgA4GLNT
         1FeveV16r0Ol0USptzaTGEDLzJ9hGhPuOPrY89YwE9TRV1wC+M6VtnjMDCyBA/DDnm8U
         N+VRkx5dNEpI729utmTsInv02f+iqpRwg2M+LDKPptFeARLkqo3auTuR/9iK14j9jJsh
         AyEHwArIK81m8GORPjmMoz0jqA4anIMvjGWhOrI/846qS6qu1Nrfx5/+6Lsf0YauRrX3
         QZ38LeCoH/rD6lxx1LZVEhtt18nXM+x4E8yhsQroWXpq01nBdgf2wtrkjTqX9NpCJfc8
         RiGw==
X-Gm-Message-State: ANoB5plWXT4So7EpizLYzXQh2sVVNpkPR7SqwDb8rt8h9MdNmu3/ESaT
	/KeUoAj9lDSGjOoEG5t1T9Ukt+G98uQ=
X-Google-Smtp-Source: AA0mqf5IOYVYleDPsILfquG8U3n7o4l8lj97+zthhrkR+uUt2jo1nY5kSTI1OSkrBLe8SSuTjdUqig==
X-Received: by 2002:a5d:6883:0:b0:236:7135:24da with SMTP id h3-20020a5d6883000000b00236713524damr2534870wru.264.1668215981409;
        Fri, 11 Nov 2022 17:19:41 -0800 (PST)
Received: from localhost.localdomain ([82.213.230.158])
        by smtp.gmail.com with ESMTPSA id bi14-20020a05600c3d8e00b003b95ed78275sm4437734wmb.20.2022.11.11.17.19.39
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 17:19:40 -0800 (PST)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 2/3] iwd-decrypt-profile: Update storage_init calls
Date: Sat, 12 Nov 2022 02:19:28 +0100
Message-Id: <20221112011929.785388-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221112011929.785388-1-andrew.zaborowski@intel.com>
References: <20221112011929.785388-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 tools/iwd-decrypt-profile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iwd-decrypt-profile.c b/tools/iwd-decrypt-profile.c
index e71b56b4..06a9f97b 100644
--- a/tools/iwd-decrypt-profile.c
+++ b/tools/iwd-decrypt-profile.c
@@ -90,7 +90,7 @@ static bool secret_from_file(const char *file)
 	if (data == MAP_FAILED)
 		return false;
 
-	r = storage_init(data, st.st_size);
+	r = storage_key_init(data, st.st_size);
 
 	munmap(data, st.st_size);
 
@@ -168,7 +168,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (pass) {
-		if (!storage_init((const uint8_t *)pass, strlen(pass)))
+		if (!storage_key_init((const uint8_t *)pass, strlen(pass)))
 			goto failed;
 	} else if (!secret_from_file(file))
 		goto failed;
-- 
2.34.1

