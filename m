Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C415DBBA
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836011; cv=none; b=bCanNAANuJpksHOd4wGhW9bsQVjF39diYjeKs9zp3DWiLg4HBVLFDKhMp8IhYniX7kP9Sf8O5pU8qmeECo0p3bXx56gHinky4qjslAhOnAaacX3tMqQJsAsrtZxTTEbGHiI55nl5PpO1nFfwbppF/Fn6R1Av2mTeav93VBdGyXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836011; c=relaxed/simple;
	bh=KovdUaiRySIwerb98Kd+zhsa3wjgebvYTwUnK+k+Em0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GriRyndgzLgVzbck59BEi7dNwk++SlzB5LQqLTG4yDAkNr4lw8NDeGi+jqMOsLWLeZDlbWI17ZkLf96Yryo2cHPNMOAmQqUBGKBD8q1ZIbx5mEfL25oPRNiojtS79BxwZgm0cPsFgEL64jLY5RZXntwzt1o4lx6kyMxfhNAew34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRQeNvU3; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRQeNvU3"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5cdf7edddc5so1187eaf.0
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721836009; x=1722440809; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATevjVQZFZhSyTTg7te/+mB6KTD3bHMCcurSBbbb+Ow=;
        b=DRQeNvU3P1mzjFCc8cW0nSOPRtIesa7pcLkjEsqQfs45J34MUGWfLL/XD0mBSGmqXc
         p5levLxoUBlszxYe49TlBbGE+dqn0oUKWozL9PKJ6KnXVlWzxyzeGFRQGcvBjl40XsK1
         JfkuTfyyiU5chO3CCu2gy/pfTmYXscgxW2ZkUdrRAabtuoFh5mkei3ZS868hjxwerHoD
         748t8vLgpgj8yweQTRunTLEd1nBx6qJee1RK4KzDPkU2I+5ezMN94U7922Ofy6FDN/Gu
         H9JYXsZtRiK1+7fnJJUZyRaNvpQ4Ny8Gp01/o5vSzJEYemR2fBXgdrIk0nC41vWgIcrp
         GbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721836009; x=1722440809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATevjVQZFZhSyTTg7te/+mB6KTD3bHMCcurSBbbb+Ow=;
        b=SYS4bIGr9UR+aWmBsU1kJbkv5un8F1Iv+EnmFhkQghjbTBEjisrIXJgpkAL+antblG
         F8+EE+EXpNEJ4963SiL7LSJvCYkixSQ6UWjbK1qV4Poy1+itOm77cXAoLrMzbIT0gj/a
         uPjoZv9ZAJHjqKNpru/y7fdNCc4/mZd+GBIglWrKAvqU9+mlD0K1PpAId2hytQl5OelL
         WVLCiTzlEikUr4tRl9o5CtNHgROxDKWdeYuZGhLJUcIRdK9Zk1kAyo2aNawz2Lbbgba9
         +arT7gyhSH1hswPppaEPoHo7K/85mABaDq0mxlqiJQtM71QcP2AFDxnll2HibTyXkczt
         h7aA==
X-Gm-Message-State: AOJu0YwzIfLS2IOKQQevcrD0EnimcAakQTDRVDR4sr6Z2GORfO3lQxXD
	c4Ru3FTTMzMC/7mN2ZCCoIccWqJCjhIDcMyYz3L1TFkusRA/DWlSnxA5Wg==
X-Google-Smtp-Source: AGHT+IGBfcTM2gnRXNNG2JPNU2sn6BCejb6txGU2TE/z2uBZ8G0HRFyk15iCD1eLFFKbl8KsUuip+A==
X-Received: by 2002:a05:6358:e4a3:b0:1ac:f13e:49ab with SMTP id e5c5f4694b2df-1acf891a11fmr29484155d.26.1721836009069;
        Wed, 24 Jul 2024 08:46:49 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199013905sm589001485a.67.2024.07.24.08.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:46:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/5] station: add station_get_autoconnect
Date: Wed, 24 Jul 2024 08:46:38 -0700
Message-Id: <20240724154641.1461593-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724154641.1461593-1-prestwoj@gmail.com>
References: <20240724154641.1461593-1-prestwoj@gmail.com>
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

