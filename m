Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C14BD02
	for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 20:15:56 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so21237605pjk.3
        for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 12:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOA1KJtJe0EYrXWOZX9o8wFbgdeUO4B/DZqAfRPT/Pw=;
        b=eq/SFB7ZjLhoMbOum9o9kVAQU8htNtdvVOa0IW8ZiSWR/syGjEJHuc5fdut6/xG3+/
         sHU6fw7fmj0mEizkTxAkRQsWbcDJRHTrRYtSzUPw0rYjINJYlFg+RJPMsvfzvO2C9Hjv
         2zQAFxPmtH++43HfmMRf8U3OrD8k9MRf2O3eZb3U/qCAryvCltCQRpMw8KmoYCgX5/kC
         Ud3CKjslOg2pG9gsLjYkvI69UawZ13+roKdCXK+mpvBEoHAxZ1E+IkQ72KHewhxDi7TX
         QMP5oVRYJ5fZtNshgQsulsS97OZkco0kLjwEB/ln/Yy/4jbm5m5dCnAFoBVo3adaTc20
         ROBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOA1KJtJe0EYrXWOZX9o8wFbgdeUO4B/DZqAfRPT/Pw=;
        b=dQf2Bt9MS3zpsdv64FpZoD2wAZy55L12Wnf0TqYRU3jSMWC+fNR0azSR/MDQJGOXRq
         KXoNqehzmRWd/2/USQXkGtaq9fvG/msZmcjickdjEq6WFDkodEfsCrd7RQqPwHzozBSe
         faiwoKmseZD/utx/ypMS+vBqjrWUvIBFQsNjUG1unPq3y68YpQ5WoF9qr22T9OEeCtKT
         x97bJa+GPnloco2nS09BMp7BG+81zybMAzbKuwNynJHebk1Z5+bIOQIeT0g2r8v273yy
         7vXthWioHveJHoJkGinTirsgac8FQ9eLYoMkZVgCqyxZJ5W4idnSFuc44Scl7A8vvRrK
         MKYw==
X-Gm-Message-State: AFqh2kqudIggQYR413ybe/FazcQDSi9fhhSuGej3mdY/LpmA/VNjH+8N
	pUcOTnGACC8Ey4PunPvRdxv69XY28yM=
X-Google-Smtp-Source: AMrXdXuCkYw5AngWzbQzmMhL9vieRxZx+S8NQ47g4JLfnjBJqjY8Dwlu+81AADeBrAxoKcpE71G+TQ==
X-Received: by 2002:a05:6a20:6901:b0:b5:c353:d97b with SMTP id q1-20020a056a20690100b000b5c353d97bmr17146053pzj.50.1673468156254;
        Wed, 11 Jan 2023 12:15:56 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b005884d68d54fsm6733904pfq.1.2023.01.11.12.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:15:55 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 9/9] doc: Document RekeyTimeout for AP profiles
Date: Wed, 11 Jan 2023 12:15:43 -0800
Message-Id: <20230111201543.397692-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230111201543.397692-1-prestwoj@gmail.com>
References: <20230111201543.397692-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.ap.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 823aba99..ce402f91 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -67,6 +67,13 @@ The group ``[General]`` contains general AP configuration.
        ensure the country is set, and that the desired frequency/channel is
        unrestricted.
 
+   * - RekeyTimeout
+     - Timeout for PTK rekeys (seconds)
+
+       The time interval at which the AP starts a rekey for a given station. If
+       not provided a default value of 600 seconds is used. A value of 0 will
+       disable PTK rekeys completely.
+
 Network Authentication Settings
 -------------------------------
 
-- 
2.34.3

