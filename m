Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4C1E0DFE
	for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642879; cv=none; b=g253mrRG76XU23Fk+UZvssa1gFBDx2oxmdDn3eEc1Rah2BQ+ko/nR6mhezy0FCnYd3gGQ01rOKpwP1NRdRbqOU/9TXA5SeVdBZRZiF2VWBJVPu04XZuKbXuS6Fcu3oiXuZYMQjJcKJA3+vqoA6CNm2Fdbt+A/ZeHGAi+04SMN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642879; c=relaxed/simple;
	bh=eKO1Gyqh2jCy9GAmlM36eeeVwtbj13gPZh5jSMvGdbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5tQGWphloW7GC6IAIGNc2mDFScqjKz/Wx+QyucPOLWmqUIXHKsZiYDQ7RV7hNI1u0oNW3Mk3KDEsJU2MxsDmGS2HMV/KN42DXxfxO06htjWytui/3DM/cdkQe7Yzk1bq3dPghrxxSpj+J9RmsAUIPGi+eIc5kytMNNsqiz7l9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqjHy65s; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqjHy65s"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47698757053so6795851cf.0
        for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 14:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741642875; x=1742247675; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMsJptddDXeOL+An9Tsw0CzZvPobOuoRxUqKqWF7bgs=;
        b=dqjHy65smFa5mtQhQoLCuctCrGIJSWIqiOLRLNt69HDdr4OZlhf84nmaR8+/yEPWTw
         0+DkQ9qmxQnqN3YgI2o0sgMKM3lQ2outhj5tr2lzHCxxwZ7B/HNKr/mozy/AAa38tW6v
         IUhLRcncghbLw5E2uTewDlC7zADGK79tg9HF1/avuob3ByWcS0SVOz8eYkm/HUWMhFW4
         SC9oe06Dh/FTgKUNvNiaICaotJPdPfuhqifcx/Ap+HjqC7CvLz0nCKvV/ymBcCQ8cOvd
         lt5bteMhuNkCkPIrvY3JmjVBdF264BnDtfQbXXmrNa4t9q9yGvlyBHMf3Jd1Lu2L5BB4
         QZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642875; x=1742247675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMsJptddDXeOL+An9Tsw0CzZvPobOuoRxUqKqWF7bgs=;
        b=QIfBRunmzCLxP9GRiDchSMSESRcWCiwXapkG94ZV/F5GasGlHsLkXvFMR84O9X1Co/
         TU7WpSVfvm3r9JfxvyA6uYuEix3IoLxTgDFXpLZGZ6M8akR5h3Wjbdig73mH8UFwxTA6
         B7BwPT1a6IThDhMFuo/1Pn+cuPtZ40p2aNFKYQNWJ5MFSYqbdQfKZ57tbBq8lNDouS3b
         jFwMgcBnUtWhKhrbzanvLJMr9OytvTkus00PI9GvQGxIEELB6JytzYDmhUoYObf/p6SV
         wIz1qM/JrAt1/xQdIR1X/3oGoZJ0EEmo3/030t+z74JsOhIZhmLDsmEyUbWW7r2Wj+RW
         BLvA==
X-Gm-Message-State: AOJu0YznGSlHoj6J/ropXe3OaM1aKoircJpRuySASCTHqReCKkakATAP
	8+b3q7hlS6Cg3sP53+sTb3EuExJtpy1v28hZUJTt3Lee6souPJOPfx/Xug==
X-Gm-Gg: ASbGncttzo4/QHhrnXGmoTallDznohCUUQHS3RMIFore+PxUFvX8z8qDWSDnotsAfDs
	QlxCAGEyOawKdgi8H65ZuNqVzNWu25GfxZ+t2rgAerqe5Obb619PKz+OiyxdpUIH0wL6LGb0vGv
	/tPWxWKS8vOC0Rlw4cqNMiXWYF6L4/EhoGpAisBpg3Yfde+z4Whn1/SuhnuD1rWMA4i6IQPypZH
	LkapIoK21ok2VTa+UC7YOn6wINCxwyiznHd7khWY0tLhqoLmRccIQt6Ms9iUtmfwFgGbLSB8R2y
	2vFQcSsaiE7i1v9xP5JJNoK26Kib2q3zCNIffdRPZio/05E2ZVJ1jV3fpW9bJBEGoLdES5zgusy
	TuMXeVM9XnUCXWQ==
X-Google-Smtp-Source: AGHT+IEOkvAD8PD3I3Myzd+xEZOmJ6/BXn3hnrlaswIlTCTsDHcw5oddunhvYYFtF0T8KA3clD21Hw==
X-Received: by 2002:a05:622a:144c:b0:476:85d9:5ec0 with SMTP id d75a77b69052e-47685d9665dmr64789091cf.0.1741642875495;
        Mon, 10 Mar 2025 14:41:15 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476772de5absm30487841cf.66.2025.03.10.14.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:41:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/8] blacklist: add BLACKLIST_REASON_TEMPORARY
Date: Mon, 10 Mar 2025 14:40:54 -0700
Message-Id: <20250310214059.20809-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310214059.20809-1-prestwoj@gmail.com>
References: <20250310214059.20809-1-prestwoj@gmail.com>
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
 src/blacklist.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/src/blacklist.c b/src/blacklist.c
index 12100a07..eef3f730 100644
--- a/src/blacklist.c
+++ b/src/blacklist.c
@@ -76,6 +76,16 @@ static struct blacklist_entry *blacklist_entry_new(const uint8_t *addr,
 		added = l_time_now();
 		expires = l_time_offset(added, blacklist_initial_timeout);
 		break;
+	case BLACKLIST_REASON_TEMPORARY:
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
 
+	if (entry->reason == BLACKLIST_REASON_TEMPORARY)
+		return false;
+
 	if (l_time_after(now, entry->expire_time)) {
 		l_debug("Removing entry "MAC" on prune", MAC_STR(entry->addr));
 		l_free(entry);
diff --git a/src/blacklist.h b/src/blacklist.h
index d4da4478..6ce26aba 100644
--- a/src/blacklist.h
+++ b/src/blacklist.h
@@ -26,6 +26,13 @@ enum blacklist_reason {
 	 * connect to it via autoconnect
 	 */
 	BLACKLIST_REASON_PERMANENT,
+	/*
+	 * When a BSS is blacklisted due to a specific subset of error codes.
+	 * This reason is somewhat of a special case and has no expiration. It
+	 * is assumed that the calling module will remove these entries when
+	 * appropriate (after a connection/disconnection)
+	 */
+	BLACKLIST_REASON_TEMPORARY,
 };
 
 void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason);
-- 
2.34.1

