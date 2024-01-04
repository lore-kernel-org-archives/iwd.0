Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF424A07
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+Wew4G3"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28c0d8dd88bso454951a91.2
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 08:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704384036; x=1704988836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InKkzwSMRWTA0epKJPhOADzVVYM/nexnJIebKVBluZ0=;
        b=B+Wew4G3BaPLvWLxuISwgzVX5UBb5HF1tXKMCYApsDhZmI2xULD8J+nc+BNZagnfR8
         DevUo5QxSlQEzKwBUKFfxZDPIrFQ7jMjURqQeQBOyLLda1IHtBklgtoaVczV18B70Xhk
         YsiUcLxaqjqSfiwL/YtGFsxgJmP3HBo+pyqFKIDWTXfkddiLfjf87IswEEdiI6OvOakB
         Zmx6cNaUtgnR9raLsG2AMWVQZ3XMt+meKTQ9TuLqjlj+qaLvu5UCb7hY6BnldbyiNUaq
         nic7SLast3m8x5cubLRhJgJzn09BUfVJ0s5wEzQGlFsu/889ksoep4INscK10cYyOCns
         NP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704384036; x=1704988836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InKkzwSMRWTA0epKJPhOADzVVYM/nexnJIebKVBluZ0=;
        b=DxJHGjOH3JppTPqCQVqYg85UtnK+E8r5cr/ct/lRlvfdoqKc9RrwFSiMVoK8B9aWbl
         WpGfgy0fmGierTcBYaQMTtdrUfzD9OJQadcn5LNMbHxn9cQJ9xVfbc79foFHvrqggkAL
         PMzQzNdpyrXaUXXVBQvFGxdPfkjE3T5w3slRfyLyejTgYEiThgKc0LugRroD2WZuKEXn
         u2T5yYt/buNfjB19hGV6uRj0ujgzxOv/O47Pq+z6MGNf3UI5mMWVQ04zY4c9UNPA+Wbb
         NO4KpGHVGd9bylte8iQVEjV0LZqNOS6Th9e4/lEvpXqd9u6v2Q7AgSRnlbTmixFT6Ue8
         DwFA==
X-Gm-Message-State: AOJu0YzAyXBcoKsEQ5f3aoCZ17Ngyhv5OXt0d7egzs2PehwYbPSXDigK
	WVQdUGtqtnP3n5SF0JtktvZzneirtcE=
X-Google-Smtp-Source: AGHT+IGugWMMflkT4pX1o8KTHq+tGCggP457xlZSuIBN/KhTADkBJrBu71IXkGNB/ryWv6BhuneH9Q==
X-Received: by 2002:a17:90a:be08:b0:28b:fa2e:ca56 with SMTP id a8-20020a17090abe0800b0028bfa2eca56mr647047pjs.29.1704384035649;
        Thu, 04 Jan 2024 08:00:35 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090ab70100b0028bc1df95c7sm3854600pjr.4.2024.01.04.08.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 08:00:34 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] client: fix AP PairwiseCiphers parsing
Date: Thu,  4 Jan 2024 08:00:30 -0800
Message-Id: <20240104160030.614736-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This property was being parsed as "s" when it should be "as". This
results in "ap <wlan> show" having an empty entry for the
PairwiseCiphers list.
---
 client/ap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/client/ap.c b/client/ap.c
index f444a12c..3a024d7c 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -162,18 +162,27 @@ static const char *get_freq_tostr(const void *data)
 static void update_pairwise(void *data, struct l_dbus_message_iter *variant)
 {
 	struct ap *ap = data;
+	struct l_dbus_message_iter array;
 	char *value;
+	char **strv;
+
 
 	if (ap->pairwise)
 		l_free(ap->pairwise);
 
-	if (!l_dbus_message_iter_get_variant(variant, "s", &value)) {
+	if (!l_dbus_message_iter_get_variant(variant, "as", &array)) {
 		ap->pairwise = NULL;
 
 		return;
 	}
 
-	ap->pairwise = l_strdup(value);
+	strv = l_strv_new();
+
+	while (l_dbus_message_iter_next_entry(&array, &value))
+		strv = l_strv_append(strv, value);
+
+	ap->pairwise = l_strjoinv(strv, ' ');
+	l_strv_free(strv);
 }
 
 static const char *get_pairwise_tostr(const void *data)
-- 
2.34.1

