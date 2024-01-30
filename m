Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E709B7AE51
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642040; cv=none; b=YqrOQ2QpQDf/KBViPvdeOa6rG1n6jBVpa54Eb9oxWggk2QENTYnJlsU3ptYtHJaCXWuI8Teu5oROQ/eSW63ILm8Uk7qfPIdUA/1urV35MELZfMJYjqKweFUaPSiR5yXBXU88aCQdqoNXLpc5/gSw6GCVv/oCZH2buryIr03Rm54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642040; c=relaxed/simple;
	bh=6FsYX5KHNRoQfEX4V29Y4TDRa6uJ2CLUjzATSgxG664=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e3/JJLKULB3wXfUEcY6fi3M7vTTx2A/bRpgshjP2LvVVUEIfHudEHtbcEjklaezEBw1fwFO5j5DqBLls9rr2X+SFsPx0uskHMaxN5x6cX4K4gX+PBHzBnmXPRV1e6TY4meRDE6/SFOexIiweQIgij5svckT1ygsBcrqwDMs57cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFvi+bvh; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFvi+bvh"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e13cfc0b2fso632485a34.2
        for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 11:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706642037; x=1707246837; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml3VHPJO2cHtZQNGsrjvaqiHyx9RM3d7ziJFuj3XSlU=;
        b=mFvi+bvhf6bEZAHvdK598ZiXG4Q3wiKXVTem+qId0wzu4b+nLjtlygHxpuhOrYusbj
         4WSRECUTeENUSR1Yb1EuFqN2JtaNKzf/gqC0XPfD02jZNiUCmZnT/YRP2XbnlINgLOpB
         44TZL6jwLWjWaYlhap9WvAQmJ+nesjZEw3PpFPIpMMXP3VGqWsBOYP0aVLqcAxqk9YaL
         loP6CfysAVzs/1INJHKifCvETd46KqxEUY6su1B2G7sWPNzSKwzIPtSZYCYJ5miBBDR2
         5PCArRCmDpuMguLOkhCB0XO9VCFKaKfD3Q7A70nh4Ht8BSm9yC821zJVe7dQ8jtZZBpK
         PDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706642037; x=1707246837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml3VHPJO2cHtZQNGsrjvaqiHyx9RM3d7ziJFuj3XSlU=;
        b=TX8j0FWRQSua68wNykW+TEuao6HKGnHfP7jnbaBLlRJp2I+5NRbDOFsD46xUwMSYjV
         GgeA4KYUFS2fHi4GbhULMWvn2pOKsuktQbyK45pT8NqqR9O9a8BBhYdWF8A5e6lEiILd
         Bfk8xUm7I2UCZxquN9fyTuxVGDUowhn5Tqyl1K83CR6ik4nR2ks1X+GdOfRJhqtpqbYv
         IJqioatXT4vyrCUp24SF6mQ93VzN+zgSUZyySlwtoywePXQnSihCn0nFDswtJ30jo0yl
         WHsHRBftHCwWl3qiI5mhbgmVcIOa4YZw3R0xSyOsr6m8/IY8KEkzqgd2aQ3IEfJ3mZpH
         S6qg==
X-Gm-Message-State: AOJu0YzfbCS3KDv9ocZ6XLQreiU3CiFJmr0k4G6A9ZbvRt9LCwP6lL1i
	QoKj9TtBztfwfztQbrx8yxB0TDuJYC/qwQd5eRtN22sUffEqhFBEZJ3EGJX/nnM=
X-Google-Smtp-Source: AGHT+IHDtLYghACeF+k1mAk6WgrjskAPOdIwh2w1zzMvVMNir6B6/mLZOI3HGxGlbSlXId8oZNMBww==
X-Received: by 2002:a9d:664b:0:b0:6e0:ead6:5206 with SMTP id q11-20020a9d664b000000b006e0ead65206mr8506350otm.29.1706642037541;
        Tue, 30 Jan 2024 11:13:57 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ie7-20020a05622a698700b00427fabefe3bsm4716110qtb.52.2024.01.30.11.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:13:57 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] station: reverse roam scan results for sorted known frequencies
Date: Tue, 30 Jan 2024 11:13:52 -0800
Message-Id: <20240130191352.85852-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130191352.85852-1-prestwoj@gmail.com>
References: <20240130191352.85852-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The known frequency list is now a sorted list and the roam scan
results were not complying with this new requirement. The fix is
easy though since the iteration order of the scan results does
not matter (the roam candidates are inserted by rank). To fix
the known frequencies order we can simply reverse the scan results
list before iterating it.
---
 src/station.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/station.c b/src/station.c
index 8a5f4e18..ea505ca2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2636,6 +2636,12 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		util_address_to_string(current_bss->addr),
 		util_ssid_to_utf8(current_bss->ssid_len, current_bss->ssid));
 
+	/*
+	 * Reverse now so the known frequency list gets updated in the correct
+	 * order (via network_bss_update).
+	 */
+	l_queue_reverse(bss_list);
+
 	while ((bss = l_queue_pop_head(bss_list))) {
 		double rank;
 		uint32_t kbps100 = DIV_ROUND_CLOSEST(bss->data_rate, 100000);
-- 
2.34.1

