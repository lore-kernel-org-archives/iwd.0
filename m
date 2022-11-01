Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAFD2F29
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:18:03 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id b185so14485272pfb.9
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8hXDu47V/KInprnnKCQWt4KLvHCkzYNAqb7i+VADpI=;
        b=MWajhhM6g70ic9RsWU+6ujqthhZ70efAYWpBUdyCPM2NXAaZhvKhexQNHcX43YkK0A
         JUkE5ZDCe0EA0lMk+xFXI2AkleecQMVvBz1n/qCf0Hm70ucic24YPRlm5lKR5O25G9EO
         /UJNSroruBTcQUrJ1fAhP+14l+08oeGCY7iBhIveK4Sro05NfB/0q2BLWqVKiYxjzvbq
         RxiThhLwlrmQNa9kiOvQmtgd6KUxNVw0ijcH/UoETWXFf7ai0hW/1H203znIBKhsVqun
         CWlENXxsn0gPup2iBFK3xhuklMYKuGp44QmvnnE8D0bF0aiKolCHAasHv7HE0Qf5baXR
         2JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8hXDu47V/KInprnnKCQWt4KLvHCkzYNAqb7i+VADpI=;
        b=uZfN9RrosQqcPbTTBtiszjQa0JbTI6TeLHVSNaV80Lo1UCbaQ28+NNUY+K/EiCuK3G
         89b93YBhusyNxrvOMi/KCwBKNJq4n3r0o9G/VheffpPM9C1YJ35LUxpPOCr6iHMAhosB
         irW9QI/jR5vuTKOIVA1/QUTLMh0wTrVUylQ9v4buStNhEsUwnCxCe3mMj54zP2M4+lvt
         JbC5dGbScJ39x0AlxYI/SW8VehWuBfyB04QECdL2X2eUua4r/PnqKLhkxcdqyNdJ0k49
         lZWBa+FHilaU0OyEK4KBzAgqhU0JXkQXd54WGn8wcPFMBwtwX7CcCggBWKAHxTPPOwP9
         Z9Gg==
X-Gm-Message-State: ACrzQf2T/gh/F9xNGCiDD494nDJUiQPT7IEx7O3lFDP8Ve/QPjW1Di59
	/BHL/XaCGW9Hcz7XU8eA41m+cb8sMTs=
X-Google-Smtp-Source: AMsMyM6kZwEQHrIqXKu9TpvDXRcrP9WCJ5+FVgPiFDJctxzw/TMRtz5J/BvjHnu5cSB9sBQZJyJ8KQ==
X-Received: by 2002:a63:90c7:0:b0:442:87:3a38 with SMTP id a190-20020a6390c7000000b0044200873a38mr18809796pge.216.1667333883207;
        Tue, 01 Nov 2022 13:18:03 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:18:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 14/17] netdev: fix key setting for authenticators
Date: Tue,  1 Nov 2022 13:17:44 -0700
Message-Id: <20221101201747.143379-14-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netdev_copy_tk function was being hard coded with authenticator
set to false. This isn't important for any ciphers except TKIP but
now that AP mode supports TKIP it needs to be fixed.
---
 src/netdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 59e73608..23bbbcf6 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1643,7 +1643,7 @@ static void netdev_set_gtk(struct handshake_state *hs, uint16_t key_index,
 		return;
 	}
 
-	if (!netdev_copy_tk(gtk_buf, gtk, cipher, false)) {
+	if (!netdev_copy_tk(gtk_buf, gtk, cipher, hs->authenticator)) {
 		netdev_setting_keys_failed(nhs, -ENOENT);
 		return;
 	}
@@ -2057,7 +2057,7 @@ static void netdev_set_tk(struct handshake_state *hs, uint8_t key_index,
 	l_debug("ifindex=%d key_idx=%u", netdev->index, key_index);
 
 	err = -ENOENT;
-	if (!netdev_copy_tk(tk_buf, tk, cipher, false))
+	if (!netdev_copy_tk(tk_buf, tk, cipher, hs->authenticator))
 		goto invalid_key;
 
 	msg = netdev_build_cmd_new_key_pairwise(netdev, cipher, addr, tk_buf,
@@ -2091,7 +2091,7 @@ static void netdev_set_ext_tk(struct handshake_state *hs, uint8_t key_idx,
 				L_BE16_TO_CPU(step4->header.packet_len);
 
 	err = -ENOENT;
-	if (!netdev_copy_tk(tk_buf, tk, cipher, false))
+	if (!netdev_copy_tk(tk_buf, tk, cipher, hs->authenticator))
 		goto error;
 
 	msg = netdev_build_cmd_new_rx_key_pairwise(netdev, cipher, addr, tk_buf,
-- 
2.34.3

