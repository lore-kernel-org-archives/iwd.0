Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F6F6120
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 23:06:42 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id 73so18158665pga.1
        for <iwd@lists.linux.dev>; Thu, 08 Sep 2022 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dR4eQdTpUWjLTWLJF/Pi4pGfzP9FoTu632hYSVVJx+o=;
        b=nHTYXIAOv43qgb7bmUQOEoGo0OyOrkCnNlTukRbYl2fr1KqIjUQYkIYzwakZ1qFqVE
         97c4SWtOPuFzBTPfvNtccKof9T3GQaa4ezR2k1NRCSbl+r3W505HaVjYAmP2A/y1nfo+
         Cu0WbCRbK/oouv1qMaQ6akLaKx1eeND+unm0ug9EiPmtE3K1ieuNXFwwdiltq4cK/XL6
         PBWtye9JzJ41+BrzPatDTeyzsomI69LfSHWZ8c5xDmspvlifZff9UzlruOaiOZiVYhsN
         vDjCZ0BIpbHRfnGJFMkg1dZpmgzTJFxIM5crJQEY9DEqTiQ+9iMNhQdZGbLEY86QSvXR
         cWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dR4eQdTpUWjLTWLJF/Pi4pGfzP9FoTu632hYSVVJx+o=;
        b=LaJmjpfTsmKvsZTrEHf9ZvyUDV+W+uRQaqrtxhF+TCLZ0KOuNA5Qx/MiRx8YBmsjPP
         7Xo1jZW+GCR/kA4FGQFx4Ijx4sDomDPtqYhsPsg99LlnTYgDWOHZLdz7dhDKTHKs7YfD
         JOz86K2RllnD3XIh+3ZJ3oId56x8dYiE4M0ury80eoixpWW7b/g+mkglNp1L4cWXRR9D
         91Ijdqr4uyBR56qda3B4Ih66ad9SEq+agn25CtHoI89r3nEnRObbpKZ4Vn3ntDvooSRJ
         CUZqbGs56vRnlIcFAz1X/Oxr6g6MwjHU56RpERrrSdceqDebonEEbFY2SSG5m2OquiZf
         QCig==
X-Gm-Message-State: ACgBeo2amMmK6ahSn4vNKeYHIEqgUfv8DzLMfgtN11orp3RJacJ8jlNM
	LtA8E84WZtzEtFcM8F7LCiD/u67DN/w=
X-Google-Smtp-Source: AA6agR4exWa3GZMQ5wUnzK1jUDkkQ3goOyn7v9+24RoGXnPUI5bdXYTw1619/H57Cz/i/D7TQo24Aw==
X-Received: by 2002:a63:82c7:0:b0:437:3427:44c4 with SMTP id w190-20020a6382c7000000b00437342744c4mr4273500pgd.103.1662678401931;
        Thu, 08 Sep 2022 16:06:41 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a3cc500b001facb7bc1adsm2329261pjd.26.2022.09.08.16.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 16:06:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] doc: document [General].Country main.conf option
Date: Thu,  8 Sep 2022 16:06:38 -0700
Message-Id: <20220908230639.440880-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This lets the user set a country code explicitly.
---
 src/iwd.config.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 422d4c03..bafb6b85 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -206,6 +206,16 @@ The group ``[General]`` contains general settings.
        required are LoadCredentialEncrypted or SetCredentialEncrypted, and the
        secret identifier should be named whatever SystemdEncrypt is set to.
 
+   * - Country
+     - Value: Country Code (ISO Alpha-2)
+
+       Requests the country be set for the system. Note that setting this is
+       simply a **request** to set the country, and does not guarantee the
+       country will be set. For a self-managed wiphy it is never possible to set
+       the country from userspace. For other devices any regulatory domain
+       request is just a 'hint' and ultimately left up to the kernel to set the
+       country.
+
 Network
 -------
 
-- 
2.34.3

