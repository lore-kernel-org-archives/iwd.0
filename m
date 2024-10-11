Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9FD2E403
	for <iwd@lists.linux.dev>; Fri, 11 Oct 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658511; cv=none; b=M88ffi5mR/pt6Rp4KTupiQoo+I6jMtfEheBro7hiWPHRukShNxTEp24kca1VBEHUq+LRBlqZMrfOw8LgN21xg25oioWrgCa+RvuGsohf7WafuqU/x9oEHUZds2Hw2t6QlzOPELe5Ui8N3OHUmDQgFdE9eoVJ9W//7yKxy7MutVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658511; c=relaxed/simple;
	bh=5CDZmbxrVpz9lET0dEhmwoGyc5c7ontzE4IwXNWyMw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q4OmijwkM1rk9DGb1gPKkaowVQRAd9unt46aBmdxSrUBslK8pwdYUqNecJJPgUXrtQBK7S/4aWqrLn4Q3BO+qPawjgOOnSNuUFPDGh8ab/6ouTgLYvaI+m9spWVA2QfBoSMVBpo90Tm18fZBIwyz4rewolw2/EZLnuH1jV4+8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcfoLr/w; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcfoLr/w"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7afcf50e2d0so102181185a.3
        for <iwd@lists.linux.dev>; Fri, 11 Oct 2024 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728658509; x=1729263309; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeHSqcYa/f4xVt0Kk/K3O/sTroZ2vwv3x7fDA9BwyYA=;
        b=ZcfoLr/wUP0JaocEMmWAl/E37m05Z52vxKiqCjV7f8APV+skFpVdBdgKImZ9wBjCWB
         HOgoGlBlbHy4EBNFy7H44GDIuvp8dEjckuKF3CrjBHMktyKBuGUXVaRQ8IcJZE7S4gXJ
         fXYAEUbSqQPe8NE+4YxCjNwugTZJLjio1g0vYWnXKD9oZvwuWOgKxWCDJd7gKz0AUoM2
         Oy0bXGcK2XH4c/vnJXIUqOdkUFBBKTuSxiFreRI8SZSSYMD4hJppjJ9IJ9Jd4853H3Vj
         tDQ0I8dcjliEbsrs0F/blUkPwwdtwNmlUDu2V28ZoAoohyvLhRNTDWFYvoW8xwhAs4xS
         NZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658509; x=1729263309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeHSqcYa/f4xVt0Kk/K3O/sTroZ2vwv3x7fDA9BwyYA=;
        b=NZGGxCapwSanoTPSx1hRLwPkktT2nXRzP+xCBGi5R1KhUebE72l+26FC2XweUB9e97
         VGO9p2zMeUY2SgIotX8kz6s0joTx+SRVn16js0UdmRCi8mmhyk0Hn/0xP8VHlSzEBC4/
         q1tj1ziftgJow/cQ8aOCFiJGDZUgPMPwWEnPHgWnx6+LR15kJ5j4lAUEEZqB48nK3q4a
         MmTACJ/GQBm/HKBd7EkVQNltNoC3IieHPrDNH+YLW+9q83DjWHbBfFDhntg8BS/iDgs2
         SRnMKjynF9qJLRNIMfrhT95cz3HkkpjboeY/APd29XE0MBdSj6BU8QCMAODzMn//AsA+
         rIMg==
X-Gm-Message-State: AOJu0YwoBrC3N/OKqG1m9GImKY27j5zykfF80+5f+DtlIRm2VfaaZ+X2
	R7eE7TtxvEJRBdMo1/t7EW2E5c69z9tRq4f6L1JYrhyUXrBgP6krcEBsEQ==
X-Google-Smtp-Source: AGHT+IFtDUQdafKUhkS7sz+KP6l7+9k/WNLM0+UU5E74kh6rx70cWInjuY4L08cOakFAqZ957AZ/Sg==
X-Received: by 2002:a05:6214:4a81:b0:6cb:ee7b:7ac4 with SMTP id 6a1803df08f44-6cbeff80f35mr46193076d6.3.1728658508789;
        Fri, 11 Oct 2024 07:55:08 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b7767sm16157216d6.34.2024.10.11.07.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:55:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] station: check if authentication is supported via CMD_FRAME
Date: Fri, 11 Oct 2024 07:55:03 -0700
Message-Id: <20241011145503.51330-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011145503.51330-1-prestwoj@gmail.com>
References: <20241011145503.51330-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the driver does not support this don't allow FT-over-Air as
CMD_FRAME will fail. This will downgrade the roam to reassociation.
In the future IWD could instead use CMD_AUTHENTICATE, but thats a
larger change. This will at least get these drivers functioning
better.
---
 src/station.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/src/station.c b/src/station.c
index 9ebed8e2..b7905c4f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2162,14 +2162,29 @@ static bool station_can_fast_transition(struct station *station,
 			return false;
 	}
 
-	/*
-	 * FT-over-Air in its current form relies on CMD_REMAIN_ON_CHANNEL. Some
-	 * drivers do not support this so only allow over-DS if this is the case
-	 */
-	if (!(hs->mde[4] & 1) &&
-			!wiphy_supports_cmd_offchannel(station->wiphy)) {
-		l_debug("FT-over-Air needs offchannel, using reassociation");
-		return false;
+	if (!(hs->mde[4] & 1)) {
+		/*
+		 * FT-over-Air in its current form relies on
+		 * CMD_REMAIN_ON_CHANNEL. Some drivers do not support this so
+		 * only allow over-DS if this is the case
+		 */
+		if (!wiphy_supports_cmd_offchannel(station->wiphy)) {
+			l_debug("FT-over-Air needs offchannel, using "
+				"reassociation");
+			return false;
+		}
+
+		/*
+		 * TODO: if drivers don't support TX/RX of auth frames via
+		 *       CMD_FRAME IWD could choose to use CMD_AUTHENTICATE
+		 *       instead. For now just avoid FT roaming and let these
+		 *       drivers roam via reassociation.
+		 */
+		if (!wiphy_supports_auth_frame(station->wiphy)) {
+			l_debug("FT-over-Air needs CMD_FRAME auth, using "
+				"reassociation");
+			return false;
+		}
 	}
 
 	return true;
-- 
2.34.1

