Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AAD3F8D9
	for <iwd@lists.linux.dev>; Fri,  1 Mar 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322064; cv=none; b=ZzNgXbw4k8e96aiVAH/k3QihCOYWk7ie7HpGvfXAaumpPik6GiVw62lntXKdJEh9DRz1hh18p5eUTSIb34rd6vOOvouIhO7YPnvCIWBWzmIxTRIeVFPog9zi+R7q1qqd6wLNxDMijvg2KD5fUWWK+9FVSRAeyMEFRzeQYxkXejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322064; c=relaxed/simple;
	bh=lj4QW0jSsg2NgCHN69LlslB+2wXTYOqzNjZ/NOX9CBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DUoIlLneLTwfGqVn0qFGS1OgudJbvXwnpsLv50Qdx1V1/SwUmBFuiD8VD24O617mvCFSMZIH2ErjIRNyOByTwJQEjjosJm7cngXg6N4y2G7zgP4Iuz8KlXmBx2He0PZsFQE1wbw8wsFP2kJLvavMazGSA6MU7e/f1gpgfwM62L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRgOdrbU; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRgOdrbU"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68fcedcf8aaso10872266d6.2
        for <iwd@lists.linux.dev>; Fri, 01 Mar 2024 11:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709322062; x=1709926862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDIckw1ifN+8BTd+L66m/equ0POj/+AQCQG5kM27P+A=;
        b=CRgOdrbUZAl0rZHxNL2Sd2em+28foDW2aVixsHosCEY2xjcdtdYM9LsfdjhU8tFlTB
         Ig4Hz2xDOZ6dso5/aC5XrNcBp3eIUWTjKja+tZ7RsZVXQdmhISueVMys2aMZHrBOvzaO
         VaaQI5Yz+Axlf7KmMs3VvJgsmPp7mcbiwv43vW7UFs4lS+xaTQMH+LcIxDYuQLnZ1GVn
         J2LsyAEISC6JqsB/uPUQyAkBguMRKDkvAxIAZ0RE1ocgrnlsCNTEIBsYgym64aHCwRGr
         55XKWNdNzgWtzuoL9jFa4yuPTfbB3ir8STTQxbvpB2LrYgsdydp5+V8xIIrD5G4WQX/E
         CjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709322062; x=1709926862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDIckw1ifN+8BTd+L66m/equ0POj/+AQCQG5kM27P+A=;
        b=Im4E0j+8ERlFOSzg4AirRJzCBuhXZirUH/nEQCx9acaDsty2Hg8O+XgMFtswXFu3C2
         5DQSOaEWB0B/4BWva5p8f+1A8Njw01Ia3hupS5Iy7/NWTEcHdI20cBMXucOIuX+cLM9U
         j/MWBKLK1W3a6CtpP/+UHMYHOVuU5cFVP5JywCg+0sTanqHAl6pf3DSpd98i2QCDlxlN
         kFH79ZH8V7RBqVV4NppUwNM7nnyztC0vWWJtcdrvIY50r/LE2qVHbn5r72WdxAbFTj9F
         kNC9M9MGKsRz3eMsk0qUTIUsbXIdz43fwrK7RwK2+ks1Hme2ClzkO6Ua2v26ZqvPPKo0
         ntZg==
X-Gm-Message-State: AOJu0Yw647w83OmV7wtQ3QicmgyHiIvuAGsskoSfJyRpeyDe+lnzcLDF
	aumUtHbVeuNzxmJcfnsLEQIagYO4ID2MzG++hkothsdJnNRR80Di7dSgO/NS
X-Google-Smtp-Source: AGHT+IGtw1Z7ssSuZnFYYKJpgZPDRian+MU6LWzAhUGVEXkmoVt74tMr2X3wtUI+Rwk9I2Z3VNtSIg==
X-Received: by 2002:a0c:cc87:0:b0:68f:a13d:ee26 with SMTP id f7-20020a0ccc87000000b0068fa13dee26mr2606336qvl.21.1709322061782;
        Fri, 01 Mar 2024 11:41:01 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id mu4-20020a056214328400b0068fd10638c0sm2162397qvb.20.2024.03.01.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:41:01 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] p2p: check connected peer before processing request
Date: Fri,  1 Mar 2024 11:40:53 -0800
Message-Id: <20240301194056.1665549-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caught by static analysis, the dev->conn_peer pointer was being
dereferenced very early on without a NULL check, but further it
was being NULL checked. If there is a possibility of it being NULL
the check should be done much earlier.
---
 src/p2p.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index 08fe8444..205d4fcb 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -2310,6 +2310,9 @@ static void p2p_device_go_negotiation_req_cb(const struct mmpdu_header *mpdu,
 	if (!peer)
 		return;
 
+	if (!dev->conn_peer)
+		return;
+
 	if (body_len < 8)
 		return;
 
@@ -2438,7 +2441,7 @@ static void p2p_device_go_negotiation_req_cb(const struct mmpdu_header *mpdu,
 	memcpy(dev->conn_peer_interface_addr, req_info.intended_interface_addr,
 		6);
 
-	if (dev->is_go && dev->conn_peer) {
+	if (dev->is_go) {
 		p2p_set_group_id(dev);
 
 		dev->conn_config_delay =
-- 
2.34.1

