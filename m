Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C907A14D
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230348; cv=none; b=aYzxBWCLY6idNWvMX1+Hmpi8cmuURVaVTY0A0C19M41f/at56paEVUWajuWm7+FOtofDHFPL+ZABjbqp6qTWU79EkZSANKE8/mEm/VwmmjcHwtnND2XiY0ygIUeb6OQ5lFuRnFSMnmtK3r7SWLi6Hco17nghLDLYPQsR7E5Da2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230348; c=relaxed/simple;
	bh=Nq5BxIQ2iQOPy0RDMFtf/L0ikATR0G+NwkOvknD+sPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iSGXyl6VMHd4xjO05vyfnnACoLQuQCG9zZGaP2BAs9CbsEY3YC3iuUSU8v0FfQ7LYYLrlFTjT7sCByBCisLmel7Lso2F6dLV44X7RoMw8YHhDflQH7HgKw/FCJszPYjxi7HgZxQ/KCUsAC4V6MkkBchVzBq3CmAe8sAnNs31UPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GswkniKX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GswkniKX"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42e885c8885so5289231cf.2
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 10:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230346; x=1709835146; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibns01NBkL1xPU+v4AK+lmGTo+9X6/v8xLW9qDyfV7I=;
        b=GswkniKXnsTzjycuCIdH9vphjAeg2CXDM6R337Rbak2chdg3MMHAqXWDHJVSOwrJHL
         Q3hJYHoYfTl/iMpXGu6mtCU/9pl+XtgexJx9bxJVXbBeXMCQR/ej2NUPvoOtrTV3tibL
         CpL5rGOz5sQJ3Y6yhJRmUvQxMMjRaJW1ZQ07/aOZxir3q5oK6PkmANKA1FhfAUptCVIE
         o31gDZZuM348RGSjaYdpymyRlz0AKZ8ghSND/KM6p7ne3BFS7sYZQMtjEqZeUEs00SH4
         F2OjvJhUtcM8TjHVD4WITB1GtH1kQmlq0wpXmBcWPDnRxwQmjujBanrZmGBoW1O/+lEa
         Z3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230346; x=1709835146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibns01NBkL1xPU+v4AK+lmGTo+9X6/v8xLW9qDyfV7I=;
        b=I+Zi3T29kwgp5YOs4a8mO8KkGozuZ/lXjc+QaF4AovWADkTwEXiGJquoLAEvX39Kuy
         eqsjjURt7hoZlW9sLvgpUocRZOyTvSKw7dZDlxFYk464W2m+E0jWlxrk6ypiyli8FdX+
         Y9ogZgPZU5sowdNtCkydaNZGNw6LENQUKnGxFhaQYq6zeoEXcF1lhkUVBM0uQ5H1z45R
         SL9U/x93v9s8NvwwlCaQ0G3pu5/b1/7a9lM16bNjXmiAxmaWhLoxMQAcokeWYhjlTzvF
         Cag1LCO2/2iG6IjGKJcJqMjRE9zwU1LTrALRjI/nczt1L7vjPgPs71gt9e780MilzCmp
         o5Dg==
X-Gm-Message-State: AOJu0Yz65ceQ87qQoqjN+Ag1YSjc4rYj8ARB8WOLK3K5XAKciNslo4Op
	Re7Ek+FbdaX2hC4bjV3ii26alC8LeFEQPhtpa63YPRtxeSui0VOkrQSeEtsU
X-Google-Smtp-Source: AGHT+IHQY7ZBVUVDr04OQEf0XMdLc7GoK38Ptak8oL7DZ1udvF55HvrhItGoF5lca5MuOiMFgz8p2Q==
X-Received: by 2002:a05:6214:1741:b0:690:4568:55eb with SMTP id dc1-20020a056214174100b00690456855ebmr2579568qvb.40.1709230346007;
        Thu, 29 Feb 2024 10:12:26 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id mf15-20020a0562145d8f00b0068cc0b46682sm994209qvb.4.2024.02.29.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:12:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] ap: bail in ap_del_station if AP is going down
Date: Thu, 29 Feb 2024 10:12:17 -0800
Message-Id: <20240229181217.1503555-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229181217.1503555-1-prestwoj@gmail.com>
References: <20240229181217.1503555-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caught by static analysis, if this condition is met the AP is going
down so we cannot continue further accessing the ap object.
---
 src/ap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index a6f8f306..b4e7593e 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -455,7 +455,8 @@ static void ap_del_station(struct sta_state *sta, uint16_t reason,
 		sta->ip_alloc_lease = NULL;
 		l_dhcp_server_expire_by_mac(ap->netconfig_dhcp, sta->addr);
 
-		ap_event_done(ap, prev);
+		if (ap_event_done(ap, prev))
+			return;
 	}
 
 	/*
-- 
2.34.1

