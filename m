Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A297D2C9C
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:51:40 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id l2so212074pld.13
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmqJE2bXbIJQtN26iYuRL/qRaWyyYJXjBFdvyK1zscQ=;
        b=KWixeBzAJLwaqjV1+egvFYBh9st0ihRi3xlK5mW25tlw80GYUf1eAmtnzteQ1LRSSZ
         V8Chzt2rH59jSv8KFryH0WIDHe569o6pfUeKAzT4ZpE5yBBSyEDMh9XV1X5TU/lsjKvA
         u75U3886VkBHRV+sIyxizmL8BdPsDyLqqqd446T/Fl6sCBRiE2zBcN5TqHSbd9fS2rPV
         wI79TkqKofMGQgT8D79TEAnLWoe4o8SUUZONBZUbqB/9ARe2AycrNurHmTVnImPmdPSr
         txooILWoOsLr9rUAFD7QU1xFH7vQZkjgHIyZoze3ZYCYR+lnNexjiy99rvBm2QKz4BJC
         X2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmqJE2bXbIJQtN26iYuRL/qRaWyyYJXjBFdvyK1zscQ=;
        b=mvLATEXfi4A9gbBTeQCf4QAYqesWZ9bskDldvFNgY/M4b+3mzm0qEPHZpddcyrKZpV
         Mk9yV8jvavQMlPPwS9/XXCourHbw/7XyGeoPBAS9xxUHandg9cHd/q2BeLgsHOn5f+u5
         xT/AGdYvNWEo2+pVjZjLs//USoTdEnsoomkskTiHeqWg87juOcusAQqNcujSlwjM7UWw
         0fzT3RZXE8Iola4SiB7r4rpI9nN83ue5wLqXOKiUY/3B+OB3lG1Y2FWfqykbQ0aY6z6B
         uBA6+HsoF1rZVUEt1UMymhE30kNdoIEU/+VNdzg7rGdZXMzIKSmJAlctMn6c75iYJiJF
         z8iA==
X-Gm-Message-State: ACrzQf1UdQuqnY7EqQOCDKh7l5IKW0jRB57juBawar06yIE8d8cPiEgQ
	NiSdzwUQcyG35DLUDn+cHAakMKe3i/8=
X-Google-Smtp-Source: AMsMyM7CCGCH5og2wv134Z/Fs6EYtFaJaWzWWhbF0poMYogMeS2/hPT+UYCJ2JGhl4jWnuvEdL7XfQ==
X-Received: by 2002:a17:903:11c3:b0:17a:e62:16e8 with SMTP id q3-20020a17090311c300b0017a0e6216e8mr27814219plh.137.1667429499399;
        Wed, 02 Nov 2022 15:51:39 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00186b945c0d1sm8920377plh.2.2022.11.02.15.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:51:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 05/11] doc: document PairwiseCiphers/GroupCiphers AP settings
Date: Wed,  2 Nov 2022 15:51:10 -0700
Message-Id: <20221102225116.297129-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102225116.297129-1-prestwoj@gmail.com>
References: <20221102225116.297129-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.ap.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 5fa23179..7b8844e7 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -82,6 +82,21 @@ configuration.
        Processed passphrase for this network in the form of a hex-encoded
        32-byte pre-shared key.  Either this or *Passphrase* must be present.
 
+   * - PairwiseCiphers
+     - Comma separated list of pairwise ciphers for the AP supports.
+
+       Values can include: TKIP, CCMP, GCMP, GCMP-256, CCMP-256
+
+       The underlying hardware and IWD's AP implementation must also support the
+       ciphers listed
+
+   * - GroupCipher
+     - Group cipher the AP uses
+
+       A single cipher value the AP can use as the group cipher. Values are the
+       same as pairwise ciphers and the same restrictions apply (hardware and
+       IWD implementation must support the cipher)
+
 IPv4 Network Configuration
 --------------------------
 
-- 
2.34.3

