Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C818C03
	for <iwd@lists.linux.dev>; Fri,  2 Jun 2023 14:58:20 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2564dc37c3eso2652638a91.0
        for <iwd@lists.linux.dev>; Fri, 02 Jun 2023 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685717900; x=1688309900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RgQTAg/ZCKH0Vg008clNOlFVKbZtFUtvy1kawtPmLs=;
        b=iVNpl1dkd2Thtw0ZcGQbROO5h1Q7RCWKbCVwTGR6V6MAzS9H8gwApaJ3m8GB1CIUMb
         Zz6gXl5UnERPJ5PkWDhS1+h+rtOD16qYyIt5N8EqVeQYJkyBKTmZtAV7Az4fbgI1sXF2
         5nLPOmHhfZcJ+LPVbrOCDF83DyNUDulywkTvpmz7QqQqWJj+5nkVcuqn+mr/OBG4rkTr
         ZIbikoUDQC+x9IcPP98UbX1rkYytTZIyLJ52nKlDt3ozyk6VJMz6jqDnaqE8s7nuInPT
         orAsfrvOqHtSqWae+3MLARjH43/Pnz6S5QQ3LP3CkYApgSP9x6zEKOaja5o8K+AbuKE8
         VSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717900; x=1688309900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RgQTAg/ZCKH0Vg008clNOlFVKbZtFUtvy1kawtPmLs=;
        b=U5qnalJYDx0Ya6X2M0k1i8htp/UXgyidXc8rS4emTdUuTRyqUNpHo8Qy1hXjheYABA
         jqrPB2wVhmulT/mWfP7U71lhu7macdka2yi4T5c544DwOfuQk+yY65SpIRWFPQikk08g
         YvQqagV9n+RJ+lgbyhEsWi/jqlJ61BN+YcqzQWY1Wq5cDoEZGB4nQd55q+8EMIQ9sz8z
         APLMkuknQs6jjyPkoaj5bGkxYoT5HfC9OVCHOZHxR6jfWSrawVQ+nGpNAlTpsmKGXws/
         vB4dzHJqIPrUiaZbdj6M8y1m8EkVVZURUmcGnaEMeLae4U9I1h48khoBy2kFVap824QT
         CSZA==
X-Gm-Message-State: AC+VfDw+DY4R9A6gdwgIlcy1XAG51wM7dwKPwpo+8INbLgGfKfUTSwkN
	Lf9sBjYDEnvpLKraNbbwJSmK+8RhmmuFDKPu
X-Google-Smtp-Source: ACHHUZ63s61+1P4/A8Uk4y6wPhSuxKIFV7l2tyM6sJNUdPQyHlYskTVr+vqMfVKYbWq/IBAcP3mEMw==
X-Received: by 2002:a17:90a:b88e:b0:256:ae6c:fd1f with SMTP id o14-20020a17090ab88e00b00256ae6cfd1fmr2798pjr.20.1685717899989;
        Fri, 02 Jun 2023 07:58:19 -0700 (PDT)
Received: from localhost.localdomain (h134-215-217-184.bendor.broadband.dynamic.tds.net. [134.215.217.184])
        by smtp.gmail.com with ESMTPSA id z23-20020a17090a609700b002563b38a2f7sm1389297pji.50.2023.06.02.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:58:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] doc: document EnableHT option
Date: Fri,  2 Jun 2023 07:58:12 -0700
Message-Id: <20230602145812.22010-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602145812.22010-1-prestwoj@gmail.com>
References: <20230602145812.22010-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.ap.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 9ad002a2..2642e5df 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -73,10 +73,10 @@ The group ``[General]`` contains general AP configuration.
        The time interval at which the AP starts a rekey for a given station. If
        not provided a default value of 0 is used (rekeying is disabled).
 
-   * - DisableHT
+   * - EnableHT
      - Boolean value
 
-       Explicitly disable HT capabilities for this AP.
+       Enable HT capabilities for this AP.
 
 Network Authentication Settings
 -------------------------------
-- 
2.25.1

