Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376063E1CE1
	for <iwd@lists.linux.dev>; Wed,  8 Jul 2026 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540570; cv=none; b=S3RTSLaKqd7GvvpGoP66q1ajurlEXWXfVX4M8AG3zkBpTsPlTnmvLK4MOlMUW2wZ1IA7Gnsa/phcGvUmMI+6JefRw5vnU5XNWd0oO3KAEIvI+3ftCv1cuLjjVKrGTOjOFm/8dnUUKYNSebuFk5CbMFsHeQN+dRBJIH+FF9Vg0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540570; c=relaxed/simple;
	bh=b95JPjlKmHqfrkuojA6VS9CcYtqexPLFFbrYe6uGA7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uvuc9kxf1nqDrDvEIylELGg7l8/p+X2Efc5kjJ6ov8W7kq+BnsBFYq2tE/qWO/y3rm6lYX80I3RaNZ60HctzyweK6OqSd3rztjlJAmQZQRZ4v5yyLCcudZSLxv49FPxbziDWteyFu9XJth3QnHPe4QzCadtSjLIiG933orwjIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2YKIVhV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2YKIVhV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c00f74baso7681165e9.0
        for <iwd@lists.linux.dev>; Wed, 08 Jul 2026 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540567; x=1784145367; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mMge/CPrcPVkz/U5A/MA4aPYzvUMjj1gRalE9p/wZu8=;
        b=P2YKIVhV4dUWoJ9jqxZrjnnwn3bIVLtBeNJXVs9MW+7AhQcUxSzxWycKiKnPh1KZZD
         Er7DXEIndkH7edSur2Jje65accyv+pkLrnVvB9qL5h6T5Udn2T+QsYyVGpUSO4BaHOdr
         kfTWg+w/hRq1Y9pu9/9bbKZzdo4uXOb8q9xJdZS4KkxbmI8QjaZRF0Lb2RtUIN0KlPgE
         f6M8GaJW7ljJhfJQxuyp/dUg6v+oyWaWfRcIPGa/a1OKvDTDbMHAvPovEkS/VIUFjFCV
         oeE3e7fC9ef0O+61WNAYdFm8vn+vzqc9tQ4zgRTKTUqUaNEWMz/+7JQrMJMDXo480h26
         bs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540567; x=1784145367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mMge/CPrcPVkz/U5A/MA4aPYzvUMjj1gRalE9p/wZu8=;
        b=tS34usFC+2ACC2tQUfVKh6dNnjRiFrmi/xRqLXKdBQzoSBRYe6EEY6FcCir4BPZBl/
         mEqLv4wwDTFkt3/cEkOwRGRorHE/Yf26dsdF9gS6iQ7x58GZKFwvl8Ew5hk5P4/e0IMM
         6ibbl7ck+g+NuKaDAxUNqwkZWxM45srgTXobiaK7Znmq0M89AGxH/19ExvtzZnuEt8Me
         T4qshaNDKVHrJoOb8v5Xs1OmabXa1yK2k/RXuChwtpPKF++nyvfHuYplmuW0m5hIAkna
         uciceVqBEOawqLoV45TDubsxlzIJhx8Jx/+rKx6lwTjhInfDjuNFAl8pZUaaCjY+X+Ys
         ydAg==
X-Gm-Message-State: AOJu0YwMSMD9ok6OT7EJDaKLxkjgmSVOoGTH4eToUUfB24ni/cc+r39a
	BoCIHeZICtIeJ1psDMnmpP5ByoanokN0Rnv0Ht1PRJRsyrEW9XGsiYGi5ZiV0Q==
X-Gm-Gg: AfdE7cnRoanRKSHVz1ypgoq9c+apcjgL0INIiHHN+bIlTceafxWxln5wCBEZJSIJaEK
	2NSWZWaXmak6GiUlZAGn/12kPCEO4qnFK0jY3FzAB5NvZ/OAYMdJjso/gWr6gb4gnarrDFsZapy
	eSi1bDfg51WF6HmYDY2PP38XUaa/oAPEh2fPWGmI3n6JkNlEueVlPBMm25cGrT63c2BALOrDW1T
	AhITRgRbdRelueOiNwKePwzVwRGG/GxmiGMPsz/v9ibUHL1T1ZLMpowdrIIqELJBkloHYerxDPs
	JXoFkPump83e3lYiAKRLKmFEt3Wubb6LRnwmmmJUj/4mhPq2VSxeaCHerAb/npXQCMbapYPbhop
	Y43ImV7ut8VoGV8PNzKTvz+wzXNiEfIevVUiC2tTPBhRG1qB7Vq2T4yOJWkANPKUfSm3Myp4Cki
	5hNil0NL0U9wUaac4ox0i9qK8DkyZa7UN2lxLIAQ==
X-Received: by 2002:a05:600c:4753:b0:493:b84f:9c28 with SMTP id 5b1f17b1804b1-493e6892e6dmr38318435e9.4.1783540567182;
        Wed, 08 Jul 2026 12:56:07 -0700 (PDT)
Received: from localhost.localdomain ([2a10:4440:fff:d1a0:d438:d408:8c5e:d0ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3b85sm5485835e9.2.2026.07.08.12.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 12:56:06 -0700 (PDT)
From: Dierk Modrow <dierk.modrow@gmail.com>
To: iwd@lists.linux.dev
Cc: pmenzel@molgen.mpg.de,
	Dierk Modrow <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH v2 1/2] It fixes a SEGV in eapol_rx_packets at receipt of EAPOL M1 msg at legacy roaming following a failed FT-handover due to a preceding ft_auth-/ft_reassoc-timeout. The issue only arises when using mwifiex / NXP 88W9098 driver for the client's WLAN module. We have seen the issue with SIEMENS SCALANCE W700 AX APs, but it may also occur with other AP brands supporting FT-handover.
Date: Wed,  8 Jul 2026 21:55:49 +0200
Message-ID: <20260708195550.165-1-dierk.modrow@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>

---
 src/eapol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/eapol.c b/src/eapol.c
index 372549c6..c2dc4e4c 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2824,6 +2824,10 @@ void eapol_register(struct eapol_sm *sm)
 
 	l_queue_push_head(state_machines, sm);
 
+	/* workaround against SEGV on fct. eapol_rx_packet by avoiding for two different eapol_frame_watches with different ids, but same eapol_sm ptr */
+	if ((sm->watch_id > 0) && eapol_frame_watch_remove(sm->watch_id)) {
+		l_debug("existing frame_watch for sm=%p with id=%u successfully removed", sm, sm->watch_id);
+	}
 	sm->watch_id = eapol_frame_watch_add(sm->handshake->ifindex,
 						rx_handler, sm);
 	sm->protocol_version = sm->handshake->proto_version;
-- 
2.49.0.windows.1

