Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4292D6AD5
	for <iwd@lists.linux.dev>; Mon, 24 Oct 2022 20:47:13 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so14171534pji.1
        for <iwd@lists.linux.dev>; Mon, 24 Oct 2022 13:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZYJssnY4Q0PnhVEkCAd2WHXUkHZuaMRZtYYrmOBD78=;
        b=FhobPJ31dDAUrccGlWN3PxjJm3M5Vqka0Qeykomnmun4R3IMcWMgE3NC/bh0TPG0ZJ
         u3xueAYMliVHAwmY2glXmFydpN2BVknvbuVPRos6ak4u7313jXVaSFDrAulBsWNpBduY
         44WaFMOOOMO1+n4NEJjMho/D5L4J2cs6AMMHtNDJ8dx8bJNi9NbKq00+NWb3iycoj9bi
         Dqp3UCw6elK9E+u6pGhj5HjOkQ7MTAVihrxjOL4ECr0jPwr2J3TpajuACd9gWSfNoNmY
         qqexHYkJLdsl/JvnZATBl9PmmYSyD4qbKlZ523VrZbhFN5beukPgdqjiWwIzMhO6LNKt
         61Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZYJssnY4Q0PnhVEkCAd2WHXUkHZuaMRZtYYrmOBD78=;
        b=lQhBbwQLBZhnxvFQzopqUCvmtfGulNGr+E6Sjj1AV6LtqiZ3bnb2sIKwP+YgY70wHb
         +mwZIo1wW1hIbXBHGje2O33D8dnkQs3vrLcK069RCajJsRlfhn+nw6hL8T6yJIMIBXUi
         +AoJqXDEiCskXp1uiSxyqR2vXLS8eokwjmjO5x/S8doDoU4f644haM+AV/OYkcYmY6t3
         waIHcbpkNrw+LTzo74qQK/htOH/rv+XdpfZ3le3TJnpwOjBzUPtB3D5XAdE2CgYCUymy
         P5rYgO+MS1UMPNI3XbqelUviGpMChDEUMUOJrpen+HLEKUKgXXIMXG2gBKTzyi3Rg7Vm
         hm4A==
X-Gm-Message-State: ACrzQf2ZN55RzOscyODFP7bSKpVbp4pqzds11nZcmKX/YOIL4xy8R+Ig
	IXfEzl+TKtxW/P7TVTrCXgDMojouIJg=
X-Google-Smtp-Source: AMsMyM7+ZNYyYTgOw6cditAqc/N7RKisUBf/LZ6v+j1oSPlFJ0nuIKxe7XXKWK8waRMwQRTanfYXUw==
X-Received: by 2002:a17:90b:3e8d:b0:20d:2ab9:517f with SMTP id rj13-20020a17090b3e8d00b0020d2ab9517fmr39540341pjb.88.1666644432466;
        Mon, 24 Oct 2022 13:47:12 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902e48b00b0018157b415dbsm151340ple.63.2022.10.24.13.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:47:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ap: disallow TKIP and 'use group cipher'
Date: Mon, 24 Oct 2022 13:47:10 -0700
Message-Id: <20221024204710.163107-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EAPoL SM does not support either of these ciphers when acting
as an authenticator since ARC4 encryption is not implemented.
(see eapol_encrypt_key_data() for key descriptor version 1)

This can cause 4-way failures if e.g. the hardware only supports
TKIP. Rather than fail the 4-way its better to not even start the
AP and return NotSupported.
---
 src/ap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index 429de560..94eff2a2 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3303,7 +3303,15 @@ struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 	err = -EINVAL;
 
 	/* TODO: Add all ciphers supported by wiphy */
-	ap->ciphers = wiphy_select_cipher(wiphy, 0xffff);
+	ap->ciphers = wiphy_select_cipher(wiphy,
+				~(IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER |
+				IE_RSN_CIPHER_SUITE_TKIP));
+	if (!ap->ciphers) {
+		l_error("Hardware does not support required pairwise ciphers!");
+		err = -ENOTSUP;
+		goto error;
+	}
+
 	ap->group_cipher = wiphy_select_cipher(wiphy, 0xffff);
 	ap->beacon_interval = 100;
 	ap->networks = l_queue_new();
-- 
2.34.3

