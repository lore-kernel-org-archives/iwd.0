Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F5446AE
	for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 23:16:24 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso3561631pjd.3
        for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8/ZyNhNS+d/UW4nLhtskXD5Bho6Qy391QnV4HgLvIwQ=;
        b=P81RoiJGDkTCIbeBfXHbugLMIDV+C+uyFlYa0wbwKowbOZ+HktHUgeU0KvlhdF/sH6
         C4ZEgQZ/DHpz2mNDQwwnT1EpVeOAtTDLTCsWhagRJ/Opud4zo99qXjL3xZJQdHUQEih7
         ZfB+xkk1bcbGzv0C4Es3UOw6cXAQLYrH9aGouKsxkG3B4Lz3ORhv2HyffaF309fBYRwx
         G5d1Tor4JS3FueGD9XZiGqMi9HOk7+jfCXYD0WBD6qx3RWIl1N+Yh6QK89xPcE2tGRmz
         Sy1TIRRN77ZXSj5ctq/1NZbCzre1OQ84U14GhkyKoGzFKwehomXUmMTaIuyOG8tJsXwu
         T9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8/ZyNhNS+d/UW4nLhtskXD5Bho6Qy391QnV4HgLvIwQ=;
        b=PLcsv2/x6SAQ3wzfCS2BlrecqRgKz+b0vxbhjq+Qte/ncKyps0UTP2uSd08eP6WQ/r
         TExGNQog5H4KPY536T1WqlvSrOxwE+RN7QPSiigigvguRyb5FQM9pVSBllHCoG3Y02Pj
         5GZ8O7SUyo/vfY0Nl/rW9/9mQUfo7waYOx2fMcsNtWcjgt4yhuyJSJUmN7F6gPS+UrLF
         8bMIMf/YKXslUOPuQJrkmKyXJH2NE4T6w/Mg/7/UKslOfzybiUObXVPp+6MgrIPEFZNm
         IAI25EBufKL2CDK89ESBeeOX8tIinLdoyQ9cUffhStyhOtQ5UiVMkwYGXyn6VMF2iITg
         5FQg==
X-Gm-Message-State: ACgBeo2kvP/r6/M6NAEHiHQwBOqUDzrAnQztW8lU0RLizl/KYxpQdL5k
	tBkPyKqskJFBkb6qk3vKrULZXjPLxh0=
X-Google-Smtp-Source: AA6agR4uWKyoqY7qd/+9TUzOl8+ZE0fSYuz/76EXCiWhVmlQ+trzsHPunDcOENobSDBoIc4I68CI5g==
X-Received: by 2002:a17:902:d1d5:b0:16d:d21d:abb8 with SMTP id g21-20020a170902d1d500b0016dd21dabb8mr30074529plb.138.1660173383657;
        Wed, 10 Aug 2022 16:16:23 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b0016d62ba5665sm13540246plg.254.2022.08.10.16.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:16:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/8] station: check for matching SSID in Roam()
Date: Wed, 10 Aug 2022 16:16:15 -0700
Message-Id: <20220810231621.372514-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220810231621.372514-1-prestwoj@gmail.com>
References: <20220810231621.372514-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a debug method, but still should verify the SSID in the
target matches the current BSS.
---
 src/station.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/station.c b/src/station.c
index 8c230b52..57dbd0d5 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4373,6 +4373,13 @@ static struct l_dbus_message *station_force_roam(struct l_dbus *dbus,
 	if (!target || target == station->connected_bss)
 		return dbus_error_invalid_args(message);
 
+	if (station->connected_bss->ssid_len != target->ssid_len)
+		goto invalid_args;
+
+	if (memcmp(station->connected_bss->ssid, target->ssid,
+				target->ssid_len))
+		goto invalid_args;
+
 	l_debug("Attempting forced roam to BSS "MAC, MAC_STR(mac));
 
 	/* The various roam routines expect this to be set from scanning */
-- 
2.34.3

