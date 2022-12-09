Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76263DB
	for <iwd@lists.linux.dev>; Fri,  9 Dec 2022 18:23:55 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so8979430pjj.2
        for <iwd@lists.linux.dev>; Fri, 09 Dec 2022 10:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqeYpa7sv4P1GZ4qZMuySNH9P1etBW2vI4Y9N6iOExA=;
        b=IOO8SD6qelMHxeT3Xu04EwM+DZ45M8X6y1r3oxptOZ6V7NkwWo2QquiN+GenuYDynK
         5f0hWLPpSsez1i8egIR2e1wGWauN7Zn+dnEkjxg9OzxqFVtDuVYdj2etNWD1mG+w+MpC
         WAjqN+7YaynA+BD8tcmKtVGaI/fz1gGHuSDuNbZYb/eZF4+FkcwrGSkVGgnrTpK7A2YT
         mKb4WZCG+gj3kkpS5sXtsfLLpjDW+WveNQSK3b5eACb9c0dzXZP1MZpdVtzzsgcajyq2
         8GtbXrxphsHN3yIrVLWCpAMhu4OIWLLoNHkJj0DJPBH7EMBEYe2A4Bgf4niXXmRMN4dm
         8ZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqeYpa7sv4P1GZ4qZMuySNH9P1etBW2vI4Y9N6iOExA=;
        b=0lCyYrehT1aZ4ACVOYCoRBkBRAUMKBOwLloWu8jGqlX6UW4C3QiNGc6NKGZc416VBo
         lMkgyvpkN49keUxCOm1GCbYFEDCcmOB3zaQkD9a48vlBy/a6EkBl7zWvcvCzW0kZgFpk
         llxdjKPh1K/EZJeyJOO6JYPzzPPdHHOD6s1xR2xN1V/+uiFR69eIQuETCTRMClQVW3PV
         2PmDjkm9YVYWW4rU5wlMOZyRXNEOQOHEb5VKPWf3wxd2ysH/+CRTniF9PSfhG+UOhgmx
         bibA19KFr/+NjlNJlnKW57I/71CfI5FbCAQKNt3AojANNxIMt7jcKBnZAiVcYAnCzwE8
         Cxzw==
X-Gm-Message-State: ANoB5pmJbl2H5xWakKEtXFr1ZkHnbPITXJ3JiTe0XvuJ2JHKnlJzFw3k
	Ww9ZYFivKNwswZLYm/nuRTrSoqeeRP8=
X-Google-Smtp-Source: AA0mqf4cRXvsNFPevmAQaU9pDZoBDqvGJ+WKeAY+wXxFYw+siRMGKc+XybhXxoy0rcIee1qi57W+pA==
X-Received: by 2002:a17:902:70c2:b0:189:adf5:da2b with SMTP id l2-20020a17090270c200b00189adf5da2bmr6706773plt.58.1670610235183;
        Fri, 09 Dec 2022 10:23:55 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b001897de9bae3sm1635790plb.204.2022.12.09.10.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 10:23:54 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] doc: document new AP profile key: [General].Band
Date: Fri,  9 Dec 2022 10:23:47 -0800
Message-Id: <20221209182347.838602-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221209182347.838602-1-prestwoj@gmail.com>
References: <20221209182347.838602-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.ap.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 7b8844e7..823aba99 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -55,8 +55,17 @@ The group ``[General]`` contains general AP configuration.
    * - Channel
      - Channel number
 
-       Optional channel number for the access point to operate on.  Only the
-       2.4GHz-band channels are currently allowed.
+       Optional channel number for the access point to operate on. If omitted
+       the channel will be chosen automatically. Channels greater than or equal
+       to 36 will select the 5GHz band for the AP to operate on.
+
+       Note: Due to regulatory requirements the linux kernel does not allow or
+       strictly limits 5GHz use in AP mode while in world roaming. These
+       frequencies become available once the country is set, either via IWD's
+       main.conf option ``[General].Country`` (see ``man iwd.config``) or
+       externally (e.g. iw reg set <CC>). If you are having trouble using 5GHz
+       ensure the country is set, and that the desired frequency/channel is
+       unrestricted.
 
 Network Authentication Settings
 -------------------------------
-- 
2.34.3

