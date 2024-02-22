Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78914D441
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615504; cv=none; b=Yw2DOkiwcmIjr4nS8R68CEZ9rWNjGTlELBRoBH6whY5VOauQgS7HlzYaeYl8hYcaOqhYr1/YAY0PGSdGZf8Yb7HlC8xasn48ZIejvqTEy0DrF8Q1GCIuEgIFwemEvRxDrgcaCQMYZMsXNsHb0wrP+BRmj0uTO4kbohIm7uHD1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615504; c=relaxed/simple;
	bh=fpUhQHTVJUBTgZ8QWi8W0NEhG+GeVRD2i6J7xVV1Uvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nNAKbTaEcriDKeRWUc8d8UUBMlQbeXjh6NGaM5Ad8TZ9iHP8kVQo+rr5njULzbu44miDyUFBnYGGg6KKL9uQmH/8wHPqx4jBe5wEIzDYkS4BbR/ueD4+krSEFzYyJiFAlJxepz0IECCzcQcYky1gR7m7z7Rrwe5Xm/V2nJ8C4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhtgZFW+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhtgZFW+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d71cb97937so79627795ad.3
        for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 07:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615502; x=1709220302; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RafitYr2Dj70DrmLktgtfBmI71dyspbC8oqI5KIOGU=;
        b=DhtgZFW+bvaOh9ZPjbmlec1A3FlSjMHpAHSwVWznw0Cmkbf18JDBZvJu7c1nRh6mgC
         NE0R9K7VrkGmJmgLTmDP2MZfU/uSlOzJPny8WqGrfInADnBsuuBaLX06lczQsH7CoBT9
         PGJKq7wVjrySQ0SlQkFumBw+RjhdK2lDTooVSGE+NreRgOJ/bVpUM2sToSpLJln/9Dov
         edpDpVuNcTL9KJCbvlhcEK0+ri7OoGgBojWTlnTo6Y32jkOPkJAuEOLiFCPITeSxKtEn
         WyZYqyX/KP5e4gbR++G4N1Ly7RPqI53qjjftTvbbzAWpi5aZD3z4Bbhef0e/erwnfeoK
         ojiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615502; x=1709220302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RafitYr2Dj70DrmLktgtfBmI71dyspbC8oqI5KIOGU=;
        b=tW7Rx4f+snGbIYi4psmneBpexYxkZbyuAjVWglgHymrLN/hr/cYmoMGm+Gl2GKwQ2P
         sDPRYVwYEEgoNE2Pe1kotJXAmLCfVev5RfO2n7E/SgtmaSmbH1zchk6axvb4TtkJPvpH
         BGjXJFQ8R+g7O/apLxhqLocnxQ+VHQOas+7MoB3kOKZUvdemSnSQYW6l93cfgrc0pF9p
         jlA8wNrRdfaiSV5hk7fc9chEaqpuxUyoFgXap/m3QM+SD5YMB1jQGt+JCWDK+YOOtKu0
         iLx6caercEI3kQKSmt/Oe2jvaucvenRZCiKiPVdurUYM6/5CMhn6Rv56gJC4wLNsArdc
         gpJQ==
X-Gm-Message-State: AOJu0YwsPrAgtHC66E3eHnHEnJ1BwvMzWxnDe++jgjBCvW3Z4v3imgKM
	c6zAxZECI8AdmBEk5DPxY8AAdJe1pb5Gs92wDB4FrLDjOXIQR60siOuzbCEF
X-Google-Smtp-Source: AGHT+IH7EkNXXH0ZOvf6MedksWSx8arbHS+aMzwEmtsjdyIGfr3KCXpCBPv2L3miHpXg7SJHedlc1Q==
X-Received: by 2002:a17:903:124c:b0:1db:65a3:e184 with SMTP id u12-20020a170903124c00b001db65a3e184mr22597267plh.4.1708615501787;
        Thu, 22 Feb 2024 07:25:01 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001d94a3f3987sm10044873plb.184.2024.02.22.07.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:25:01 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] auto-t: timestamp log files in test-runner
Date: Thu, 22 Feb 2024 07:24:46 -0800
Message-Id: <20240222152451.1541682-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222152451.1541682-1-prestwoj@gmail.com>
References: <20240222152451.1541682-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The log files become much more useful when there are timestamps
associated with each log.
---
 tools/utils.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/utils.py b/tools/utils.py
index 8219542e..5984fc69 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -6,6 +6,7 @@ import traceback
 import shutil
 import dbus
 
+from datetime import datetime
 from gi.repository import GLib
 from weakref import WeakValueDictionary
 from re import fullmatch
@@ -125,7 +126,11 @@ class Process(subprocess.Popen):
 	@staticmethod
 	def _write_io(instance, data, stdout=True):
 		for f in instance.write_fds:
-			f.write(data)
+			for c in data:
+				f.write(c)
+				if c == '\n':
+					stamp = datetime.strftime(datetime.now(), "%Y-%m-%d %H:%M:%S.%f")
+					f.write(stamp + ': ')
 
 			# Write out a separator so multiple process calls per
 			# test are easer to read.
-- 
2.34.1

