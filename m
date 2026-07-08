Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C482ED872
	for <iwd@lists.linux.dev>; Wed,  8 Jul 2026 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783549280; cv=none; b=PQDLPOtu2OfgYcTJ44gGtBEsoZX/Pd1v1kTCbpk6b2CTzehM17HozeDUwUUa25q0yKnEdpqRek0dTrmLd+0hmU1qmDIrlf6vNFb1/xvsPfQbRQp+eLo8SYgFfWrPrLogSA0OOoiDyZV0dZRQboXe4bkmWP7c50g0l9WJ1pG9rJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783549280; c=relaxed/simple;
	bh=gnJfQj+v4XqfgqJ/j3dl1vRfi30EoiR7kcGSxAp460s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oqa3a246VEzQzMywoIj7oN5UpU2fWDn6M8xT0B3IAmiQxaslHCv+QgInv4VKunopVYS+sEV/OQaDgLMo+CxRXTc0Nvf0a5Sagqp8L2sfuAgT8u6PlB/N+PkrmEMfxBkgoVhybe3XOx8us5ZKv2NhLUXCjNlm7JMWwHTGc2Q6qrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEUOzy0n; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEUOzy0n"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so2218925e9.1
        for <iwd@lists.linux.dev>; Wed, 08 Jul 2026 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783549277; x=1784154077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RbUto+rMPL4GZ2Y0JE8Nac2bA4q8bCwQM4z0SJfuGwo=;
        b=fEUOzy0nefOmabHbwakvDjjyHGY4cHi6Kb/5oMWxGYZHx9ZYbQTms+Gthmp5pm0crE
         H0pVWLr+IbvF0r0Xchh+QS2ym6BRbI/9/bpAfTaS8nFPdbktj1w5dpYsaZXbrBdHrnws
         iQ/Eb6dMsltUu0J6uSzLPY5GPiacrG9kgkccZ++KcCOu1sOZCTDk0WixI5Aa4wupBjoP
         J1tBIEqSIQ6sqPRjzNpnsSs9f5NIB8jsy1QZy3lpHyOyxGfq+eDzYiaaDUWw/09Wd9YU
         dmMsC0eGtP3qGr2X5DkTPzaMOBA/0EGKuKVOrJPIMQm1svTIfIpA0vghfwCH/3NZFbgr
         hXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783549277; x=1784154077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RbUto+rMPL4GZ2Y0JE8Nac2bA4q8bCwQM4z0SJfuGwo=;
        b=oFsvWH1wIpFn124HGPFzRwD6fu7MQtlyu9FJpUqqYn2CVwsLFa0EK47+Ii4bQQgaR+
         4KnAgtqL+nje/fEOa9CG4VxAGZLbNbZHrft6BwhhN3RVDMiEMX7OCjbowhrghz7sx2ql
         8PKqF/wwTpry9C+eG9OtP7ZAn/y4QPkiEsSj5gupNd5ruOirkjw4mK8HbLz6QwyfGCfV
         iVnGqutoJUpghnkFoEnBbwmGHwehoPxTDvZp84YRdMK1m1AA0sujg1x+5uZNDgfBDoHY
         YFQFkjbvQ+Vi7PnvBps/+dIrO5Oe6ejH5rFe47Gp6KpiqgMhp8F2yOwbTsX3iXJxe5XP
         AX8w==
X-Gm-Message-State: AOJu0YxAjBOlBWGYn1PCvKBFckIZe76MF8m/DNFKTR9gEeTht4qsD1/w
	B9qjTYlI8dnMvtKJ6+O7IUqD5UizcpcWR31pq11xfUwQ+MzrTPOin7nCk4FNQQ==
X-Gm-Gg: AfdE7cl5K2rG9/DvZOhftH0Kdrk5JwH9KPnw0DsDk4cx/r/BE+nXiNd5JMjH3vhe+SA
	xgRwt53t2F9lUkQ9NZWRrO5Mh6TcXM4dlLHqehkfbbbAhWPpJ+LUPsTl8RCvMUTQYZhenI+zvAa
	GjMeDEMyVE7pRoRxisdBvHnkOFbjMpkgE9hEux7G+9eedFXoYAcxm4gdyu6LzA8FomoehSRM/Lv
	KMpCkg7kSliGitL3iKKh/d8EoWx224aeaGr+XX5smaQ/WWFtwQGhYYFO5TVY+aeB6ApmcPuYCel
	O2MhyJdPi5mZv6CT3pOVE/JEgHYSZS7YxwPGfijxrvlVEo2VcTaV5Ykmpn1h/3EYhe1lrioE66Q
	5HLjeLgPQKhfNOKXLes0C8H4aIc0jOALopmeahM/nDvdS0ByApHaRRTCeMknocl2GeYNMPhlcEh
	t9Kr1b7aDe9hCZGj1IdVj6zb6Vv1gsif7UrHZPoA==
X-Received: by 2002:a05:600c:4754:b0:493:c478:8744 with SMTP id 5b1f17b1804b1-493e68df956mr40578425e9.18.1783549277129;
        Wed, 08 Jul 2026 15:21:17 -0700 (PDT)
Received: from localhost.localdomain ([2a10:4440:fff:d1a0:d438:d408:8c5e:d0ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f373csm19920295e9.14.2026.07.08.15.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 15:21:16 -0700 (PDT)
From: Dierk Modrow <dierk.modrow@gmail.com>
To: iwd@lists.linux.dev
Cc: pmenzel@molgen.mpg.de,
	Dierk Modrow <dierk.modrow@sew-eurodrive.de>
Subject: [PATCH v3 1/2] eapol.c: Fix SEGV in eapol_rx_packets at receipt of EAPOL M1 msg
Date: Thu,  9 Jul 2026 00:20:55 +0200
Message-ID: <20260708222056.273-1-dierk.modrow@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dierk Modrow <dierk.modrow@sew-eurodrive.de>

It fixes a SEGV in eapol_rx_packets at receipt of EAPOL M1 msg at legacy
roaming following a failed FT-handover due to a preceding
ft_auth-/ft_reassoc-timeout. The issue only arises when using
mwifiex / NXP 88W9098 driver for the client's WLAN module.
We have seen the issue with SIEMENS SCALANCE W700 AX APs, but it may
also occur with other AP brands supporting FT-handover.
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

