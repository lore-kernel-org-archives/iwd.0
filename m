Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6923181B8F
	for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228133; cv=none; b=jI72TXTHf/z0/tdtef6ZU/Pomr5kGk0Y87x50DkFoX9LTvj2rJ67OUQ+cdeC/FO7PRhqYWSuJxq76q9Y9D+4/lWc1+boM6wIDlRwrUX44Z6yk4l2sg3WNf2TDuLErGKKlqQM1xZOtoqm6QO97L3j3rxNfR0Pa3Ots589apGSwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228133; c=relaxed/simple;
	bh=wZ+kNudVV7hwu4gCZ4CWnYsGgwx3Egdac3AVoFktwuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hMONlCMUl5Z6DXz7v6xkSd8pEl0F8EBMe+cu2h3XchI22saX97gxpR/ENoI5AOMT/spR7slqOGO+sSoGDweV3VXdIVLzg6qJSeRh8WgmTlEoNjabgWCZnHeZ1Nk62U7GAGwQQXJrj+OyZoghTGOVstxG3QJTOnOVGAG5sqf2JE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0Cz9xwZ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0Cz9xwZ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-65faa0614dbso45206647b3.2
        for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721228130; x=1721832930; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MToUH3sxHOEmHeBTXUaH2EP9mBA1Q5dI65ZttqNNPQ=;
        b=m0Cz9xwZn6sKxWfZxqE0dBtEAazMtYB6bzviSefF3wQJlMteXtcNosLDXpDK1UdjQc
         01LNsj5SUBF7ODvdvdpUlc1AnsQcoL+u/73BgkXP/h5cuTPFEfwMPCsgzkEvi40LsYBO
         C1oNYCc+lVtUj/8Es6peW7yArw+3eCnNmHMol7pOw0yhv549gq/rPPDYqFmpfFU32xfu
         S7ulm9n55ZHfNEmXjRV0F0NutLYA8zJxdl4+aXPGbz57u3iG/r4DbitJwYIf9WqKs3Mm
         6zEa1KrTMJh3U35ZdDc4dajl0TpgAivhbCa7+1x0Zw3RmVZ+y+rsrtWSGt79TqASk52I
         9nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228130; x=1721832930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MToUH3sxHOEmHeBTXUaH2EP9mBA1Q5dI65ZttqNNPQ=;
        b=cSh4vRJakNRnMdToXFzwVzRKjphIDq4HNjWcLh/moLidMYASbGm9oO9C8AHb/DkzK9
         u4F/SPgDyQhK1oPHXrO3UjDQkSCp/ySLf0i8nTE8XZV3fXnOfSDjJldzO8K5ka1XtFze
         s0f2/7SSmhkmWTiyLQbgDx2udRwSdXPhkU1hF2t7+ZjeZ+PHqu7zvl9bQZQU47lbCcTf
         aFTvwLf0Sj/zdo0e5DnLV2ivBKfgwa3v7uJVsBIjcf1d01gxj9UXVQYtgnKukRa58MB4
         7KoQ+DWVDXcSJGPoXObDR+bBK/xcuF/qdT20PKQjyCE6sQ6x0RkACSgA1hD4fAknekwv
         qKNw==
X-Gm-Message-State: AOJu0Yxojxf88nCaAY1Xi9KrgnCvJVNLz/FRCaIh627QcixOxr6qeDeZ
	+ckVlImIbgg/ziFDdy3Qsb5dZ3hvS2Zl10ocJ/3ZXaJMpx9wtNB6nIX1Iw==
X-Google-Smtp-Source: AGHT+IEt8HnhgXjD8Nf1nmhEMwyYPthpm/yFhv5YzBQ4mwKgZyY1/dqIrFQ13NbySh0uNWyIya8Lsw==
X-Received: by 2002:a0d:ff42:0:b0:64a:7040:2d8e with SMTP id 00721157ae682-665001960cdmr19297787b3.33.1721228129795;
        Wed, 17 Jul 2024 07:55:29 -0700 (PDT)
Received: from LOCLAP699.localdomain ([50.78.19.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbff41sm407195885a.53.2024.07.17.07.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:55:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] eapol: move HANDSHAKE_STARTED_EVENT to eapol_start()
Date: Wed, 17 Jul 2024 07:55:21 -0700
Message-Id: <20240717145525.2656306-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This even is not used anywhere and can be leveraged in autotesting.
Move the event to eapol_start() so it gets called unconditionally
when the 4-way handshake is started.
---
 src/eapol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 845ef866..6d176304 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1036,8 +1036,6 @@ static void __send_eapol_start(struct eapol_sm *sm, bool noencrypt)
 	uint8_t buf[sizeof(struct eapol_frame)];
 	struct eapol_frame *frame = (struct eapol_frame *) buf;
 
-	handshake_event(sm->handshake, HANDSHAKE_EVENT_STARTED);
-
 	frame->header.protocol_version = EAPOL_PROTOCOL_VERSION_2001;
 	frame->header.packet_type = 1;
 	l_put_be16(0, &frame->header.packet_len);
@@ -2858,6 +2856,8 @@ bool eapol_start(struct eapol_sm *sm)
 		eap_set_peer_id(sm->eap, network_id);
 	}
 
+	handshake_event(sm->handshake, HANDSHAKE_EVENT_STARTED);
+
 	sm->started = true;
 
 	if (sm->require_handshake)
-- 
2.34.1

