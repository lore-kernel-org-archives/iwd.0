Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3F3217
	for <iwd@lists.linux.dev>; Wed,  5 Oct 2022 22:46:39 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id n7so92271plp.1
        for <iwd@lists.linux.dev>; Wed, 05 Oct 2022 15:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KpWEG4dJ8NELJDoSHEz3eBwPeGj/62KIKAe0qpfb7NQ=;
        b=B49rKFMIIbzR6SnP3I9bQDq+Du6L8xjvX2YprPJZwwlC9InJI/KDN5XIvVH0Oes0N9
         95kwlOUi2YFAKAaOBNVzlBl4WMLZNvl1NHYcUtKzoSWQ1IP6Se18BcXVMu/c1imsQGnx
         mbyEToiexUDl0Yss+0BtMnksXrNciQyu547uRadJEflDwLCxFKLOCMYasDbyosVyGNrY
         OEixVvyz6a6xeM963cFk4FxzPtjfa5VYB/ySc7pQLyPAM4r/8iMVwyn0VP5RGHY5Y+U8
         aOU45Mwr1hEZRlc/cHA1K9fJNBlosuJBGtKgJup2NloTuncJ/XCklhEjK3hafWllecP6
         Zqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KpWEG4dJ8NELJDoSHEz3eBwPeGj/62KIKAe0qpfb7NQ=;
        b=JFwRFpdKbnInMonrfodh9yAYJibLpfRvGPzYAK5refwkpDIKzj4/BQPelS57Sf6C/x
         D79PX8buMZbG1bhJlrnxUue+8hsy7IroZMjlNRmhG3jhWRzZsPzrb5bwkxIQphVUCmEZ
         d/nvFqhVvzMJMrtPRwKXo16lFF0j1WIhtNNqtzndsjK66C5P5CwB2FAigth35ZgcTpq8
         RSYHzh7R2bXVVWPsJlQnD2phYowjs6bqCSY4Jt4yLv2RE8KwSdRaLYyyyztaYnDD7+lT
         GvbCaP/4q2LlAsPekab7ifjw72V98tWaIGVCDcfOVaV384cdm68wwX1ySObCCnCtSuJ8
         j8LQ==
X-Gm-Message-State: ACrzQf1SKk9tNhB1kVNWegR8fVcf/qhd6Hf5LXY4EI7pberRkv14xCwT
	cEZy0x7sdT6SRiF03xgeGSANR7Yl+W0=
X-Google-Smtp-Source: AMsMyM4ep75ms+t0+zX3t/l2HvNyf4cqHR7j8N5UmMzj3RaGMJIRxtpZuSEnusYBP0C0c5+O7/WeDg==
X-Received: by 2002:a17:902:ea02:b0:176:afd7:3d1d with SMTP id s2-20020a170902ea0200b00176afd73d1dmr1863335plg.120.1665009999185;
        Wed, 05 Oct 2022 15:46:39 -0700 (PDT)
Received: from jprestwo-xps.none (h67-204-159-212.bendor.broadband.dynamic.tds.net. [67.204.159.212])
        by smtp.gmail.com with ESMTPSA id 61-20020a17090a0fc300b001fd7e56da4csm1590686pjz.39.2022.10.05.15.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:46:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] monitor: parse DPP frame types
Date: Wed,  5 Oct 2022 15:46:32 -0700
Message-Id: <20221005224632.780575-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221005224632.780575-1-prestwoj@gmail.com>
References: <20221005224632.780575-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parses the type of frame for easier debugging.
---
 monitor/nlmon.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 2e232130..2222db09 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -4724,6 +4724,36 @@ static void print_anqp_frame(unsigned int level, const uint8_t *anqp,
 	}
 }
 
+static void print_dpp_public_action_frame(unsigned int level,
+					const uint8_t *data, size_t len)
+{
+	print_attr(level, "DPP Action Frame");
+
+	print_attr(level + 1, "Crypto Suite: %u", *data);
+	data++;
+
+	switch (*data) {
+	case 0:
+		print_attr(level + 1, "Type: Authentication Request");
+		break;
+	case 1:
+		print_attr(level + 1, "Type: Authentication Response");
+		break;
+	case 2:
+		print_attr(level + 1, "Type: Authentication Confirm");
+		break;
+	case 11:
+		print_attr(level + 1, "Type: Configuration Result");
+		break;
+	case 13:
+		print_attr(level + 1, "Type: Presence Announcement");
+		break;
+	default:
+		print_attr(level + 1, "Type: Unknown (%u)", *data);
+		break;
+	}
+}
+
 static void print_public_action_frame(unsigned int level, const uint8_t *body,
 					size_t body_len)
 {
@@ -4791,6 +4821,12 @@ static void print_public_action_frame(unsigned int level, const uint8_t *body,
 
 		print_p2p_public_action_frame(level + 1, body + 5,
 						body_len - 5);
+	} else if (!memcmp(oui, wifi_alliance_oui, 3) && oui[3] == 0x1a) {
+		if (!print_oui(level, oui))
+			return;
+
+		print_dpp_public_action_frame(level + 1, body + 5,
+						body_len - 5);
 	} else if (body[0] == 0x0a) {
 		if (body_len < 9)
 			return;
-- 
2.34.3

