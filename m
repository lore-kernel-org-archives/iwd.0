Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691961925AF
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451829; cv=none; b=RGg9+PGrV533RdcfJywTdZbXXIcfh/+VUrpR92tnUyxXFLzz7l41clFfbKAybQRyi0Zf36NpZ/WmBPa8BkuIpAUtHqTUNim3bXOMI1sCOrQbQ6Zwn3EM5nED5EaBgOWViFd1nUNWHWkB5r9Wqv4czTPsrOYuyjsW1mfbaPEqSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451829; c=relaxed/simple;
	bh=XuOeFsddTnDIC956A+nIPyDg4sOeSaUqYh8SjqKWg7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRW3L4fVqmBsYdOi6OnR6rr31cxQ+WKnCOwKN+z3aaNOdC8D2T99kWBksTV+hQg779EpS2+FaS89qjnPTOon2cjWD0imDk2evyPVR8xlyrSE8WtNsYobUFnWHEGIkIgtnIuil/n0ZjFpYZsokDQLSDtSZQ9RIG1oLNlYFBUzwAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOpbd66T; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOpbd66T"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d6f4714bso234191185a.1
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 15:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724451827; x=1725056627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tQJvtRW2PSFTZ4r1iQQLiNM4sfBKdJoT8tMjFV4cTk=;
        b=kOpbd66Tc9YW8lVk02rxgUNW7XX7W522uBnlvF+9rzyt1TyetEdF5oPSH3dNW5OqGR
         fWIe4sJ4sOdhQvwi+ITHK/Esl7JuhvceOatTgTNmbtJYfaSavKoe+UimFe6sVru6HHh0
         tL19kHP4C7mzKepxz0eqAhgzjpqSdj2K9kkZKgRlzCy7CaIICKHmzYqVde6x2cCOcVOb
         vC3G2G0PLIL+zIGARL45oiyrEqTqjoMDRSr86scPULic6H+EqNuOanv9Ax52d2mUsY8Y
         EwADjzvo38ffpx8e1cfMq7nw/OwsHDW27iYaibhfhdbS3C3ZNMRMXNapu0/fU7Hi/6b6
         i/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451827; x=1725056627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tQJvtRW2PSFTZ4r1iQQLiNM4sfBKdJoT8tMjFV4cTk=;
        b=Ttp922YxqnU7ADaYMVeUuZXWkL1qTz5rE2dG3BgTzGBiYGLN/z3KDR4TvufYipqNjW
         aIinzoSnDPAYYK97QTrwsm34qgj4z5oqAfMzg4ljsC8OJ2ul6BBCprWy/JoBqx3+gPYb
         kRBSr/954CCBX0pYOEX72v+KY3omdr/iBvbK7rwc10ci6KEpO+6Aw1DvFe91glAbigY9
         CCMlO9orxa9SjfJcAfH58Ta3/XxA/tSNwtnepBEQx1hwIWtiBj6CYM1E5jHInwt/x/Lm
         tlQa4V21gPieogC6Ox2J2IwbnvWF3ILQAW2PrCciZnxVHcd7vwY3xueUdkoExBpzDhE1
         nBVg==
X-Gm-Message-State: AOJu0YzZv5fRspcBAZQax+de//va0/kFBFoCqEej7mgx7Sp3E8277+MH
	f2UbxPVxjmGI0Jtw8FvQzjuMvwyfPlI9m1UQhByXTze0gutIGD/UW3MaOA==
X-Google-Smtp-Source: AGHT+IH6JA9XJ5HcNuKwQL5SqPvFRxiGbCE5qMOdpy4drAjjlWahPaxkhWwS4ZoudkrXUDMuRma+BA==
X-Received: by 2002:a05:620a:1a8b:b0:7a6:50a4:291c with SMTP id af79cd13be357-7a688d3b540mr645036085a.14.1724451826968;
        Fri, 23 Aug 2024 15:23:46 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41f507sm218860385a.132.2024.08.23.15.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:23:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/8] netdev: define netdev settings in netdev.h
Date: Fri, 23 Aug 2024 15:23:33 -0700
Message-Id: <20240823222339.328006-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823222339.328006-1-prestwoj@gmail.com>
References: <20240823222339.328006-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following knownnetworks, this moves the settings into a header file
which is easier to maintain/read.
---
 src/netdev.c | 8 ++++----
 src/netdev.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

v4:
 * Fix typos

diff --git a/src/netdev.c b/src/netdev.c
index 494e46a5..e0121095 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -6264,16 +6264,16 @@ static int netdev_init(void)
 		goto fail_netlink;
 	}
 
-	if (!l_settings_get_int(settings, "General", "RoamThreshold",
+	if (!l_settings_get_int(settings, NETDEV_ROAM_THRESHOLD,
 					&LOW_SIGNAL_THRESHOLD))
 		LOW_SIGNAL_THRESHOLD = -70;
 
-	if (!l_settings_get_int(settings, "General", "RoamThreshold5G",
+	if (!l_settings_get_int(settings, NETDEV_ROAM_THRESHOLD_5G,
 					&LOW_SIGNAL_THRESHOLD_5GHZ))
 		LOW_SIGNAL_THRESHOLD_5GHZ = -76;
 
-	rand_addr_str = l_settings_get_value(settings, "General",
-						"AddressRandomization");
+	rand_addr_str = l_settings_get_value(settings,
+						NETDEV_ADDRESS_RANDOMIZATION);
 	if (rand_addr_str && !strcmp(rand_addr_str, "network"))
 		mac_per_ssid = true;
 
diff --git a/src/netdev.h b/src/netdev.h
index db0440d0..c48b2c38 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -29,6 +29,11 @@ struct eapol_sm;
 struct mmpdu_header;
 struct diagnostic_station_info;
 
+#define GENERAL "General"
+#define NETDEV_ADDRESS_RANDOMIZATION GENERAL, "AddressRandomization"
+#define NETDEV_ROAM_THRESHOLD GENERAL, "RoamThreshold"
+#define NETDEV_ROAM_THRESHOLD_5G GENERAL, "RoamThreshold5G"
+
 enum netdev_result {
 	NETDEV_RESULT_OK,
 	NETDEV_RESULT_AUTHENTICATION_FAILED,
-- 
2.34.1

