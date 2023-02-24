Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F23C15A5
	for <iwd@lists.linux.dev>; Fri, 24 Feb 2023 00:57:26 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id il18-20020a17090b165200b0023127b2d602so1117964pjb.2
        for <iwd@lists.linux.dev>; Thu, 23 Feb 2023 16:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2BXuPEpeshNc+xDtycGK/+OyzxRsctYE161KNyNnfAY=;
        b=IZRFMRGJft4F3UXzb6Zv1LSmnpx5sbZzplK1R2L7GoyTV8c4ImE4NVlm6I5JNZnhEn
         XbniwLA6Zw+QuOA+PXYE8w7nOWXEtfJHzEPsSyoyoRAa2cy+Bi+TQS4PmOMeb716iYmV
         KHgH49cHQkC1SBRQO2YaUcmwoo3qMspLo6Up+qTgEAUC5M0DHewuEvH8xhdv41mHxVzS
         Rdql/DcW4Y7LPqjL645o6B10AUzS49TLG8JDTjtnOfEHxOa0OY1ygNpSFYQlMs427ysD
         k17dqR724JwZJ8r4VdpJYs/yXN48z5AdMAmo4NEkXq79q3RqPKBeCScUUnOG0NBzVUL4
         sATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BXuPEpeshNc+xDtycGK/+OyzxRsctYE161KNyNnfAY=;
        b=DPIdVywiPJ4txPpjII7Pw6rc4v0aVLbSjadRKL0h9XFa4PcDUN6AvrTIUStXX+78uX
         MEq+1rRh8gOM3E9ph2TmgBhNNe8Zbn46IypdIu6R8VidyGjskeltv9SpBcFF76RNhYkI
         4RNGcE0PvWz20L7H+Vo2qmcy7CJmRE3jrvY8C6qZUYqSPR1otS5qiHbZSb66gq2ZJ1UQ
         3NTKZHqvpVy7CJ7HhSBKIUm1LPU88JgbgwIGaWtjsamNDOK0P5fWLnYgEK/cPXVJ5LPX
         fmCfsMXTtQsUmxJbV9O2DdhoXmHQ71ltuurrYuwJI45JH9jntOLt3b5g27LUcnXuW6Us
         XhWw==
X-Gm-Message-State: AO0yUKXmeAvBFtsF0q4M7LYUIHqIB1zACvN5Fxr0g4cGhd0pUuk3GmUJ
	jW9PQkiSccvkBcG6gxPRbU6XqAcPFb0=
X-Google-Smtp-Source: AK7set8cWwjEMvg1jMs+wGZb4MdhPrYE5x5Of5OoBzSlV46X03kX+qeSFobrrd2l69vh9QeUgMV+Gw==
X-Received: by 2002:a05:6a20:a111:b0:c7:5f49:8d0e with SMTP id q17-20020a056a20a11100b000c75f498d0emr16193739pzk.36.1677200245722;
        Thu, 23 Feb 2023 16:57:25 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i15-20020a63bf4f000000b004fb95c8f63esm6801132pgo.44.2023.02.23.16.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:57:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] doc: document DisableHT AP setting
Date: Thu, 23 Feb 2023 16:57:22 -0800
Message-Id: <20230224005723.1411083-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.ap.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 0763b442..9ad002a2 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -73,6 +73,11 @@ The group ``[General]`` contains general AP configuration.
        The time interval at which the AP starts a rekey for a given station. If
        not provided a default value of 0 is used (rekeying is disabled).
 
+   * - DisableHT
+     - Boolean value
+
+       Explicitly disable HT capabilities for this AP.
+
 Network Authentication Settings
 -------------------------------
 
-- 
2.34.3

