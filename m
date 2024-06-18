Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931613AD12
	for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729953; cv=none; b=UcgDm4mTUk7tNVtt6XUKeOz0r3wgfR/TnlH6W4nSdb69/WIGRZt5vHb/vfl/I1mqbQcW6moOmt3kBWOAxOFLnTCPvD4u6c3/2nJHgClUuFKzrYFynVTiAl3s6Sqk3hkyT40nOwBmexNHrOd71t0VPHCeSdcYcI5Q3/R4U5eTHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729953; c=relaxed/simple;
	bh=d4aQiARAjHBxBw3HNTLNiEesJ/4Ik0DfP7TPhYRIqYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/Hw3SoQlDRG622dCZCxuJ7ykteH6+r2puZY22hbnUKCmEm7F0w7h8mTJ1JSnT6JsEWS5OQ+R0PYNorhdYW7QnFO8KK77doBSQZTOXIERcykNVyl0U8RqdVMvY+fkRao53NfYpjPLJoLZPI17zjJjGcS8MjwBBzK23aS1MIbfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh8bdcrN; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh8bdcrN"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7955ddc6516so400077785a.1
        for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718729951; x=1719334751; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YugUbaB++Sy+7ZvVbpCjBKUT8aoIJZhlP/HBkUlkHjg=;
        b=mh8bdcrNMvRSHnJ7LeEKW0OAaBPOFDCUqet+PWAJOILBiQYFSjgOfT6qiP5BRayiFN
         08yZ+jGq+uzZElPxbiiBMpoLfdpwAtDRPazLvJaLt7R5j34OGfRpNXme2ESG0EqR5JUB
         Usl6O9BaL/QjkwkMMvqtnZ9OTCS0i9+A5Bw2ZEZQ8S1mipYWX+4CHV2twYD8brSskQZX
         ni2tj/feKJTnsQG/wd+I6JUHSecCG2JLaeUlf+yWP8i3n9zKzs4bp5opNuHJ27MRWz9F
         jQsODQSWFYF3VybdDWpbSY1M+RZwVyoctXXmeF1G0vtVMCWh0kIirbHKtSuT2iY7WRjI
         FH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729951; x=1719334751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YugUbaB++Sy+7ZvVbpCjBKUT8aoIJZhlP/HBkUlkHjg=;
        b=PWmUfiuyH7Qm4sh/KFTN+M2g2tj1CaoPLzQM8GCHSQ86oOO/k0jLN7QybNfxE2FtjP
         I4pKT7KvoF07HKrKzrYsY/tToYynP8beCTu+Wi9RVg7FTlZTXAM8XZAJXNIxDdzkBPdd
         ywwJFmVNhXFrdk5Tsfjam7cWol7psDH17U70gGKEriSKuhVzfBvaWdRRcrf00C2J5S0S
         1P/p18MHmdRt268w01fupksm/h1Kr6ZuPqtAAQHkj/0G24lQa80V8988qhlOr7AOOgvE
         eUBDRbUU5MBBN3yLDDdJvwhxzlz7/f8sKWb+Jvy7S67tZjJE9+tZM8rCTjMvs0F6CErr
         7Zwg==
X-Gm-Message-State: AOJu0YxY/QZ+5gJHTV6Kr6nxMlltnANP+tkEHgikjGq3xCFNjwbND8Z7
	BX/1uqCPjt5UQZxvN3CUxemS4vsd6w6x2PvO5pxQGkx8AmaD/+MPN3Al8g==
X-Google-Smtp-Source: AGHT+IG7AUVQnRTafTcFJODn51tADr5q8C9bQNFU+yY6c4R+lXU5HuLikr+Lon/KF1dlSpe0aTXZ1g==
X-Received: by 2002:a05:620a:4506:b0:797:8ee3:9f01 with SMTP id af79cd13be357-79bb3e602e0mr25128785a.34.1718729950113;
        Tue, 18 Jun 2024 09:59:10 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b49e4c82sm533688785a.88.2024.06.18.09.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:59:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/10] scan: add flag if BSS load was advertised
Date: Tue, 18 Jun 2024 09:58:53 -0700
Message-Id: <20240618165854.113598-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618165854.113598-1-prestwoj@gmail.com>
References: <20240618165854.113598-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ranking purposes the utilization was defaulted to a valid (127)
which would not change the rank if that IE was not found in the
scan results. Historically this was printed (debug) as part of the
scan results but that was removed as it was somewhat confusing. i.e.
did the AP _really_ have a utilization of 127? or was the IE not
found?

Since it is useful to see the BSS load if that is advertised add a
flag to the scan_bss struct to indicate if the IE was present which
can be checked.
---
 src/scan.c | 14 ++++++++------
 src/scan.h |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 76ea379b..5091ad77 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1344,6 +1344,8 @@ static bool scan_parse_bss_information_elements(struct scan_bss *bss,
 						NULL) < 0)
 				l_warn("Unable to parse BSS Load IE for "
 					MAC, MAC_STR(bss->addr));
+			else
+				bss->have_utilization = true;
 
 			break;
 		case IE_TYPE_VENDOR_SPECIFIC:
@@ -1533,7 +1535,6 @@ static struct scan_bss *scan_parse_attr_bss(struct l_genl_attr *attr,
 	size_t beacon_ies_len;
 
 	bss = l_new(struct scan_bss, 1);
-	bss->utilization = 127;
 	bss->source_frame = SCAN_BSS_BEACON;
 
 	while (l_genl_attr_next(attr, &type, &len, &data)) {
@@ -1704,10 +1705,12 @@ static void scan_bss_compute_rank(struct scan_bss *bss)
 		rank *= RANK_6G_FACTOR;
 
 	/* Rank loaded APs lower and lightly loaded APs higher */
-	if (bss->utilization >= 192)
-		rank *= RANK_HIGH_UTILIZATION_FACTOR;
-	else if (bss->utilization <= 63)
-		rank *= RANK_LOW_UTILIZATION_FACTOR;
+	if (bss->have_utilization) {
+		if (bss->utilization >= 192)
+			rank *= RANK_HIGH_UTILIZATION_FACTOR;
+		else if (bss->utilization <= 63)
+			rank *= RANK_LOW_UTILIZATION_FACTOR;
+	}
 
 	if (bss->have_snr) {
 		if (bss->snr <= 15)
@@ -1734,7 +1737,6 @@ struct scan_bss *scan_bss_new_from_probe_req(const struct mmpdu_header *mpdu,
 
 	bss = l_new(struct scan_bss, 1);
 	memcpy(bss->addr, mpdu->address_2, 6);
-	bss->utilization = 127;
 	bss->source_frame = SCAN_BSS_PROBE_REQ;
 	bss->frequency = frequency;
 	bss->signal_strength = rssi;
diff --git a/src/scan.h b/src/scan.h
index 0bfc9e47..06753b82 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -91,6 +91,7 @@ struct scan_bss {
 	bool sae_pw_id_used : 1;
 	bool sae_pw_id_exclusive : 1;
 	bool have_snr : 1;
+	bool have_utilization : 1;
 };
 
 struct scan_parameters {
-- 
2.34.1

