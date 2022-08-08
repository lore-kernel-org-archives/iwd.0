Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F13D90
	for <iwd@lists.linux.dev>; Mon,  8 Aug 2022 17:14:12 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id f192so8625661pfa.9
        for <iwd@lists.linux.dev>; Mon, 08 Aug 2022 10:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=opHczMfeZdStThwEfUauOQjRo99oUUDw5Ktzg8xvm2I=;
        b=UAJmxYrM1wDu3FidDsphAwe0NVmGTDapNmvOT/gkrp23GHNs3x+kcaz5PLUkyKcoFG
         K7TX2UaRd4z+9w1QA2a8GvjIUF1PGU3N7sA1dhTvxu3WSj3BUysG/qWIXfLibkxBKM7b
         yoKqSUxePWexdGAaFWKLbuQQrq2kfCZbUVA1qnirG4jqd5UTYL+lLhiwhkgJy5iwn+KT
         k9pZuveg2/2U2q3gakpRlVDjHqv0nQMTLu3WkX+RrhlJJHeN1gIh2Iy+/uR1IadSiRaO
         mXadJr7SlwuxShwlJIT+lD5Aw87aBcKlaHYJhryRisAINQmzIpV0MgW8/Z0y+Cch430l
         KVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=opHczMfeZdStThwEfUauOQjRo99oUUDw5Ktzg8xvm2I=;
        b=DqviJxNvuFD8bEwAU2Gq7NUUOOcqC53Ztmja3f9wwVXy7VWt50r5mISVHCT7YcOsSw
         4OX2NT45Jc9uVl79b02w+8vCvmDfBFyQH8ZwZyQj99AurtL9xysOZw1zHCubAqhc6Df/
         kZAImBLzbzpQuUswL+giSPUtW7qVjM8dwb7CrWd1yzgPsDnQjR2FLwV1y+8PAbleArZ0
         ZZuVdzGabn62b4ylnq4MXE9+Wbg6CoKdn/RSXEeNIKVsWsdZWexSnC7W/bh1DEFPQV2C
         QVlRqAa9qBOvS5iB2ovKER8QtVnQw9wE+8lgrzy9wzZKI7rVlN1EPDL6/Ane8pWY6s71
         zHhA==
X-Gm-Message-State: ACgBeo3AMZxSUfoKfPfOZrE4Xtt2sNuPHwob0ZquhbPQF9CVf4ZKqYNZ
	G5ZHlAX1qY8d43rYgAljYVg3KLNyZ3A=
X-Google-Smtp-Source: AA6agR49EYaR2Pn6z3NL5Ad22aGRtzH5GzMByq07xjtqQZs7/BFZ+90YPdubRve/pl8SS49aM9f/+g==
X-Received: by 2002:a65:6043:0:b0:41d:978:7a47 with SMTP id a3-20020a656043000000b0041d09787a47mr12353842pgp.484.1659978851424;
        Mon, 08 Aug 2022 10:14:11 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b0016dd667d511sm8932754plk.252.2022.08.08.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:14:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] network: add setter/getter/flag for forcing default OWE group
Date: Mon,  8 Aug 2022 10:14:05 -0700
Message-Id: <20220808171406.12931-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220808171406.12931-1-prestwoj@gmail.com>
References: <20220808171406.12931-1-prestwoj@gmail.com>
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

