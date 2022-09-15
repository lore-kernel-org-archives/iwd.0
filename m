Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9939C4C91
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 21:18:56 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so9117437pjo.2
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+JzW7VnwR/FW2qLFYt6b6aIFvnLxLEYb3/54IE2kMFk=;
        b=EB0n2TIOuPzNaOfL0yDOygPoaxHZnTgfEEXQcn9ZMWevYfVtsp4b+BYYiqlacok4WW
         P5wrbtVoME7QK4+MHG+9mreFg4561ACZT6RMFQFcDo2JXuiMDKPWcSTOh0GGP8sYlyvj
         J9cBgvcW9Yvsy4zKf4o3gKHQv8j7Jt95xNywwS9qbtX2ssflMeqFCOV5ag2Rx9l47OiQ
         9s2COTpOmq9pnvAHzxdjkxZM01zjAvqC4z570HPce68uUYuvDmBKRqtzYMksmkDrfbvj
         uZMCK+FM3ZsBccktsLD4UgVVT3t+pQFUPWFdGOWTzO4E/Z8/bHvvfCUA6TNEVivxwzYB
         bZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+JzW7VnwR/FW2qLFYt6b6aIFvnLxLEYb3/54IE2kMFk=;
        b=vcRL3DMq2EL2IckeIOHClOd/9pUBNomphU4uXpmeVZSb9huCg8UcyOenEUhAiMXOum
         5dK2j3xlgBjhQjh59q4jiNYzrYNicJW6vWpCdyJOG/ZNk+ymJhO8D0qY7ueQIJEge6Op
         l+MEQjHbxOmOmKFxIPkbTMDSqqSzFdDZmOTCWS+Va71WzAq7BoZ62GTZjYPUB9WC9E4q
         aaq7Yhg/FWZ57/f+zAdeV3Ie1FsCjy+4jJU3DpDNsAQonNA939v8y62Qn4vvqMuNMy4S
         ycfyQ3YfGGl4BNvq7xwUyzmQam98WimDpiyKMNsQh0hL7v58OPMZwmhG1rLMeNyrQQWE
         H6vw==
X-Gm-Message-State: ACrzQf0lAADdENtEyyMxYz0I0qAykmKYZRZ1v1YN83J0qXkico69cIT0
	wUCxjcWsNGLe7bRojN2aaUOnfp+OydQ=
X-Google-Smtp-Source: AMsMyM7BF4aR7+axs9gNWsuXOrThL04PlSJM4qiWCYG26HmvEsWyz2QwigjOtaUYLb8gLfyy8tPf6g==
X-Received: by 2002:a17:903:41c6:b0:178:348e:f760 with SMTP id u6-20020a17090341c600b00178348ef760mr1450379ple.123.1663276735989;
        Thu, 15 Sep 2022 14:18:55 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id 2-20020a621902000000b0054aa69bc192sm125139pfz.72.2022.09.15.14.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 14:18:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] monitor: parse probe response frames
Date: Thu, 15 Sep 2022 14:18:53 -0700
Message-Id: <20220915211853.1093078-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220915211853.1093078-1-prestwoj@gmail.com>
References: <20220915211853.1093078-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/nlmon.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 15f4c828..5ae014e4 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -5018,6 +5018,16 @@ static void print_action_mgmt_frame(unsigned int level,
 	print_mmpdu_header(level + 1, mmpdu);
 }
 
+static void print_probe_response(unsigned int level,
+				const struct mmpdu_header *mmpdu, size_t len)
+{
+	const struct mmpdu_probe_response *resp = mmpdu_body(mmpdu);
+
+	print_attr(level, "Subtype: Probe Response");
+	print_ie(level + 1, "Probe Response IEs", resp->ies,
+			(const uint8_t *) mmpdu + len - resp->ies);
+}
+
 static void print_frame_type(unsigned int level, const char *label,
 					const void *data, uint16_t size)
 {
@@ -5063,7 +5073,10 @@ static void print_frame_type(unsigned int level, const char *label,
 		str = "Probe request";
 		break;
 	case 0x05:
-		str = "Probe response";
+		if (mpdu)
+			print_probe_response(level + 1, mpdu, size);
+		else
+			str = "Probe response";
 		break;
 	case 0x06:
 		str = "Timing Advertisement";
-- 
2.34.3

