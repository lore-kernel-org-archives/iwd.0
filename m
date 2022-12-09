Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB46FAB
	for <iwd@lists.linux.dev>; Fri,  9 Dec 2022 19:39:37 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id r18so4187004pgr.12
        for <iwd@lists.linux.dev>; Fri, 09 Dec 2022 11:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqeYpa7sv4P1GZ4qZMuySNH9P1etBW2vI4Y9N6iOExA=;
        b=Z8S07qDpk7JgFPkFvvyJTjyC0cXqrGy1NQZ1YvRvPnFW386tJw7RI8kNOdHQbDII4j
         +lKxJytRmxw8exkP+HvKyUiojhxI7t1++ttsymS9YS6hv3l4ubXvcMiCJ2FSJLbDZy/l
         R2w7KUarvw/aHbPTM8N8btHCPYhqVd4YbQrdYPTHzHWEkUhUBlo4H962ufEsN4idwkkg
         nqTJfdTxLYKVMJlXTFhIs4323hLIUTo0gIv6in2zB35BPORERXnvWJItr1eFz267GqVs
         lTI0vIep2n+4Vgr+BN+t7ptqFdIYnjoNIrhuA4PZ7o2WewpakztnInNBk8Rk2F0WRdCr
         uAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqeYpa7sv4P1GZ4qZMuySNH9P1etBW2vI4Y9N6iOExA=;
        b=NCBzb0TkxIs1CmOQgEU1FDNhx52MGRSmqSrpTuuJEtSbZrWobUbgR9PU2wElvNFyQj
         sdevUnesD/CnPbU48aKDh0XBZ7lkmSb/gNddi++MSK+50hIwge0DGgx7OrRp99CW8G65
         N0Y0wa6ff1DOJFXZ4TFF7NbUdeqO25DNJdIpm5lUHwj/OQRuv0tBTucX7URBP7EApCp6
         Wq1CDYHScQRdRC4JI1i4NUFChCVpO59hdEp+XXK3ENAKxy8V5+i7ALPV+oQ1ntmTGszS
         tyeuh+lkZGf/X3etWhtx2CCIDgZz6LuWHRI+lJyQSaVecxvLG7XOeqUDg3uuT4Z1qIDr
         hfOw==
X-Gm-Message-State: ANoB5pnIWaWDdCrNCT1trMEbZkGORnNXo0eW8vb1WRUIEijzYZFuw/eB
	p0yUOolUlPHFujYVZpT7p6nqLLQcQAA=
X-Google-Smtp-Source: AA0mqf5/HZNnmUE4imv77WJkfddpCcGz3KHB/FTfybp3Nuds+Pw4YzPojj0+AoRlhlqehGNccrFiNg==
X-Received: by 2002:a05:6a00:1c81:b0:577:8bae:29a7 with SMTP id y1-20020a056a001c8100b005778bae29a7mr6414804pfw.33.1670614776720;
        Fri, 09 Dec 2022 11:39:36 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056bc5ad4862sm1587638pfr.28.2022.12.09.11.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:39:35 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/4] doc: document 5GHz AP support
Date: Fri,  9 Dec 2022 11:39:30 -0800
Message-Id: <20221209193930.845238-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221209193930.845238-1-prestwoj@gmail.com>
References: <20221209193930.845238-1-prestwoj@gmail.com>
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

