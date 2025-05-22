Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91351D5AB5
	for <iwd@lists.linux.dev>; Thu, 22 May 2025 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939319; cv=none; b=lZHpGxlzkpcpsT93VGHvVADOP7PCteacFIqq1fc1FEXXsJwAccDToF/LJgmO4fow6rt8YV9hhz3jjuaojTSUZhJbw3PDXVw0dSy9KdgpWZ4lSuiBW5Ihzrdx6Nth2HTcPBbgpN13VZZtFHm6Lp2jb6cpQvxnU0JmUW8LEkrTyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939319; c=relaxed/simple;
	bh=nkme0XkhQJ7TsF5PjmBq+WbXMZUnjhTgSo9OPe9xG/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qr7LI59JLM88M0D9QPo0/1yHLgfD/8hlS4c93K2TwHmT1p29kFLkzlUsi9woxSzBuDKxRQKw5WajPK4J0soFnBWQSHwhKJoR6rYFyNpb9cIBFRW4a7XKXvmC6Q/LJ9GQDjHqZAlFb52CQqDhq1QurzGTTyYNrXrj6XWLJsfmm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGhKX+ca; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGhKX+ca"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30e9e81d517so4950582a91.1
        for <iwd@lists.linux.dev>; Thu, 22 May 2025 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747939317; x=1748544117; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UD/dCfDBTWGqcRBuY/3ANOfX0RrdeWuZlf5p97oE6zk=;
        b=WGhKX+caX3HrfLTLL5HNW5fNPFT005FU+z3E3JiakA6Nqqorhzlno+fXACrwU5ftP/
         RPHueLqeqFiwlQp8474dgU1e/fOv9GFrH7pJ+nYwIZnry8DEiagYNQZ0Admel+Ql1JMG
         qIelnqU90edD3pm8XR6qOpQripAgR9hPVTR2fQ9D40mQ5nC5xxvXx0LUnRJaBpMdQ5iO
         5QJFNVQ5Y1FUCIT+EByIw2GRdkP1tBygiXyZ0U94obkh6XBUUyEoan+5VMrWCbyqBZpM
         x+3T+R5KNWWAyu75oR1hedXEaCGz3JMIb/eo+/w/57kx4mx97zZ/HFrB9GMlm2C3dV9v
         itKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939317; x=1748544117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UD/dCfDBTWGqcRBuY/3ANOfX0RrdeWuZlf5p97oE6zk=;
        b=sh0j+t4gnocIltfw1LetGV27kN1rzRGGQAChmy/Mk+OuRV3CeqmfmYevNrsb7EjI3I
         5zVevKwVHl525d5yHZZSiSSPoNcLs+LEkSsbnOsXb9vT/dWdTrOjBwXLqIPFpPeFT512
         3AGajuDh64qgd1m31xpce8Jj4tY4Xr30pidkNmN1TzT7W7lVR1yD/ax+XgyG/BVgtbSg
         QcmxR1rz+ZK7yE/IIvToao/AD7f5t0sMMZdDZpZNhHEM7zw/TrI5y5JV+CZZMKv6a3qI
         440yo7JfxYaGi/rynW4YqsIzlRSWCI7/tmWVNuUrM4lUep62HZH0Mb30A3j8nGwWYziO
         U5JQ==
X-Gm-Message-State: AOJu0YzeJfXl/8x/RLPKhy3fM/BqjNZJVNXiGnXTgeaIgssiIiu2k92U
	iiLTWZzpPbEfu5sAd0OgDa1Wfve1ZAZKaFPZsOv9JxBvtaB0yRkG2MCP7cNZYw==
