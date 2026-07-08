Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13C3451AF
	for <iwd@lists.linux.dev>; Wed,  8 Jul 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524194; cv=none; b=DDJ4NYk1E6qtPKn/RYwsDx8GY6Q1aA7hCEzxBs7f3XVeH/fVttFny3owE1QNRKMlHigZunGASt6u/YFWfsN+mvJ4z+IxU+yYKOKUCthOTo0e4uCz7WKFuaK1EECB95h7U4eUz5szcMRStN0M/D7GNdQLL3hCtLVlJ7IW4P2h1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524194; c=relaxed/simple;
	bh=i6CB0RGySQ4tEKc+FtRRWf4TIwEBkdRMVwdut9O9dtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQ6yBO+yxmvYumr57Vw4jcVGdgHC9RlNrvavu24BgKy/IzH+xc2nwrAvxN/7U6ZKyic6W9N5GiDlFJVhov8YyeyY/pxmCNH7DMVZyDuxzJJF1ixMKrCmq+4lqQzpLzWtWdsxu2uq8i6esjrXc+kyuh6mEYWtpMpXkYJJE0nBwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S98H0P6H; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S98H0P6H"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493e4cccd8dso3614085e9.2
        for <iwd@lists.linux.dev>; Wed, 08 Jul 2026 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783524191; x=1784128991; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ji+74JjtsCf46eEciwJLMgSMMYyY6/3ISbbxDBKYoL0=;
        b=S98H0P6Hp202UeFs+GTo4dpg1eUYkn+8jGB660YLwHPy0gt3zLwB/CQ2GO/GVri2EE
         1RfP/ea8OWEpWNKChr6/tz/1JfpZu+I1vbigGLechIpFfYtKrl+Fmi7vbYZtGEAC7ASF
         98FyJgHN2ywnDv9FexabK3SEVzItbpuoIGvlZy7MLbxvbH93NvkvGcZcNp8e8yL5iOjV
         VZHIziBp716b02DrYE2IR5YsiYQfAm/Ktwv8rXe3ali9I1EtV2qrWZRKQ+2RkY45ioOO
         npNxH+9XwdeC6I5NAerUkvRui5QxVXuTAyGlPRCcWkX9Hhf4Wb80tpN6tJrUn9TSj7Sf
         Yjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524191; x=1784128991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ji+74JjtsCf46eEciwJLMgSMMYyY6/3ISbbxDBKYoL0=;
        b=QUWgqiraTe2tycPmp491HQ+iMnbLT+HLSXRBzGP1/kFbOw5QiYGaK7K3v9VPOSHzN+
         vL4oC3yUjMggKCzIRR4/ahwzNYucNfjNMMisHygCCzFEbpsEFRAQpUSoLczbj9GK55we
         1eKoeMIPH6oc3L5rocpkUWv3KikVCzTBru94O2dxIzHXCpERhAhifIn7YsrKNqyrDN3H
         V5m0D3kOs5SDif/wDct613gFeg1OJoZReojApSn5f/aTmZAyv74zzVGosYfqJb5T9M1F
         b8cMRxhNPPLwlfsopVDfVBIQ0rqWpWOjeuJyCTWahMjdW7IpxCNkOypq1+hu5paVn0Yn
         wvgA==
X-Gm-Message-State: AOJu0YyeI2I3PjKSuYTKGknFXAYcqhglYPN5arTGthdYdJbrpLlIB72s
	KtIwg41GX/Qnu2XYQZrzpJ4n/jSyG+c7euLMGZkk5QfGEWrI+hlY5ey2tOoxmA==
X-Gm-Gg: AfdE7cm3crUFS/i6v2m4ngAPL5XY54WIeo1wR64XHSkSAFa8zFmghDQ5nyCg8vElRe2
	VYRL4MVPEzaWomZCuFvQVuE6Z5S0/0uMy4EBmrv4FjASDeF7l/mGSVPTApo46o9HypbKr9OX2p9
	W29dvNzQ4ZD/HqpN84WeiFCC55NQTY1qAYk8sjt/KxPpbm8paa/C+Op1egiL2hBUNAKnbpqzRVg
	m83Ly71lKaKgvMqVdBhEI1KKisRdxcQc6rheyyyKjvYbtMlSFqpFzjkZqNw84q3tn6cS1DBI2Uj
	wa/VcTGllvgzjy+ocnu7nN/H8CLcCbvvIxFPEseGIkuG4VIy0BkjIbUJBCQOPiNn8YN0S3y7gSQ
	Eqp/dmH9ZpjxQMq6gAL26GhFjFgQb6FN8AAOyBe/Kqiql+aM7v49T6g39STPGRHnYAet144eEZi
	HWgVpuBxNcE8Qd2hdJUpn7h8VwT2QM39jyv23Y5w==
X-Received: by 2002:a05:600c:a00f:b0:493:bc4b:b8c with SMTP id 5b1f17b1804b1-493e69e9902mr31486995e9.38.1783524190696;
        Wed, 08 Jul 2026 08:23:10 -0700 (PDT)
Received: from localhost.localdomain ([2a10:4440:fff:d1a0:c58e:91f1:416f:77dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a61135sm42412065e9.1.2026.07.08.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:23:10 -0700 (PDT)
From: Dierk Modrow <dierk.modrow@gmail.com>
To: iwd@lists.linux.dev
Cc: pmenzel@molgen.mpg.de,
	Dierk Modrow <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH] src/eapol.c: fix of SEGV in eapol_rx_packets at receipt of EAPOL M1 msg at legacy roaming after ft_auth-/ft_reassoc-timeout when using mwifiex / NXP 88W9098 driver
Date: Wed,  8 Jul 2026 17:22:27 +0200
Message-ID: <20260708152228.1191-1-dierk.modrow@gmail.com>
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
2.53.0.windows.2

