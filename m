Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23A5388
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldbYetKX"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58d9a4e9464so859823eaf.0
        for <iwd@lists.linux.dev>; Thu, 30 Nov 2023 20:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403270; x=1702008070; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQ5YhLfDEuWDFPniwXZVE5AbyeNPpLG0QRLsYCodl8M=;
        b=ldbYetKXFefh+v64Q7KeuEwRRfrLrC/lLDkCuJB10OqyZJzPLMvnBETHBkc+qpOJF0
         s4XqdNj/Dfbj/CImTAVfRMi5yb+taOqyH/3Cyt5kBGZeMPecJ5ak0ePkYrtXzXYwkaSi
         tI2uZX098KfvmH291h4vP7yFuQWmUJ3sQ9xjJRIoEvVUZiPlVY3GHZABbAVkx4FLeCz5
         OG3o1sc/RLlarYGJ/5/YDjAo9jkhwvG5O3TAgcSLhrUqV98O9yR9OzB6QXF7IA7f73YN
         uLtE3gC4AyQjgZmPBMcnOp3gDfZ3JSp7Y0y8j0sPVvVxFB6LmsvxGDidq1PdTjw9ME07
         Yz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403270; x=1702008070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQ5YhLfDEuWDFPniwXZVE5AbyeNPpLG0QRLsYCodl8M=;
        b=bwYBk97I5Edf736RyFeXqGctsxA9YgGOhhRSEh6Wo9XEgDo515AVnmPwDZHqH3QoMT
         DNeyziLBpG/wqBkiUEYNeLN5EsTY+megbZNO+D1U4+ZRvyC1Wo/TTj9AG/8urcsVgrui
         mZ2nAlZMS/zrFDDKIO2OF/eNDjtSKlyepDSAnS1o7uc91KszS6n/ZfDYRKd5P74C/U30
         FfYmnkpro0aC60NuRJ3tL4B19f7XhtydBoCZm4zVxssanDmr1iwQhMyBKZcORXt8v02I
         z0zxvHZONLmlp6vduHmbxBFNhlGYjy9Jix59jo1nZyjdiFJBlFh9aa3oS2jhNRt258XC
         s9oQ==
X-Gm-Message-State: AOJu0YyiuZ7ET4f3ZHbkVReIcIi31vASb12TEZWIZFFB86ipB3OmIH1X
	/H3EPkedGPGR14fxMAPg401v/ZsOit0=
X-Google-Smtp-Source: AGHT+IFk7SsQCYcjJh2aynQ7e/XkxgbLsHfN1apnzE2Q9WL0QmfhiWj6KDN18clgjzFQUf9E2RAVUA==
X-Received: by 2002:a4a:e0c4:0:b0:58d:d938:26ac with SMTP id e4-20020a4ae0c4000000b0058dd93826acmr1509178oot.8.1701403270558;
        Thu, 30 Nov 2023 20:01:10 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o3-20020a4ad143000000b0058ab906ae38sm404005oor.2.2023.11.30.20.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:01:10 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/7] p2p: Simplify handshake_state cleanup
Date: Thu, 30 Nov 2023 22:00:02 -0600
Message-ID: <20231201040020.161143-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201040020.161143-1-denkenz@gmail.com>
References: <20231201040020.161143-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/p2p.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index 5d96e6825e1a..c823b2b134dd 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1496,7 +1496,7 @@ static void p2p_handshake_event(struct handshake_state *hs,
 static void p2p_try_connect_group(struct p2p_device *dev)
 {
 	struct scan_bss *bss = dev->conn_wsc_bss;
-	struct handshake_state *hs = NULL;
+	_auto_(handshake_state_free) struct handshake_state *hs = NULL;
 	struct iovec ie_iov[16];
 	int ie_num = 0;
 	int r;
@@ -1562,6 +1562,7 @@ static void p2p_try_connect_group(struct p2p_device *dev)
 		goto error;
 	}
 
+	l_steal_ptr(hs);
 	dev->conn_retry_count++;
 
 done:
@@ -1570,9 +1571,6 @@ done:
 
 error:
 not_supported:
-	if (hs)
-		handshake_state_free(hs);
-
 	p2p_connect_failed(dev);
 	goto done;
 }
-- 
2.43.0

