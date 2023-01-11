Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911E5A93F
	for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 20:15:52 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id y5so12272385pfe.2
        for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 12:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZHkgmj/3JvSEaxBPaEKJm2kAF473q3CKZ7/Z8Kv2+c=;
        b=QFuCPOCKHQZmU/OnALSY+0E2oRVAbVgc+4Xzlkrp/mG1U9KPXdEtwNPR98YkFmm5PP
         xA9UDGN3iTu6roUTRU5T2utvctpKjlO3HdtG1r1rSNSl3z1OCGgGng8/rRi3PB+sf5v6
         uTU/4Fok+c5yJpVRyEIuJpKI+Cl77pYj1FXJOkuIwsqtw0rKMl9/B58MpYgj/FuPtsE5
         flt86Mnf43766L656LYO1Fl0DJm9jUAiREWSYzOXdCn+55MBWZQspJTsH8SvKYsQ8Xze
         w0CxaHN8+kcSsT3D4NV4guVnfbEUHGCy1SbYF3CeWWPoUHBV8LmA8bd7j9qdFq5vjPou
         wQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZHkgmj/3JvSEaxBPaEKJm2kAF473q3CKZ7/Z8Kv2+c=;
        b=Rq6vi6c+v21WAAMzEzbwOtExKqvLR9+pnBD+HMIqLkEOzgpxC+yIdiM7QNA6zj/nQm
         +J/kEs8pYfsjijtucUWqkLp+jTTkjyA4EHnpBZsZrhGy1Q8VmS55OR+Jed8xYoNpQnzO
         KFnOOHaVXYsfgBLq+owkKuS7deznnXj/whVZqhi0Z7bwjt3bXsqjJ/5Umy7W5CkS77hk
         ReofJdyPLY2Y9xvNLo70H0WhMH0+b1GzJCLJaUMYyg89zyxfmGkK4UHm6aEBue3b/V/K
         jmxl9gJP0pFogQ2GFVr1gniEtcERGT3L0JI+Q7AeHQfCV+hXNKN9kFoMCKaHvAvQspyV
         f0rw==
X-Gm-Message-State: AFqh2kqGpzNJacehh48KXU14ZG5FFKsos7CyAOviH13IKiJKWDhEu9NV
	sIiMZVWoM/WsEtqSi4Vc3+vrC+XEfgQ=
X-Google-Smtp-Source: AMrXdXtZjQNvngDnQZYmoz2MFQNYRzpW8eoHi9sWIuvfQjpL7jQhl+qQ2zeDM63eqQ3YBWb0QQ+EPg==
X-Received: by 2002:aa7:824d:0:b0:587:749c:c0d8 with SMTP id e13-20020aa7824d000000b00587749cc0d8mr12046482pfn.5.1673468152082;
        Wed, 11 Jan 2023 12:15:52 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b005884d68d54fsm6733904pfq.1.2023.01.11.12.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:15:51 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/9] handshake: add event for rekey success
Date: Wed, 11 Jan 2023 12:15:38 -0800
Message-Id: <20230111201543.397692-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230111201543.397692-1-prestwoj@gmail.com>
References: <20230111201543.397692-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rekeys for station mode don't need to know when complete since
there is nothing to do once done. AP mode on the other hand needs
to know if the rekey was successful in order to reset/set the next
rekey timer.
---
 src/handshake.h | 1 +
 src/station.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/src/handshake.h b/src/handshake.h
index f2321634..863ffac7 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -60,6 +60,7 @@ enum handshake_event {
 	HANDSHAKE_EVENT_EAP_NOTIFY,
 	HANDSHAKE_EVENT_TRANSITION_DISABLE,
 	HANDSHAKE_EVENT_P2P_IP_REQUEST,
+	HANDSHAKE_EVENT_REKEY_COMPLETE,
 };
 
 typedef void (*handshake_event_func_t)(struct handshake_state *hs,
diff --git a/src/station.c b/src/station.c
index bad067c8..ad5ad724 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1015,6 +1015,7 @@ static void station_handshake_event(struct handshake_state *hs,
 	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
 	case HANDSHAKE_EVENT_EAP_NOTIFY:
 	case HANDSHAKE_EVENT_P2P_IP_REQUEST:
+	case HANDSHAKE_EVENT_REKEY_COMPLETE:
 		/*
 		 * currently we don't care about any other events. The
 		 * netdev_connect_cb will notify us when the connection is
-- 
2.34.3

