Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A01DF722
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288566; cv=none; b=VfvwoLAAnY8i7ebIZQibsU9jrycYvp2E+s8J6rEsrEWb7WTnqx4DY22ljD1vrRlK6PWuXSyNMO9I9w9WoNPZAvuzwQ1NUzNWnNX4/QOQMy+vr5n2XPGzK2oCfQyGd4O3BLQzfoomXJixGfKkVsI0kl81SmgA5k98jAk74TjAoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288566; c=relaxed/simple;
	bh=L26BtJ3msy54RtgliMzXVVn1l0C3+Mj3XP2g9AMd0XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikfQ0+3CaL4W4K3wB4Z7P1luO9SXXDf01GQe2PvVITwAoee5rOnrQLOt5PbOC55ks6P4Wetwt1D1ejsk9lUBjH+tqW8o0hb7tH8IiowiCo1W86eFlOzgfapU4XmnbCuEOi2BJil6YfXE/WX/TwBEz86YBcFnK0+TBcT8QAuF3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQcD4LcG; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQcD4LcG"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a77bd62fdeso7490835ab.2
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288564; x=1732893364; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EluXf0G+pEbuPEV/B3osZR6S7xYW0Oy/n3g5+l/9zxs=;
        b=aQcD4LcGHotNaULmSUa3gb9kf3IPonnpKPIAvcHgJT/DxZzrjk3BnKBYDirKqWKI0A
         amP1EsyGpFPMraOTZexZ01FG+bVHUKOsBw0vZU5bbnEndMhE9cxnzD/h+9zjY/Q+FSot
         lwWZRJibt0Wsv3IDQr6XlVSAzctVOGWJJgejxewI5mxrj75F1GW+/XU3NuY1221vY34t
         gbs4/c1DdgT4XlCQi0KmJhmnqRTipZstCxMTJJRNOQgwf5HhtHSB50lHMQbYVbmQx3GH
         jY8cLwD9co8Z0kGRK3zYMTv0WHrrY3mcz3oUNh4/DdW8vsdiOTH/edRQpLyAVaHuyyU8
         QLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288564; x=1732893364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EluXf0G+pEbuPEV/B3osZR6S7xYW0Oy/n3g5+l/9zxs=;
        b=j6FkbArRVrDyqio8LiAIEyjuRnvvGrVaIkG3b6z6+XEtU7w1Yl+z6FZ9jdLa3CXjuL
         trbQHZcLw/oMnWsRlHMkAsn+CqS8Y13OWl5TZ44BRRqOPWwxXaeSSW89SzeVYzDq6BCs
         ERR9avwwx7AkdT/ZBJ1vMoF1QaoVY4gUNJgsWpnJBJ6WL+mt7QOSGyv8veBxGN1YkKae
         by7F1tiZ6TzhKljgzgE6rgtM+YD6s5f6vS8YbeTuZzYQuZ8SKgW1bxRHnOzW94d7kVR5
         4k1WMGwbMj2tUziS2Be92hT2hsvLIx0DjZzHW4S2/CrK+gjvohev3hE4Ha3KyTpTEvw8
         47Qg==
X-Gm-Message-State: AOJu0YzzxszKacgFNjc0bcDWAshwRHMX5rbx3sA3R4swk5zApyGW4zYi
	A48P6yJiyvzEmAqI4MxRAUc4AmIN6Btty0ro4XGL1xz6uTwoLvFCOAGcxw==
X-Gm-Gg: ASbGnctR5DfF2mpLT5BRCnd3ji+inGAIXcRqtkymkyaXcdOciyEqS/YHN0yDBOHUg+n
	qIz261K73p2VpZlvzwRXuDAuBvybPCIALfYeJV1A8oe+l93ttUDt5cxgiQMWXWHydKhdOKCu+6z
	CoCnIzXOgALXZtDZVoUBxmIQ4Cs6s/mSzNwLv/fqqa6crWiC27EysSwh2KBYwSPrrjIlFE54qVl
	Rary2aOGDmjOuJVrhliIwmJyGvmvqhC2rVzoj2CsBGMKMZgzXgoFbGt+Pzq
X-Google-Smtp-Source: AGHT+IFiv23yCej8xjoqXXEpKWDqmGUdZAhschTIz3t7BqBZlbJKccs4eoZi8Y4Zo7RI692WaOYGug==
X-Received: by 2002:a92:ca0c:0:b0:3a7:466e:9ebd with SMTP id e9e14a558f8ab-3a79aeacd85mr40460805ab.11.1732288564148;
        Fri, 22 Nov 2024 07:16:04 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:03 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/15] auto-t: update testSAE to disable PMKSA
Date: Fri, 22 Nov 2024 07:15:41 -0800
Message-Id: <20241122151551.286355-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are quite a few tests here for various scenarios and PMKSA
throws a wrench into that. Rather than potentially breaking the
tests in attempt to get them working with PMKSA, just disable PMKSA.
---
 autotests/testSAE/main.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/autotests/testSAE/main.conf b/autotests/testSAE/main.conf
index 932eb38b..ee279b4f 100644
--- a/autotests/testSAE/main.conf
+++ b/autotests/testSAE/main.conf
@@ -4,3 +4,6 @@
 # hardware, but fails when used in simulated environment with mac80211_hwsim.
 # Disable MAC randomization for the tests with hidden networks.
 DisableMacAddressRandomization=true
+
+[General]
+DisablePMKSA=true
-- 
2.34.1

