Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A3181B95
	for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228133; cv=none; b=oI3dwq3I8aS0yX1+OpIOXRQgNdGwaYh4BuyrnK6A/E5UKFHAVKzGddOAHu4CNvdrc7T5FD6CHV4h/vFI8jeIoWFMV41grn6E0An7nMrnseRU7Z4MVtIkfiXfIGS0S57/FH0QvclYKgKY/daVY4RnXPo04/jP1fB2HNT9I3gwYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228133; c=relaxed/simple;
	bh=TGAAW4NYA+/Y4VzLVrhPOmXIX84Sj33+H5noybSUR0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uq05Llj3/FAT6KgFc0vrgIheXUhy4m8KYNNvgglfGyylDQrBXo84zD93/r8sU4ILf4k+aNKoQepyEXa1Lc+LXCVEHIIMExyXbGSxFYpiAajt07umGPmC3Q5a7YPjfu7Q0CqwWAP4b0TS4OZncf9SJEnH4GgOOFeCR5lMIEQKDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDF1wH7A; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDF1wH7A"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79ef82c6391so362454885a.3
        for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721228131; x=1721832931; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EWwYsj3H7RUvXP19XAS6eXUp+2yZiOBfg6yuMA1mqk=;
        b=SDF1wH7Av9wDnjwthB4a/Droz/6HnDfm0UivZ7mPaSC1/tYcgpFu1k2ShoGEuUDBUp
         88N92XBWzceMzTgzloa6VE5CB9QmOmAO//m7qPoL8KGmT2qaZLp2SkpySHeN2rArY2Fu
         b8pIog1m6mFnpsUVCvwEYNIzbtbV04nRwCj9g735qB1PDGpdTZkeoW6bvG9fkIce6fko
         1NrU1QJsmwPI2/0czNsodoQp7gwMjEASyptjtfe1GJ+6B4Lf6SG6+KpyQQtLT9HktEg4
         dMuuc+eZTu3EYgEUxX2Ykw8lULxWxFNg233hejXREeQhF0UMcXxI8hCUAFH82cD5DuHb
         cFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228131; x=1721832931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EWwYsj3H7RUvXP19XAS6eXUp+2yZiOBfg6yuMA1mqk=;
        b=pasNH1lyb65lOd/DlcV1miukng8nszwaRzG1G/ogGqW9QqqGBTviL5VdbInxfDxyLW
         UuhYyJOhEdBTZNOPQ4D8kOkL6mZ8I9ew2PFxTXgXjF9MjTdwM/I6aePryD3hEjqtK25K
         XZZUoRW7nV3uomukzmi8+rV+Ppc39QB391Kklmx1tv8h4hJETbe28Zol5X99Ssu3SRtd
         blGINT+RrsGEIs6jqI0UmbXRP9c9c5meJKt9j4tCHmnmH1yDELmLSu5UBkttEZUAYxZf
         p0GqXTN4nZBYMhoH1wAwlbTlMG2+4aUxQBg6RfkNNNPTR084jTU6v+qBtDtMyFO7olO1
         bPig==
X-Gm-Message-State: AOJu0YwrLP5H0A9M2aLWbm3VmSsjGkTAFpnXciNG+MWgbjZhzAz13EQE
	gckn7tVr5Xu8FGRTY9PqvMQe9XimDI7uGBXMyKLhGDzO8hL46NUpQy3mDw==
X-Google-Smtp-Source: AGHT+IGPbDZKHMaoLaZkymwhS6wRVMV0SN2BTRrUtuhC+CYOPOPoXlIk4wTPuo0oNHelqw3NmxOQsQ==
X-Received: by 2002:a05:620a:29c1:b0:79e:f9f0:4347 with SMTP id af79cd13be357-7a187448b81mr189713785a.24.1721228131006;
        Wed, 17 Jul 2024 07:55:31 -0700 (PDT)
Received: from LOCLAP699.localdomain ([50.78.19.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbff41sm407195885a.53.2024.07.17.07.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:55:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] station: add handshake-started debug event
Date: Wed, 17 Jul 2024 07:55:22 -0700
Message-Id: <20240717145525.2656306-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717145525.2656306-1-prestwoj@gmail.com>
References: <20240717145525.2656306-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/station.c b/src/station.c
index 05392fa2..bec19d79 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1015,6 +1015,7 @@ static void station_handshake_event(struct handshake_state *hs,
 	switch (event) {
 	case HANDSHAKE_EVENT_STARTED:
 		l_debug("Handshaking");
+		station_debug_event(station, "handshake-started");
 		break;
 	case HANDSHAKE_EVENT_SETTING_KEYS:
 		l_debug("Setting keys");
-- 
2.34.1

