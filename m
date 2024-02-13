Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342960B89
	for <iwd@lists.linux.dev>; Tue, 13 Feb 2024 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847749; cv=none; b=WA+VLF5/S99j3/LFBQr2zTahuy5EOyLvfsdVIiEkFadPwzy/HIFkQA/qWz5PgeEyYkElvSoFtXi/n68d15oLPYR4em6pcOesvn/LiRk+sLAUBB+M8XIuNgnrX5TRzUdyN3YXaG6lp/KhQdJvLt++eOHx254oHl8Lmp9n+hQjtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847749; c=relaxed/simple;
	bh=qJIJ8eZa3iNbrFJMuRWrAyPOSIWIKmkP9tzEd7+03ms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M5eajkKR5Zv+ja52YXkZG9Ttv5N7UUPGNKDhjvjlst5epYYSU1d7il26kWWP6Fnb4BIWUtVdFLtgqeOHZHcpaqSX7DfHKyvnXXlIxfk2pg9pC+Qb40/rX8Nd7q9w0eEQLrxDwUmzfb3GxDjt12tPon8t2xrLlQv+ReYIdN/5gEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaRlaH0K; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaRlaH0K"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68c4673eff5so22594946d6.1
        for <iwd@lists.linux.dev>; Tue, 13 Feb 2024 10:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707847747; x=1708452547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/zYnWPWa8+rIdJA2Fhi7gU5m9F9jlb+RNCQTj1oPu8=;
        b=WaRlaH0Ko/oZxkPN8Wej1nYUp9pz3lhwv68ZOh6jc3xtLtqa5SgSxLwL6ObqDDpGrS
         wxmJeb0hKkqTHT8XLLDff2hjAKnD607EKcgn2eT3zst5nfy/Je82vjrTxDJNETbn2QGa
         mJNdQUvNBh08GrT7lFBPVX0p7w3OBfP1qBjdCGy3iWPIJy1852B68jobr66lrpV6dJOj
         Eg2mqH6TuyOOypFzfVkTqHUpXL+2OiRUln0mtlo+hnF7i0ckLZWEbLPnp7+hOEMcO1e6
         fiPOgF20vsA+REl+sNpJ1E1zXBF8hKBeASZO14gg1gZJynf4KDWcYzzEsbzOLMM48UcQ
         JCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847747; x=1708452547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/zYnWPWa8+rIdJA2Fhi7gU5m9F9jlb+RNCQTj1oPu8=;
        b=Bxf7GorEhsaax0Ao4Hcit/JDUeTf3xXQTYFUQwqcxk/Hw48c9MPm6Fx6nkKvKEYVP7
         FlM9T/w/ouK1VRX7puL1O4gtxxer4tQBkcON5omSooIoOh490FBl+fxO/dFHga/8lFhf
         RoDyLkwWrn9b4owZcAbH/Z/is34MMmg5ujo32N/5yOmVuHsYl41JsHy4rtCywOOEMwU8
         tb3BajHE4sniLcn1iQ536UFhFwWoWDumDAVtNojJPAG4GjvEb6vg2G2yGNyoIl1IRzWW
         0EygWcgzmfYMGWtgmFXUkWwk/Jt93r5Rx0HppsW/vNAym5EvZULV/l7P0FpxBvpY3alA
         E91A==
X-Gm-Message-State: AOJu0Yx+uHx9V79H+i92kq7c74pT93z47BnWKfuH4ZgOoo/FS87AlP6g
	OMr19o6/WqMy3DFL2vWCchTbWBSrP54p4+ccOJieC9fAeU3ClZ0nB/nEqyblzBU=
X-Google-Smtp-Source: AGHT+IHwD+8Y283Dd1ALt6yvdLKRObN467MRt/H3hrZ2ZK6ByLjhtCbk79kX5xIyIVS/fpV+wVj6UQ==
X-Received: by 2002:a05:6214:d49:b0:68c:c3f7:618e with SMTP id 9-20020a0562140d4900b0068cc3f7618emr297771qvr.19.1707847746881;
        Tue, 13 Feb 2024 10:09:06 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id nf7-20020a0562143b8700b0068caa42dbf3sm1461670qvb.91.2024.02.13.10.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:09:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: use reason code from netdev_deauthenticate_event
Date: Tue, 13 Feb 2024 10:09:02 -0800
Message-Id: <20240213180902.850693-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reason code was not being passed to netdev_connect_failed as
it should have been.
---
 src/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 2b3925dc..48fb15df 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1375,7 +1375,7 @@ static void netdev_deauthenticate_event(struct l_genl_msg *msg,
 			MAC_STR(hdr->address_3), reason_code);
 
 	netdev_connect_failed(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
-					MMPDU_STATUS_CODE_UNSPECIFIED);
+					reason_code);
 }
 
 static void netdev_operstate_cb(int error, uint16_t type,
-- 
2.34.1

