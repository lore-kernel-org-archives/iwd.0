Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9B13E02E
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054477; cv=none; b=nlKhnUWvCdZhcklBojiLV1hl0Z08C60FHfb+3EvKM1uXyu6QDXLqXvZ0fn1cl9EOdHbbZUIwA++0LFUpfTVCx2VF9yQLqb9VEzFBokOdKRM/M4tu70wfuaTWo5DmBSVAUbI6qLoUObya0+sfwn3bDMrwbFEA8MfW3EEks6LHlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054477; c=relaxed/simple;
	bh=SSw2Nq7zPTb84jAOJ0zQy+P5NSu+fpk1vgOFdPo2GOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IpPhLTQ/jzZyTxZaHdVOFsWMkiE9Rd4KOEfEIqdbiwT6M3TQ7mIxfuqB4gK2j9/TOQXlgzDoKVBsxK4d8uIfFfPliHnfXHgq6B8o8wz3gWxT2Xbz60mNhQG/JmhcQKtK8hYAdYYuxoyTS3rgBZ7yHl2An2k/T3AHn0qqJWll+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLwowjP/; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLwowjP/"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70930972e19so45958a34.3
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054475; x=1723659275; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC6n6rinu7qAtnF7Q2mNVXJosOPkR7krcnvMsA4Cqn8=;
        b=cLwowjP/zTvonpMleKaXivaWJUIgwniISNu8NASSSUh0opqOfche6I6A0hwAQDHrY0
         OHxOWi/kP2VLJCJig5Ozi70sVPAuPTAZEjteUONHLXRZ9X7XQeoa4HcBFHzfF1LNbjY4
         oaIwMsIdHTWFkoLw2KhEIaEpQgMqB2bCl+MNwvlFj8L6xSTgX3PV/cBqv80tnIT3hqZS
         YlZig3GzQvdrmNKNbvwM6o+N03NgW1WyorGCU3qSeEdRbsHcVK2nvXwNncmj1rSgYsBx
         oyNt04jMw2g9I3sFXOgCiZbMJyYXj/4TX+mzmG9FEYSZrQxouDp1SRj7CU6QiSBdbDPP
         O8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054475; x=1723659275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC6n6rinu7qAtnF7Q2mNVXJosOPkR7krcnvMsA4Cqn8=;
        b=Y9bOJwMo1Cn5QX24IzTgT7ehBmOzq3STG2JUQiyNgSEPMpbxHDXYLV0x1UWp1NryDC
         8Asyt0phRkioEfsZgaubNSI33J1CcoTVWEum24ZxjsK80lIh5rUbL2iVOJA50/u2B5ye
         NcR4+M/YApsnxl0l1+Qnf355g1CwhJoQ4fe8GM6wdtKPffHv1IEEiex3GfD19CW6d8s6
         83bggUQHVhPnIIHCAmHwSXo+Sx26SVVZ/KY9bskWGBfKma51E62x8/sgRFDYx/6dkqkg
         LQCBs1IsxJit761RdAVQHJEMFSZmh0i2CvoHvmqWpvhgwVFUL979wqvrGbKJN64qDgwz
         JnYA==
X-Gm-Message-State: AOJu0Yy1IINOoClL1nu3OyvLfjRlv7fJVxCjOKpwj/kdiQFRri3p6UX2
	4tCPwMjPkrJSgOdMLkAzVSB9VDPIrsHjMHstVUJluqXFInclcrj+up8Uvw==
X-Google-Smtp-Source: AGHT+IFGrIAV3geiLRWdyBCN677nrkKiOTW0NJclPnEUxEiq+ho+dgWEqvSEYaYriuT8UwCnuGAC6A==
X-Received: by 2002:a05:6830:638b:b0:70a:92e4:6736 with SMTP id 46e09a7af769-70a92e46bdbmr23951566a34.28.1723054475395;
        Wed, 07 Aug 2024 11:14:35 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/14] station: use network_bss_list_prune
Date: Wed,  7 Aug 2024 11:14:15 -0700
Message-Id: <20240807181427.170515-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807181427.170515-1-prestwoj@gmail.com>
References: <20240807181427.170515-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use this to clear only entires that were not found in the newest
scan results.
---
 src/station.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index e373b03b..2c4d686b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -943,7 +943,7 @@ void station_set_scan_results(struct station *station,
 	l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, NULL);
 
 	while ((network = l_queue_pop_head(station->networks_sorted)))
-		network_bss_list_clear(network);
+		network_bss_list_prune(network, new_bss_list);
 
 	l_queue_clear(station->hidden_bss_list_sorted, NULL);
 
-- 
2.34.1

