Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D8F208A5
	for <iwd@lists.linux.dev>; Tue, 10 Sep 2024 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995020; cv=none; b=sEG0Gwtl7AnR9Wkdo/WspH6KVTdgPV0bYZKyGGI+e9nGCl9kjZlK4/S+0afxRShhd5rciFlLGwGzaUa8Y8lfUMM6SyIFm9k1yJSI4LAIZMpSmPEqHj35wlSpV4bPCiKWQh8tWX6OcgCltfpBbkPWFvz/dF+Lveu3u5flGF51r7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995020; c=relaxed/simple;
	bh=eQC94XKYiYEXwkAzLiXaLnzMhvpQkoqcDOTCITGN/eg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nAfeHt7u6ZRjMp31zgsu5YG8EsTJ+au5d73WW64PrunJqKj8X7B2GDNtYBP0ztEsJzSJJDU86revtp1N1qq4favR5a61iSViGt/uPbTc1ejg9f7nwFGOGkCxmdD/s3G3+Q6I5DPNZwBcFRdsUPGQ2W0e+rnQcD3vmT2lDqjusAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdgOiVnE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdgOiVnE"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-456757d8871so35354761cf.0
        for <iwd@lists.linux.dev>; Tue, 10 Sep 2024 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725995018; x=1726599818; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwI9RL+ciErqYJEQXpJmf0GOJnxpcMjPr5Q61MEz5GQ=;
        b=hdgOiVnEzhN4iIzvK96AmI9+3zrgBlLjJCgN3/1bRa3uhhjtgbhRA9Xxem6WfLJ5ui
         FdjVam5t9aewTdNv8HZfWOf4sGNCf5f2j/8oluk6or2ePnJANYeNR11Ro5NEqaTLxJek
         V6bqUu37b0xA8u7gyxdzicWwwRulWSsQirTestvdIUHyT8aX+AyvyEdTvD3Kj7JSzcFR
         004j2fH9SVL/rvxjLVv0l7sKKdkutR5zHzXk1O5E0xQn09hw+FY/5TNKxDZGw0zSdc+t
         s7r2Kr5GK/qdc2Hi33reDbVdhnx5wvM9b9vJD8TjS4HMSHi00GoQZa5Itzvd4tcrh3K3
         JM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725995018; x=1726599818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwI9RL+ciErqYJEQXpJmf0GOJnxpcMjPr5Q61MEz5GQ=;
        b=pNUeG2hp+2+iCEbcigAr3vuyHaFFYsAtGUc5IfRuZ4GjhkN8vACTi1YnTT/M8Zy6t6
         tZTjiQmpp8w2RB8tlk6IINqv65LiyeTnjcObyLVlM3J7d/X95XLfSS/LQCDO337pwi81
         qWWPuXUy0A5SAsfv77ycYi9C16U18xzNtxegzHVXOkqkIwyGinSdZw/cBZd8SefmqcA1
         Ql+/KejVZP6GZAUzL4OEe99cG+nLMvjdtivbCnYb7+hAc5KarJAYtyl0hPtWanAr9ufR
         Uu4fw38hP3HqD08+H2aj0dRMHA/9D9J+fO6DpWTtsgEewPDYa+BjJSA2Ju67UCV2EnOR
         VB0Q==
X-Gm-Message-State: AOJu0Yz8J96/bDOiUhWy9nUVlyyifsq3UHJZfeIImq/WkzN89u+63070
	lNZCMPpsy80Ag4KQCSkNlpnyDE2Rfqbhr/8Pt1yJJS3QH3uTdbPK75EPTA==
X-Google-Smtp-Source: AGHT+IGXK/dCAncRxbB6Cl8crmnPCGHgT9TiEoDZiSlHDJ+BukSWSi8dpXMKIW+rxGKI23O7OjEGSA==
X-Received: by 2002:ac8:5a03:0:b0:458:3ac9:11f2 with SMTP id d75a77b69052e-4583ac914e0mr80965931cf.31.1725995017925;
        Tue, 10 Sep 2024 12:03:37 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f93978sm31558431cf.83.2024.09.10.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 12:03:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: emit property changed for connected AP on roaming
Date: Tue, 10 Sep 2024 12:03:34 -0700
Message-Id: <20240910190334.128166-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was only done for connecting states, but needs to also be done
for roaming.
---
 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/station.c b/src/station.c
index 44f5f771..550ef745 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1767,6 +1767,9 @@ static void station_enter_state(struct station *station,
 	case STATION_STATE_ROAMING:
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
+		l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
+				IWD_STATION_INTERFACE, "ConnectedAccessPoint");
+
 		if (station->affinity_watch) {
 			l_dbus_remove_watch(dbus_get_bus(),
 						station->affinity_watch);
-- 
2.34.1

