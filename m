Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C22260B
	for <iwd@lists.linux.dev>; Fri, 26 Jan 2024 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300571; cv=none; b=EK+iz2J1ZXqcBRdDErgn1Kne21hyxGseRHU6u6/DHwM/K9VG0fZCjPs6rl/1EZr6mCFs9+CUOGnRmJ7dx6dOKN0YoS+8DmS8tjrUwtYRC9J1ubHCDaqdwQbp007+PDZG1JO8asB9Oxebjl5jcp3+L5u/K8BWFNSbz94FHGxcO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300571; c=relaxed/simple;
	bh=W4iMwkE9iQ02GeuGwH8BAo68hrjmStDaoPV5BDUIwu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/BFsQXSc71LbUQDXW6PnARJDXqCPTNbXGO8fsqW77hVyTBxNq6QtxT1VyOiJp/DM0z31FwA/8c1KY6sc4PDp/N2zBksQqG14okRcNQZ+pnqFIQzU5LIbakWJcB+r8h7vQVmELjyQGtWsXM7URu/oLViekz53/YkKhDseAVKNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVxysvV8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVxysvV8"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4298b23abffso6753501cf.0
        for <iwd@lists.linux.dev>; Fri, 26 Jan 2024 12:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706300569; x=1706905369; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs3+rSdiYsZ+AL1JTeDJXl9LKEZVoBz4NKzp2eGlKfc=;
        b=RVxysvV8rkI1kF4fz/QKo9ApkC9VTcTV0wNu/Fq7yaRokFXOLttQgOmfu4g7i1i7vb
         p1nOhU19z/ZZQ72r6W0qiuRWsMIpFdKaK/ND5tFaneboxt9xzBT58oe/fmhM1EfvQKAK
         RB3iz198yPWn2vtVxEvQQyPu5u9qNm39Q5o6a0AjfYIzDEupH+dffe9r0Md4B6CscP9O
         zIuWrcdxFRdqUhZ+us73rWJb3OXVzlXoE/N81lbuMWE2+K4LJGKL83DaWtH7iah5TTeF
         SnuFLRsgH+NWqButy79Yuyep4hlmLK3ZdtqsFOY3srnbeAdW/ACc491fn12AOi0ISR3d
         JR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300569; x=1706905369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs3+rSdiYsZ+AL1JTeDJXl9LKEZVoBz4NKzp2eGlKfc=;
        b=Y6zS2HkzfMbfp34D1Cbnnha09w9Y9J8ptCNuMHTtYTaBWOywddSOdzppIHZRhfNzgj
         vzN+OQCsFMkoDBWmy7vm4oafHfl1uGBbneP0iYI/8vhZW3oUSKU54cqZwt/8Ra5CEzWa
         uycdH4VYZTYTYb4lVEwEAUvOKvQ/255agL4iJ90O3bY8BrehQBLD1YM8qVbn84Iwj2Bb
         LdV3Rb8kqXZHF81Y7M1mJ8tAtPmfzjXelcmDmiGt2RrefWU5UIrjmPTXZGKNEgbA197a
         COdWQprPgmxfCnnMSPPaq5viigcAU0E0DC3M9VDQVnlGOPUFsa3QySkAeHysqA9pQyjY
         ftuw==
X-Gm-Message-State: AOJu0YyPv9aaDMtf50AM5Y7DTM3EnFZxozoUQm7IncnPzWO5OZ83+MzE
	Y8YyB89qyhfPn8WuKbW0/Htv84viSL5Yg5qFBbSUEeDTGgbmuDXruBT0mVznDpU=
X-Google-Smtp-Source: AGHT+IGpzN+WPE/FQSzk29et12yV9hj3OkK2c/6nySvjhLm9sOLUVhgyQYMbCPYaVc0C7ZGWjukr8w==
X-Received: by 2002:a05:622a:100e:b0:42a:75ab:ff09 with SMTP id d14-20020a05622a100e00b0042a75abff09mr413667qte.74.1706300568669;
        Fri, 26 Jan 2024 12:22:48 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id fe3-20020a05622a4d4300b0042a25f3950esm826463qtb.75.2024.01.26.12.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 12:22:48 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] station: use network_update_known_frequencies
Date: Fri, 26 Jan 2024 12:22:41 -0800
Message-Id: <20240126202243.91947-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126202243.91947-1-prestwoj@gmail.com>
References: <20240126202243.91947-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates each network with its new, most current, set of BSS's
for the different types of scans: dbus/autoconnect, hidden, and
OWE.
---
 src/station.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/station.c b/src/station.c
index a6442d3e..b186c505 100644
--- a/src/station.c
+++ b/src/station.c
@@ -350,6 +350,8 @@ static bool process_network(const void *key, void *data, void *user_data)
 		l_queue_insert(station->networks_sorted, network,
 				network_rank_compare, NULL);
 
+		network_update_known_frequencies(network);
+
 		return false;
 	}
 
@@ -799,6 +801,8 @@ free:
 		scan_bss_free(bss);
 	}
 
+	network_update_known_frequencies(network);
+
 	l_queue_destroy(bss_list, NULL);
 
 done:
@@ -3684,6 +3688,8 @@ next:
 		return true;
 	}
 
+	network_update_known_frequencies(network_psk ?: network_open);
+
 	error = network_connect_new_hidden_network(network_psk ?: network_open,
 							msg);
 
-- 
2.34.1

