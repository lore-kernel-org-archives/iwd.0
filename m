Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015792690F2
	for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302026; cv=none; b=ELyw/URhZOywZ2Zh51DUh4Xgt5+nLI1ftnoGTIlLn9GRcBOLBJJTDN3x0YkNeCXdqXoBSqZmmiVIJuMrmDz7SE2BcCGXXP0DmGrxJjBnUJzBysFsdjhdXzwAY1E1+MnvTSDgK4pZakT+GuaGNL1m9/I5zOI/uRdlUvWwKvMawTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302026; c=relaxed/simple;
	bh=Ae8ishP9HSnR8xHa9lW9/XB27vUXAz7jv/QgDY9W0B4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RIg8fVoFAvFLs21ieGApMfn5tRr6Dz7Ph/TmkR/0YHIOwbcYOD4R5fAxEmw66BDBaRIIWDptXOMREyGqhVHi7kgx3FPv04xS6iU6okPVvAXE0xwqfJMyUGsn6lkEGKp4KR5/ilV0264K6ZOvpo2WwLR+kHM9ciHSbHUZuxDP/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQoxZ109; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQoxZ109"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4718d9dbcd3so36330871cf.1
        for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739302024; x=1739906824; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=memb4uFhdww4OmKs4VK9liMd+EgKjITX9t4n1kRFoOk=;
        b=gQoxZ109JnYPo8yggg1bzrWu1sEUzF92WNlLNEgyGvTiLbdpxPPoBXzzp0c9ZP5Kt8
         2qxnziPGY4wzeLUvjwjn0c2+3ZGL53bPTChlExgBsANsjZKo+F0Mty0eaHWLaU2IvUDV
         xjRZdHk4u9l3Mi+a+vDx1our+YaZXvOLLsiSYo8mePo/ADHA3lmmVOGjF5nZgYAsJvqZ
         uYJ6iUiLhLPcQHeDUbVtZIRzxYo5583rA/Cn1/qRyB25RggJlAswGgDu7floO3iJq2wB
         zMJ/6cGEamrLqdjCl1qZuBDgTFKbiPzPAj17j3zkBbCc3pcZcJJbdCNrwahWOBvjwfXs
         m9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302024; x=1739906824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=memb4uFhdww4OmKs4VK9liMd+EgKjITX9t4n1kRFoOk=;
        b=Z9YU4ImktGzLEubpr22xB5a0DKzqjpg7qSCvYtgbWbqgp9yxsawLCqNmqd6fnZ9zGq
         /2w5XOr1uDr28ocNtlCor84r2gl9DcmIcpEcqfIh9ft+2fsajVr6odGoh0QC4B1rMPe6
         NzWUObF79/S3aQ3twnMaAlxgChxfQQa5tEMoU/WIpF7Te2LstzJoT7uJB0eBeZyf1Nxj
         FEfjYiAm7p2zyLgcS3IYBTbVvQwX6wjJKOkI4ZogsQ49qkRxe5vIH4i+4GvY7OJNlpmM
         2gYBzu+WXxPHM+eE2PNM/Qs+dfMAzZ4YpXLc5maygaD+88z7+bk2ZxG5LFoSX9cWntN6
         dHTA==
X-Gm-Message-State: AOJu0YywEomnVsy6NoD1C82taVO4aVTkJBysIQ6im7zlPKpXYyLng24A
	TPJFlBD+fOKthCXSSQpwEzaIPYym+xj+Z4pj0JhsL2StSd1z4Tdvqp+LNg==
X-Gm-Gg: ASbGncvEnjIvrOyOGjFy+QRAdB3wFTVL9bAPwdrdtyi8Xt7EfGOaDLrLjTSQSF168z9
	XmMfgcu5Qtru/Y0fvBQogPWMOo1576+aWsFOtu33z2xorkthSge2ZYF9Er9IVMC+QiYqVmGdeEZ
	GSTFtFUJZHO4AZL8p/zsYqin7JrY9FCJKTHAz52EVpsjOUMWIh8Yftcl0/u2e5/ke4ld7JMse1f
	XAaWZe2scTXbuKuF1rLJNv+elz3gH/hlOH7K8ZRmpm/Is5ZlDO92za8wA+VBEGmTf8GrjzqMyyp
	7EeD3Vghfw/ePqoZsMF6Guz67w2yIo0Splq0B7GADyuCkXBW0A==
X-Google-Smtp-Source: AGHT+IFr1F4uMq4HU7TSi2MZYsIjYwNztMDWUwuLc/a+grq9qCpx0p3uVPDqqQdZrZmA8I+jMlF25w==
X-Received: by 2002:ac8:7f8d:0:b0:467:50b8:63aa with SMTP id d75a77b69052e-471afe645cfmr4958971cf.28.1739302022043;
        Tue, 11 Feb 2025 11:27:02 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4719dab7aadsm18681601cf.51.2025.02.11.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:27:01 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] eap: initialize vendor_id/vendor_type to zero
Date: Tue, 11 Feb 2025 11:26:53 -0800
Message-Id: <20250211192656.83157-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixes a compiler warning, specifically on ARM/GCC 12.2.0

src/eap.c: In function ‘eap_rx_packet’:
src/eap.c:419:57: error: ‘vendor_type’ may be used uninitialized [-Werror=maybe-uninitialized]
  419 |         (type == EAP_TYPE_EXPANDED && vendor_id == (id) && vendor_type == (t))
      |                                                         ^~
src/eap.c:429:18: note: ‘vendor_type’ was declared here
  429 |         uint32_t vendor_type;
      |                  ^~~~~~~~~~~
src/eap.c:419:49: error: ‘vendor_id’ may be used uninitialized [-Werror=maybe-uninitialized]
  419 |         (type == EAP_TYPE_EXPANDED && vendor_id == (id) && vendor_type == (t))
      |                                                 ^~
src/eap.c:428:18: note: ‘vendor_id’ was declared here
  428 |         uint32_t vendor_id;
      |                  ^~~~~~~~~
---
 src/eap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/eap.c b/src/eap.c
index 9e924577..1a03fbcb 100644
--- a/src/eap.c
+++ b/src/eap.c
@@ -425,8 +425,8 @@ static void eap_handle_response(struct eap_state *eap, const uint8_t *pkt,
 				size_t len)
 {
 	enum eap_type type;
-	uint32_t vendor_id;
-	uint32_t vendor_type;
+	uint32_t vendor_id = 0;
+	uint32_t vendor_type = 0;
 	enum eap_type our_type = eap->method->request_type;
 	uint32_t our_vendor_id = (eap->method->vendor_id[0] << 16) |
 				(eap->method->vendor_id[1] << 8) |
-- 
2.34.1

