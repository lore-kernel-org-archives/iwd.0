Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6EA481
	for <iwd@lists.linux.dev>; Thu,  8 Dec 2022 23:48:22 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id 21so2519017pfw.4
        for <iwd@lists.linux.dev>; Thu, 08 Dec 2022 15:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkWXHL9QpRN0P17qHhHjwOyYSxwizyQuhCSmiEKlic8=;
        b=WIq0VtzNUtIvVPkmV7BO93UcyQLZPJtbtOcdnUDb6K7Qsd/NrJvRfUQURcMVuMkE0L
         HuxIm9L8r+X4j8fgOBwnmjX0J13b3jfmmIqMba/S54ZQzykoAu4j0nfEpXYNpuEqQTnE
         PF097UQroYeu6LqzVwe/nw6mwZ/0yeq1rnlB2S/vY4L+CW9KpE4S3taM3Wv9mXnsMxEl
         FU3ibehUPNrtC5uTuGqt90bSy3aSjDR/ETarWy+86CXkXjnRG7HIVUs+U2sATZ+09BlJ
         5JrJaxgHJ4figOuMPcMofp3LAZx7NfV5vK1BCPDWhsPEGbTvz3If12qdN3VEaMmGUU+U
         7zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkWXHL9QpRN0P17qHhHjwOyYSxwizyQuhCSmiEKlic8=;
        b=XSlLLUx2MAkBQp1MQS5vlsUdK3Z/K/DCcSkPYRhfvbpjO9FphAzfkt7oNJwvV0dq+a
         eGaQKB3gqdAtgmh6moTLC1O5Aeuptct6ubg+plryPkVb2XjwQWyX3a5Nh3iQu752Ss9X
         +MTe5390iOU2m7sODVSztS4CeTv/L8zG6WVRoQPeDFLkZgmLdtfaWudmIfNioq9a0XWH
         KeN1OZ52cqID0Aixr1krkykniDJLbxkihq5PVS1Al9ShyHuKtf/rGbNnUzLa25N+lrH9
         UIVc8Q6K0LCokzvNmo1MZ41mcdL8sY5NxWu/8FumAqqwAOizMdui547CLunIutzS9yOP
         y9iQ==
X-Gm-Message-State: ANoB5plExfvDaa9fUObX4+S1CPmogV6AXKEfyocZr6Oywg89hnrbPDcL
	tGjmK3ZTqZqpPAriHG13NTXlLtd62Bs=
X-Google-Smtp-Source: AA0mqf7R+XDaU6loTHJYJAt2BNvyMrP8K6imm184I2AFm0RrW/CL5QYT7rwlhvkDQpHjBIGY82A87Q==
X-Received: by 2002:a62:ee14:0:b0:566:900d:6073 with SMTP id e20-20020a62ee14000000b00566900d6073mr3067726pfi.24.1670543301879;
        Thu, 08 Dec 2022 15:48:21 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id f67-20020a62db46000000b005767cb32fdasm41392pfg.188.2022.12.08.15.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:48:21 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] doc: document new AP profile key: [General].Band
Date: Thu,  8 Dec 2022 15:48:12 -0800
Message-Id: <20221208234812.778191-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221208234812.778191-1-prestwoj@gmail.com>
References: <20221208234812.778191-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.ap.rst | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 7b8844e7..22d307e1 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -52,11 +52,23 @@ The group ``[General]`` contains general AP configuration.
    :widths: 20 80
    :align: left
 
+   * - Band
+     - Frequency band
+
+       Band the access point will operate on. This is optional and if omitted
+       the 2.4GHz band will be used. Value should be "2.4GHz" or "5GHz".
+
+       Note: Due to regulatory requirements the linux kernel does not allow or
+       strictly limits 5GHz use in AP mode while in world roaming. These
+       frequencies become available once the country is set, either via IWD's
+       main.conf option ``[General].Country`` (see ``man iwd.config``) or
+       externally (e.g. iw reg set <CC>).
+
    * - Channel
      - Channel number
 
-       Optional channel number for the access point to operate on.  Only the
-       2.4GHz-band channels are currently allowed.
+       Optional channel number for the access point to operate on. If omitted
+       the channel will be chosen automatically.
 
 Network Authentication Settings
 -------------------------------
-- 
2.34.3

