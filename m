Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14692563
	for <iwd@lists.linux.dev>; Fri,  5 Aug 2022 17:28:04 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id w10so3243179plq.0
        for <iwd@lists.linux.dev>; Fri, 05 Aug 2022 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=5udxjarUFq1O7OlA5JGzwtGAsw4cla0geoYHtque4Dc=;
        b=l/UjjHR9MSW+CvIzUruz2CYjdPBhHkgfmSWS9okFYNQZOPTza2O3wFG+ICXYFF05+e
         NfrwX4MAxLzVvtHcGy9ZtrcayMMozNoRdLU3uBNMYSEN7il7j3c+1JExgAR5gqmXrMJZ
         eOaOeRKNC9b+j7oKyHtx607ul7Blb+IpDD4K7bpGhkZ6ocop1GXvtCTtM1/Zd4dhtJ94
         7neJHDf41x9fo18c3hsct5xewEiuiTCr0l8DfcScsED2bXPoEQcyvp0irfqi3kwHfpwN
         83K/t6ToGmQ8LDzrUG1yvttOTeRgEZ96Mne3bVMuPnOo7YoF6gPvwERgsBC8QFWXP95e
         9gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5udxjarUFq1O7OlA5JGzwtGAsw4cla0geoYHtque4Dc=;
        b=kJUXYAKC7aSrOHUKpWuvzW1M2nUJwL1r1v+WOL3aJehFJcoEx6jGshOs8EnWorAm4X
         dJ6jKyhlz5HRHTewavRhfcLuwfr0cffu/ba2UsU7vPHv1/P4Lwrv6i8aUilEviZQbbau
         ef52e/HjbKFkKqPvFOH5bjC19Yxjurt8zDETTWlmPMcHrVPTiQyiSdXr3zqENHDhnMRt
         d0SbqZjQQAx0yoDCJlc+UlqUogigHsCgPcz6ZohGKAX62Y4QpquWlPdjClWAT9sWGExM
         3eu0WNWVbKobP68xNPfs6sKj6HVSlrCgFdvvj1uVNAa5o1jWGyPEZp0iavvPlgin4L9g
         ossw==
X-Gm-Message-State: ACgBeo2qXpEzAc995uMpm9SABKUjDT3TRVSVKoPDYyzfOqyZpnsduaK6
	sf8DaruIt6k0TQF06zKxJD0XQqeUKXA=
X-Google-Smtp-Source: AA6agR4M6vcmf3LQqPePpKqq0O+p7LxET4LD/Z12kxv7iyWhtdlXNF2CFmCLmVWK0C7bNY53T9uLzQ==
X-Received: by 2002:a17:90b:4cc4:b0:1f4:eec1:e168 with SMTP id nd4-20020a17090b4cc400b001f4eec1e168mr17295940pjb.116.1659720483935;
        Fri, 05 Aug 2022 10:28:03 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b0016b865ea2ddsm3364847plf.85.2022.08.05.10.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:28:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] util: guard against NULL 'freqs' in scan_freq_set_free
Date: Fri,  5 Aug 2022 10:28:01 -0700
Message-Id: <20220805172801.637589-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since this can be used with the _auto_ macro it must be able to handle
a NULL input for error paths.
---
 src/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/util.c b/src/util.c
index dfee77fa..d564ebc0 100644
--- a/src/util.c
+++ b/src/util.c
@@ -330,6 +330,9 @@ struct scan_freq_set *scan_freq_set_new(void)
 
 void scan_freq_set_free(struct scan_freq_set *freqs)
 {
+	if (!freqs)
+		return;
+
 	l_uintset_free(freqs->channels_5ghz);
 	l_uintset_free(freqs->channels_6ghz);
 	l_free(freqs);
-- 
2.34.3

