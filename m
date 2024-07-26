Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E293987B
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016925; cv=none; b=gIetqZo7gJzCr2xebTJZA/D6yYEr9keVYshhh0Z5xTTrbUYu0kcPgAZQdRzP2pi0V7nALJDB5Ss1EKxtTy8y0e3vc2DmwlSmewhKQoFBsk+nqNZQWKUwTRzXvEagy5PhLSlEYtRYSsugClgELYya73X7nzFAdG2RgeyNxUI3ews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016925; c=relaxed/simple;
	bh=7zJusb69k140r21nHVW4UxozIWxBkc5LUReVwSFjqxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cf28rvAVTwKLvWYIqdPG1Rm0pMmGayKXJgBn26BXLYr/aur5jBgOFKW+E/+Vit9xvZERtN53D1AKnctfOULy/0GBSU3iBZ1lDwFxeo8IUXux2ibhpfJUqGID4BlmMoAX9g59icCK2LtYn6xU0qPPQ6xlgdMpqyetorO5gxp6Iqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTPrDm/0; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTPrDm/0"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fea2d40adso5977921cf.0
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722016922; x=1722621722; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvcG0Xm+bCBh7iuKYU4k3BgYlEk1+pMHhaLMzx/1EOs=;
        b=kTPrDm/0vF+ylMBz7wHgq5j0Jd8X/t+MLu9PjFaKsPTglB9fLYZ1NHJBlrFVZNud27
         0kKeoxMWSFogVJGcptqVc2Il36G68leHPUwga1v2x4JTIQfgv6kljw6Y3i1ZQCfNoCp2
         J9W/4ulUl37G4q0ySqpi4rP23wRa36b8nnEsHfSsvHWPnjeIMh/Y73IAw31i5Bj0XAia
         OgoknfkiKU2wBFV/pmMviUltr4X+Y1a9Y6j8jq2FrGFz7b/6nnX/SQl7HLTm0HwaryS1
         OLLjYHqkqSbckMC9XYSCM+/7Aobe3jf50ALPMGP/+9e9QnHdxoUXm6l9vHMw5wbDU+BZ
         3Keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016922; x=1722621722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvcG0Xm+bCBh7iuKYU4k3BgYlEk1+pMHhaLMzx/1EOs=;
        b=izvFH65G2bBX2h5uInCb2P0eA2C4vHeifd1zVJ5U7p3sjWpv2U/bMPv6DeJmF48/BA
         swlrvVN6bUX1SQuyMrFsPGbYXOpm4vG/5RbD7oH1G68AfOJ7P/FDiYG9Y6Mx/9kKzfAW
         G78aVESwFJYeDBT5oGtw6hrsPfpBu3wl3Zar7ZyztdEp/Ku4OrIP6Qh+PfSwTYiRTiGu
         shoqCxgfpDS/gnHC7C/0R+DJU8cvXWZLEweYbs49JLK0Z+rcEHWFyTdu1uawyAsRSdwq
         pVBXiP0dAx0EsVo1VY4Rr5dmfH5oV45bO7mCfqbZzUZ+3jrzKtG/2Y/IQ2ztDtn30RuO
         X/og==
X-Gm-Message-State: AOJu0YyA/JreILD9dtT6uEFxVEOuc5gdk6+JHz4LJQDSQoBHbz3FPdWQ
	IBqlWud8Vf7a7Px/MRyYSBVotgztBJGCy/yjHs8iZ/8A6d8bbkNaJGIQSA==
X-Google-Smtp-Source: AGHT+IEKOgIq+B5OY12p9ytasEIsBR33F8q6pH2xdMHHf31c4Do1HkC8hT1fBWNoKYSKETucEPh4Cg==
X-Received: by 2002:a05:6214:4106:b0:6b5:4865:948e with SMTP id 6a1803df08f44-6bb55a4642cmr6048426d6.32.1722016922155;
        Fri, 26 Jul 2024 11:02:02 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8fccc8sm18877166d6.46.2024.07.26.11.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 11:02:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] station: don't allow FT-over-Air without offchannel support
Date: Fri, 26 Jul 2024 11:01:56 -0700
Message-Id: <20240726180157.1654827-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726180157.1654827-1-prestwoj@gmail.com>
References: <20240726180157.1654827-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CMD_REMAIN_ON_CHANNEL isn't supported, don't allow FT-over-Air
---
 src/station.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index db069981..44f8d33c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2004,7 +2004,8 @@ static void station_early_neighbor_report_cb(struct netdev *netdev, int err,
 				&station->roam_freqs);
 }
 
-static bool station_can_fast_transition(struct handshake_state *hs,
+static bool station_can_fast_transition(struct station *station,
+					struct handshake_state *hs,
 					struct scan_bss *bss)
 {
 	uint16_t mdid;
@@ -2032,6 +2033,16 @@ static bool station_can_fast_transition(struct handshake_state *hs,
 			return false;
 	}
 
+	/*
+	 * FT-over-Air in its current form relies on CMD_REMAIN_ON_CHANNEL. Some
+	 * drivers do not support this so only allow over-DS if this is the case
+	 */
+	if (!(hs->mde[4] & 1) &&
+			!wiphy_supports_cmd_offchannel(station->wiphy)) {
+		l_debug("FT-over-Air needs offchannel, using reassociation");
+		return false;
+	}
+
 	return true;
 }
 
@@ -2495,7 +2506,7 @@ static bool station_try_next_transition(struct station *station,
 	station->ap_directed_roaming = false;
 
 	/* Can we use Fast Transition? */
-	if (station_can_fast_transition(hs, bss) && !no_ft)
+	if (station_can_fast_transition(station, hs, bss) && !no_ft)
 		return station_fast_transition(station, bss);
 
 	/* Non-FT transition */
-- 
2.34.1

