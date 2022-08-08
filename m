Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63D93D9D
	for <iwd@lists.linux.dev>; Mon,  8 Aug 2022 18:23:02 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so8575730pjm.3
        for <iwd@lists.linux.dev>; Mon, 08 Aug 2022 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=opHczMfeZdStThwEfUauOQjRo99oUUDw5Ktzg8xvm2I=;
        b=ZZkarzU6bgjm8MLed/sLaKu8xOvuu1oKJj4R+W+dDFnzla9NgyCdPKEh5Jhre8ayd4
         nBecbutCugI+qJFDwvSbshy+LCdfXixKI1uEYp5EkHWFPzKjQb/SggMagCKhdzoG0Pzx
         hnOcUp0EU1vmqe0iAJ+yBbuUy9jjU3Dv2IwNnPPSYOjfcmDthLq3gYG3OBSotMilDkbH
         Cg+DPELO1d2PDmBrEoMEFpeMr8Ms5nHxlj/jSKDPwARt1CfmkBNXFqANcFXtTxI6wWu2
         kTKf7kz0jpIMBc0OpCfFztQWX+uH4Qr9Anly02eHkzZsrWKrBxOROAfHc6AfzS/wOMA3
         19mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=opHczMfeZdStThwEfUauOQjRo99oUUDw5Ktzg8xvm2I=;
        b=jmbSCrzP5OJvcM2rStnUR3nIlQijdEqvRXzNjddjbZlDmj9OohIxpbODMmkiHLzaES
         SUs38aSasTXWpmUA+fALyBDtoS7ZrvWl4JWuZ5bgLXNAYnDJo9ixQ0e1l9BlFK9JkrkE
         5v2jP6ddkplnUUAFCBWrRtO5r4xVJdy3bYALPmdf+gODeMTtS+AgysJHj6qZxs5B+QeN
         kucwROKsadbIrQAyJIffF0iW60+a5jgsY5Otq5/NdfmiQ1wPDOCl+l/qTiB1baahTCOU
         ujkd9viuL9xPZNWPTVgYW/7qzugGHgeh1bu2+QCHwae3q8XuNoWoP5AOmu0cRMm0KEL0
         DWZg==
X-Gm-Message-State: ACgBeo1BuwStfQo9qyIdSTM8HgJ/N8y7RASe7ggtcYwsMDvVQ2bTRR95
	iukf217/3GThErbfV8qI4fYGzsZLbtg=
X-Google-Smtp-Source: AA6agR7HErnBaNDbKkLsYIUC76uSaML1ecsAxv3zX4o25H7ktcDNPWcc4AaiQNtJd9yDda+0IJULeQ==
X-Received: by 2002:a17:902:d54b:b0:16e:ef40:7b45 with SMTP id z11-20020a170902d54b00b0016eef407b45mr19874496plf.102.1659982982117;
        Mon, 08 Aug 2022 11:23:02 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id 129-20020a620587000000b0052516db7123sm8972197pff.35.2022.08.08.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:23:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] network: add setter/getter/flag for forcing default OWE group
Date: Mon,  8 Aug 2022 11:22:58 -0700
Message-Id: <20220808182259.19402-3-prestwoj@gmail.com>
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

If a OWE network is buggy and requires the default group this info
needs to be stored in network in order for it to set this into the
handshake on future connect attempts.
---
 src/network.c | 14 ++++++++++++++
 src/network.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/src/network.c b/src/network.c
index 70cb925c..c0befa42 100644
--- a/src/network.c
+++ b/src/network.c
@@ -88,6 +88,7 @@ struct network {
 	bool provisioning_hidden:1;
 	uint8_t transition_disable; /* Temporary cache until info is set */
 	bool have_transition_disable:1;
+	bool force_default_owe_group:1;
 	int rank;
 	/* Holds DBus Connect() message if it comes in before ANQP finishes */
 	struct l_dbus_message *connect_after_anqp;
@@ -525,6 +526,9 @@ int network_handshake_setup(struct network *network, struct scan_bss *bss,
 		handshake_state_set_protocol_version(hs, eapol_proto_version);
 	}
 
+	if (hs->akm_suite == IE_RSN_AKM_SUITE_OWE)
+		hs->force_default_owe_group = network->force_default_owe_group;
+
 	/*
 	 * The randomization options in the provisioning file are dependent on
 	 * main.conf: [General].AddressRandomization=network. Any other value
@@ -764,6 +768,16 @@ void network_set_info(struct network *network, struct network_info *info)
 					IWD_NETWORK_INTERFACE, "KnownNetwork");
 }
 
+void network_set_force_default_owe_group(struct network *network)
+{
+	network->force_default_owe_group = true;
+}
+
+bool network_get_force_default_owe_group(struct network *network)
+{
+	return network->force_default_owe_group;
+}
+
 static inline bool __bss_is_sae(const struct scan_bss *bss,
 						const struct ie_rsn_info *rsn)
 {
diff --git a/src/network.h b/src/network.h
index d69d63b0..c6b99f6c 100644
--- a/src/network.h
+++ b/src/network.h
@@ -58,6 +58,8 @@ void network_sync_settings(struct network *network);
 
 const struct network_info *network_get_info(const struct network *network);
 void network_set_info(struct network *network, struct network_info *info);
+void network_set_force_default_owe_group(struct network *network);
+bool network_get_force_default_owe_group(struct network *network);
 
 int network_can_connect_bss(struct network *network,
 						const struct scan_bss *bss);
-- 
2.34.3

