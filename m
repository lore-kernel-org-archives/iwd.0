Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50633D88
	for <iwd@lists.linux.dev>; Mon,  8 Aug 2022 18:23:01 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id p8so9239449plq.13
        for <iwd@lists.linux.dev>; Mon, 08 Aug 2022 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=npPadd1c+74e9zEQGbL298nkfqh6ux7bBWkepYYATpM=;
        b=ZgF04caAOPbofO1rsMc/fa4qZp+DqcZEkZX4SdG7GkHsHcafUY8rwwWMS14vHJruMk
         QHuwrMyl8Jj4ryUX5b4KhPawSsbL1LRqSzSAu7ezS/BZ4nFbg65xeRlZmyhRfyq3Bukx
         uWLIvt2m5msILqz8XTI69H4edmO3tGJqDNq/ooXptnnKpm2lZ14NJx1Zvq+smUFY7Sgs
         YjELSZU0vWrCRFI0wYm4xjYeXUM3HOQgnh2pfFkbbBcnqRRR4ZVI88oOkRqklC3pgdXk
         O65B/UqaKKYNNjB2LlS8Dazr0WDM+nCKsiGb0HxlccfIpmkaimZnkB1I0yR0zi4qJGkE
         DloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=npPadd1c+74e9zEQGbL298nkfqh6ux7bBWkepYYATpM=;
        b=ojNxkHws5DHksNTmoiFtqj7KTJ69IRpV1BMIp5VHLxnu/hu7pwBX0DHWAZqqP3TGNV
         JrDllSiDgjoi+X84W3kbHRA0wYiCFe2BQWr66Gtt3Xjgzpt75GoreLdGXBi3Kh7yuPEi
         Icg1h9HPvF+2fHkeEpJvEvrutTLaZf1cF3vaTKtisyBKQI9Rry3mMPadDMRED0lSOfig
         dd1uogxFelTkq68TcUXrHr7ura5UicU8VhoesshXeIwi0hQT8BguzLkL2H0GIe6/ZjxM
         dzJ1vEx5xfO3M0Zmpp74x+NBqZztLPxhInvcqshq9FoDeu8h4RpE/xZgCW9YHfSMP91e
         f6xg==
X-Gm-Message-State: ACgBeo3VJcFhbCLwuOs+50yUnlMfvLxeUEWanrnYe8LRKkjFJKsAQu1K
	5wKOU2rTj7ipDCj1n8J2JA6uBNjFwr4=
X-Google-Smtp-Source: AA6agR4koGuJtTFrkmnl+v3o6AWC+29apOyh1FsrW349pBtNqOlbeqhTZulBsN4jfYt1VnbB73h8lQ==
X-Received: by 2002:a17:902:a5c5:b0:16f:1e31:daab with SMTP id t5-20020a170902a5c500b0016f1e31daabmr19657390plq.82.1659982980995;
        Mon, 08 Aug 2022 11:23:00 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id 129-20020a620587000000b0052516db7123sm8972197pff.35.2022.08.08.11.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:23:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] handshake: add force_default_owe_group flag
Date: Mon,  8 Aug 2022 11:22:56 -0700
Message-Id: <20220808182259.19402-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicates the OWE SM should only use the default group
---
 src/handshake.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/handshake.h b/src/handshake.h
index 7f597b06..f2321634 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -137,6 +137,7 @@ struct handshake_state {
 	bool authenticator_ocvc : 1;
 	bool supplicant_ocvc : 1;
 	bool ext_key_id_capable : 1;
+	bool force_default_owe_group : 1;
 	uint8_t ssid[32];
 	size_t ssid_len;
 	char *passphrase;
-- 
2.34.3

