Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE225752
	for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo1I8PNc"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb6ed2b913so529096b6e.2
        for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 05:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703078112; x=1703682912; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0R64pEBzdlh+5LwtZ54IZaHpQJGU09o1WLlkirc0ISs=;
        b=Fo1I8PNcRldQlGFqdflrAAGC+cWjYMpkM+wj8GtaXidkrdRoVBw46Zd+PJJtwzAkQc
         1tzcPwKggMEPCfvg5OTxSERKmtjVbsJ+cpK6TNJ6U6NMP5QVp1Mgxbcj8Vkp498M3yQp
         DFj8HsIVxVYG9u9gd+gTtNrxmAdBYXKr+JIHZVOkaVM65sv51XmjjyzClNFIVMFD/OvW
         lGaHGdxe/PNU2FeuKKnsKkx+0V9Gt1WHF5+/TJlTjNQkKxuUMQWzbN4Wt/VWOK5hMvDr
         bir7IDImxgmDDVMuJ2njF7VAB8VIHnISHDhCc37VmwDVZAcCgap/w7heDybg/DR3BRxB
         0niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703078112; x=1703682912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0R64pEBzdlh+5LwtZ54IZaHpQJGU09o1WLlkirc0ISs=;
        b=hE8WKvZEGVlncICAM04H0+F9gjf+I5kHdFKvmIsoOI86p8bZ0zl3Fmroi5gVHJq7mt
         a8EXFwhnHpQ1lfZ9eCXqvJJ5lRRHI4znK02iekW0ErYvakIMYN5SI3cgtH7+kMdwRGQ0
         fiDdSVKYcMPJzIMkWEbt5Gs7YkCHLPhXTLcJBB8NBe9c+BGyzJAjvZcVslazVbFRYpmT
         PCJKosuH6ca8xSOEWJBCuYu5VzAMyvzXtu7osDKD/r6XzcpcgGEB/onjG2dJImYsMyvO
         QFblrSUKpk3qyE+ovL7fvYRvWfJbXHCphsLwRsK5bL8OmhoeZceJCVaJQ48s7TUPEzIz
         e46A==
X-Gm-Message-State: AOJu0Yytv87/EAJmKKOJ3VMPfsatDaHn+tYEurWdkrn2mJqPvGjxozB0
	XlYLcJhCyfeD72sE6GX/vzUPbnJlwvk=
X-Google-Smtp-Source: AGHT+IGWWrQciDjMOlM0v1Uvvuzogrr/Nh3pcS+8gYXwcj+NKjgpbe5jwHMf6DweNMMf1HxMkbUSRw==
X-Received: by 2002:a05:6808:2e8c:b0:3bb:6e0f:4e6a with SMTP id gt12-20020a0568082e8c00b003bb6e0f4e6amr1871906oib.103.1703078112440;
        Wed, 20 Dec 2023 05:15:12 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id cc7-20020a056808324700b003ba4d1225e6sm1467456oib.45.2023.12.20.05.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:15:12 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] knownnetworks: limit 5 recent frequencies per network
Date: Wed, 20 Dec 2023 05:15:09 -0800
Message-Id: <20231220131509.267549-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since this is meant to be used for quick/roam scans we should be
putting a cap on the frequencies scanned. For large networks with
many BSS's this could end up scanning quite a few frequencies which
isn't very 'quick' as it should be.

Since the known frequency list is now sorted in most recently used
order we can grab the first 5 frequencies per network and be
somewhat confident that this will result in a BSS to connect to.
---
 src/knownnetworks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

 - Whoops, this did not make it into the original patch set:
   "Reduce and optimize quick/roam scan frequencies"

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index e44109fd..ecdd79a1 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -540,10 +540,12 @@ struct scan_freq_set *known_networks_get_recent_frequencies(
 				network_entry = network_entry->next,
 						num_networks_tosearch--) {
 		const struct network_info *network = network_entry->data;
+		uint8_t num_freqs = 5;
 
 		for (freq_entry = l_queue_get_entries(
 						network->known_frequencies);
-				freq_entry; freq_entry = freq_entry->next) {
+				freq_entry && num_freqs;
+				freq_entry = freq_entry->next, num_freqs--) {
 			const struct known_frequency *known_freq =
 							freq_entry->data;
 
-- 
2.34.1

