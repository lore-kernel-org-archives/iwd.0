Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E865337688
	for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253709; cv=none; b=LMXx1CaswJTmcxG5UqUEW7VdiyfzdBxwJ7sVAAmwGmeif4aEsZH7Ovwt+dQ6ESfd89b2P/JUdvoV2PId7jpjT5775l3i7Z0jpoxXQ1FCrff4hFOV8+jf1lbf/b69Xb55JAP0OYaqta6HFjgDK2v35kfuPkUjIsnLYFUSJsuqkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253709; c=relaxed/simple;
	bh=drcNSHHjboOovl42IKepOS/BJ/Q002E25PM+ZnbGF3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlXRHKxD1pya4eJv7+rtmhMHWFJ7KWJ1YoZQJSED1bhiEvQwHDJWyX/p1m0oPrr1cXLeGwZpyzBrhRe7qbtwm7sO2BgE6x8RJo3Z7luQXlY+EevvX6of7vLD5qSMTfyEz/apD0FE995fn3WDZUV55TdbGG5IcdRa7ff2ibJn1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhCYDe2G; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhCYDe2G"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c94fccf3eso34887551fa.0
        for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253705; x=1785858505; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vjgls6bwTkDDZ1mElL5Q5RfEN/8SGYvYzzpOFtttoQI=;
        b=XhCYDe2GS3fecGwApSheRUBXJYs1EJ6tN4ntQbhct42+pocSmhSJp64Wh/D3gYk21M
         59LLxATg6SxtaphPhPBD8l4bNDtvDPUQvwf5lqx0QucjFyTp6vp5r0goYU6XH0EWLlIA
         n7i7nobfu8lkgDJ0kUZElHsGdCiotRoA5VKyq2tE3XC/ltVL+ZvvrQKGe7Hxo2zzYWOT
         x+Gyvz+2ZEpl8fbRv81X5olQccIvCl4MN+32L8fJqXq8aTkwRyKlzRBVXb+See/V/X1J
         LrE55K9gJHsNNANInnJg47OVIJmBmr10NWNQEQNOZMgCVAqfXPYHQM95cqBo3rtSfbgs
         2wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253705; x=1785858505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vjgls6bwTkDDZ1mElL5Q5RfEN/8SGYvYzzpOFtttoQI=;
        b=sJoZSXSi5pa0PzxNX4lHJ5Kl21CLGGuyW3Th4xtU3m9UBx4z7fsVT+uOd4uhIyxt+S
         z5Dz91Yz7RIlms2NoZ/QmvNKPsXeuH6VASAi+i1uijE0BOfCyarNxSJs0q3QIdefBzpC
         5mHCnJmhuuDmZvrdPx80o9eapGh9P9yJP0w0TFYE90FHL8Y9i2AOh+rAukJmPA35TMf7
         /v9LflY1iOGTbKiHt9cmaV75dTs4OzIvVRdFHl4T0ChBMz7gUOuIepNgRMOplBGx+uPd
         UggklATPeazeqUzuu8CoDSjdvjIC6wPwYF5vCf0XjXh2+qqvh4TYgq3HNtm5Y1ZV/lHp
         eBwA==
X-Gm-Message-State: AOJu0YzL49rPDJMqVnvQatAzLBr9MLUGneF5fis81HvSo8DPiNqb1ckv
	bzwHSAIE7cKbLE+xIGMM8dOOQ9JxTzR9XyYZpiLwk1Y5sLNNzl85frmszGg7IDZwXr6afw==
X-Gm-Gg: AR+sD13UTR2tz5y8gC/ZMLlyLvPcxheZwWRW0ibDWcATIUrQtHhqMQbWB5aNCGsfxyD
	O8mbwGJbiXmmPbpnE9Q25jzNCUKMrZpuxhis8PqAYeXCzihNgN46JiGHarSSZb/7f+YKiplu0WV
	rzU7LcpMC8lGaOtgavBsfZoauStD5BmFs0wPhQGnvaUR9FCv06EO++2c0YmzrLQZcv2V/4quViK
	Gg19kYSYWWhJbZOl+MTnFur3+t2ya1A+hEDcKNR6N9/3Z+hWnxLpKlfxf3oML4b+n3s6p41B0Jo
	1PlE8MfAHHjNEnjeDzEOn7u4E/SQ4tOYSuNgm4DofvmZGrDjx0X8WqGoGjzmwi3dSMc0iX/Pufs
	jCLFdYwiCZNIKRW5VDV3olf/xKqoCMgiTPdgEy5myiEywNL2Bp0Iydpy5CJcsW7b+yI6jefszq9
	TAiBnDYjqGKavaY+WY4w==
