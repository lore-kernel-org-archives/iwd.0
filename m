Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA93D9E
	for <iwd@lists.linux.dev>; Mon,  8 Aug 2022 18:23:03 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id b133so8794057pfb.6
        for <iwd@lists.linux.dev>; Mon, 08 Aug 2022 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PRe2tqwozw0inC4CpR3PdgRYPw7XugrHXiiior1jr2A=;
        b=R/9wMS0ok5oGYPFPvG/B+00uXhOvk0DZWOW9WtKWvnojnHMdjI3Y8kimzOHFW/cY3S
         wQJglr3kvYv1S7uICO+YAgxSJkYLsAVn+Dfoz3cqrU/2nIhmmYfuFdj+xtUo0vE98wEP
         TtUdeRyesGFx6lZ1/v3b528po0kag24UERas7sa1C9GFxvf0XRowxht4c+ZiUQ5P9Vvx
         nMugzW1XcU9AVMlva1P+cIbyv9njj0nsiewHVLpJzrMhJOFX+OYx02o/tQcxjUZLsqqV
         Nftp35a72ukirI0EzVGEjCwc+K/6WOMuE2PeLyUc09SCPB0LsOa9hvFKMTQ6PAqss1wv
         hzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PRe2tqwozw0inC4CpR3PdgRYPw7XugrHXiiior1jr2A=;
        b=IBz4q/LUNE0l0ekqwzO89EgCjaSDuvgv6+4SdRorEZrV8xfTzQGO68PBuY9EpwBoQx
         lqj91iRmFOaOCJN6GhGu3JFm70xXhsKZ5+sOhZT83D70pnAOe9nGvBP6G0HWmbqfh9EU
         cm6wevY8Q0GdIjGhYJWm79hZTw0wt1IZowj3fhTsCst9KHE+q/hEdH1SNKyUeYdBaRn+
         TUHctUZRw9KhqGlUme93YuvMR01NeqdAAkXIkvGW9fgdj1A5e4DxvE5La9pWx14/D88M
         ORsBn7m+UQ8YTRB2dsvnE8vp/00MVWA+2s887SFXCg5bCQapecGt+47wPvqAeWtkJkj1
         ykwg==
X-Gm-Message-State: ACgBeo3kppi1ljRZRXY6ydTf3QN/92AMh3Pveda/IWvUKpv61i0Y9b5v
	CnbHI3D7oXHFRfiFokRdI/JulxX4sig=
X-Google-Smtp-Source: AA6agR7HlHsTD9/eqpBwJHnIaAjYKIWnLoSwiQCEL+6LsYpW7vIMDt+sijUabVOCycSqyqpKSlwqRg==
X-Received: by 2002:aa7:80d0:0:b0:52d:f9c6:bb14 with SMTP id a16-20020aa780d0000000b0052df9c6bb14mr19783058pfn.57.1659982982567;
        Mon, 08 Aug 2022 11:23:02 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id 129-20020a620587000000b0052516db7123sm8972197pff.35.2022.08.08.11.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:23:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] station: re-try OWE if buggy AP is detected
Date: Mon,  8 Aug 2022 11:22:59 -0700
Message-Id: <20220808182259.19402-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220808182259.19402-1-prestwoj@gmail.com>
References: <20220808182259.19402-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some APs use an older hostapd OWE implementation which incorrectly
derives the PTK. To work around this group 19 should be used for
these APs. If there is a failure (reason=2) and the AKM is OWE
set force default group into network and retry. If this has been
done already the behavior is no different and the BSS will be
blacklisted.
---
 src/station.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

v2:
 * Made warning print more descriptive
 * Just check network security rather than parse rsne

diff --git a/src/station.c b/src/station.c
index c5dfc48e..17a48670 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2815,6 +2815,29 @@ static bool station_try_next_bss(struct station *station)
 	return true;
 }
 
+static bool station_retry_owe_default_group(struct station *station)
+{
+	/*
+	 * Shouldn't ever get here with classic open networks so its safe to
+	 * assume if the security is none this is an OWE network.
+	 */
+	if (network_get_security(station->connected_network) != SECURITY_NONE)
+		return false;
+
+	/* If we already forced group 19, allow the BSS to be blacklisted */
+	if (network_get_force_default_owe_group(station->connected_network))
+		return false;
+
+	l_warn("Failed to connect to OWE BSS "MAC" possibly because the AP is "
+		"incorrectly deriving the PTK, this AP should be fixed. "
+		"Retrying with group 19 as a workaround",
+		MAC_STR(station->connected_bss->addr));
+
+	network_set_force_default_owe_group(station->connected_network);
+
+	return true;
+}
+
 static bool station_retry_with_reason(struct station *station,
 					uint16_t reason_code)
 {
@@ -2825,12 +2848,20 @@ static bool station_retry_with_reason(struct station *station,
 	 * Other reason codes can be added here if its decided we want to
 	 * fail in those cases.
 	 */
-	if (reason_code == MMPDU_REASON_CODE_PREV_AUTH_NOT_VALID ||
-			reason_code == MMPDU_REASON_CODE_IEEE8021X_FAILED)
+	switch (reason_code) {
+	case MMPDU_REASON_CODE_PREV_AUTH_NOT_VALID:
+		if (station_retry_owe_default_group(station))
+			goto try_next;
+		/* fall through */
+	case MMPDU_REASON_CODE_IEEE8021X_FAILED:
 		return false;
+	default:
+		break;
+	}
 
 	blacklist_add_bss(station->connected_bss->addr);
 
+try_next:
 	return station_try_next_bss(station);
 }
 
-- 
2.34.3

