Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD712FB0A
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303129; cv=none; b=uf+xgISZw16ycy5CwWLsJlpFuGJEio4en4k8evt6QJOu5cQS6jzsvO8nK2Xy+vqGLgJGyIiUoQZWRh33nUcE/m434vFEME1lngJctsn45kJI6EtRBjiET1yG7xpCN0Gm2a9t2lUOqMCI6tyG2/jWLhr5evxf7Y9KwP3f4QuTnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303129; c=relaxed/simple;
	bh=wZ+kNudVV7hwu4gCZ4CWnYsGgwx3Egdac3AVoFktwuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5Egj2IiBRNEOv6zQT2qvH9QANedjx7yXgDSAOci7RF6nM1qNN+pl+2tXqTvDDpKEkrj1wbLQi89VDoI2oBCHJbpHspd967voBTkpGBzM8KoPfO0082a4QSN8T2S3W9tc8OlGAljE+1TOsVoPuVi1HW6RQ1JS+MnWZXSkj4YJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTELeszq; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTELeszq"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a05b7c8e38so11089685a.0
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303125; x=1721907925; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MToUH3sxHOEmHeBTXUaH2EP9mBA1Q5dI65ZttqNNPQ=;
        b=VTELeszq29EFucsILB9FO3BongR/qoXkIecxjo4W3JJ4ctTjjoUCu/1hYw7Thv5Y9k
         b4I+DYd5qskQ4XL78xBe+6EbyjZCk5yFgJ0sjCXGwcK3w//SUu5UgXdbxEuiPquMCE3I
         zKrnWz87MLPZ8Xl/5ltedtePJOCJd2ilG6eNcJLy1WndB/vVeXGM9R0QyHxP1eJvaMDU
         Lj+2PIIBbmUJqgwN80JgJs1eZvGsarQlzWV+0+dksduilJRUK5NKAhozUI1kBVKANbCU
         BwzthQKNTN5+yuoiSc+7/aK+Ek277/NcpPuDetHdYEjM/EEB9qAWj5jG/zNrbTvTHcpf
         PVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303125; x=1721907925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MToUH3sxHOEmHeBTXUaH2EP9mBA1Q5dI65ZttqNNPQ=;
        b=H5ajABSjj2p9xmGywtWE2YgUXFj04KyMf5GnBww0fWFUoH2E36F2vMfwHWdVYCX1nX
         xetJsnxn27dNviLvRJttM+tG2UPTkDARrRLUvhDmBgKoYV4WV62w197vjwMu00kGqtVd
         XzDhp/cCebBZFjkxMwg5fX2C7lyBT3OcqSWZqccO83W7VJEnSbmEUKC0PQR/srUsgO6W
         YJBqIiwLx7bIzAgnC+gdQsn6vGMg/V10ArvYzLrwNIhCvS4NoERKmpyWa67g/u+0htT2
         xBIgguwgmMu1eOqRsg92aQE8v5eWXuVT+x9OF5mdlmmdHfkFOfGRwf0fh4YssFpGEAMf
         MKVQ==
X-Gm-Message-State: AOJu0YxwZUODvb68FRcy2XVkoeEBxZo6PXM4WArxZh/OZo9oMPytZEs4
	Dbb1ARLhXxbT5SD86un2z0DRhvuUW/Fy2+WST94jEQtpdOkFxIyrrpSH6Q==
X-Google-Smtp-Source: AGHT+IFDVeXohlxtYEVQ2KAAugUwHNKzlaiDBfil1d6MvVGh6OmvnotonbjGR7vov/ZkKPvCxndtGg==
X-Received: by 2002:a05:6214:2307:b0:6b5:116:eb54 with SMTP id 6a1803df08f44-6b78e2ad032mr43520066d6.47.1721303125380;
        Thu, 18 Jul 2024 04:45:25 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 06/11] eapol: move HANDSHAKE_STARTED_EVENT to eapol_start()
Date: Thu, 18 Jul 2024 04:45:09 -0700
Message-Id: <20240718114514.2916258-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718114514.2916258-1-prestwoj@gmail.com>
References: <20240718114514.2916258-1-prestwoj@gmail.com>
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

