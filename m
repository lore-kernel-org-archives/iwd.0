Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471DC13AD22
	for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729946; cv=none; b=WYKHqOCgIoX/2ydH7C4ELg/zahilCcE3IFAMzQt3uWjeBo/zLO6J69aDgRhq44wKl6CsXRqhITNh6zc1Wn6kIKh54t0LDPG/LfyAR10PIlZIc4pWLi9xapoBKeFz7lx843Hx0vRqIMjNztYu42flLYgJbvpcXsusQRQcRrokNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729946; c=relaxed/simple;
	bh=Qi4p6aQevwnNAZ9SyeVDIQTjS9ss0P6raApIZwur9Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K5b6GmfRvVP4bJXb8jV8uSa3AvoJkuU3bkTntztRH0A8Vvu5mecwf6qvlRd3ptPGqJphBPpnT8eJhZOKF46YuANyObmxEpMxkRkZAzT0U+DoUANtVU/wHlIHZ+fUQhZJvSEJWUlzUxPvl71Tk7Jx86t383p/25l74WoObwc2/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikVF168h; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikVF168h"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-797fb0b4832so280211585a.0
        for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718729944; x=1719334744; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPGwI/L7oeCcd5nppSf7suc+fUaEOGrTT8KkHeDu7tk=;
        b=ikVF168h7fQHJhI56UC7fL+x9nf4V8h3GhJOXEnRNwHYWClZacpq8ymdxneqkSGdJU
         a+NOo8IPUnkz/dY8b9yLN0p6SFmQrxcauLYyV4Lsb7/2oMwdJaeaamGXmcN6bqsidkaK
         GtOsPk7Wbk3DcjNI44i9SJL/AKIs5e0QJxDCoG6W3R1gthZHnxsKWj6aStl/MQPVNflx
         GwYiJKU1aLlNG674Pl6OIKqquftXAtpxD/llJGibdG/nJzilrX48U/BBK3kSVCk6XwU+
         tNLkc1Ddi9ldGCfgJzAKvFvWW7tB2oJ/Qz0BYurNOfc4l+CaaQd4K6C7nK/eZAcqAHa+
         LwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729944; x=1719334744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPGwI/L7oeCcd5nppSf7suc+fUaEOGrTT8KkHeDu7tk=;
        b=r9OSdVusuP6jDCXmNIX1rH4wECKil99LI6RZwxo5AymQzLNdRtlKdmfcBhKOdMdiRY
         bBYJpch/DlDKzxaIFE+gaCA3BbRaF+flcSxESXCMm1XvitgjREexSYpOzLJCXkCEzcBb
         XRYopWVWppou7FUqk+4gkXUG8yTwG702sA+9gpvqtfOlNXAQzCBTwKsxBp5GWJfaQced
         +xMWUtnbYss89FlNqNm8jmu6bmpG0KnPgC2nwQHQ4I4kByoGJAz0MI6/DSUF7dbv8ZPS
         C3DC9KY9ZNTNWbvTr3wWNXngZ/nAYfKv5C79Dc7g0KneNmD5hdtA8o4cF0IKJ6EFIrLx
         fBsg==
X-Gm-Message-State: AOJu0YwpesipIIhfz6EE+Nopdd3S2mHTicMP6rD7KfwvdTLeYo8G5vIT
	u9oQwIZnQaGqcWASkzRNkvYprS6pCigs0LygkDmEjFJfgqzh943nAiMyDA==
X-Google-Smtp-Source: AGHT+IH7XQsahiuGxsFRzM+TKq0UXCafNxymm0nuDaknRS5oebi3k1/7EXA7725kJxfm26XV+HvEaQ==
X-Received: by 2002:a05:620a:1918:b0:797:a485:28ef with SMTP id af79cd13be357-79bb3e1240emr34202885a.8.1718729943950;
        Tue, 18 Jun 2024 09:59:03 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b49e4c82sm533688785a.88.2024.06.18.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:59:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/10] nl80211util: add ATTR_SCAN_FLAGS
Date: Tue, 18 Jun 2024 09:58:49 -0700
Message-Id: <20240618165854.113598-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618165854.113598-1-prestwoj@gmail.com>
References: <20240618165854.113598-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/nl80211util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 0076aa51..ac4ad223 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -159,6 +159,7 @@ static attr_handler handler_for_nl80211(int type)
 	case NL80211_ATTR_WIPHY:
 	case NL80211_ATTR_IFTYPE:
 	case NL80211_ATTR_KEY_TYPE:
+	case NL80211_ATTR_SCAN_FLAGS:
 		return extract_uint32;
 	case NL80211_ATTR_WDEV:
 	case NL80211_ATTR_COOKIE:
-- 
2.34.1

