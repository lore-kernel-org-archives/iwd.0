Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61DB8C06
	for <iwd@lists.linux.dev>; Wed, 18 Jan 2023 21:18:06 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id p24so328299plw.11
        for <iwd@lists.linux.dev>; Wed, 18 Jan 2023 13:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kby3VJG1FiAn2tNWqTblHDfbhXUNhCflRjPv7u3AcX8=;
        b=XZBtJ9ZBNz9p92VbdNolMwH8FA+7P+S8JbYxFQaF2rvJFXmT90Gfukptclaox6HwPS
         n4iGVbgSiBnh9WRzqjOCgsg6/HmcZfdx4cS1sM9TQbyeH2dZhaZt5Oh7jM++x+Y4o5tx
         wLfZH1Yk8J3G7GvmrpC+dFxL0b/WnbTGODJ4YlrJwoDUlongb0pMyxkxtd97Owyoj2nn
         6+ST4fEBaR19jdtiAjIRsd4vO8BpcE43BXrb9ECAzIDeJtsB7A+dO1IE2k3s3UT4qgH+
         os8EKp8Y6VrjL++DWkBPAUTO8r/0T0lDbSOSadXkLOL8/JMsNcBONiPY2X7kWlCLL63J
         rZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kby3VJG1FiAn2tNWqTblHDfbhXUNhCflRjPv7u3AcX8=;
        b=Ju8XpqB2YXUpjv5gsw/nwu74sBFVmp/O7vvBfKziwh5KkcT2tSEg5YNL2V9PDEzyyl
         7c0GYDdXwJTXgL1lB3ErtkW1F8SxsD41ey6frse+7fhI61K26uhR08EobED6JSmQ09fN
         3ZfVPUCV1gukl+mYucef9lsX4qT1XP8tddsDGx6vvV2KioXLukokyZPy2zRqQPPsRbpR
         5QuXBpcpr8sTcHZku6zJOvR5q1KjBpqi86YWyR4+2XNCGCacFxB81gLqS6DmAstoo9Nz
         JBpPbS84jLJ+vZcYgno0Qd3gJ2Z9Eo2IAqsUXfVmzn4lfTSQJxHI6n1RvU/9Ei4mkDsX
         o77g==
X-Gm-Message-State: AFqh2kpB1pmnJTMtb+/fm2mbwp7ESM+eObpHaCTNw0oj8mt1Y9EMHf9x
	iXcCM8R0jHcTIUm7JCeV1mAK4SS3MFk=
X-Google-Smtp-Source: AMrXdXvRDLdstY0r8DfJv4vffRKJshotum0tV8YE7Z/njPBGddBXG3L0pbcLRqA7ZOhZFE7AJAP46Q==
X-Received: by 2002:a17:90a:9bc8:b0:229:36dc:a945 with SMTP id b8-20020a17090a9bc800b0022936dca945mr8860699pjw.23.1674076686130;
        Wed, 18 Jan 2023 13:18:06 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090a5d0700b0022335f1dae2sm1784802pji.22.2023.01.18.13.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:18:05 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/3] doc: Document RekeyTimeout for AP profiles
Date: Wed, 18 Jan 2023 13:18:01 -0800
Message-Id: <20230118211801.1636194-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230118211801.1636194-1-prestwoj@gmail.com>
References: <20230118211801.1636194-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.ap.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 823aba99..0763b442 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -67,6 +67,12 @@ The group ``[General]`` contains general AP configuration.
        ensure the country is set, and that the desired frequency/channel is
        unrestricted.
 
+   * - RekeyTimeout
+     - Timeout for PTK rekeys (seconds)
+
+       The time interval at which the AP starts a rekey for a given station. If
+       not provided a default value of 0 is used (rekeying is disabled).
+
 Network Authentication Settings
 -------------------------------
 
-- 
2.34.3

