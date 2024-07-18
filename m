Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DFB13212D
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303130; cv=none; b=FWmUwLE7E/szvDB9CjvlvDzaRwIf9nPZ7jUCpxJIlP03q0u+WSDnAzHtLKhWuWkpsDsWpi7UVHfUGBhFsMmhaoz0QT2iAtji1EsLz3fX5YdaA/5dD6YSKLBjIRIWqLsDtRx/mShKqogS/LTJJP/pWS5lXca9jgF1xrBTm3BgPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303130; c=relaxed/simple;
	bh=BeueZWDXixymJFyPRdsGIekPtFW//6cluBuzP7j4x9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHECGEjQpaSC2XI36xPBvDyRxDR+YFmyFhyC2/1RpUj/D1iQJV1fpL8+yL/fZGZrnQps/qfoekRSaJU6ldLu82IBVYzO1g1eTkhEamD0VvhQ9uMwcQ6VFXwVh73O8N/L6b5U/qzZJ5+AJGeV3dFOozH1TT4g1m3ozRjVNQYaMDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtPq02o5; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtPq02o5"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e03d49ff259so722105276.2
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303127; x=1721907927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1iztXrJVzy+bdpMpzcoTbj2hxX9w4+Z1fDvnyjiApo=;
        b=YtPq02o5OOO1UzyxpXzt7PmDHA8xjLW3MSGUs+byMpbrIWdIoGizwb21pT8/tq8HJ6
         jItHM3woRF1z/dHTlnPIIVX2nTQwATikaAfmtjP/uvr+7qIWwvdEsHtQmrqMPlnycqeS
         uDUZlxipyF46yYDQ8FFFFfEnQBg3jWE4eh8wONpiLZT5ixhxo4lwoijQTDr4V6jKCAV8
         jkz8Sg1UwRgv6wvpRai4z2ho/GCqU/8haMslj0ifrmTqpVBlOIW1Vxw2lPGSFj0VgdvJ
         lmI8mS+pu7TVYvTUaD9ulhHOVolUqjOovV2RewPxvu5VdrjSckd0r3AMplLp9Zlqf9NI
         auCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303127; x=1721907927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1iztXrJVzy+bdpMpzcoTbj2hxX9w4+Z1fDvnyjiApo=;
        b=f4ekNmT1UXqFr/s1H1wNNIMD5AymXB6U9Zr0a644nvxgrQuWXwL+eaok2DKq3n2A8w
         Qt6EpXznjuAtvqPm6oRRmY/X7RuCw/LRNGHCB5NuMiN5oUiYyaC0PaIDuzXpoY9GAETo
         WMFc4D6mkBx0jo2my/74V8uyp5SOg8SKws01gY61sXW7dYtzLcB3fPDwXJWmwgaE9osz
         BqdDkQ5uzoITLq9FuJkCulYpGH7qaB4o07ynvXIxf8/vFFaErkXY8knay7o8k0zf/iSq
         NtPXYBGo2nMZ5cCtr04td8gp232E38lenWwtqdlGFzniVAiB72e4jssVYDFrKZuGw7ch
         jb7w==
X-Gm-Message-State: AOJu0YzWnuW6xOuZ2Y3Rof0mnqgZvfDKfNkIpbUDExb4Em1cVnRFWOr4
	7M1R6EFdOvAleWYPPYWUvA9RPoQHJvaTIzfV6LUPnwlFq2r4nu2LMDeAbQ==
X-Google-Smtp-Source: AGHT+IF9b2ijeVWSv0cGusgVX9ViqERuADtuOXHjQYL2Kok75qDBON3dCxkF7nh2PR/60BmGv9CFtQ==
X-Received: by 2002:a05:6902:2086:b0:e03:a688:ab5e with SMTP id 3f1490d57ef6-e0640dbe8fdmr2054326276.27.1721303127464;
        Thu, 18 Jul 2024 04:45:27 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 08/11] auto-t: add clear_events() to IWD class
Date: Thu, 18 Jul 2024 04:45:11 -0700
Message-Id: <20240718114514.2916258-9-prestwoj@gmail.com>
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

The wait_for_event() function allows past events to cause this
function to return immediately. This behavior is known, and
relied on for some tests. But in some cases you want to only
handle _new_ events, so we need a way to clear out prior events.
---
 autotests/util/iwd.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 511fb3a5..1d4a5472 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -299,6 +299,9 @@ class StationDebug(IWDDBusAbstract):
 
         return False
 
+    def clear_events(self):
+        self._events = []
+
     def wait_for_event(self, event, timeout=10):
         return ctx.non_block_wait(self._poll_event, timeout, event,
                                     exception=TimeoutError("waiting for event"))
@@ -859,6 +862,9 @@ class Device(IWDDBusAbstract):
     def wait_for_event(self, event, timeout=10):
         self._station_debug.wait_for_event(event, timeout)
 
+    def clear_events(self):
+        self._station_debug.clear_events()
+
     def event_ocurred(self, event):
         return self._station_debug.event_ocurred(event)
 
-- 
2.34.1