X-Received: by 2002:a2e:bc89:0:b0:39c:9aa0:799f with SMTP id 38308e7fff4ca-39f51eb3a29mr6819541fa.33.1785253705363;
        Tue, 28 Jul 2026 08:48:25 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f22187e5csm19807431fa.16.2026.07.28.08.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:48:24 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com,
	denkenz@gmail.com
Subject: [PATCH v4 4/5] client: display BasicServiceSet RSN property
Date: Tue, 28 Jul 2026 18:46:43 +0300
Message-ID: <20260728154729.3485557-5-aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154729.3485557-1-aleksman4o@gmail.com>
References: <cover.1784069194.git.aleksman4o@gmail.com> <f9cb0ba9-da64-48b1-a8a9-3fe5c463b568@gmail.com>
 <20260728154729.3485557-1-aleksman4o@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleks Man <aleksman4o@gmail.com>

Parse the optional RSN dictionary and include the advertised key
management and cipher capabilities in the station get-bsses output.
---
 client/bss.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/client/bss.c b/client/bss.c
index def4de7f..b5c80087 100644
--- a/client/bss.c
+++ b/client/bss.c
@@ -32,6 +32,7 @@
 
 struct bss {
 	char *address;
+	char *rsn;
 };
 
 static const char *get_address(const void *data)
@@ -57,8 +58,82 @@ static void update_address(void *data, struct l_dbus_message_iter *variant)
 	bss->address = l_strdup(value);
 }
 
+static char *string_array_to_string(struct l_dbus_message_iter *variant)
+{
+	struct l_dbus_message_iter array;
+	const char *value;
+	char **strv;
+	char *result;
+
+	if (!l_dbus_message_iter_get_variant(variant, "as", &array))
+		return NULL;
+
+	strv = l_strv_new();
+
+	while (l_dbus_message_iter_next_entry(&array, &value))
+		strv = l_strv_append(strv, value);
+
+	result = l_strjoinv(strv, ' ');
+	l_strv_free(strv);
+
+	return result;
+}
+
+static void update_rsn(void *data, struct l_dbus_message_iter *variant)
+{
+	struct bss *bss = data;
+	struct l_dbus_message_iter dict;
+	struct l_dbus_message_iter value;
+	const char *key;
+	const char *group_value;
+	char *key_mgmt = NULL;
+	char *pairwise = NULL;
+	char *group = NULL;
+
+	l_free(bss->rsn);
+	bss->rsn = NULL;
+
+	if (!variant ||
+			!l_dbus_message_iter_get_variant(variant, "a{sv}", &dict))
+		goto done;
+
+	while (l_dbus_message_iter_next_entry(&dict, &key, &value)) {
+		if (!strcmp(key, "KeyMgmt")) {
+			l_free(key_mgmt);
+			key_mgmt = string_array_to_string(&value);
+		} else if (!strcmp(key, "Pairwise")) {
+			l_free(pairwise);
+			pairwise = string_array_to_string(&value);
+		} else if (!strcmp(key, "Group") &&
+				l_dbus_message_iter_get_variant(&value, "s",
+								&group_value)) {
+			l_free(group);
+			group = l_strdup(group_value);
+		}
+	}
+
+	if (!key_mgmt || !pairwise || !group)
+		goto done;
+
+	bss->rsn = l_strdup_printf("KeyMgmt: %s; Pairwise: %s; Group: %s",
+					key_mgmt, pairwise, group);
+
+done:
+	l_free(key_mgmt);
+	l_free(pairwise);
+	l_free(group);
+}
+
+static const char *get_rsn(const void *data)
+{
+	const struct bss *bss = data;
+
+	return bss->rsn;
+}
+
 static const struct proxy_interface_property bss_properties[] = {
 	{ "Address",       "s", update_address, get_address },
+	{ "RSN",           "a{sv}", update_rsn, get_rsn },
 	{ }
 };
 
@@ -72,6 +147,7 @@ static void bss_destroy(void *data)
 	struct bss *bss = data;
 
 	l_free(bss->address);
+	l_free(bss->rsn);
 	l_free(bss);
 }
 
-- 
2.55.0

