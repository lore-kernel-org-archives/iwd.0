Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACCF1C36
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 20:46:02 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id y13so12114811pfp.7
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tLW+zrLWt5QZwEfyUpfGrj+Uj1rEjGVGzf56CSd2AZY=;
        b=T4nz3UN4UWDbJyhWC3kjArR18QYfAV/5m4LaZynmn7COCkyJI05yAqg8IRWKrlbTM4
         o/W/xhlWBxpuD+d4QdsSL4l+mU9ND+1pcnOmdsW0zi9HhAY73pMMXjj55ZI7H7HDV0aX
         gCRyIDp9pXqc9peYxbroqsxQ2L7LQUJV7wHmmUDAbKYNE127lyc9buAioC4bsbkXUeLu
         VzG/vXExu1YD6OIo9os7Dny4DoAJZggkH7Lovbjl3DAt/1YtwyaTdxwAKkKI3+wxH+mZ
         UZJEpRpQhLzMrwSEBtqpTS1t87HnuxlyomCIl1FObaJSZfgvoYUl+sLRbv5bE5R/66s6
         GUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLW+zrLWt5QZwEfyUpfGrj+Uj1rEjGVGzf56CSd2AZY=;
        b=wxk9ruuSZY5VRXj/+Nt40zCQzw6YC/bJcjgGx4tsLotR+1dJV1vR/P21jo0FbSUGuS
         pKMneF1KNYuHiIHoSyrRRL4XVV0bMHltWbehff8yxJ+RzRawyLq2Pqf9DkoWUM2H483C
         nJSixTdBy+uSiBt5vP53JwlP81NOBN9kwf51mVysN6RxCw+cdzl8FpHxxNkWIJzWMsd6
         Y+jXwP6zlZMEaGqITrC4kdTNIViEjDxbgBHqDtOw9zF6RDa3eBg78IbHCntSMoawJIUD
         qFQldTj+huW8G1hD3nsxG/yaT2z1sEF51dNCYw3uTW7Jk3mxlceMu/IGRWlVR4PJNmHK
         HpnQ==
X-Gm-Message-State: ACrzQf0skgd9tI3/RhVJK0ARqnW8ZeanHIRCWiKAc+jNHefgKu/gEVag
	46ia/+bAkFEjqb8DfSksEek6WJ37Nsk=
X-Google-Smtp-Source: AMsMyM4zdcA/PHgWk5pHucyzq4M8AncoDZw+7FWEsYOvYabQgllrPwJlsPgm9lHGPKBFUmJRHiALnw==
X-Received: by 2002:a65:6e89:0:b0:43c:e3d8:49f1 with SMTP id bm9-20020a656e89000000b0043ce3d849f1mr39080149pgb.315.1666817161365;
        Wed, 26 Oct 2022 13:46:01 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i27-20020a056a00005b00b0056203db46ffsm3510588pfk.172.2022.10.26.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:46:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] monitor: pass config to nlmon_create
Date: Wed, 26 Oct 2022 13:45:57 -0700
Message-Id: <20221026204559.502432-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand nlmon_create to be useful for both pcaps and monitoring. Doing
this also lets iwmon filter pcaps based on --no-ies,rtnl,scan etc
flags since they are part of the config.
---
 monitor/main.c  |  8 +++++---
 monitor/nlmon.c | 15 +++++++--------
 monitor/nlmon.h |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index f0b16bbf..50b3fd27 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -569,7 +569,8 @@ done:
 	return exit_status;
 }
 
-static int process_pcap(struct pcap *pcap, uint16_t id)
+static int process_pcap(struct pcap *pcap, uint16_t id,
+			const struct nlmon_config *config)
 {
 	struct nlmon *nlmon = NULL;
 	struct timeval tv;
@@ -586,7 +587,7 @@ static int process_pcap(struct pcap *pcap, uint16_t id)
 		return EXIT_FAILURE;
 	}
 
-	nlmon = nlmon_create(id);
+	nlmon = nlmon_create(id, config);
 
 	while (pcap_read(pcap, &tv, buf, snaplen, &len, &real_len)) {
 		uint16_t arphrd_type;
@@ -797,7 +798,8 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "Invalid packet format\n");
 			exit_status = EXIT_FAILURE;
 		} else
-			exit_status = process_pcap(pcap, nl80211_family);
+			exit_status = process_pcap(pcap, nl80211_family,
+							&config);
 
 		pcap_close(pcap);
 
diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 69e86ce3..b58bef05 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -7253,7 +7253,7 @@ static void nlmon_message(struct nlmon *nlmon, const struct timeval *tv,
 	}
 }
 
-struct nlmon *nlmon_create(uint16_t id)
+struct nlmon *nlmon_create(uint16_t id, const struct nlmon_config *config)
 {
 	struct nlmon *nlmon;
 
@@ -7261,6 +7261,10 @@ struct nlmon *nlmon_create(uint16_t id)
 
 	nlmon->id = id;
 	nlmon->req_list = l_queue_new();
+	nlmon->nortnl = config->nortnl;
+	nlmon->nowiphy = config->nowiphy;
+	nlmon->noscan = config->noscan;
+	nlmon->noies = config->noies;
 
 	return nlmon;
 }
@@ -8449,17 +8453,12 @@ struct nlmon *nlmon_open(const char *ifname, uint16_t id, const char *pathname,
 	} else
 		pcap = NULL;
 
-	nlmon = l_new(struct nlmon, 1);
 
-	nlmon->id = id;
+	nlmon = nlmon_create(id, config);
+
 	nlmon->io = io;
 	nlmon->pae_io = pae_io;
-	nlmon->req_list = l_queue_new();
 	nlmon->pcap = pcap;
-	nlmon->nortnl = config->nortnl;
-	nlmon->nowiphy = config->nowiphy;
-	nlmon->noscan = config->noscan;
-	nlmon->noies = config->noies;
 
 	l_io_set_read_handler(nlmon->io, nlmon_receive, nlmon, NULL);
 	l_io_set_read_handler(nlmon->pae_io, pae_receive, nlmon, NULL);
diff --git a/monitor/nlmon.h b/monitor/nlmon.h
index ab038fdf..d1092c11 100644
--- a/monitor/nlmon.h
+++ b/monitor/nlmon.h
@@ -36,7 +36,7 @@ struct nlmon *nlmon_open(const char *ifname, uint16_t id, const char *pathname,
 				const struct nlmon_config *config);
 void nlmon_close(struct nlmon *nlmon);
 
-struct nlmon *nlmon_create(uint16_t id);
+struct nlmon *nlmon_create(uint16_t id, const struct nlmon_config *config);
 void nlmon_destroy(struct nlmon *nlmon);
 void nlmon_print_rtnl(struct nlmon *nlmon, const struct timeval *tv,
 					const void *data, uint32_t size);
-- 
2.34.3

