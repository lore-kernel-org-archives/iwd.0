Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB064A24
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806864; cv=none; b=UNxfNKpPAvCQdc5CkDbtxAx2xpncuYUuBac98e+dHe/mnccjTUaHAT8DDHhXpOE1kFL8XXiaNUyQiXwwI7DAfbyAGsxiq2WEp04wCnEObTRnk8R6sWvx7O/F8/w+lvZMmonQVmkmmqu1hybBZXAQEveXia6LoVSAqTpyEhsADjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806864; c=relaxed/simple;
	bh=hUd2YT0aGCin4eMSchiyq7FG01bWPKTS9+SRylV+eAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VGJHflGodmPR5sTuwzCGPliJRPMp+krb/wqeBhRdCY1VSNMpenVsiOBNo5Tz5iBjaV8Qe1HIka/T0HaaFoSUwkd+0K0/MGK+29tyaTdHy/KO0NAzpNY20gc9YjIi+XnQnHZwih9Bd1BUzxoWvJM4ROzlVzFWaUU2vSKQAaheBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmjyxfXm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmjyxfXm"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73bb647eb23so5979958b3a.0
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744806862; x=1745411662; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZuV++ETRS1A3j9AaU2IkvJsHQTs67s+TTFawoqeHw8=;
        b=WmjyxfXmFDL4a3FYTgFlxzywGKDRjz1Rz2YNmIeUxRO9Vxd0POLTu8kMhnZZfsIiFb
         DRKhtSskJP0GvJLxk7R9AwYwAxbftrcNMFLqkMIUUjNR+Qsdl+XvPAWgTh1obve3GoYu
         AbODOMj++5hZkKAsjeHnRlV+KB8MzUNxAwkOTI6/1quVnodpJCEH88DwJzUTHqw7nEMS
         cHee93HXxQq2n+lmRdgyET7/usAV1CHM5qYOSnK9WQopfgn3eQ5n+2Ch/3DtaOkl12Zt
         jExd0oDk3n395/K2ZS1FrOQijLXQnn5KcyLIA0bfdXdWC8JGH2IVe4C/GiBQigVp5/+Q
         mgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744806862; x=1745411662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZuV++ETRS1A3j9AaU2IkvJsHQTs67s+TTFawoqeHw8=;
        b=Mx3HlBB2kcCZTvKgTHnTF2Aj9rjtjz5Cj+bEvEkNlKBETGYmZ7MYfKTmRkQlvgMBdb
         tiP64LBjGzVz2aM2GC1oVWVheYUYSZ+BH+iCqY979ONox4G+lEUqV+yW451z1CHXmJ2L
         Mos/cTCkXWirL8gjidPL48Q4u8jJp8D94P/QFwNal7G6uBTEZR6S64/ilTQj7er2asFO
         zbETjP3MWAkmfQmeJyzytzcUozJ0+gilx3XuU330RO7plvzgXkXxoMMUifbQsG2W+uyA
         R8pq2ajZW9NebaaZjkNm4A7KgKqYslz7CV1nGEFqFkJ2uIYht5IUWK/go20GUwwooB4H
         gUrQ==
X-Gm-Message-State: AOJu0YzDj0hAJKMRYHQefBpEnk55BcvOMQUkNMW8YQpYUGH3tcFb2MCX
	m36Q9olqXlR3nxk86xZ3A8W4k3CiLRjLEd5NRaWROFoiEmwxVp9Kem8ZoA==
X-Gm-Gg: ASbGncva3e5VYstk2PhuySPHnrPlMor+pntDMww0Sk50kHAslkddwyicIFS6VfTBJA/
	9Xh9OFyXCUIUOm5F3l0kEyX2dVesxGNMLjYCE2vwByoPe+FdyeCaoNODzvJ/lhkod1dWEykdGRJ
	D9o7OcmAvsYfNZG492rQC3fLet0s0p+KckKPiOkfqKipyUi55T6/B+MGKcjWq593EbokkIZ14em
	jRnXKrOJK9iyzhq17fdwsn1LKWeBHHJwO/DyN/IBUPpr1N4yh7HqZK/xEGCudTT+szSOP+fQe3+
	Zg0QD6+W55E5vGYPrmaYyzHUtzmJ0Tq37KLyf9GmoCESpmcWhMhNIIuSvpwDeuSmQW3YO/3q54P
	5u8G1EfaSRnUB56Rb8y19jwBD/YU=
X-Google-Smtp-Source: AGHT+IFXW1PX6FbyvttjLpLvbdVXLpIodS8KVf+J9NM/BIiotJU3vY/P1ro3hXCU4y1yV04XvsrbRg==
X-Received: by 2002:a05:6a21:108d:b0:1f5:a3e8:64dd with SMTP id adf61e73a8af0-203b3c53020mr2889369637.0.1744806862125;
        Wed, 16 Apr 2025 05:34:22 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22217ecasm1124408a12.68.2025.04.16.05.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:34:21 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/9] monitor: add size check for interworking IE parsing
Date: Wed, 16 Apr 2025 05:34:10 -0700
Message-Id: <20250416123414.114231-5-prestwoj@gmail.com>
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
 monitor/nlmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 14a29eab..7924f6f2 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -1915,7 +1915,7 @@ static void print_ie_interworking(unsigned int level,
 	size--;
 	ptr++;
 
-	if (!size)
+	if (size < 2)
 		return;
 
 	/*
-- 
2.34.1

