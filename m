Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6277A156871
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823291; cv=none; b=jh1GLWkjMyDHOJgN+fH4I0N/GznQ06+q7i2+a6fQNGwl2o6ooBgopkyBpHgPFVFSI/5ISHI29PekZEl1fKmEIAHwVQfzGZPvVncG8kTKIeA46m0R1sz/wnwP0inaQIqbRwxTBkpsrVQFG1ULH5I/U+f1UTV2cY8z6EVKRVHZFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823291; c=relaxed/simple;
	bh=sqfgEz3zIDGjyFyKb74MAymgN8FgL6s8p2L5gY6jrzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g77Ek7iutT3Mgt05lQnFo7k5wu0uuv8+0Vt2li2R+4O37nGT3OvLelzTRlRhMTQB3xrQpVB4o+n+mpU/u+E2eo+19WGoi54ay+YKP1wnqPqG3RJ0CFBYFKTbAOJEFyGuzvuo59L5gxVr+iMetaRnsiDyX7GuOxxLoRkqmLL9gjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEsyih9U; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEsyih9U"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44931d9eda6so7802471cf.1
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721823289; x=1722428089; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAU4dXXXTey9vbb44uY0bmxJruUfpkLZVIukYkG6IHY=;
        b=EEsyih9U9r4SNoAkE8V0svNLzYvDtnLDnVhhHPUG/X10+zaYIYN4Z8PcRj6GNHC6mx
         UZJ2V300hV/zTQJg/EPlfobjPy9XgdIHGrY7vR1WYVrCGvEvZxpKd1LpwT+SYjxGP9+A
         fidD+1Ql8j1XHLLYzEdQZxCq7Ss2mYowc8ODVzbUEVtGoJMav2cUqBwxzgUK2o7pdfrA
         fKBNrN53raOpU71odVNtI7RsYQXkLkwF7g4XS0iyrgZSRAwNmX3W1KDUi7Lm5IXrZTAi
         83M5ikSy5nEc1GSijqqa2vfCdDAFBpHtLaPXn8V4+J2qaAgfBMk6uUUA9y3KJwsvPemk
         uSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823289; x=1722428089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAU4dXXXTey9vbb44uY0bmxJruUfpkLZVIukYkG6IHY=;
        b=r2YsxhQck2Clyjl2qR3yHUV7DM5Jus6QIf1pxLV1JtM1ekF1Dvmxp41uQLYXjssbFx
         VDAmdmHWjKIggu+jzMOP/njssmrlR4c+34DJIapsXNnYvuUQzn2J+r/fylsvlG4NM1tZ
         4mSjkvlKWDp4Ja09IumSuo5f+quQjyIlobtbNkAv7xLYZdcXD1XUUNZpumN9UqeIJeFn
         2+CIwRHPFGugJ+Mtxx/iZfsCpvRWH/uQ8tyze9cbYKVa1wtWBRp3UYJ7w3Xy6sSMdslZ
         58xb1jyM74kHzbMvdF+OBbFcdpgtYaevdxoMx3utmRE8NNHIPj7v2AeUc8HKubcBlBVq
         YqoA==
X-Gm-Message-State: AOJu0Yy0N5TiNmbIdjnX3/JihbJOP/ZjYbtwUV1oBrq19vhEkVxhmeEC
	nWdh22Q3r/TRp/TBhd55n1huW428vXUbOv04FxezZl7CkBI7MVxIjHCHkA==
X-Google-Smtp-Source: AGHT+IHCqXCUYKLJg9lZS8qrFvZmO1xgdaMZ8sAgmUMmY0qLti3UoSVVJ02HFeXqjE3Ius2Ct6u3DA==
X-Received: by 2002:ac8:7f08:0:b0:447:e636:9ea4 with SMTP id d75a77b69052e-44fd7b0149fmr23284981cf.8.1721823288902;
        Wed, 24 Jul 2024 05:14:48 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdbd9b6sm52652171cf.88.2024.07.24.05.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:14:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: don't print valgrind log if there was no error
Date: Wed, 24 Jul 2024 05:14:43 -0700
Message-Id: <20240724121443.1425256-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724121443.1425256-1-prestwoj@gmail.com>
References: <20240724121443.1425256-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If valgrind didn't report any issues, don't dump the logs. This
makes the test run a lot easier to look at without having to scroll
through pages of valgrind logs that provide no value.
---
 tools/run-tests | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index fdd0b989..e043965b 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -899,12 +899,18 @@ def post_test(ctx, to_copy):
 
 	if ctx.args.valgrind:
 		for f in os.listdir('/tmp'):
-			if f.startswith("valgrind.log."):
-				dbg(f)
-				with open('/tmp/' + f, 'r') as v:
-					dbg(v.read())
+			if not f.startswith("valgrind.log."):
+				continue
+
+			with open('/tmp/' + f, 'r') as v:
+				result = v.read()
+
+			# Don't print out the result if there were no issues
+			if "0 errors from 0 contexts" not in result:
+				dbg(result)
 				dbg("\n")
-				os.remove('/tmp/' + f)
+
+			os.remove('/tmp/' + f)
 
 	# Special case for when logging is enabled
 	if os.path.isfile('/tmp/iwd-tls-debug-server-cert.pem'):
-- 
2.34.1

