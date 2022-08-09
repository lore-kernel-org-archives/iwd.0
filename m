Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6146AF
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 21:04:52 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id d7so12436518pgc.13
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=kt1auLOcChLYta0iCDcf2PqGmYR6wkIamB/sFjXtv6s=;
        b=lgCABbYxcBPl4HDFBXzgR8Pf5foBuFAuFOYD3RNKyvtfifT2vBVi27YNvOU5BWlPk5
         z/ZzB3ZGGTc3rKVnadVhBTh/blCnKzR8dcdKvccE9rRxallxHJA5xpg1P1YjDWo2rzjw
         xzUB7qCz3vX9F5FWW/yQkIB6EXUJQvLwXJfQavi6lXlOKO1ctjwCexaoIcY8iwYwlPtL
         Z+gURTImMNfxOdgib3rviuOrFSrL7NeKtTIKSYCDydKuuOZzCsMGU8dV1m/VrWyHDPor
         eMfRfQHYwheugUtIxlJoYqWdpzN+iaqBsasruOMha8gxBO0sfE+pso9ypXWS8f/iPhdE
         WJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kt1auLOcChLYta0iCDcf2PqGmYR6wkIamB/sFjXtv6s=;
        b=whCSruX2LEBeR8UB19ryyOf4l8oWRYUXAqKkxjWZhuNZVC0aAdjSzIdCJeYHK2yNEj
         qlwinDxu/I4FXu8t0UJnzOANJaeUaM0GNmW2oy3GXtS9d1YjViVz6h5MyAoKWowdmwox
         GyzSucMX0wlvVTbCE7w8SRbH+Umx/snRZAbBVVUduHGdvD2CEaK8wa96hHHxxHfDZE/d
         UlbAC5oZaNg2fOh/Sw0ZHtfTXmnZRzhO773hF0Syb7k6r0A0fn08vLgx0MQ0Pf8rx0r7
         iLpbeIhHzyWYmeosVW8O1qKmK8n7zHL3Muo3wnN/DlkxSg6Yky2kpZP0KYZZ4fmW/NQN
         AB+Q==
X-Gm-Message-State: ACgBeo1L6pf4mZEaKsX3VhyPREOiYMNticjyDz2kxsCpWHPFeDpZ1fRp
	TaUECPAYJ2yKQwRuC1dLxVyIsMULfjE=
X-Google-Smtp-Source: AA6agR7Lz7+ErnK+D8ZJSpgnj0HUAkxbtrqqQFuTenCJfxGS7A/b1HN3xoOpTFQzEpktDeXQ1uaNhQ==
X-Received: by 2002:aa7:8d94:0:b0:52b:a70e:ae89 with SMTP id i20-20020aa78d94000000b0052ba70eae89mr24586588pfr.23.1660079091941;
        Tue, 09 Aug 2022 14:04:51 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902904800b0016d23e941f2sm11161706plz.258.2022.08.09.14.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:04:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] monitor: print out type of unknown element
Date: Tue,  9 Aug 2022 14:04:48 -0700
Message-Id: <20220809210449.158256-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220809210449.158256-1-prestwoj@gmail.com>
References: <20220809210449.158256-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This changes the string from "Reserved" to "Unknown" which feels
more fitting, and also prints out the NL type of the unknown
element.
---
 monitor/nlmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 8b70b055..e880ca1e 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -6743,7 +6743,7 @@ static void print_attributes(int indent, const struct attr_entry *table,
 		int64_t val_s64;
 		uint8_t *ptr;
 
-		str = "Reserved";
+		str = "Unknown";
 		type = ATTR_UNSPEC;
 		array_type = ATTR_UNSPEC;
 		nested = NULL;
@@ -6763,7 +6763,7 @@ static void print_attributes(int indent, const struct attr_entry *table,
 
 		switch (type) {
 		case ATTR_UNSPEC:
-			print_attr(indent, "%s: len %u", str,
+			print_attr(indent, "%s: %u len %u", str, nla_type,
 						NLA_PAYLOAD(nla));
 			print_hexdump(indent + 1,
 					NLA_DATA(nla), NLA_PAYLOAD(nla));
-- 
2.34.3

