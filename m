Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD0259C
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 20:46:02 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id g62so12642560pfb.10
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lUBE4OWfO/bpkhLFVtTt/Kqn+0VZ46llClhPgULhaU=;
        b=Hu+oZmdhczRXg7usvAOXIVqBmEWuFq2UibgYlg2x4ca7qxURVDvBhrGSzMOotXKmdq
         Lv9ONX1PerzNhCul5+u7ZfJZr3z7f3IgRMx+HgVYbF57lRU4JR0QCmzog+CW/QnymxDP
         sFUSe9AdLGHlmx5ROKbyAAljcblbDyEI/KtOvR6NSJv8z7qGdB8lv0lM13Wcw2onWs4n
         iWlAcee8dTdDvELKTt0V+hMtfWe67taCIriV7BYgmiwveJaWe4YbTw+FHs+tZuVY1WCj
         sn/UMp4WdzB2VqAoZJWu0gWRHi8TLektj3aI9m1Fj/ABG42DEGL4mKHYDu3JkQF5LHLW
         hCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lUBE4OWfO/bpkhLFVtTt/Kqn+0VZ46llClhPgULhaU=;
        b=St0kCnLRZNduKaj8BW0UjRf2Y+aVcGbmUmkZhSNUJYw4qx45/eDnU/SPNJAVZLcygi
         4QYB3JYA0AK3eE5koLSU7g2gkjH0RoEUlU9C4CWUuvfd60c+x5jO/m2yYSMmlCbNDVm6
         rCIZtnRAQvQUvgzDwV+gbtl42d4NtgG9sacVyszGRQAQFJ2kmztbAfWhLyzOz3FB8YWC
         2bxO1gFln/ove7aLHF0iNZDL8kItcnjhtFDFCvwnfxoP/jIZ/9u2nX2dtaJQ+flRk6vE
         k6lOi+Qiz2F2mug92gixl+klqK5/DSnZxbP3Wdhf41QeQlBN2+kFf2W7oFfF6TELmwhT
         Lk9w==
X-Gm-Message-State: ACrzQf3pDeFnLSZ8bYzeVwtCMBPpLwtTzjrHmA9bm3xqhmvW4jJ3BZUG
	ezqMKgmFhKJ6r38oGPsDGwAVhh5AAys=
X-Google-Smtp-Source: AMsMyM7VwZlx1wePCdWNPwvThccQjz8ah/6FnCRPD5+2sWnO4WpaU6rzwqc7PbPxQz+gKlZ7YHGyBA==
X-Received: by 2002:a63:8b41:0:b0:461:7bb7:bbea with SMTP id j62-20020a638b41000000b004617bb7bbeamr39309485pge.0.1666817162032;
        Wed, 26 Oct 2022 13:46:02 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i27-20020a056a00005b00b0056203db46ffsm3510588pfk.172.2022.10.26.13.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:46:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] monitor: allow parsing pcaps without -F option
Date: Wed, 26 Oct 2022 13:45:58 -0700
Message-Id: <20221026204559.502432-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221026204559.502432-1-prestwoj@gmail.com>
References: <20221026204559.502432-1-prestwoj@gmail.com>
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
 monitor/main.c  | 1 +
 monitor/nlmon.c | 4 +++-
 monitor/nlmon.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/monitor/main.c b/monitor/main.c
index 50b3fd27..0cbab179 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -710,6 +710,7 @@ int main(int argc, char *argv[])
 		switch (opt) {
 		case 'r':
 			reader_path = optarg;
+			config.read_only = true;
 			break;
 		case 'w':
 			writer_path = optarg;
diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index b58bef05..d786cc33 100644
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
@@ -7265,6 +7266,7 @@ struct nlmon *nlmon_create(uint16_t id, const struct nlmon_config *config)
 	nlmon->nowiphy = config->nowiphy;
 	nlmon->noscan = config->noscan;
 	nlmon->noies = config->noies;
+	nlmon->read = config->read_only;
 
 	return nlmon;
 }
diff --git a/monitor/nlmon.h b/monitor/nlmon.h
index d1092c11..96958c25 100644
--- a/monitor/nlmon.h
+++ b/monitor/nlmon.h
@@ -30,6 +30,7 @@ struct nlmon_config {
 	bool nowiphy;
 	bool noscan;
 	bool noies;
+	bool read_only;
 };
 
 struct nlmon *nlmon_open(const char *ifname, uint16_t id, const char *pathname,
-- 
2.34.3

