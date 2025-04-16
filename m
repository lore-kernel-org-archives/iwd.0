Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24C6FBF
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806868; cv=none; b=AA4cPNKmqTmjSVEBUs9wQJ/6gDruZP4vGvDAo/gfxAYxzghhUkMprGDjTVWvuyU33NKr6ZeCyhgKnIwuKhHsVosghaueui3EbifWcjrmBUKzzHHFdxwEHMxmWTHIqhtyDbx5gEDmFmuW6qeMgecrNpk6Mp4RrHv/AwNBYEmagOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806868; c=relaxed/simple;
	bh=MHQbTckju6xqhW6lrULPhJj/4+mL4ZQFwpnfTJ/JHmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1SI6YW1mf+LrDzpz7ZxG95XQ5tJApcOpkqdZYR4ROnFIN1JF7b+/qU2LfmDCvb16uPWm6Bv9L/DxzzrAlOUZeWWY4AebyYm+MJ4A/Ut9zgCei4aKKVQ4uyNKapFzFNyIYQSF08g2/Wk0s+kKH7IL9c0GovYjUFH0jC90GV5c2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoHx5cAa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoHx5cAa"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso7451792b3a.0
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744806866; x=1745411666; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBSQn9yo8qa+EQMx6pYBu4ng25ctApqBin2P7P0xiyE=;
        b=KoHx5cAacshKyKACmgDkiPrwR4njR4MhsTqt4Q1ePgbE6BzWTPOM48JijhZqRWRyUY
         jcH7XYbaAUgaFH8wreQyFwCfMt61WfkmVfxtY/hb3dwFFO6dlYmiALX1a8iDFyF7qp8c
         733Qm0qQNfqYxgdEdiCd4fRRlb0mWLAOfzrTPquY8B1MI2pUaDWnnk8ChvUc+EeRQvqk
         3aOk93d73mq6ZbywEz6RZ6QpJeVrraBfHvgbZ2HemsukOzcR+O9RtfiL11vqqvdyKOk2
         s7tje9Ps0N1DpUpRU1qlmsm/Xa7vY3PQ1XFNsLv5nz48kA4I1fjmYec7fOEgcWPXRj5l
         2qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744806866; x=1745411666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBSQn9yo8qa+EQMx6pYBu4ng25ctApqBin2P7P0xiyE=;
        b=EOFyXsd15bwWAKD7gXG7n/jfDJudECuYO666RFC3ltfr8ZGxqnRs6s3MG9gI9K5dQv
         4USJ2Pxf9Puze5sZLExdKwEZeoTNuxqscgKxAb8DEz1K656Ndv0vxIhRt1moHFhsSWiH
         lRGT52uR8tvMCBrDwOuBy440oIqkyXjfI1ALMAgYXTd6+WT0FKgCXm76XCfQ3hmUTe5t
         bywOR/aa1krLvSSuZOj665Ot9xr2a4AC2saqY/qCU99lAEEiLhflb/VTBwd/h/6/8uH+
         EftuD+xda3TQE+sHTOP/zmGRK5fd5lpcYFAtKxSiwgOW49a/+3d8MC/yaZESGisLhiEO
         BerA==
X-Gm-Message-State: AOJu0Yz8Cgy+HpUMOnSyX+LL5YLYwuHZ2EPBA2z96svohAmLKv1rwMHW
	TA7jz8lfmCa+zyluwqhm7AdN6ad/bejTUuomvcFkKkfymZwpHFMIivbXGA==
X-Gm-Gg: ASbGncsU/sT87s8F9qEPudMXbsOkhUmBPB5CHwJX2pR2FcDR1SOriR3sClInODk633T
	4/Zfd7mobWWfTStaG0gULHB4zGMonpTVUVI4bD4NkNxe/yKryaVHJI7vTEgjIIZU0pmGJxH73oN
	QWP75NLGntmUT+6EP5Hdlu4v4R9KocbuS++ATcrTznTpFJWiMhF2YrOB6PoXotoQZ/SFzzvvpIB
	TH0YwXAvMl47tRF/w70kR0pE6iiloahqg4JAYcozb2xROm42ofQTnMnichtKB0TUaG8mN35lzC4
	oFLEH0VVAsRR758fS1I/C/o2VrSZHVmLwJG5mpm/rlXFDjmPd7EEsJPhcobXpVxWY6khoFKZAbE
	vyPNDxSPMdrvBvaO7d51FCM6vDR8=
X-Google-Smtp-Source: AGHT+IG0CjmzIdA04qZZwQHcNNUBjbWzYinb6D3G7RXIfZGnr95D+ll7QdHe/3JVRXuKWXgt//QJbw==
X-Received: by 2002:a05:6a00:2d29:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-73c267206aamr2374935b3a.12.1744806865544;
        Wed, 16 Apr 2025 05:34:25 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22217ecasm1124408a12.68.2025.04.16.05.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:34:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/9] station: check return when advancing iterator
Date: Wed, 16 Apr 2025 05:34:13 -0700
Message-Id: <20250416123414.114231-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416123414.114231-1-prestwoj@gmail.com>
References: <20250416123414.114231-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 9972ea76..14c93671 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4836,7 +4836,8 @@ static struct l_dbus_message *station_property_set_affinities(
 		return dbus_error_invalid_args(message);
 
 	/* Get first entry, there should be only one */
-	l_dbus_message_iter_next_entry(&array, &new_path);
+	if (!l_dbus_message_iter_next_entry(&array, &new_path))
+		return dbus_error_invalid_args(message);
 
 	if (l_dbus_message_iter_next_entry(&array, &new_path))
 		return dbus_error_invalid_args(message);
-- 
2.34.1

