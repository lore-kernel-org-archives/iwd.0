Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7D7B
	for <iwd@lists.linux.dev>; Tue, 25 Oct 2022 16:04:02 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id q71so11888612pgq.8
        for <iwd@lists.linux.dev>; Tue, 25 Oct 2022 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwTPuMavgY7eQ5Uiv3f4rriyXgff4ljGSo+Q4vJHFBo=;
        b=Jhb4HEJ03YFNpwKGDrjsR6k3ZIXXZUYo7BUWS7GH9yp51kkCjvgutDsXhzHPJqRXl0
         lA28YxK8laXHcnK6PTAmvDyEbkNLIoCC5n54YRKVy3JTT66wtK2MgMotUlyUycwgCLT3
         3yx6+X9HvpXIByVWD0Z9ph9/JphSPb5UR/VncX9k8a0ZfRUj+/0ZzdzT6C2pEqeuEJ2u
         XuKDz2H4M7cv6Mh5ZpCXgEnjS12/4gJqjYP0eshMNEpFbKJcdIRHNyImnwC4qq43FlEp
         mmKiRqv+tlmIbGjTnF5IPNCk/Jx5ivY5jqewKTB+sCybSJPnWD+iC/0HbOclO8GlYx3a
         YQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwTPuMavgY7eQ5Uiv3f4rriyXgff4ljGSo+Q4vJHFBo=;
        b=ZeKGCce2x65tPChp66B2X9pneYWQGfi5zYtmYRurdifS+5z5Jq7K4BOUE9nkYhX/qf
         51PpqD9wJtZV5hhdq0OvEvuB/v7UCfY49bQbJZlni6iqDprXaqr8kU5f5zaZlF7Y8nFC
         vAXKqhcfR/JPh+MHcTIEQsyMXTHgwlvknfSuMa4vrJpd1MYfy3uO8Accj6Z2FowZUw5+
         Ryfw0Ur3XkMG/PNgQ6hqy2cI7SKt41FPPMk8FN4W8rREjEwJfQGSOZk2LKZzWdIT+TWf
         /lZudUkcfudGsyKmGeuwQRbo4YTV6t35upjZjGmq4V7Afcu5Peo5frvT2gFyUvJWbxY0
         Pyuw==
X-Gm-Message-State: ACrzQf3KdjkiG/HPd7Ch6e3obBJLuFA0o/tz0cDv91QbeH2WnvSZlvDq
	Ui4fgHTehK8LKYeiUUvMG/MUtVRRjIc=
X-Google-Smtp-Source: AMsMyM5QrPBeZksYzZ8PDSlUy866lxo2rnqRzOU5zCkU4LgAimnc0dvmyvdTxItAQzgpFX2KKdKtSQ==
X-Received: by 2002:a63:6b88:0:b0:46a:ff3c:b64a with SMTP id g130-20020a636b88000000b0046aff3cb64amr33180129pgc.196.1666713841866;
        Tue, 25 Oct 2022 09:04:01 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a0e8900b0020a81cf4a9asm5603787pjx.14.2022.10.25.09.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:04:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] monitor: allow parsing pcaps without -F option
Date: Tue, 25 Oct 2022 09:03:56 -0700
Message-Id: <20221025160356.217578-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -F option is undocumented but allows you to pass a nl80211
family ID so iwmon doesn't ignore messages which don't match the
systems nl80211 family ID (i.e. pcaps from other systems).

This is somewhat of a pain to use since its unclear what the other
system's family ID actually is until you run it though something
like wireshark. Instead iwmon can ignore the family ID when in
read mode which makes reading other systems pcap files automatic.
---
 monitor/main.c  | 2 +-
 monitor/nlmon.c | 6 ++++--
 monitor/nlmon.h | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index f0b16bbf..30aa06d2 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -586,7 +586,7 @@ static int process_pcap(struct pcap *pcap, uint16_t id)
 		return EXIT_FAILURE;
 	}
 
-	nlmon = nlmon_create(id);
+	nlmon = nlmon_create(id, true);
 
 	while (pcap_read(pcap, &tv, buf, snaplen, &len, &real_len)) {
 		uint16_t arphrd_type;
diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 69e86ce3..f2db47a8 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -104,6 +104,7 @@ struct nlmon {
 	bool nowiphy;
 	bool noscan;
 	bool noies;
+	bool read;
 };
 
 struct nlmon_req {
@@ -7202,7 +7203,7 @@ static void nlmon_message(struct nlmon *nlmon, const struct timeval *tv,
 		return;
 	}
 
-	if (nlmsg->nlmsg_type != nlmon->id) {
+	if (!nlmon->read && nlmsg->nlmsg_type != nlmon->id) {
 		if (nlmsg->nlmsg_type == GENL_ID_CTRL)
 			store_message(nlmon, tv, nlmsg);
 		return;
@@ -7253,7 +7254,7 @@ static void nlmon_message(struct nlmon *nlmon, const struct timeval *tv,
 	}
 }
 
-struct nlmon *nlmon_create(uint16_t id)
+struct nlmon *nlmon_create(uint16_t id, bool read_only)
 {
 	struct nlmon *nlmon;
 
@@ -7261,6 +7262,7 @@ struct nlmon *nlmon_create(uint16_t id)
 
 	nlmon->id = id;
 	nlmon->req_list = l_queue_new();
+	nlmon->read = true;
 
 	return nlmon;
 }
diff --git a/monitor/nlmon.h b/monitor/nlmon.h
index ab038fdf..69391b85 100644
--- a/monitor/nlmon.h
+++ b/monitor/nlmon.h
@@ -36,7 +36,7 @@ struct nlmon *nlmon_open(const char *ifname, uint16_t id, const char *pathname,
 				const struct nlmon_config *config);
 void nlmon_close(struct nlmon *nlmon);
 
-struct nlmon *nlmon_create(uint16_t id);
+struct nlmon *nlmon_create(uint16_t id, bool read_only);
 void nlmon_destroy(struct nlmon *nlmon);
 void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 					const void *data, uint32_t size);
-- 
2.34.3

