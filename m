Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5521B89DD
	for <iwd@lists.linux.dev>; Wed,  7 Sep 2022 23:32:05 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id c24so15015325pgg.11
        for <iwd@lists.linux.dev>; Wed, 07 Sep 2022 16:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dR4eQdTpUWjLTWLJF/Pi4pGfzP9FoTu632hYSVVJx+o=;
        b=hg4bm+0TQPjKI/njCMrWqJ8F5EsfgNawR3gFELw9+oxJnM8zXnDR/6sRsy5FFkA29U
         1QrVL7ilolpLr7nBndFKjvw3gM+L6c/VguHU4je1dfC9lNZ8/OWcjCrN0XWWlEoEpBs/
         YgtPRN2fphr1BuT7jZI2ZgeZQvnLigAKU5aVqsuB7BAeTve4WLsDXfxRy7XZjUtkLuZV
         IaUFt5Vn4OoZwBn9/UxPP9WLVKaTJyHTwvkYrA1JN97+1RJENMvTUYb/GjiFAkDAZz41
         Vn0kFG8Dzm0U7SY72ms4cPi3xdHFqxzHdPJlmsjlB07oHR19UxJ4ZRdUf0AF5i6Z5id1
         NCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dR4eQdTpUWjLTWLJF/Pi4pGfzP9FoTu632hYSVVJx+o=;
        b=qB6T2Sm5NCh18DNgdZv9c2xseilhpyEje2aXQooXRtYJE+54/A4WsSfFMPw0ma4VBM
         5lg3zJjtrw1ZnH3E6H2S+TpWg5BMXzCoVVWP60BhpMIYFS+PHN1aSBFzHG58/KorQjbE
         +J0AdZhwhdwE1L9j7fxt9Ci7mkC97hcGs9lNKOBLiw+KinRU2NriJ/7MNfJKhqmkDgnV
         M8dTvv8HNxGYGpNSudBUwsc5VvBYXVBTPReVFdtRCciRBNY8UCFK9tyLXt3mOxcUXRVC
         Efo2KyADfeLgIdZDYxg5v870kLoyeozmfAhj8piVnGxDIcLuejfvp2Nbzpty2tq2NySW
         DKow==
X-Gm-Message-State: ACgBeo1wEHKY4hCxMpUOG3+2SfjYc9kEDSrAiBxTz0TMb0zNesAef79I
	uWJDuOD78qEmPLjoM/KV04OP3izTCWU=
X-Google-Smtp-Source: AA6agR6OQ4t4eprnKQ0I7EorKNsZIn3ihLMTCveKO7jP10j6M5bsedjfx5g81tWzT0qcbQvtzWHbow==
X-Received: by 2002:aa7:9e52:0:b0:53e:49b2:1c6e with SMTP id z18-20020aa79e52000000b0053e49b21c6emr6413779pfq.70.1662593524606;
        Wed, 07 Sep 2022 16:32:04 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id q24-20020a63f958000000b004348bd693a8sm4918192pgk.31.2022.09.07.16.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:32:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] doc: document [General].Country main.conf option
Date: Wed,  7 Sep 2022 16:31:58 -0700
Message-Id: <20220907233201.227577-1-prestwoj@gmail.com>
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

