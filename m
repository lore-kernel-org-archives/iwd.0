Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76238181BA7
	for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228134; cv=none; b=HtVwbzQtyRczcYJNrtJAh1sqM/xIeGT1X+3AImDUvKFRGEjRngjMnNjI1AyiBPpHFeIzgEw17AGoVYQF/mFhO2hDBjCxdH1nJWJexB8ewY7q2GGzq44CYYCXKxzGp3bh5SFQYAx6C+sji+HZye5mbnkKgfKNv06XOLGgkpvDrMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228134; c=relaxed/simple;
	bh=BeueZWDXixymJFyPRdsGIekPtFW//6cluBuzP7j4x9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJWVFv3uPysT3M4kHPJ3wc3o/WrSbHU+OqgsXwkahHv6XWHheoim5vMoHP9iIyelfLg5kjEXeGV32kL0NkslTdbU1CSdnedcGqh2LsaN4B2F6b4+NyVLUMhFqxv/PPTl8sAVl+sN+mtyzSHLbcld6II0/G0J2fIGFUAEnI76L1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2yPSqiy; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2yPSqiy"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65f880c56b1so43952647b3.3
        for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721228132; x=1721832932; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1iztXrJVzy+bdpMpzcoTbj2hxX9w4+Z1fDvnyjiApo=;
        b=i2yPSqiy3uz2Zffpb547cAXvsEGmPpW1uC7xGdVT4CmK7Uz8FtWXPHCTmtWE4wIiEj
         E3LkYe59PCCDsCTac/jBpV26itmj50YXPNgAZvTdIy6ucBo7hgoTE+4QcXIrBcd7jc5q
         F5haLqwQWYOEmyAbPLfC40m7Eoh+ULzlzaGVMLorsvFN4EaUoJA46PXhW9rZI92pA5dg
         Fug2+IRXMdfUOb6EL5t7kh2Sl431FYrnfwkZP2TKzZD3G4b0F0ltZpwPVwlD3OthwvOX
         PrsUjTQsksHywYHFngV2xRi2ub7zmuw6sJFE+3xB7x7ZjM8prNk0o7fvfpP+Uxj5zoF8
         B8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228132; x=1721832932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1iztXrJVzy+bdpMpzcoTbj2hxX9w4+Z1fDvnyjiApo=;
        b=Ixlbhixq2qsO19jQrAoGNG57vLyH3yiLeTJ+IVoXOvIbYgZG7t2+Uufqdjwrjuxy/u
         4uk6xcDXXM4MNm+mZKsPyl+ZwJVi6+kGK+9csYGT5nexN0AZFRXjUel6FAwU2jULcDxq
         4KI2f7Vd+whloOxo2KzdUq8xGIwXv8oxS8MoT7aQPcu8wG7+VU1qE3l1mFXu/BKOiPIm
         iqvLxD52RWOYdhUWnIGNCHdfE1sbLu37caYN7y+vsyfWw01mMWF5pWYBM+W35Kp7wuMO
         pm7U+C8q8gKy9xrwdszi7LPdqBQI/13qcgKxENbev2SYwOMDZ83/Pt9XqbgjMWUCA+5g
         3AsA==
X-Gm-Message-State: AOJu0YzE+7ZkKxkfhGvDgdPaHfMn4dwBC65ZbPsxbv7oS41g91sSV8DC
	LlJ8GB9hUWS5wu7TJMX1FjhcjdnAJbHnNJ91xPvqwHA79zFY+ojel36kRg==
X-Google-Smtp-Source: AGHT+IESFo6GJr7Rva2zmuLRcJjqfWRlphOLb0fxthMTVWuFVKXds8Ximx+Dy9vbnMJWWIJ7iZ79GA==
X-Received: by 2002:a0d:d382:0:b0:664:7fb6:a5f9 with SMTP id 00721157ae682-664fea2c132mr21548657b3.21.1721228132162;
        Wed, 17 Jul 2024 07:55:32 -0700 (PDT)
Received: from LOCLAP699.localdomain ([50.78.19.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbff41sm407195885a.53.2024.07.17.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:55:31 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] auto-t: add clear_events() to IWD class
Date: Wed, 17 Jul 2024 07:55:23 -0700
Message-Id: <20240717145525.2656306-3-prestwoj@gmail.com>
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

