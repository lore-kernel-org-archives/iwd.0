Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0BA12E1F4
	for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552813; cv=none; b=afBkzGq6xh1FbmGUFueCh3UrtPeswTr6aepqJpzSgyiq5obnbUi2nX4zRnEE2oodhrnLYS5CpMFXRZVYye7dkbP5AxHEyBN2xRWrzY396Ifb9KjDH6FqiIdA+EiZih5I0aHOqsuHexLpz0dzrVEkaT6/sZ6NnGeAID+n5rFlj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552813; c=relaxed/simple;
	bh=qH7OW1nI7s51hIOMmEexgrPbRzsK10IRp9nvVO0EQiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnELuL1iUmE4J+ZOZY9WjBqSp6SlmfN1pVOf6jByN6OBrbA9FnfPsYFcTADFMn4j7FGDjsJQHxSZv3goYY26U7nHg6qAZ48pMjlXdYjwBHrRS5nV/pVEHjxEF3T+DEKiG4rsoUwU6NzO0LIrw+wfB3ZO0xh/3rXvsim9VoQmDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzcbSsJF; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzcbSsJF"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e6e37d33c5so1228193a34.2
        for <iwd@lists.linux.dev>; Wed, 27 Mar 2024 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711552810; x=1712157610; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk9QlwTkGVz8zuUU9zzjxqyAOXZ89ug2efi/CErU4NE=;
        b=FzcbSsJFIaQYT6zGfKe+KAzx9lTUvkdlkzzxkvZf7GJ5ESd1o8xqC6+32EBI9eI9lC
         jWLDvK3mhw7SS/MOfbXmdcD2450UaounCBxAH5yGYepAQ+dZG+J5iCAnSFWDzhorqNk1
         xwnCuJ63u8Gjck949cuiziRxheJ2NcjtLE8Iq7/Q1r3kaMMlu7Z68Aoj3G6dSlYVB/i4
         JJZK8asEv3wUtuxpnauQOylz4XxwIt5dbLNHgbhSDYWTpHo5GyZ15oTznbaSmFxAL/ts
         htVreo7xQ7MnvSK11OcIXz7HXOmgFH3vi1jTVVX6DGNPTFMMwGOVHIWTUvo44xsLLr8+
         5JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552810; x=1712157610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xk9QlwTkGVz8zuUU9zzjxqyAOXZ89ug2efi/CErU4NE=;
        b=qvec8+zygQWjbsIUJm40ifAJf4XVw2vrF2mHzmlyre5dsK0HU74C0D8iOduyLNC5aq
         jJXjVSibUxHinphl1pw9fZUPQH3wQXt81UrNKpl3PLWX8VCnMUgbcqSKMAIhjtCBaynF
         x7VWnJLThokNXm2cy/c6NyAf+M69kMPsrzBpCMgLYojjV0ehh4UXHqIORheyPDyhLv84
         rE7ryEiXLyu+sjmfQTOTT7uUAEhK50MrQHGIHQQkWPITv4o8B3AyLhUfAftSh1OpdUrd
         IrIaMcJh/WHg25e/BEhTtuIo9GLO1TLITRWGuwGIn8mnRD+j9K1mz/u95YGfw/MvjmH0
         wnaQ==
X-Gm-Message-State: AOJu0YwTajC6D7t2twVp8vbZtEA7UkgYh35zf9GVcXZyen7C1GJ9NRqG
	a+8eWPAQ+ZRRmfYE/n1KFC+Do/0OrHU1vNUr2AJFdlzyg6peq/60ABjiG2oC
X-Google-Smtp-Source: AGHT+IEX+13ZUTzS+RYnLDbXjNqeoFZiGcl7Bx7c7ioFHDhT1PJUF8O47rjwuWuYluJzwhkuN4APmw==
X-Received: by 2002:a05:6830:410d:b0:6e6:d042:87dd with SMTP id w13-20020a056830410d00b006e6d04287ddmr344638ott.35.1711552810458;
        Wed, 27 Mar 2024 08:20:10 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 7-20020a056214202700b006968ce99b7esm3520782qvf.34.2024.03.27.08.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:20:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/9] build: add dpp-common.{c,h}
Date: Wed, 27 Mar 2024 08:19:55 -0700
Message-Id: <20240327151957.1446149-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327151957.1446149-1-prestwoj@gmail.com>
References: <20240327151957.1446149-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index be287572..e9f690f2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -265,6 +265,7 @@ src_iwd_SOURCES = src/main.c linux/nl80211.h src/iwd.h src/missing.h \
 					src/dpp-util.h src/dpp-util.c \
 					src/json.h src/json.c \
 					src/dpp.c \
+					src/dpp-common.h src/dpp-common.c \
 					$(eap_sources) \
 					$(builtin_sources)
 
-- 
2.34.1

