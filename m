Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01D53A5
	for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 22:12:24 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id w37so14925934pga.5
        for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 14:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=712Xib5GZS0yo34zUjXZlI+2Q/rjv1W2U8y+/4BUASc=;
        b=iBEvkJckcQHclpqseSsvQ/iFTMo9kCMVCoEhdWMCMO9Rb+++XyU8/VjNgqy1Ennl0g
         JHNEonLTTmkGEMu5h3Nybnb6RlIgfYWJJWZZHgtLIZcz5rwnFBc7J/sLXNvn/HSD/vNA
         ozYY5Wht/N6SFGjy8kzcoghLlK2hTmB3XfUof7OMlQBdVtJG+EXl4u+HZ7f6eqsBOWP2
         x3DQipBzx3M0qBn7istSn20UYxTIs+D/MrwrYVEcDCpvDJe+z2ZrixHErhb3DOQXY1Jk
         WLhEq8wgFvbPorrj+FL4r8XqpEeI5leBQa0tmHaqtYpTvXxuhgtmhDHCk1Un1N3dK9uU
         brmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=712Xib5GZS0yo34zUjXZlI+2Q/rjv1W2U8y+/4BUASc=;
        b=IvZOrPMPdN9ilx8x45Yo8ZKHi7tQnAIz91J0azTpWiaBp75QSPYmC8bNgLLOsl4UAn
         bVYL1r96kzPhjY7uVGwmW2kAjJHF9YWOacgX/jzyQDKFVjUpFfTAhF2GHs/1vNHVGJcE
         q2ysIO3avST/Y5C62ynzpSofIlpR53jQZk99Q7cCZIGl5V0bwA217ejUBc3lY0vh8dBT
         HQ6bhsFOjLCaNHdEDFhPXizRvnkj2sjyDPQqfqtXQdKQIp4LXcoKZE7EMYtWlki3W63U
         DW4B/sOlRPLLEMWCFjOhFqMu5wRzpdBUB5lSIijQkaqueTiBpuJ7syFZRYP8LVjTF2AS
         vIyA==
X-Gm-Message-State: AFqh2kp6jpTzXc2WaawAfBl5uH2IfCiNzPEtB1HkL2GMUfdrNLcDD45c
	x+B9FiNkD3xAgk0siowv824aNz2KJms=
X-Google-Smtp-Source: AMrXdXsqIaeIK8ELYaOnGpzh3FhUCVjvJqUXVvNUXHsZqKPD0W3bAJg6edWd+J01zExplJJOb6Ovqw==
X-Received: by 2002:a05:6a00:1d28:b0:577:6525:fc98 with SMTP id a40-20020a056a001d2800b005776525fc98mr37937038pfx.3.1672438343511;
        Fri, 30 Dec 2022 14:12:23 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 123-20020a621881000000b00528a097aeffsm14187833pfy.118.2022.12.30.14.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 14:12:23 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] band: add tx_power to frequency info attributes
Date: Fri, 30 Dec 2022 14:12:14 -0800
Message-Id: <20221230221216.2985011-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221230221216.2985011-1-prestwoj@gmail.com>
References: <20221230221216.2985011-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/band.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/band.h b/src/band.h
index 676c63d9..b94c07d3 100644
--- a/src/band.h
+++ b/src/band.h
@@ -56,6 +56,7 @@ struct band_he_capabilities {
 };
 
 struct band_freq_attrs {
+	uint8_t tx_power;
 	bool supported : 1;
 	bool disabled : 1;
 	bool no_ir : 1;
-- 
2.34.3

