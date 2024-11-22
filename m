Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F591DF27E
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288565; cv=none; b=SF9GxfmxvoiSrVrFEDlMF7jsOfpnV6cTdb3XJeo3s8Urbn6BpSAoS+KVvdrUbi3EV34XWUhzHkVrHEcZPQ3qkn2l/aLZW3MJA5DKapFYYFKVQNc0fJUMX078JjeQKaYq5xbNkURYac/F5DkqUUv99ClpxNmpjwelPUQXL6ALV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288565; c=relaxed/simple;
	bh=F+ZINwdxUv1j8363e0TcjXdQkq8wX3RLY8HtOMevR9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvsOQh90wkbMmVvJdEvS+Uu7a8w+Xl+unrOEWkzksr6bGX8Hh7snAlx3rXxoKYVvX1h4PXYagnOLFLu+mFjYabQHm3Pm/LP6sqiHTU8r1YX1lTlnzY3UH5BowY4nShq48BHqE/5KQSGLiNqofT12j63NZv/3GScCeQyWCGS+0is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIgIz61G; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIgIz61G"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d408e38561so12958546d6.2
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288563; x=1732893363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9fJp+iP2ienHIhxJqavPfR0kha9omAdAWoA2nuKMPo=;
        b=SIgIz61GGv/pNwBs80J0SkE1fEBf5Cm/VQa2CZknpgc88zcsXDZzneqjdBa++jPytV
         FUeT2UDqJ/fXTA/sg129Wb3c2u0DLJiaVhEYKNk66RiXdWZ9llljMEG4S18UubT/ul02
         oE/tQYdPuELtuctC5wIqPYaUNjie0jYQ9stwlLwnJqR+Tw9b2vTqourshTd16LrWsa7u
         SvYFYRbP+4RyDnXxa27sN33nCxiEc/33FSEYSjuthzbZFQkri2NcwEPRl8EX1pdYDaLm
         JZWItO0GSBI1shwhnrcRg8MrhPXg1PCf0fYjSvkS9KiSR3ZzEB84HwbpzLA7XNkm+i6p
         JAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288563; x=1732893363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9fJp+iP2ienHIhxJqavPfR0kha9omAdAWoA2nuKMPo=;
        b=qbZvgV5MUn7XjPhIP6msoHsUpCS9bQ8WH7mkKj6zlRuvP0pDSejMOICW/KkrbITGbF
         OP4NKhGkJ8RsISEMHZKPsrhX/r6szHvQndFZIrWdl9VQX2/zZyr8Yv0ikVJlKglHH+jU
         bebOUbecDYs549bvh1+FC+iEM9NhzT6/PQ/vLF9ZAmu1Xz2u+HOAKO7YQnFUuBRKURro
         PzgkVseA2tt9PT2WZOMzidnAFaGnA5HjYgs2W5Pw6fbkl8Bd1ad+78PnT4SLO8M+ta0e
         FOcLOGImfT9C6pbtgIGKmL45yraDy9SEFwUCnEyFuSHQaP/3PatzWgVhhzpUodz7HfJV
         T3WA==
X-Gm-Message-State: AOJu0YyFFAQd7EEVILGQnszNmMHcY3jaENYqUG+J1wdRm69tjqWV594L
	F88JJJNIktd5x/3W1353YtLexUu3apbemAxsenSR+meN4YtVox2ciYNbVg==
X-Gm-Gg: ASbGncv8QuWye7lCFqh54GdchlHpw016809NzIovYn38QyQou/3BFjZTTrd6dlKNCwi
	7KGMSUyTo0w0DI4LIDS9AqQ7Yf5i01cOp7KAoLAPk1ajI0CvSiZHMBYwJcKX5/5T/PILf94tYQo
	4sIS0tWhfwDNVFFfPdEBItWL64/qE0yhYtJhGkU82g65rBbn1EiX3rZs0h3Q7H2V4WvNGfrQtIU
	6E0k51JvaLkmXmpumzKM1QO/6gWGtymMZ+Hd+q1OfY2MMejTXf3wD6HSwIW
X-Google-Smtp-Source: AGHT+IGZk7RyCXPwpdE4MyiDAqgGkq/2/dBkcXrasPdiY1zJ3XSkbCaY8ADr1ZQk2iOIEyrkrTInRA==
X-Received: by 2002:a05:6214:1d0a:b0:6cd:ec00:205e with SMTP id 6a1803df08f44-6d450df104cmr55223036d6.0.1732288562614;
        Fri, 22 Nov 2024 07:16:02 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:02 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/15] auto-t: add pmksa_flush() to hostapd module
Date: Fri, 22 Nov 2024 07:15:40 -0800
Message-Id: <20241122151551.286355-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/hostapd.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index e5e35a96..611d8a63 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -368,3 +368,7 @@ class HostapdCLI(object):
             others = [h for h in args if h != hapd]
 
             hapd._add_neighbors(*others)
+
+    def pmksa_flush(self):
+        cmd = self.cmdline + ['pmksa_flush']
+        ctx.start_process(cmd).wait()
-- 
2.34.1

