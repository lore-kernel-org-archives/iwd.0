Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6546AD
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 21:04:51 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id gj1so12904672pjb.0
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5xdUDQux1ToIRpEEPJyVULPdiiwTo+90TFcCy4/Zrzo=;
        b=UJGOz+5QR1xzwucT4iNV0DKoJbP1EAboFlvWfjV8i7TRg/z2dOXUcTubb2F1Irdw7b
         4qNE0/HY+OCwOVp5stl808q+q09+ByMm55mD8Msxl/UeQbna4SXvr/7FDh2XYtKi08ce
         heNrqcNY3e9Zsf5FPN3iKG9yW00RE/ytdh4d1zdcEAobrnVOFSJeqBCI7qy1s9TzKOF6
         vWadn0d6BfmXKcPElmi5MxDCoPEaeNeSHRQNkZt8yv1e45iMK89F/6me92sAE+1TAW/0
         q9f621209LgpFCeJyIDVIv5Iviu24GBo/qdM2xo700N4Tyoy19FnCB3WVH+/u2tAcdmY
         VWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5xdUDQux1ToIRpEEPJyVULPdiiwTo+90TFcCy4/Zrzo=;
        b=6yAZYklB7LLmTQmPUy47aoWU8RvepPMTJkDPgoScerePiJj3XcuNg+MJU4G/1Xv21N
         92cN1yC+cq8eN7hFdb0JqN16fMQDLYSUNzxoB1Q54/qFKOTpL5tscYoNmdlkkqlzp15i
         K8oq3tkdJSLxmVqhrzlUs0z8gB+1rxkpO1znch3paQuEMvU1d4PCYuXPVpSj6NzSXono
         Zoqh3/Ly1+dIHKv6dhhuhcH07m4i/tv8L9RC+RSbTvlzkadvvmpb6fYmZ1Utex2LgNty
         shCyWYKPtUg0CpRatAcrEomlkcoIa+Yb9tliIk0oabmUwpBdxHHLlCeHcwPU+GMSqYEu
         lobA==
X-Gm-Message-State: ACgBeo3A/T8//4mrkVFqmWl544Evks8OpWgGQl+HGgiHXqb6ictd+iko
	1i+hVSqEMFJDwkBbXaQZaj3RSnNs/iI=
X-Google-Smtp-Source: AA6agR4YsuT55lyC73IpP19H6X97X6ZKCXXNNZyy5zq9hbjHi+tGvG7+Xc32eirTa7rYIL3tFJGeIA==
X-Received: by 2002:a17:90b:149:b0:1f7:59cd:9847 with SMTP id em9-20020a17090b014900b001f759cd9847mr373447pjb.78.1660079091279;
        Tue, 09 Aug 2022 14:04:51 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902904800b0016d23e941f2sm11161706plz.258.2022.08.09.14.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:04:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] monitor: add better array type support
Date: Tue,  9 Aug 2022 14:04:47 -0700
Message-Id: <20220809210449.158256-2-prestwoj@gmail.com>
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

The ATTR_ARRAY type was quite limited, only supporting u16/u32 and
addresses. This changes the union to a struct so nested/function
can be defined along with array_type.
---
 monitor/nlmon.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 54aaa465..8b70b055 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -139,7 +139,8 @@ struct attr_entry {
 	uint16_t attr;
 	const char *str;
 	enum attr_type type;
-	union {
+
+	struct {
 		const struct attr_entry *nested;
 		enum attr_type array_type;
 		attr_func_t function;
@@ -6691,6 +6692,7 @@ static void print_value(int indent, const char *label, enum attr_type type,
 }
 
 static void print_array(int indent, enum attr_type type,
+						const struct attr_entry *entry,
 						const void *buf, uint32_t len)
 {
 	const struct nlattr *nla;
@@ -6700,8 +6702,22 @@ static void print_array(int indent, enum attr_type type,
 		char str[8];
 
 		snprintf(str, sizeof(str), "%u", nla_type);
-		print_value(indent, str, type,
+
+		switch (type) {
+		case ATTR_NESTED:
+			if (entry->nested)
+				print_attributes(indent + 1, entry->nested,
+					NLA_DATA(nla), NLA_PAYLOAD(nla));
+			else
+				printf("missing nested table\n");
+			break;
+		default:
+			print_value(indent, str, type,
 				NLA_DATA(nla), NLA_PAYLOAD(nla));
+			break;
+		}
+
+
 	}
 }
 
@@ -6832,7 +6848,7 @@ static void print_attributes(int indent, const struct attr_entry *table,
 						NLA_PAYLOAD(nla));
 			if (array_type == ATTR_UNSPEC)
 				printf("missing type\n");
-			print_array(indent + 1, array_type,
+			print_array(indent + 1, array_type, &table[i],
 					NLA_DATA(nla), NLA_PAYLOAD(nla));
 			break;
 		case ATTR_FLAG_OR_U16:
-- 
2.34.3

