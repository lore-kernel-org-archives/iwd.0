Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCA16C849
	for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672978; cv=none; b=qFcMSswCk/+VF+hN/BLk2pPOJGP/0KGl+msxUV+NNsuzGOEXJ09ymw2QY6+5qFRMQDXfTGx/A7sMacsqI/x27Dixye1/frV6hr3nIPdZ5Nk4RBTK2vbXxxZxQi/R0mysVCm6qZ5odXQA0K+mkPoy9q6rrkOlsSpi0s0pVT7a3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672978; c=relaxed/simple;
	bh=KovdUaiRySIwerb98Kd+zhsa3wjgebvYTwUnK+k+Em0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ECA8TG26tWJbXszQH5aE4/KdIp/HveX9YpsLt8aChPrbCZ8igXvrT8SWjG1wptyddUyCT0dpUv44wcoYiCgkYoUNnEhKugIKl9HQ5ifUllZEjDIDS6O2Z1w9uUwk/46uHZwlPkAcUHuP4LzysiPWIiv8+g7tTM1DBJeTvxGzPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qzw18BMu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qzw18BMu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc56fd4de1so265645ad.0
        for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721672976; x=1722277776; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATevjVQZFZhSyTTg7te/+mB6KTD3bHMCcurSBbbb+Ow=;
        b=Qzw18BMuAPh6Pp1+ZwfnpxlDb0c8fklNP2aBViTzLyRtJysotGS+aMB5kcuuc6+edK
         pQCa7f9E4WfCprY3tblaeuiLxu9wgXeOrt9P62+QIKp/RqsxYPYvrwlRSHT+SaCtWDo4
         JQDYbKEeRukW0CbmUF8LECitKqPUknlel3OSYywZgYh1TedLrghIGfs6sJfxSYxkoRQE
         /u2EdHInE2JeX3VN6C/XOjWHwfHenOSJtRxJKVSF8xuLM3P7BPg4RHei1lMJLHFEl0Gy
         m7OaV+zY29o0PTjsGsDGUJ/giGvu73cBgxakz2mj4Pp3DrnrR2JarNX1JlOou8d65Myz
         Mp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721672976; x=1722277776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATevjVQZFZhSyTTg7te/+mB6KTD3bHMCcurSBbbb+Ow=;
        b=wSrX1/9kCSQtAut3KHucbPD7+WF03TZutLqHhx4T6z7eV4v0/DAUZmbg8PvpO8kyEA
         kdcLUFc7jPC2z5cQaBHygyk+AAEcPFNkPw/A1uKPSAjBYVoqTnEBWaASwxa1lYD758nP
         ZKIHss2JChy0zdqBPOM9Nzmopq6HpKI9VnPhscaPKcyD8lwQQyXp+2pGlBHMmZaSby8h
         qjeK9XiZvuZAgqxzRg7iWxwe28qXpetWlqHlo8g1Odhh518lFb3phg+8kVsmFQEATwAf
         iMAocsuFFp5ffMPAxBr/CEY+/9qLje5fBZ+pMYHqVVvm3DXwnfL3CuWVbN000+WBl5PB
         6ogw==
X-Gm-Message-State: AOJu0YxGH7ZCwm1qWsBhC0Jk50Bkl5fkQ71Q1wbMp7eqbxvL8yIlYId5
	oxDP2MwHyawt9cQ9AecQhZguCazRPYz22siXsnVyu4lyd7+jx2s++OsmCA==
X-Google-Smtp-Source: AGHT+IHefumNCjKUIUGAX7Q5qYTOA4zUY7DVCgwcOFOxEPmXZgEGrNtH8adnN0DZ6bzt4kz/Sb0lOA==
X-Received: by 2002:a17:902:dac9:b0:1f9:e2c0:d962 with SMTP id d9443c01a7336-1fc5b63500fmr185969015ad.31.1721672976065;
        Mon, 22 Jul 2024 11:29:36 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd8dff753bsm33622625ad.243.2024.07.22.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:29:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/5] station: add station_get_autoconnect
Date: Mon, 22 Jul 2024 11:29:29 -0700
Message-Id: <20240722182932.4091008-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722182932.4091008-1-prestwoj@gmail.com>
References: <20240722182932.4091008-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gets the current autoconenct setting. This is not the current
autoconnect state. Will be used in DPP to reset station's autoconnect
setting back to what it was prior to DPP, in case of failure.
---
 src/station.c | 5 +++++
 src/station.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/station.c b/src/station.c
index ca0e6a38..db069981 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1726,6 +1726,11 @@ bool station_set_autoconnect(struct station *station, bool autoconnect)
 	return true;
 }
 
+bool station_get_autoconnect(struct station *station)
+{
+	return station->autoconnect;
+}
+
 static void station_roam_state_clear(struct station *station)
 {
 	l_debug("%u", netdev_get_ifindex(station->netdev));
diff --git a/src/station.h b/src/station.h
index a38327e4..50f0be12 100644
--- a/src/station.h
+++ b/src/station.h
@@ -88,6 +88,7 @@ uint32_t station_add_event_watch(station_event_watch_func_t func,
 void station_remove_event_watch(uint32_t id);
 
 bool station_set_autoconnect(struct station *station, bool autoconnect);
+bool station_get_autoconnect(struct station *station);
 
 int __station_connect_network(struct station *station, struct network *network,
 				struct scan_bss *bss, enum station_state state);
-- 
2.34.1

