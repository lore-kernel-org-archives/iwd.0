Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5D4C82
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:57:58 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id gn24so1282250pjb.3
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbDhtroaqcjVfvUGI9Wyt/DIs1zo4c14ptqkYtdbk5k=;
        b=Vo4NtftPBb5itO8pcrboJ3261Gi31lxBPGQ9WdmjvlwDAPO3IBiQJ677AwOFzfVVQs
         gcbRN7VMcWIqDhhKMzuLm0KbMN1FNtBhWhxsRMsoyuwtTFem6UYk5Nga9r8vIcpJJaz3
         pprc5Oosk632GtXg28DcGjTndhCpQuR3tBXRYeeTUefkHKTb1Hx/Qxzsmqd9G+z6Xl0B
         TOlKQNT3nDTr/jD2tAW0C+L+/QPLOqAo+wF+aeHUU2JJ9gb2VvtSTVLA6IlPdftnWe04
         FXgvam7cnwlaPFx3UjLO9gdSBC4/V5XMIAAMwL9N5Oi7zpLpNqvwTT5Fzqip2j7mxnQ7
         KKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbDhtroaqcjVfvUGI9Wyt/DIs1zo4c14ptqkYtdbk5k=;
        b=DjIgw1c9Oqk3PXWlFOJM6/qqrIHUtMxyO58tMxRkC5YkW7x4WYCoTixk4sBums6Gst
         S0tQTqXBmawv8ezNnpqWFwV2/vDO9TwP3fs4ORfIn5ZgT5d6pKCuqltrhAAmpVRn/tC+
         7LFlQSVXWg5TNW2zaWLA4JEQyGKOZq3qM7B4APdQQmaCGvnj30FR9cTbjCZ5UWy4yQHw
         e0ZFbYZPuAB2gZQrM0RAQz9lFBKyNVHA65Rk+++9J6YzGl+8mYWKh7azsA0bfAe8Oag3
         vu8CrbF3wdEZu44PiPb7iAVrcqpWWo4Gygiva2AzdvajO0vwS91l9u4qT/mWEGnGP0fC
         soOA==
X-Gm-Message-State: AJIora81dAGOYimD/Kj+1NmXYOrL8R8nHFgRXugSQ0FHaWOQFFJVN07d
	Io9jK5mgJFFLzi23tR3r11n36A26PsU=
X-Google-Smtp-Source: AGRyM1sHCAyXORL+5Bi5wkp82BEJwGKnzAT404bBpUT+PPPC4p5JmQqGNtKzSXmd/DwL6S0nd2Asrg==
X-Received: by 2002:a17:902:b617:b0:16c:bd91:22eb with SMTP id b23-20020a170902b61700b0016cbd9122ebmr26988346pls.108.1658257077525;
        Tue, 19 Jul 2022 11:57:57 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:57:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/12] ie: add IE's from 802.11ax amendment
Date: Tue, 19 Jul 2022 11:55:34 -0700
Message-Id: <20220719185544.456727-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719185544.456727-1-prestwoj@gmail.com>
References: <20220719185544.456727-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/ie.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/ie.h b/src/ie.h
index e0bc6505..d38e9e8e 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -274,10 +274,29 @@ enum ie_type {
 	IE_TYPE_OWE_DH_PARAM                         = 256 + 32,
 	IE_TYPE_PASSWORD_IDENTIFIER                  = 256 + 33,
 	IE_TYPE_GLK_GCR_PARAMETER_SET                = 256 + 34,
+	IE_TYPE_HE_CAPABILITIES                      = 256 + 35,
+	IE_TYPE_HE_OPERATION                         = 256 + 36,
+	IE_TYPE_UORA_PARAMETER_SET                   = 256 + 37,
+	IE_TYPE_MU_EDCA_PARAMETER_SET                = 256 + 38,
+	IE_TYPE_SPATIAL_REUSE_PARAMETER_SET          = 256 + 39,
+	/* Reserved 40 */
+	IE_TYPE_NDP_FEEDBACK_REPORT_PARAMETER        = 256 + 41,
+	IE_TYPE_BSS_COLOR_CHANGE_ANNOUNCEMENT        = 256 + 42,
+	IE_TYPE_QUIET_TIME_PERIOD                    = 256 + 43,
 	IE_TYPE_VENDOR_SPECIFIC_REQUEST              = 256 + 44,
+	IE_TYPE_ESS_REPORT                           = 256 + 45,
+	IE_TYPE_OPS                                  = 256 + 46,
+	IE_TYPE_HE_BSS_LOAD                          = 256 + 47,
 	IE_TYPE_MAX_CHANNEL_SWITCH_TIME              = 256 + 52,
 	IE_TYPE_ESTIMATED_SERVICE_PARAMETERS_OUT     = 256 + 53,
 	IE_TYPE_OCI                                  = 256 + 54,
+	IE_TYPE_MULTIPLE_BSSID_CONFIGURATION         = 256 + 55,
+	/* Reserved 56 */
+	IE_TYPE_KNOWN_BSSID                          = 256 + 57,
+	IE_TYPE_SHORT_SSID_LIST                      = 256 + 58,
+	IE_TYPE_HE_6GHZ_BAND_CAPABILITIES            = 256 + 59,
+	IE_TYPE_UL_MU_POWER_CAPABILITIES             = 256 + 60,
+	/* Reserved 61 - 87 */
 	IE_TYPE_MSCS_DESCRIPTOR                      = 256 + 88,
 	IE_TYPE_SUPPLEMENTAL_CLASS_2_CAPABILITIES    = 256 + 90,
 	IE_TYPE_REJECTED_GROUPS                      = 256 + 92,
-- 
2.34.1

