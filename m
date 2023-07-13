Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70488F9DC
	for <iwd@lists.linux.dev>; Thu, 13 Jul 2023 14:42:41 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so494130b3a.0
        for <iwd@lists.linux.dev>; Thu, 13 Jul 2023 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689259360; x=1691851360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r27bPCHa8MtH+EuRrIHwfH6o8TbrY/HsrkYajxLWUiA=;
        b=lnXqCFixS3D2dI/EnJtL74E1xzM/Y2AXzORIKm7SK9IfThXVaExztFqvkdRsJXfG3r
         /EHP0YK6aLp+G+EvEogLUaQg0OtISo7b+5+/qq7rNDvOumz6ZnJFh2mIz/60vtb2OjQ0
         RmCgYVulpBQDnxA/YKcSfaqi074vZVf4P7pj654V4rbP2YbgRKWD0Z7bxVKAsfVQjH22
         uzxP2WasfQsSQ0QVcnfC1RJ81vljdv6gyDzKjfYdLmb5J8oHN0FMizSZNKv7zP82oNu/
         yiXV4+uxbMuFsZIqhtE581ryGnTdXXevnKe5W9Sv4k/kNNRVQTw+UKUU7Qq+LY9d3huc
         BSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259360; x=1691851360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r27bPCHa8MtH+EuRrIHwfH6o8TbrY/HsrkYajxLWUiA=;
        b=hQt6omIUsNWQ1ZCXgtxPANh9k5wDMQnASvEC1rXEFROcGyJhreY9u/cBSne5Aortve
         L/Bg7KbNdUIWvicO3l6PHOldieyfe8KbT54XOjEKOJXVHQyDA3EDhBz8KY0rLEuXrntH
         9JleWv2fod/pQvQ6oRjGrblAkPuEvy1wthyo1CCU2eN79Sh34Xdz++V/NqkyNWjqLdso
         T65HRBTgmK9+jaH2rfzNk5/YHdKVMzhVp9wEbIuxdT3Z0CXd1qK2JAiKhFwC/aoX0K9M
         JYHEE3ntrnxiTYw/tUtJDGZ8iFu71ZYHuEzPF+32VPrimEOuEni+6irjbtUTsw2QV3h6
         G7EA==
X-Gm-Message-State: ABy/qLZVqcH+3/VtPLVrwTj9PxdxlNri2zvB8xmMIt1ZnuQbQXjrAWBO
	ZquHzNAFBl3Mioj+On8nGrjcBztkauM=
X-Google-Smtp-Source: APBJJlFzhz3E17sXCSujz3pc6xEhI4c9QtjW/Mj0FvHWbsDHntQmGXU48aI6MMJiyiP04904ipNNEA==
X-Received: by 2002:a05:6a20:3956:b0:127:7ea7:e039 with SMTP id r22-20020a056a20395600b001277ea7e039mr1214884pzg.62.1689259360401;
        Thu, 13 Jul 2023 07:42:40 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id z12-20020aa785cc000000b0064cca73d911sm5540057pfn.103.2023.07.13.07.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:42:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	Wen Gong <quic_wgong@quicinc.com>
Subject: [PATCH] netdev: relax requirement for OWE AKM in assoc reply
Date: Thu, 13 Jul 2023 07:42:37 -0700
Message-Id: <20230713144237.2977210-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some APs don't include the RSNE in the associate reply during
the OWE exchange. This causes IWD to be incompatible since it has
a hard requirement on the AKM being included.

This relaxes the requirement for the AKM and instead warns if it
is not included.

Below is an example of an association reply without the RSN element

IEEE 802.11 Association Response, Flags: ........
     Type/Subtype: Association Response (0x0001)
     Frame Control Field: 0x1000
     .000 0000 0011 1100 = Duration: 60 microseconds
     Receiver address: 64:c4:03:88:ff:26
     Destination address: 64:c4:03:88:ff:26
     Transmitter address: fc:34:97:2b:1b:48
     Source address: fc:34:97:2b:1b:48
     BSS Id: fc:34:97:2b:1b:48
     .... .... .... 0000 = Fragment number: 0
     0001 1100 1000 .... = Sequence number: 456
IEEE 802.11 wireless LAN
     Fixed parameters (6 bytes)
     Tagged parameters (196 bytes)
         Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
         Tag: RM Enabled Capabilities (5 octets)
         Tag: Extended Capabilities (11 octets)
         Ext Tag: HE Capabilities (IEEE Std 802.11ax/D3.0)
         Ext Tag: HE Operation (IEEE Std 802.11ax/D3.0)
         Ext Tag: MU EDCA Parameter Set
         Ext Tag: HE 6GHz Band Capabilities
         Ext Tag: OWE Diffie-Hellman Parameter
             Tag Number: Element ID Extension (255)
             Ext Tag length: 51
             Ext Tag Number: OWE Diffie-Hellman Parameter (32)
             Group: 384-bit random ECP group (20)
             Public Key: 14ba9d8abeb2ecd5d95e6c12491b16489d1bcc303e7a7fbd…
         Tag: Vendor Specific: Broadcom
         Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Parameter Element

Reported-By: Wen Gong <quic_wgong@quicinc.com>
---
 src/netdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index f5c5fc51..56c6ebd2 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2911,11 +2911,15 @@ process_resp_ies:
 		}
 
 		if (netdev->owe_sm) {
-			if (!owe_dh || !owe_akm_found) {
-				l_error("OWE DH element/RSN not found");
+			if (!owe_dh) {
+				l_error("OWE DH element not found");
 				goto deauth;
 			}
 
+			if (!owe_akm_found)
+				l_warn("OWE AKM was not included in the RSNE. "
+					"This AP is out of spec!");
+
 			if (L_WARN_ON(owe_process_dh_ie(netdev->owe_sm, owe_dh,
 							owe_dh_len) != 0))
 				goto deauth;
-- 
2.25.1

