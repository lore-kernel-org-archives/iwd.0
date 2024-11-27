Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694DE1E1041
	for <iwd@lists.linux.dev>; Wed, 27 Nov 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728816; cv=none; b=kEXBcGY8eBngsJQ4OsL9aOFE0lSwdq37oTQn9fKxpSfJaqAdHQDvtfa620YUQgS0qzHJuYnb7TuN7MGjTPKRmNtrQl/eKVt0WosZ1QudcFXtChaHEYwIVStB3ALsmOveJzuqpbNcYulJ+YFKEhZG7wlbZiw9xF0a9NDWwkJsJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728816; c=relaxed/simple;
	bh=2Zi4/vqFtxByKs/3VxDoJnY99JyExLX1mp2WF7lSBr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKRaGE2LS5QNtr2QwVdIOoqYn3dNFdKVLfbCTLEjztH+gr3oPX4zg0zr0+q+nQgJRp9FwJfHHQLrDmzHlTQGROvzLE7krzEbMPWL/lY67oJDjjLQ8TSmU8ik7gFPCRnzm1rjUTTKCk2HqrGuYragfBcZV+j6rsxR0xEZkyB/kKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCOOv19E; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCOOv19E"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2126408cf31so51311595ad.0
        for <iwd@lists.linux.dev>; Wed, 27 Nov 2024 09:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728814; x=1733333614; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTf38Av7Y42HfeDckzjvAA0AbIrAstHrD8Hg1EQv/xY=;
        b=BCOOv19EKmzALAUqJ1MLQK3fB2JDqi0EOXB4571ooKtoIPHYYMNFk7UEXvtUfyi3oA
         DR/Z7tIcNGs8vJ0oWj52+MwOmMlM2BsKgHaDsmx+IKUDHxUsHtCGO4VC3qDb9b7XFH3a
         DpCAbpggQQ4FQusn11uPNtj63K0VTjYrBaP3obV9M7USGvnefxKCJ5zt9tdB8n+WGTlT
         VWUyaj6UI4UrOEM3jOzM7/nJjMRjXiVszibRJ//H6y8vfaVyDudELZ+GqawzzeJie2BI
         +f37VSi+Kh6DImCaS7/3EgQBSHC6PwunVoafw7+hKoT9Q1ajqv7f7xIca6GEqKWaoNzY
         XngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728814; x=1733333614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTf38Av7Y42HfeDckzjvAA0AbIrAstHrD8Hg1EQv/xY=;
        b=tSevsqcqZYOO+YHz/hCGbGBxWtYvg54I3iQQtf+T65S6WYxUGW+E+7Rj+r9gvX7O8w
         1qY6MBcocRzoMpnIJ8XwaLiZGaMPoV2/CRY4DIGxQRHLaafZ6ANkGAsuvDsmIqQ4eV4J
         sPznbyRd12x0/3pncY87+x2U8yDy9ue9g3bRqf9hN5zDrUfzwLvxBN4Ok3Zg8nZMD3yX
         Kclgsm2PFaud3BRVzqmqUfdpFpYpP6GwCIQipqUa0Pmqf7rRb8u3vlbwE2TO6ld690wi
         17OgTbSgHhxPWPHA8PiElMYZy3QbdmKaPr61+YG9ZVXnKYe2bFgl+T+RtgkUl2RqERAk
         fqtw==
X-Gm-Message-State: AOJu0YxjvCsjcaTAMeteoaxwyCMA534liBkul8TGtcINUg7fwa/DHchG
	JK67Mr0Nz4eE0M9jG6l12E0QtTq0omxPi3l787DyrELq9Ns4goUumGNRvQ==
X-Gm-Gg: ASbGncuh6+rujv9GG14jSPxJTraWAzK9xV9qnRK6Mg2Zgu+AvFWkDwh0DG/hHW+tS0N
	vm16hl0C2Fpn1VlKJFZIrwAshUjeEFFSYqA+IXGwwUeZFjW/+FeJ1P/pLU2CA4MS6LLwa9aDH1r
	yZss8/zqcTBHZ1Hdwg1Yjo8+5EVpw7iYaYf5EPVjKMjHbOTG8AuXYBCsEhL6ycAAI42lkYrdJ23
	/Q671MHdURjBcclPD+5pb03sUSWQ7V9zs9oR6LqZ3/zcBPdW9HgUjWMSJdl
X-Google-Smtp-Source: AGHT+IHkvGYa6Gd5O36r4wejFYGYsZm78OXyXoMqGPrPxhlq/D748qqp8nxMNcAQs+DnB5Uu6TKyuQ==
X-Received: by 2002:a17:902:d501:b0:212:9b1:e56b with SMTP id d9443c01a7336-21501b5a270mr41895425ad.42.1732728814494;
        Wed, 27 Nov 2024 09:33:34 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba3022sm105487305ad.65.2024.11.27.09.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 09:33:34 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] monitor: track current PCAP size
Date: Wed, 27 Nov 2024 09:33:26 -0800
Message-Id: <20241127173328.158354-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127173328.158354-1-prestwoj@gmail.com>
References: <20241127173328.158354-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will come into play when support for rolling captures is
added to iwmon.
---
 monitor/pcap.c | 10 ++++++++++
 monitor/pcap.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/monitor/pcap.c b/monitor/pcap.c
index fb29eea8..b13a29f3 100644
--- a/monitor/pcap.c
+++ b/monitor/pcap.c
@@ -60,6 +60,7 @@ struct pcap {
 	bool closed;
 	uint32_t type;
 	uint32_t snaplen;
+	size_t size;
 };
 
 struct pcap *pcap_open(const char *pathname)
@@ -152,6 +153,8 @@ struct pcap *pcap_create(const char *pathname)
 		goto failed;
 	}
 
+	pcap->size += len;
+
 	return pcap;
 
 failed:
@@ -188,6 +191,11 @@ uint32_t pcap_get_snaplen(struct pcap *pcap)
 	return pcap->snaplen;
 }
 
+size_t pcap_get_size(struct pcap *pcap)
+{
+	return pcap->size;
+}
+
 bool pcap_read(struct pcap *pcap, struct timeval *tv,
 		void *data, uint32_t size, uint32_t *len, uint32_t *real_len)
 {
@@ -279,5 +287,7 @@ bool pcap_write(struct pcap *pcap, const struct timeval *tv,
 		return false;
 	}
 
+	pcap->size += written;
+
 	return true;
 }
diff --git a/monitor/pcap.h b/monitor/pcap.h
index 1705b33d..5b797cf3 100644
--- a/monitor/pcap.h
+++ b/monitor/pcap.h
@@ -36,6 +36,7 @@ void pcap_close(struct pcap *pcap);
 
 uint32_t pcap_get_type(struct pcap *pcap);
 uint32_t pcap_get_snaplen(struct pcap *pcap);
+size_t pcap_get_size(struct pcap *pcap);
 
 bool pcap_read(struct pcap *pcap, struct timeval *tv,
 		void *data, uint32_t size, uint32_t *len, uint32_t *real_len);
-- 
2.34.1

