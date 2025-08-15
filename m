Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD92BEFF1
	for <iwd@lists.linux.dev>; Fri, 15 Aug 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271574; cv=none; b=W6OzLGjPkjNR8b1uh44hHhurFpstDxSyU3QhEcOSLXCbnO5Vl1464Bid/1vnu4iyflQo1Y9xub1sH+uxWRPM7HLZPJVNnuhkDppJsXRb0yt/+E8jD0O3pcGfkbshCD9LTMnZAXvHk8ivlo1x0t25eHKUyi52M1IY4qd2lZENBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271574; c=relaxed/simple;
	bh=/6wP3ihWMuMPzzAhTk2pJzckLS+bjxnKqgscxfZWDX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y7MsZGzMjWPzsH7YiIjr9PUFNiKpQRl1kW46I7vC7MOEOsXFilzxp/M+L2CndRJBUgNT4nFItSk+Iq1/KXcQaE8isIE0bE0zIJg7clQthaOtuurbTI9Sq4mUCizPRSwRA1tBZquZYztFJG4w8uNkjnWab2jU/2JALGogZeQ7u8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKKgK82D; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKKgK82D"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109ae67fdso26634911cf.1
        for <iwd@lists.linux.dev>; Fri, 15 Aug 2025 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271571; x=1755876371; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha+y6ZlFXVVPDK+CFCdyAFjVQHHk7LaZkerjVDrRvbc=;
        b=IKKgK82DT1DfPP9hzOr2byUpOIF9M6XylZIIsRpdLR49QJxwuD2MlH+ZDDAExByuYP
         ep9gS6A0uvnVZtNM5qacm+60XuC6Ra5j7hieBT3lOPWfVLSuOaizkSx/Wses3YImIR/D
         amehzzyjw+vpSstMmIF6M6u2B5MdIUSqtIxlQAepdvF2sUeHhPxHfygTIDUxIiljEj0b
         apmgVgvELv4tEK2DsK/rUYMc0G0LQo2IsaRSJtmx5wWb3U/9Le5zcwXEqROy8QoQXR86
         2+KYHnxMiA7c8jXZQFmV7kNgg6pRlfHwLenwytRuf+M1G8fXcJ6FmUAWaH5uKJc7K0Cb
         2j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271571; x=1755876371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ha+y6ZlFXVVPDK+CFCdyAFjVQHHk7LaZkerjVDrRvbc=;
        b=KdToopZcfIGDcK/K7DauhbrIoDPgKlBsx7U2+NMxapzOm1a1Zp3eN2CajDblrH45Ua
         iul54okInr8WxW3nzTPYYe0OJebxHaMkAPjQFKEJ5QZxJzqh2rEgOxcfacLho3/EyfpY
         9UL/rDhEUyxiDM0MS5AHw5jaIXhRCTr/uBygvUqreT6iNH08Sa+rxIFmaZ/+dYbA4Sf+
         xM5caLIzzdyn0r9yPZ3BpnzaIjWWgS6XI+Ur9fdtkGcLXX9Sksyg8NfCM7i84+3egGQ6
         Few/CcLdKu9jLi0iWHzMcYnCyLS16ltf4N5ZnBif6F2DLDszJejKDyUjpmqDzGM0r+8a
         1WLg==
X-Gm-Message-State: AOJu0YxBWgVYfg7w2jBuLkrw4qq9XACn7LThPnO3hxqFJ1ec9I7NaQyx
	1kJTgIQLn30cIiHc+xdtzCrI6rNpBvL8Hd6li3uqUNBoZ//7ty2MG0vv3dBhTw==
X-Gm-Gg: ASbGnctR8Me18mJjDLRBi8CBwm4KcU4JLJ/D7kMJgzDWoRaWzAwh7D4TX15/KsxOQGb
	pkzcjct3QX8b27gQQrEvgLmYGRDVpdMx7MHzDIrGm3FxadXx9d7E8ta160VuCXG3KyW2C6PY8CW
	m9T5qy36/kNSIJPlQmWGg12UF1jid5iVgos2ZvGPmHT5I7C4fL6GB6deRvjolhGcxo4hABtREvc
	uay8yNDPxSrA4TSZG+eJF4n+1NIiwp7p+DPocgncribkAxi6+Y3WjnRq/nTsubNoj0SFZNJVfNY
	85jr6zJz9yLhgdVNFG8dP5mIiLBPfymlYGpkAiduzblN8+0QJ25ty/x6Z6gVJhN8XNFHWQWERyk
	cGH2Hyz3tMFBNjsga0q5TQshdEJP6M1En
X-Google-Smtp-Source: AGHT+IH9yklanSGuky4xybSRJItJe5tgMV/QA3T9J3JgFuZe6/snp2e7Cp0ucFE9MxjMQoiZZPIw5g==
X-Received: by 2002:a05:622a:199d:b0:4ab:63f7:9a80 with SMTP id d75a77b69052e-4b11e0ff784mr34000881cf.13.1755271571287;
        Fri, 15 Aug 2025 08:26:11 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de0d731sm10393851cf.40.2025.08.15.08.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:26:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] netdev: check connected in channel switch event
Date: Fri, 15 Aug 2025 08:26:02 -0700
Message-Id: <20250815152604.175977-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In an ideal world userspace should never be getting a channel switch
event unless connected to an AP, but alas this has been seen at least
with ath10k hardware. This causes IWD to crash since the logic
assumes netdev->handshake is set.
---
 src/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 53a97cbd..ca8bfea0 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -5402,6 +5402,9 @@ static void netdev_channel_switch_event(struct l_genl_msg *msg,
 	if (netdev->type != NL80211_IFTYPE_STATION)
 		return;
 
+	if (L_WARN_ON(!netdev->connected))
+		return;
+
 	chandef = l_new(struct band_chandef, 1);
 
 	if (nl80211_parse_chandef(msg, chandef) < 0) {
-- 
2.34.1

