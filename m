Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDB21CD7
	for <iwd@lists.linux.dev>; Wed, 10 May 2023 20:42:06 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-50db7ec8188so4092678a12.2
        for <iwd@lists.linux.dev>; Wed, 10 May 2023 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683751326; x=1686343326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGaSRVFoZIHRUupgA9yFRhhze1LGhEbdVs0BsR56Xxc=;
        b=pRQZZQp5y0yKRoYob4cw5nitUBEj/qikrWURqCn3PdFLAni4a023tMO99w5PMwpVFp
         t+EhBhmSG4y88agYzQrTrNBzFC3nj2NbMmRadesEl+R9Di/4N+wFPrhltb/UhkxWxHnR
         dybjOE1meHIx+i15idEHBOcoDjZm+r5D5ZX/bI3a9MSW88T7ddtZT5EEEQqSS+/2jIV4
         hoV1V2K3SmGcvGPmDG6KTe/1/zilkDPko562Mz4huNJDwJWEb8lmIbwSFp2L4lV4P7rR
         EPGj/hOmhQlQagwbylunDwUq+v7Mo5IWVAKpFVCaA0MhqT2rYnt+xfRcOmPUyQhXqK/a
         bwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751326; x=1686343326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGaSRVFoZIHRUupgA9yFRhhze1LGhEbdVs0BsR56Xxc=;
        b=RyaUlbu2ebN8pBcLyreKIClw9ECHs9W6ilPzIhyi9qVjVFe77hs8tlfjVbG1gYpcQR
         yljyjlcEHMJA3EzbONmJmxKRwFSIDZIDXqsXr56CcUD8VYgLSWuNyYdL9q5kf+4uEUET
         zo+E72eDSkN/hxsPWjK8pbIJHcRZtGOHgJo7gznwdfqn56aoiEFlHsCREsoqONj4EeAy
         hUHnl7IoInc5fXOjgE02BZb+zVNi31C6N9O5sKvTbxneckNFlpH8pduYxhovK3wPMtv2
         buMFlLj4Q3rDgmU0M6JJ5Sq2C8VoYC0NPx6s4wDuIzG5n5xnjakxp2ZOnreHo+pfJ3TT
         INGA==
X-Gm-Message-State: AC+VfDyAhxgCvegx6ogT5ZSjit26bwcrwlzt8OQq99DWQ3l473kCOstV
	LwaX6ybcwdotQqj1xDR0VlQ4edQEgFw=
X-Google-Smtp-Source: ACHHUZ5MO91eYd8kPE8lwoC0jPp8zriNgMqIBxDeVSBMqAr32yymT41h8K9Ll96W/HvqyyN1s+/boQ==
X-Received: by 2002:a05:6402:b13:b0:50c:a8ca:3240 with SMTP id bm19-20020a0564020b1300b0050ca8ca3240mr15335131edb.24.1683751325828;
        Wed, 10 May 2023 13:42:05 -0700 (PDT)
Received: from LOCLAP699.unipharma-middelburg.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id q22-20020a056402041600b004ad601533a3sm2237700edv.55.2023.05.10.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:42:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] station: fix reentrant FT wiphy radio work insertion
Date: Wed, 10 May 2023 13:41:53 -0700
Message-Id: <20230510204153.715304-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510204153.715304-1-prestwoj@gmail.com>
References: <20230510204153.715304-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The failure path for FT was inserting the same work item inside
the 'do_work' callback. This caused duplicate work items to be
inside the radio work queue, and upon destroy the ID would get
zero'ed out. This caused a host of valgrind complaints when this
behavior is triggered.

This can be seen with slight modifiations to the FT test:

src/station.c:station_try_next_transition() 9, target 12:00:00:00:00:02
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 6
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 7
src/wiphy.c:wiphy_radio_work_done() Work item 5 done
src/wiphy.c:wiphy_radio_work_next() Starting work item 6
src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
src/ft.c:ft_send_authenticate()
src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
src/netdev.c:netdev_mlme_notify() MLME notification Frame Wait Cancel(67)
src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on Channel(56)
src/wiphy.c:wiphy_radio_work_done() Work item 6 done

--- Work item 7 is 'station_ft_work_ready()' ---

src/wiphy.c:wiphy_radio_work_next() Starting work item 7
src/station.c:station_debug_event() StationDebug.Event(ft-roam-failed)
src/station.c:station_try_next_transition() 9, target 12:00:00:00:00:03
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 8

--- Here we insert work item 9, which is a duplicate of 7 ---

src/wiphy.c:wiphy_radio_work_insert() Inserting work item 9
src/wiphy.c:wiphy_radio_work_next() Starting work item 8
src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
src/ft.c:ft_send_authenticate()
src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
src/netdev.c:netdev_mlme_notify() MLME notification Frame Wait Cancel(67)
src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on Channel(56)
src/wiphy.c:wiphy_radio_work_done() Work item 8 done

--- And finally, the duplicated work item starts ---

src/wiphy.c:wiphy_radio_work_next() Starting work item 0
src/station.c:station_debug_event() StationDebug.Event(ft-roam-failed)
src/station.c:station_roam_failed() 9
src/station.c:station_roam_trigger_cb() 9
---
 src/station.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 0d8f7628..3c6e43ce 100644
--- a/src/station.c
+++ b/src/station.c
@@ -122,6 +122,7 @@ struct station {
 
 	uint32_t wiphy_watch;
 
+	struct l_idle *ft_idle;
 	struct wiphy_radio_work_item ft_work;
 
 	bool preparing_roam : 1;
@@ -1739,6 +1740,11 @@ static void station_roam_state_clear(struct station *station)
 		station->roam_freqs = NULL;
 	}
 
+	if (station->ft_idle) {
+		l_idle_remove(station->ft_idle);
+		station->ft_idle = NULL;
+	}
+
 	l_queue_clear(station->roam_bss_list, l_free);
 
 	ft_clear_authentications(netdev_get_ifindex(station->netdev));
@@ -2282,6 +2288,16 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 
 static void station_transition_start(struct station *station);
 
+static void station_transition_idle(struct l_idle *idle, void *user_data)
+{
+	struct station *station = user_data;
+
+	l_idle_remove(station->ft_idle);
+	station->ft_idle = NULL;
+
+	station_transition_start(station);
+}
+
 static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 {
 	struct station *station = l_container_of(item, struct station, ft_work);
@@ -2300,7 +2316,8 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 	if (ret == -ENOENT) {
 		station_debug_event(station, "ft-roam-failed");
 try_next:
-		station_transition_start(station);
+		station->ft_idle = l_idle_create(station_transition_idle,
+							station, NULL);
 		return true;
 	} else if (ret < 0)
 		goto assoc_failed;
-- 
2.25.1

