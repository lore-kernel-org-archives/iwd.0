Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBF4468E
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 18:48:10 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so13042327pjf.5
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IPu+zk/t4fWWnok/PJoKTmzBeUVbEvPoKTaQGz6oXnw=;
        b=Z8+24CtGxzdv0mXgwHHOPqD1t93tjtDTYohnuWTY1AO+OQHnGzNLtQtVGGgXBF6q51
         vUghkepeCY/yPStXGC8UccB9/Ru9xLQf8EIlKB+YaoKhA9wSHEJyk2gLq7bt+meXDV4p
         427sdeFq4RZA9d2t8q4tsIPbAhvUn2gl06vzmR4/Y6UWI3kYgTuqztpMfuo/IuBrEhaM
         T0T/Je61euz0AcmQWgU+YWlAM9SaKzUgoxW4r0rpS8fRv3/yEDZSEjnerZTPXau++rKa
         xMdYu4g6Ry8qENjduQSg7F+6ta1G1P0rt3rrUVhcQm8Se2OT1389fo4cv3WZkTQV5s3Q
         NzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IPu+zk/t4fWWnok/PJoKTmzBeUVbEvPoKTaQGz6oXnw=;
        b=boGoo9hKLlFQJcGSkrj9RhCJc1F3KMzRSL+gInXqT5UW8dQvwquy2DVHHizTDXyaPm
         +jNsGxxd0HqKn/LRdPnxDwdmLK0dyDC3hZdZbYTzfkLJYy+ljW1G9SKZ92rkkYFXoMjI
         G7y/8gQ6yO2T51PyJEm+UWconvY3dDuwzoIQ85b1pyaFDP26xYtNybB+B2hk8lR3C20T
         iiM6it6mdfuIYf5TaEiovADDXmRscsCGiyAUhZpIzKt4K+KdG3DOdVbOHG08hAe/XdXA
         KK6sFr8XPkr0FkHOZQMZK2qJ4w2zhwH4JZylT7w7vSI9a8oTuj9AWNdDeJOPsKa/p/EA
         FUJw==
X-Gm-Message-State: ACgBeo2IwoaM7WDlRtAoY5FK7sp4qwq7A64ONq43+xSRuzt7yr4+JBU7
	G1qy09PrFv2BSMojSNYykc9G3ooEEyI=
X-Google-Smtp-Source: AA6agR7Q09xqThHmC3ak2epXVjYfmkSoLjNWrFyUkZeBjqLNP9uXiOkXHZnUDSRsj+EcYL7QpJ3Sjg==
X-Received: by 2002:a17:902:bc49:b0:16d:ac99:f96f with SMTP id t9-20020a170902bc4900b0016dac99f96fmr24473025plz.130.1660070889901;
        Tue, 09 Aug 2022 11:48:09 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b0016a0bf0ce32sm11403157plg.70.2022.08.09.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:48:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] monitor: add more array type support
Date: Tue,  9 Aug 2022 11:48:05 -0700
Message-Id: <20220809184807.147780-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220809184807.147780-1-prestwoj@gmail.com>
References: <20220809184807.147780-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ATTR_ARRAY type was quite limited, only supporting u16/u32 and
addresses. This moves 'array_type' out of the union in attr_entry
which allows nested/function to be supplied along with array_type.

This poses an issue with defining const entries unless array_type
is moved *after* the union. Otherwise nearly every single definition
would require setting array_type to zero in the const definition.

Instead array_type will come after the union, and the few definitions
which use ATTR_ARRAY have been updated to fix the compile errors.
---
 monitor/nlmon.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 54aaa465..cb1097fa 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -139,11 +139,13 @@ struct attr_entry {
 	uint16_t attr;
 	const char *str;
 	enum attr_type type;
+
 	union {
 		const struct attr_entry *nested;
-		enum attr_type array_type;
 		attr_func_t function;
 	};
+
+	enum attr_type array_type;
 };
 
 static void print_attributes(int indent, const struct attr_entry *table,
@@ -6230,11 +6232,9 @@ static const struct attr_entry attr_table[] = {
 	{ NL80211_ATTR_MAX_NUM_SCAN_SSIDS,
 			"Max Number Scan SSIDs", ATTR_U8 },
 	{ NL80211_ATTR_SCAN_FREQUENCIES,
-			"Scan Frequencies", ATTR_ARRAY,
-						{ .array_type = ATTR_U32 } },
+			"Scan Frequencies", ATTR_ARRAY, {}, ATTR_U32 },
 	{ NL80211_ATTR_SCAN_SSIDS,
-			"Scan SSIDs", ATTR_ARRAY,
-					{ .array_type = ATTR_BINARY } },
+			"Scan SSIDs", ATTR_ARRAY, {}, ATTR_BINARY },
 	{ NL80211_ATTR_GENERATION,
 			"Generation", ATTR_U32 },
 	{ NL80211_ATTR_BSS,
@@ -6488,8 +6488,7 @@ static const struct attr_entry attr_table[] = {
 	{ NL80211_ATTR_ACL_POLICY,
 			"ACL Policy", ATTR_U32 },
 	{ NL80211_ATTR_MAC_ADDRS,
-			"MAC Addresses", ATTR_ARRAY,
-					{ .array_type = ATTR_ADDRESS } },
+			"MAC Addresses", ATTR_ARRAY, {}, ATTR_ADDRESS },
 	{ NL80211_ATTR_MAC_ACL_MAX,
 			"MAC ACL Max" },
 	{ NL80211_ATTR_RADAR_EVENT,
@@ -6691,6 +6690,7 @@ static void print_value(int indent, const char *label, enum attr_type type,
 }
 
 static void print_array(int indent, enum attr_type type,
+						const struct attr_entry *entry,
 						const void *buf, uint32_t len)
 {
 	const struct nlattr *nla;
@@ -6700,8 +6700,22 @@ static void print_array(int indent, enum attr_type type,
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
 
@@ -6832,7 +6846,7 @@ static void print_attributes(int indent, const struct attr_entry *table,
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

