Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CAF212D83
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299312; cv=none; b=PZXXiYfiPNQ4o/8AKfiyY7xCRip4vn7hBGcAsSJ8iT0qfT2/pAnSvcCm+5BjGqZzbyU0GOmlIX7Qz2TdIyH0W0BsF/ln1kzcPXhAq0r7tEWuFS85UMBWCFmk8PKhGQVQcxBNVrBYNNXIHaU1ISagPVlbjMI7KFGxzhk3IBfR4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299312; c=relaxed/simple;
	bh=3kAtaEp0pa4Gm7HEB9gBBGzJ4vEnDwy4HeX/Aat1dGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxXCy14A+wyCl3uiCcCrRW3FVl2BhI9X4EJJBl0wwcaJKnZHmhqaR+ZIfVzhNWIs5OGEtdq6ci7HsKr0rymsYD2M+1IR7Zkl7p7zFLhj75tJBUkV0EauIIDTsoQTs5RPJoV2qvC6c7PrRvVg5IVWt5EFnP4NNr4OkzU0g/rz6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZe5DDEj; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZe5DDEj"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso4767319a12.0
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299310; x=1756904110; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alIgJwrmTHXXKrnLAFl22+RZeoUD+45TPxrvi5uvmkg=;
        b=HZe5DDEjaRXnHrsEZM12m/9WVFcXfnfWHuDz08JWBJrY26SSq5WeaUPkjzQW4kh0HD
         7reiQqoHC6FgAL7g+39+qXKy0G1UzGWYwM3QSzzRIeLrWLoyawgR/sO53uBLYpZmzlr6
         7MwXEdJQZUdrMqrLqvJ76hqCf6AcO1ixsmkOCcDJHZCZBT0sBWz9C9Et95sYciz1dfdL
         Kq1+FZ1KzxV0+xXEnPlmCKASx163rJ7DPxHvnamzHUJNDOQ7le/UDc1KHMxu7vWdQPFm
         YJa/rTIOZXBSHyqALoXzaUSvX53hxVDIrYQNgeH6JYGFbX17+c7y/Tj0eCpMNtu5W4jX
         zGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299310; x=1756904110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alIgJwrmTHXXKrnLAFl22+RZeoUD+45TPxrvi5uvmkg=;
        b=PwTJf0CP6844ckKy4EoOQRbLy4az6hrdt+6abQpi/3Dly3yAvE1TJnyNVqj0wS20YE
         kBscCj5tG14CrV67/kcIy8rPyeuFsWVnSuoXwf7HkOqs100CakBnaFrENNPaVhRnqvwj
         I3czdrHSLt6GFwQbFUtv2PKDvfX20JUjbPO7FYw64bkFq1I2BTAjQljY83W4sYssVYo3
         WO0W4pIpaoO2JzAL6QmN1xWWcRY0L3QVDbwyYLscgQn4VfmEqvEWufet69BcZfm4IYjo
         wRuJDD5oJg0rMcHxZgxvbfScRd4H2VLncQbg50aeSv2ef45JNikAppPd2uRh3hk5ICCD
         0XNg==
X-Gm-Message-State: AOJu0YxypoYXK8GOUDNjRy8yoBaiXm415pRO2oDHzpYWQJ+MaRecdd4K
	96naGVFX0vt7JzLbkDUVo5A3CuZZjVShPE+6WSmozpnkTBM/h9ojCZ0QGDbn7g==
X-Gm-Gg: ASbGnctPNdBuMjYJr3sTrOrKfsCfq8w8+nxv6m1DBvvhs8HaRoMGgJ5Wt87RzDRsDQs
	XJVJp9wDgwCvfyJe4TP5L7lX9CVEZ+oKGBoXUHipvccUmqBPPytXFTnsJib4hgPe4yTE+OLdt1G
	3nBTSdBGlGmWa86f1fx4cQRU7D9ydLdiJ3KGhKIowtCuRva0AYOwsYlhOM39lNf+fomfx5gQdJ7
	79ennmjdhzZT5aolNAzYJkeNCetPyKOjtxTfK88ZgW7eibHkUyCyt/lMtTWr0u16XIwy1MQVVah
	7KUlRqO4bGxQpD7CUy3u8gDbsP4abbCmQ3QwC1vVow+k1sNd4hyW9uxY3PNwYzVGputhk28vVmQ
	evCDPWCG+gnebn0Kd6Elc8sacysUEldTiva+4WvelIEJKG/CvNo+FHo2Ypa9oUSabrfYnww7lpj
	UWNTMsS+yHY35WaSfcSlw=
X-Google-Smtp-Source: AGHT+IGYS9oXVfVyzy87LnbazP7uE6ftMNayPTfRxud6RdExCVR8AeLU+D15VHaNAGl9PzROIMWiQg==
X-Received: by 2002:a17:903:943:b0:243:47f:c41 with SMTP id d9443c01a7336-2462efae4fdmr240929235ad.57.1756299310394;
        Wed, 27 Aug 2025 05:55:10 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm121650955ad.66.2025.08.27.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:55:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	Michael Johnson <mjohnson459@gmail.com>
Subject: [PATCH v2 07/11] handshake: use vendor quirk to disable check of replay counters
Date: Wed, 27 Aug 2025 05:54:57 -0700
Message-Id: <20250827125501.477908-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827125501.477908-1-prestwoj@gmail.com>
References: <20250827125501.477908-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has been a long standing issue on Aruba APs where the scan
IEs differ from the IEs received during FT. For compatibility we
have been carrying a patch to disable the replay counter check but
this isn't something that was ever acceptable for upstream. Now
with the addition of vendor quirks this check can be disabled only
for the OUI of Aruba APs.

Reported-by: Michael Johnson <mjohnson459@gmail.com>
Co-authored-by: Michael Johnson <<mjohnson459@gmail.com>
---
 src/handshake.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index 02dfe2d8..ef1a8220 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -914,11 +914,15 @@ bool handshake_util_ap_ie_matches(struct handshake_state *s,
 	if (msg_info->no_pairwise != scan_info.no_pairwise)
 		return false;
 
-	if (msg_info->ptksa_replay_counter != scan_info.ptksa_replay_counter)
-		return false;
+	if (!(s->vendor_quirks.replay_counter_mismatch)) {
+		if (msg_info->ptksa_replay_counter !=
+					scan_info.ptksa_replay_counter)
+			return false;
 
-	if (msg_info->gtksa_replay_counter != scan_info.gtksa_replay_counter)
-		return false;
+		if (msg_info->gtksa_replay_counter !=
+					scan_info.gtksa_replay_counter)
+			return false;
+	}
 
 	if (msg_info->mfpr != scan_info.mfpr)
 		return false;
-- 
2.34.1

