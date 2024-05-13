Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A137700
	for <iwd@lists.linux.dev>; Mon, 13 May 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623250; cv=none; b=K761Irsla0EJWlq9zL8dekLkUhxTLp8/dctR6cn2WpSOEbB1JYBq/V72fF6tKDd1Cwq6lcY4g8IbJ16Hb0bdcvKnSUPEHYBnrmhJyh5kIvduakleCDHOuu3yYC9giGWyH6dSnL7psFXLb24QGabmJinWbPKfZngg2nrfQ/7eMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623250; c=relaxed/simple;
	bh=ucloBuCvVMvE66xJZC3/wXA+1i0GwEMEZp5z4qEYZgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=swAOqR0V23DSfKUP5+GfPy08iSvtNmPxUESWVtCy/v3po3UjMUtD7ErrTY4FZT7viMxgibqei5VZbPFA//jZCf20EFLSIpH6DnqOIneTV2PIYchKpk8CCGvUI6/tK9pH7WFj8qF6/H5ZgavkCqLnKprNJNnSJ4riJeCOMNs0D94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+9rmB7w; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+9rmB7w"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23f9d07829bso2496775fac.3
        for <iwd@lists.linux.dev>; Mon, 13 May 2024 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715623247; x=1716228047; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5l3mf1Ku8B/DFLJvIYPwJHk5PcutLzNsCUAJMGmkDfk=;
        b=K+9rmB7wdRwAZmPkt73TvanQc/WFc8lgTfD8N5HVET8A87Q1n++acOYM4hmv5sElfj
         faCt/ID1mQy2cSJKyGAEdz/0lIierzHZUxjbgR+sbaiaY9dyrNkKoYlL8ZA3PQ52L37M
         pF+Ot1TefuorzsWGCKzHDOgyvvfOq7gcvO9IxOgwR+HLD/LeeijUzKkv5Mhu6natjLtd
         BTuAO9969CtrRS83bYwbecodC3cb8HYCYdCeeVIegMWyr78OQMUoObkH2COgFao4CdfQ
         oB+j8k1q31lLZxbkmN7gbU32PjDmeyA+PQNDKM6ZvOmShQhIwGUrizJz4JZI64B2eKG6
         Yoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715623247; x=1716228047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5l3mf1Ku8B/DFLJvIYPwJHk5PcutLzNsCUAJMGmkDfk=;
        b=MEsq9Szm7vs9s51o90pMvImf4+Eq7hYeTI+5uodBpYmeSzP5S2+t/sZpH/UehUYrOA
         DalK22PwVN2T6to7+x5AjGM2XJC3FZz8APBt3d5UroOb5PnpvGjq1Q1SBoaiz+ozGMSr
         i6zvn28QRuUm62C5RCZBou/NxImip7OsModM3mthiVgEnMIem6ZLW5BEP7p/z+/RbWFA
         I14D0I6sC4QugtajLmLN98Epfg9FGCrblcPMbNe80C8CgejLjXuysfQksSSLmB81yGyd
         EvGbKb5NcHrt00Gpyk472G6F4nioW7zwfN2rS+Uf7sKnynNzo8gl5bB/LtV23tFbEavj
         oORA==
X-Gm-Message-State: AOJu0YyYDi5C2XQd5A/cyAuLlgLYPs1tA/TFuyktZ6KcWH9x3oDOps8/
	7ocdmw8MAQ1+ffx7IP4tUazgItIY8sajPcvshcPdTeNlb5DKqC5bjMzlUg==
X-Google-Smtp-Source: AGHT+IHCEY/EO85ZV8mNNXjn6B+rfIVWSCgAk93K07AZctMqFlA+HH/UFsyvK8ZfuvndU+WTeum/Rg==
X-Received: by 2002:a05:6870:9589:b0:23f:2cb:7c12 with SMTP id 586e51a60fabf-24172bd071amr12710459fac.27.1715623247180;
        Mon, 13 May 2024 11:00:47 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a4b38sm479404385a.66.2024.05.13.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:00:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] scan: remove force_default_sae_group from scan_bss
Date: Mon, 13 May 2024 11:00:40 -0700
Message-Id: <20240513180042.257401-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was added to support a single buggy AP model that failed to
negotiate the SAE group correctly. This may still be a problem but
since then the [Network].UseDefaultEccGroup option has been added
which accomplishes the same thing.

Remove the special handling for this specific OUI and rely on the
user setting the new option if they have problems.
---
 src/network.c | 3 +--
 src/scan.c    | 3 ---
 src/scan.h    | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/src/network.c b/src/network.c
index 7b996f51..09099fac 100644
--- a/src/network.c
+++ b/src/network.c
@@ -556,8 +556,7 @@ int network_handshake_setup(struct network *network, struct scan_bss *bss,
 		handshake_state_set_protocol_version(hs, eapol_proto_version);
 	}
 
-	hs->force_default_ecc_group = network->force_default_ecc_group ||
-						bss->force_default_sae_group;
+	hs->force_default_ecc_group = network->force_default_ecc_group;
 
 	/*
 	 * The randomization options in the provisioning file are dependent on
diff --git a/src/scan.c b/src/scan.c
index f48ffdef..d3f0ad31 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1242,9 +1242,6 @@ static void scan_parse_vendor_specific(struct scan_bss *bss, const void *data,
 		bss->cost_flags = cost_flags;
 		return;
 	}
-
-	if (is_ie_default_sae_group_oui(data, len))
-		bss->force_default_sae_group = true;
 }
 
 /*
diff --git a/src/scan.h b/src/scan.h
index 65caf41c..516b6152 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -82,7 +82,6 @@ struct scan_bss {
 	bool vht_capable : 1;
 	bool anqp_capable : 1;
 	bool hs20_capable : 1;
-	bool force_default_sae_group : 1;
 	bool proxy_arp : 1;
 	bool hs20_dgaf_disable : 1;
 	uint8_t cost_level : 3;
-- 
2.34.1

