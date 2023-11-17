Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF41199BE
	for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6vAGL1r"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so1905487b3a.1
        for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 08:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700236819; x=1700841619; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mtNOcEi79z6ov2hxbQs/Z/E2q8GhWiBJHOFdAqxhEmc=;
        b=A6vAGL1rw+w5WIN8qBoWK9ShTPZkIBitF/bhp61GpYmYW5t/2nX9UY5Oh5kMTe6Itf
         SNMjMoE7zp7uBOJ2uTq4ygYN5txpsOENflbGRShNzQCTUa0j/h1gTwgd9h23y5AAVvyY
         FhttBOscV+8SF90ENIaVatNIJPgh5kPlEueBcyw9ODRFSLhaI03oxEeFLQFw9POP/cI1
         a2jTrFPrGafuKOWOx9e2SpDlfMCST+BGBRcd3fjLXmrpK/115bdrh2q5mHX4weUFprjZ
         6lm25gcm4Pno6etfrZnfTK4KVi9dZXKUpSC/aq+fyuKcJHpzrQ5aiwwYJPkthfFl2H5Q
         c3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236819; x=1700841619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtNOcEi79z6ov2hxbQs/Z/E2q8GhWiBJHOFdAqxhEmc=;
        b=WWRn5wSx7zy4/C+j7YOOr37E5rngoZeTykSYeEVTS8qi1iwnD166O0hwalYyE7FU3U
         FWDelVm8APIASkTMuEMLhVQXTr6aiuWQNOqcdE9BrR8YDgdyN4HzmqEHSQWjngM07Dom
         dMIOpFYZ8q53XWUcbyY7lJ6YUKp52yZ0cZ17CUQOqI63HN8pT8Y6O3wlDNTAKz+UKmNu
         9buGNpmyJ65RFOqIsVh6ebR4xczhislzkCPRHLYskhWkU3zegr3Q8YwK7j9s0pBUSZ6P
         etyWEZWCx5J4weGQkVbAuVVol/Fr5WldLfcCg/Vop1zz4Wtcofcw2YHlN3yk66YM1UEe
         SVjg==
X-Gm-Message-State: AOJu0YwLwGe20ZhdyUjQnPg32L+Diu7YgXTXbIWDtKN1M+z/KAM18yhm
	icJbBVwCVLnbkteitx5gNrm/856apGZnFQ==
X-Google-Smtp-Source: AGHT+IHS5j1Enbe8ODzoLObBt2D5hkmB5Ah2AE3qR+d7JuVQ9e/0WBOJyhMgltPzGWqf0jLuPfLAww==
X-Received: by 2002:aa7:8895:0:b0:6cb:42de:24e0 with SMTP id z21-20020aa78895000000b006cb42de24e0mr267785pfe.28.1700236819341;
        Fri, 17 Nov 2023 08:00:19 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id i14-20020aa787ce000000b00688c733fe92sm1559431pfo.215.2023.11.17.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 08:00:18 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] dpp: fail early if multicast frame registration is unsupported
Date: Fri, 17 Nov 2023 08:00:15 -0800
Message-Id: <20231117160016.81253-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is done already for DPP, do the same for PKEX. Few drivers
(ath9k upstream, ath10k/11k in progress) support this which is
unfortunate but since a configurator will not work without this
capability its best to fail early.
---
 src/dpp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 0064187b..c7cd4bb3 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -4362,6 +4362,12 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
+	if (!dpp->mcast_support) {
+		l_debug("Multicast frame registration not supported, cannot "
+			"start a configurator");
+		return dbus_error_not_supported(message);
+	}
+
 	if (!network || !bss)
 		return dbus_error_not_connected(message);
 
-- 
2.34.1