X-Gm-Gg: ASbGnctOtX/qlTh+SEO2ucZxnswaGgTImviNTYXzXoMTFG0wmcG6qofPJndFZwUuUK2
	pQF34gWBxhWLH+am/fnWW3Q8DlpYO3l9D6aUmgJwDAPQSgTtsZQ19s9KC/eJXoOO3JhTpF/YVXU
	M/V7yhtufc5S2zYOB5q1zNHVyUx4oSsYFZI66x44xiEGDHvZvNKY7zvIquY8tmLdwel7izTeWA2
	lei/wdYKoVVKgOmVmIcz1W/B+k73cGdY4XD7GQ2r16gtDm76Aiy3AdW3DER0gkkmpU8oto9pXSI
	ne6bLeQpT8gohvtJCfllin3ZtkETftlHDPu9IKiGutBNoS37S1o4IJ5riLRj+E7SRZHnwJG1c5f
	qUb6cOH+sr+suS9cYiWMBhF7WXtWtikGBZDQNw4ogTTdHNe+0
X-Google-Smtp-Source: AGHT+IHbDVACsPJG3zquytDXV4zpgxu5w/Y1XDFHPLsOFDxfJH0VjqwkeDFss4dcWuWvdnxT3cnYcA==
X-Received: by 2002:a17:90b:1ccc:b0:30e:823f:ef3a with SMTP id 98e67ed59e1d1-30e823ff012mr39228036a91.30.1747939316771;
        Thu, 22 May 2025 11:41:56 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365f3487sm5829492a91.42.2025.05.22.11.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:41:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] netdev: support handling NL80211_CMD_ASSOC_COMEBACK
Date: Thu, 22 May 2025 11:41:52 -0700
Message-Id: <20250522184152.29950-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522184152.29950-1-prestwoj@gmail.com>
References: <20250522184152.29950-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BSS can temporarily reject associations and provide a delay that
the station should wait for before retrying. This is useful when
sane values are used, but taking it to the extreme an AP could
potentially request the client wait UINT32_MAX TU's which equates
to 49 days.

Either due to a bug, or worse by design, the kernel will wait for
however long that timeout is. Luckily the kernel also sends an event
to userspace with the amount of time it will be waiting. To guard
against excessive timeouts IWD will now handle this event and enforce
a maximum allowed value. If the timeout exceeds this IWD will
deauthenticate.
---
 src/netdev.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index a26a484e..3bdc3e69 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -5451,6 +5451,39 @@ static void netdev_michael_mic_failure(struct l_genl_msg *msg,
 	l_debug("ifindex=%u key_idx=%u type=%u", netdev->index, idx, type);
 }
 
+#define MAX_COMEBACK_DELAY 1200
+
+static void netdev_assoc_comeback(struct l_genl_msg *msg,
+					struct netdev *netdev)
+{
+	const uint8_t *mac;
+	uint32_t timeout;
+
+	if (L_WARN_ON(!netdev->connected))
+		return;
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_MAC, &mac,
+				NL80211_ATTR_TIMEOUT, &timeout,
+				NL80211_ATTR_UNSPEC) < 0)
+		return;
+
+	if (L_WARN_ON(memcmp(mac, netdev->handshake->aa, ETH_ALEN)))
+		return;
+
+	if (timeout <= MAX_COMEBACK_DELAY) {
+		l_debug(MAC" requested an association comeback delay of %u TU",
+			MAC_STR(netdev->handshake->aa), timeout);
+		return;
+	}
+
+	l_debug("Comeback delay of %u exceeded maximum of %u, deauthenticating",
+		timeout, MAX_COMEBACK_DELAY);
+
+	netdev_deauth_and_fail_connection(netdev,
+					NETDEV_RESULT_ASSOCIATION_FAILED,
+					MMPDU_STATUS_CODE_REFUSED_TEMPORARILY);
+}
+
 static void netdev_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev = NULL;
@@ -5504,6 +5537,9 @@ static void netdev_mlme_notify(struct l_genl_msg *msg, void *user_data)
 	case NL80211_CMD_MICHAEL_MIC_FAILURE:
 		netdev_michael_mic_failure(msg, netdev);
 		break;
+	case NL80211_CMD_ASSOC_COMEBACK:
+		netdev_assoc_comeback(msg, netdev);
+		break;
 	}
 }
 
-- 
2.34.1

