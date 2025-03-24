Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEF25FA05
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825762; cv=none; b=HsdAnPryVvqsTgp5g5zr7P5gddXoT1UaW6g/92w0Cl2jTBjhC2tgRqmUxFerxluEgmKUpVb/+jVIUzAw77jmHGu+2amKUUDHkTTQAgW3tBAMs7S5zWwZrc2dFtN8S17QxibJUV18X3yrvyiy06Nm9h1pMhx72NesWBxYXEbL1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825762; c=relaxed/simple;
	bh=eRr0JBpLmGE6bEeGFmCycLYH8r6/0QvKzbywXL9YS64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCDJt5jZCPTyQFE5JkXZ9hQvTkcGXtadUpm8wlrqExoUM1paJSllekLLLmlTEJg1bRMRjXHiO5yADVkf9MtqEcgZTz7TENoQ0er+patLPehNXcJvxwSKwBIxWzLGKsVnt0cAp0wjYXMCgOe0Lp6HaQFsHIMIKmG6frLg/gEMBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRValOZn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRValOZn"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fb0f619dso87450495ad.1
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825760; x=1743430560; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJrxc1DdTsJ+3uGDO3B4C5w5iLEzjBxEs5BJpFpk+II=;
        b=bRValOZntmogYqxBUbuaUbEjSRYYUbHBUAgcw1J0dbK/sSzKDNNywWWLR1w50h0SEm
         HJoSIJhY6/FEvBLkPvciD1blQyt4Fg/KFp7X2Mn+se/8qXh6XVHfz7ZoXZmmsewscUQU
         ezMBTZcsdVGdzas7bK2tzFAjU+VKW/mTign4uD6YcMfZLLp89onacHtZF3KkisWJlPr2
         uVYsABvWQHZkv/CeFlsOUhzk4S1wIraJB1fr4oJ31mPkE8pLEDzdFRR0UmcqqlBA5N3z
         aemMLYvWcmONJzurtz2CNgnOS7QPMaaRm5qsFWXiFP3yaOEOyCi3AvEpNsvApPqkFvpv
         YgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825760; x=1743430560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJrxc1DdTsJ+3uGDO3B4C5w5iLEzjBxEs5BJpFpk+II=;
        b=DTpOxJMuUf7we6DuFLOHbvg5BS53XQSc+erOMxcWEojIfZ8RSfyLrM9GzKIXZtV0t5
         GhR8mnADwHqHzDzz5IKCGrSQkhTtDgqfA0gLXXG4YXBbBgBEqfMMmb8pAvrs79WH4KnO
         FP9di3IJqYlAHFVirxWFRJev3LbZvVkaJM4x24LJ63dtCTNABud8HOaRMNX/9IBxMEtF
         evOTJ7oaK8z3ffE3TpwbHzl2Z1OnuReAqNbYp+X5eJYa2K5IMAzMX8X+aA2kzzhc3v/t
         mv0Psu7sOSUco7MOkQmCJzcskzEOO4mbRf1vtKQ7R/O7KMyY0ZKSZhs2qPyMe0xOWea1
         KhUw==
X-Gm-Message-State: AOJu0Yx/1v+C2d/S/o2jnRwGtKcW5fi5R9CiAY8NtkJs2j3VLUrDeypR
	5UL9+1u9HUJ8uzCTfcFmCasFtMI8RgzA4T48UkbPWwsvDdz0hGCZgvJyDQ==
X-Gm-Gg: ASbGncsuGUYc+fbywWbE9RnnwBZmOuBi7jQpkIkA1t09fNTtEOxHL7iu5N0/zfbRlqZ
	OOWLRO2IuL9f+pSlj1ZxEFUAeTfy4GBsZwGPMgl96aQHtVzfnmPbrqtKjWD5/MocYvyTwgOi5wu
	df5Fq/ioeAg3ZncjzSKkI46wzmO+QVL6Ls6HyVXevqjqTpyxRReyEuT3caIZRMuK0CrZtcjN7V8
	DgQemtQajW7LnxHdYjfRsigCwronVn0FsBspxRqseTYY6VgewsoW3+J1bbhnVgveHKCRyyff2GU
	rAHp3NJPcplVHvjp1R4sX1si0T67yX+qmmal+5epwIXXT80zOl/bJJQ=
X-Google-Smtp-Source: AGHT+IH1JlNqp74wZVGqgUZtRP4qT9KZtyUpgCFn1f4omAbwXPHx6reJBgrvBCcYWsATSB+LeYz8ug==
X-Received: by 2002:a17:902:d481:b0:224:1074:63af with SMTP id d9443c01a7336-22780e10a2dmr182301475ad.34.1742825759503;
        Mon, 24 Mar 2025 07:15:59 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:15:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 05/13] blacklist: add BLACKLIST_REASON_TRANSIENT_ERROR
Date: Mon, 24 Mar 2025 07:15:30 -0700
Message-Id: <20250324141538.144578-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324141538.144578-1-prestwoj@gmail.com>
References: <20250324141538.144578-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is meant to replace the blacklist held in network objects,
known as the temporary blacklist. For these entires there is no
expiration as it will be up to network.c to remove them as it does
now internally.
---
 src/blacklist.c | 13 +++++++++++++
 src/blacklist.h | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/src/blacklist.c b/src/blacklist.c
index ca699767..17122840 100644
--- a/src/blacklist.c
+++ b/src/blacklist.c
@@ -76,6 +76,16 @@ static struct blacklist_entry *blacklist_entry_new(const uint8_t *addr,
 		added = l_time_now();
 		expires = l_time_offset(added, blacklist_initial_timeout);
 		break;
+	case BLACKLIST_REASON_TRANSIENT_ERROR:
+		/*
+		 * The temporary blacklist is a special case where entries are
+		 * required to be removed manually. This type of blacklist is
+		 * only used for an ongoing connection attempt to iterate BSS's
+		 * and not retry until all have been exhausted.
+		 */
+		added = 0;
+		expires = 0;
+		break;
 	default:
 		l_warn("Unhandled blacklist reason: %u", reason);
 		return NULL;
@@ -96,6 +106,9 @@ static bool check_if_expired(void *data, void *user_data)
 	struct blacklist_entry *entry = data;
 	uint64_t now = l_get_u64(user_data);
 
+	if (entry->reason == BLACKLIST_REASON_TRANSIENT_ERROR)
+		return false;
+
 	if (l_time_after(now, entry->expire_time)) {
 		l_debug("Removing entry "MAC" on prune", MAC_STR(entry->addr));
 		l_free(entry);
diff --git a/src/blacklist.h b/src/blacklist.h
index a87e5eca..dc7891d1 100644
--- a/src/blacklist.h
+++ b/src/blacklist.h
@@ -26,6 +26,18 @@ enum blacklist_reason {
 	 * connect to it via autoconnect
 	 */
 	BLACKLIST_REASON_CONNECT_FAILED,
+	/*
+	 * Used to blacklist a BSS under certain failure conditions that don't
+	 * warrant a full ban from connecting. This can include an invalid
+	 * password, or an auth/assoc failure with a subset of status codes that
+	 * indicate the BSS is overloaded or cannot accept new connections.
+	 *
+	 * This is used to mark the last BSS as having failed, and to continue
+	 * iterating BSS's. Once the list has been exhausted or a connection has
+	 * succeeded all blacklist entries with this reason code should be
+	 * cleared.
+	 */
+	BLACKLIST_REASON_TRANSIENT_ERROR,
 };
 
 void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason);
-- 
2.34.1

