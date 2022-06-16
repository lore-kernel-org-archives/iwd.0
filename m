Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE07E
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:47 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id s1so17299631wra.9
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4vRxVU2FW4g4w9ahnql53sfkKtfO+xQM6sqepg0z/Q=;
        b=jf6hVDQm5EXOCl++XxP+eVOvVFI2d4Z2HvkKpIjkxF/4BCXVwOhWnBY6mMu7AneXxv
         jVn3qH++L9WCPKUrMR7Y4FeOq5ZRO3+FEdTQJdnIp7r75vIcbTLqkqt5PeScLxEAgz1f
         lGv4DAHMxLncOsUN0iU789g1W5L8/fDF9xS/LESz8SN06oslQvZa+XPyUxqCd/bpDKXp
         tvds+5lKw+p8lFp2XVrJPs4lKUCewEXMJknlrIZrJbQY/uqD2sPOl1NWfpXw0IW8KFsv
         XZYuEnyvukWVIOLPguYOViZwpaFmGfn+WH3qpXt0lYsla6MC+6/abpNrQepO0XvoxxpC
         ot5w==
X-Gm-Message-State: AJIora979Xs0BkWt9QZibgC+Qc3gXWhLCox6OXdtABHN/EK8rIOgdG/K
	0ZTe5kNuorQWPPFMRuBOuWbVs4IKYZ0=
X-Google-Smtp-Source: AGRyM1uCV+pNEFQ+JnZRub843G5xTH9fq6UysHqolJsQVRiuTSCe0B4+4FpANTs69017bPNLs5nKzA==
X-Received: by 2002:a05:6000:85:b0:213:b57a:ea74 with SMTP id m5-20020a056000008500b00213b57aea74mr2070568wrx.69.1655337765360;
        Wed, 15 Jun 2022 17:02:45 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.44
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:44 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 07/15] autotests: Drop unused file+directory
Date: Thu, 16 Jun 2022 02:02:23 +0200
Message-Id: <20220616000231.1966008-7-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/testNetconfig/storage/ssidTKIP.psk | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100644 autotests/testNetconfig/storage/ssidTKIP.psk

diff --git a/autotests/testNetconfig/storage/ssidTKIP.psk b/autotests/testNetconfig/storage/ssidTKIP.psk
deleted file mode 100644
index f15724a3..00000000
--- a/autotests/testNetconfig/storage/ssidTKIP.psk
+++ /dev/null
@@ -1,3 +0,0 @@
-[IPv4]
-Address=192.168.1.10
-Gateway=192.168.1.1
-- 
2.34.1

