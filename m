Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151BCC95B
	for <iwd@lists.linux.dev>; Tue,  4 Apr 2023 20:38:28 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso37463324pjb.0
        for <iwd@lists.linux.dev>; Tue, 04 Apr 2023 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680640708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+fQUxdO98mVYrscZjfO/OpmnjOz8X2JdwaI9cWElYE=;
        b=V3PZda73Pcl3bw9+fogVxTanaV5JupSNBquu9bZS41b6IteBJwyf6gMxyM8GHgzDJt
         BIBSWSlna2Si5Kk1Mrk85+B2WXudI7Qy7qEVFhmYFRGrDVKOiHshurt9qbS2RRWSKFcJ
         FWR9YUGK2MXuOeHO/0UzHlpDTv2gT9P8UUVbReOxfe3L2I48I7jb3F7kach8ts3zQ81H
         MQtDnEuPGwo9CSB2151SMGveXUapiuMEXNz4eg/5D9ZO8oeKMTEPjP4WFvRJeiV8NhJH
         m6RtxY01aFh44pe89R0GJT3c/59aAWjDf3OJTDXQEU4muO+hvCqHwj1F5d8dlGzMfuq1
         Yddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680640708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+fQUxdO98mVYrscZjfO/OpmnjOz8X2JdwaI9cWElYE=;
        b=Dtl8Dha6v3VpCUuu/iPudcm2x7tgFP/dVUCCvnAAdmmBYlZ6MTMP8kSMxVLaitAJpK
         ZfHNVDQyaPhGpQO1awy+sYP+u7R9zwwiDdnwxT3H7XLFqrAoyWlEFDFF01ypXXLYLwtP
         nNSL5zLbE4IozgGEL+l8c1vM19Le7IDMcmoG5dZiGKK3lAxHzsapDma/QsWG0lV8prYb
         7YGmlyYxTYXtEvkGHHD7Ct8k+IBzfzzrXYXFHdKEeH1ykMUQOWtpsMxMECUJwu9qncrq
         LNrgWN5caSKUV8L4iYkhpcKfJbHf99UtsNj3k29FuD06I5ARd6BNySrhDtAx9j/AjkD0
         wXfQ==
X-Gm-Message-State: AAQBX9cFmyb+fKZRQX/fgpJzut3FyXvre5yWM9BlKgFGyitoEKFOW6Px
	fbNCaObRCr71hBtS8Mr38WwULKBCy4OPag==
X-Google-Smtp-Source: AKy350YdoX4teDPTscN3+pRRweTLwCrDVw/vgVjZ7qNZ/JVJTfLdGbpx2Hw+2OIWKt3GZpD0lF4c9g==
X-Received: by 2002:a17:902:dad0:b0:1a1:da3c:605f with SMTP id q16-20020a170902dad000b001a1da3c605fmr4362730plx.58.1680640708286;
        Tue, 04 Apr 2023 13:38:28 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902b28100b001a21cde3458sm8755417plr.90.2023.04.04.13.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:38:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] eapol: warn rather than reject invalid PMKID (for EAP)
Date: Tue,  4 Apr 2023 13:38:23 -0700
Message-Id: <20230404203823.384260-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404203823.384260-1-prestwoj@gmail.com>
References: <20230404203823.384260-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent hostapd change b6d3fd05e3 modified the PMKID derivation
which breaks EAPoL if the FT-8021x AKM is used and the AP sends
the PMKID KDE in message 1. This is because if the PMKID does not
validate it kicks off EAP again to renegotiate a PMK, but ultimately
the PMKID generation doesn't change so we end up in a loop until the
handshake timeout.

The validation of the PMKID isn't really required since IWD doesn't
support PMKSA, but we do it anyways if the KDE is included (why not
right?). But now with this interoperability issue we have to work
around APs incorrectly deriving the PMKID since its been in hostapd
for quite some time and a guarantee there are APs in production with
this issue.

For FT-PSK there is no changes required since IWD already ignores
a mismatch (see comment about zero/random PMKID). For FT-8021x
IWD will now first check if EAP has been exchanged and in that
case ignore the mismatch and print a warning.
---
 src/eapol.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 3d7d33e0..43f65b85 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1237,11 +1237,17 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *sm,
 			/*
 			 * If the AP has a different PMKSA from ours and we
 			 * have means to create a new PMKSA through EAP then
-			 * try that, otherwise give up.
+			 * try that, otherwise give up. If EAP has already been
+			 * exchanged its likely the AP is using an outdated
+			 * derivation, in this case continue with a warning.
 			 */
 			if (sm->eap) {
-				__send_eapol_start(sm, unencrypted);
-				return;
+				if (!sm->eap_exchanged) {
+					__send_eapol_start(sm, unencrypted);
+					return;
+				}
+
+				l_warn("AP may be using old PMKID derivation!");
 			}
 
 			/*
-- 
2.25.1

