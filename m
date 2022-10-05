Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76E3217
	for <iwd@lists.linux.dev>; Wed,  5 Oct 2022 22:46:38 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so1106532pjf.5
        for <iwd@lists.linux.dev>; Wed, 05 Oct 2022 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7dICHwCgo5rS1eY/pYGDoaDMXlcV/t81Lfz78eAtEw=;
        b=mnVEVDd5dF5NPMV6WqtoIWILSMWkJN6DiX+IvAXBP+3WZ+rAaQQcmZkcpixtDi+TOS
         Q+mxn1U125ZjlgsaAWDFZw3jJ6N2MfsUjgaYb8IcAwnq34X+dGu2Lf8e75jlj5IR1Nvw
         QpJzzeRHtBH999cooIEiwW/5unfAnHSTjKCewE155MVPgdwA0Ec3AzmO2IWb7o4ib83r
         Teqw5RXeBM0lGUvbVikJ6bb0V6Jnuc8fbK4YP0uPjK8eNjySpLvF1vzVhI7sOBwTYRqG
         Qk2K+vZFNgfMxGSadUVDh1RB5W5Q1eG3TNFJvSVUeI/0xAUbFd5mCDDApHPrlWVaRTpG
         PovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7dICHwCgo5rS1eY/pYGDoaDMXlcV/t81Lfz78eAtEw=;
        b=XHzRmfEqmHN+crvJiTLXqvkFgADhFZEWDqnbQp6iJlLQlujXot/1EK4H1KMRhqZ2Y/
         Wr5oWU8uV2B7nJc//Cd4RJCL6+LaLw5Rbo/UtXUq/xH+pdM4mUOO6bnWdTxkoLpqRmT+
         nSrW4MScxJY7PBLouXBHqIYi1PGJGqRbEzieuupn/G01zB5qwYONOzwcJXOSFTjspcyt
         pxtwPCDOLxMT7zh8dueISvqkd+dXlkh0KrsjlyHsD9KobS88tc56numSzmP1lDG3PEAC
         U097FwVKBBWwfC9FZ5bEijCP3lag1L9fr3N9ZSCdR64nSD82I6f15NLNHv5MlMdX+pOj
         JmuQ==
X-Gm-Message-State: ACrzQf31CfaEHaj8nKkEc7Q6GqY0MJq4QE/q7ZYmDZoUb9T0jjdiTgPN
	CEjV6NdFZt7zLAPZDauIJvVuT06UR2k=
X-Google-Smtp-Source: AMsMyM7CJWcEVq8askMHg55yeaRli2kKfQVYZIP3UBQ4cVd2MLvHvG4qXnNBtUGlpb3K5KLyGuSulg==
X-Received: by 2002:a17:903:1ce:b0:178:80f1:c4c7 with SMTP id e14-20020a17090301ce00b0017880f1c4c7mr1643010plh.27.1665009997666;
        Wed, 05 Oct 2022 15:46:37 -0700 (PDT)
Received: from jprestwo-xps.none (h67-204-159-212.bendor.broadband.dynamic.tds.net. [67.204.159.212])
        by smtp.gmail.com with ESMTPSA id 61-20020a17090a0fc300b001fd7e56da4csm1590686pjz.39.2022.10.05.15.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:46:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] auto-t: remove old debug print from wpas.py
Date: Wed,  5 Oct 2022 15:46:30 -0700
Message-Id: <20221005224632.780575-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221005224632.780575-1-prestwoj@gmail.com>
References: <20221005224632.780575-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/wpas.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index c1a12b62..442f0dce 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -72,7 +72,6 @@ class Wpas:
 
     def _check_event(self, event):
         if not event and len(self._rx_data) >= 1:
-            print("returning %s" % self._rx_data[0])
             return self._rx_data[0]
 
         for e in self._rx_data:
-- 
2.34.3

