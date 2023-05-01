Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF678C05
	for <iwd@lists.linux.dev>; Mon,  1 May 2023 22:06:10 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-61b6101a166so2543506d6.0
        for <iwd@lists.linux.dev>; Mon, 01 May 2023 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682978769; x=1685570769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGaSRVFoZIHRUupgA9yFRhhze1LGhEbdVs0BsR56Xxc=;
        b=RZ0mmrA3YoSMnY+8OjzbZIjCFf2LCXfYOSD/fU4jqRYgV+8oKyhKYUHfixqkgHj0Wd
         qcv3A8pGlJI4pdRW0H1PLl07YFAkg3BIusKnwsQ+PM6em30/bjEx7UpIU6FoMi0CImCR
         3V7+DUxmFbgYnCHpokMnimq1tisp7DDsQaxTm/QFqx63LlHmPRe7F4WoWmA6qe4ePLhb
         UGXDeDXlVaR+Xe/m6vL2ZfejNXXZ5hIM/cj6AoNOg0DFwSiaGo0WvCi8a1ZjQjmolRTj
         YOjBjw4I9d/U9wWUxFPOms0LrSagj0npqnL3QxEBApJCHDlzY8e/1mmQM6swVs4a7L83
         OzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682978769; x=1685570769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGaSRVFoZIHRUupgA9yFRhhze1LGhEbdVs0BsR56Xxc=;
        b=H4pXPQtkWzyjEuPfuSSXWoKZb5CdeqpF5TrZty9Yw7OmMulrXKDM11G/V6hfs9esQz
         HgjtFsL6uNRs2Wqm+UjfKu+rs3IhV+pYByqoHToOSE93gCFx/jkMAmFtbs8CojgaDYiW
         YR6X2RhGGz96rwD5uELIMvUkQGXh21r6EAD5htSEKMZA8LOZahILaoGkgQtNssH6pLHk
         VR3n7b51sSrY05a1csuhqkYx5vj5Z/vxRNn9xq5q9l9uU4v6JoLpLiHAvqkzKQ5vYn1W
         7owGZ6PR5TNYvquJ+3V6ZlVQTiI9B5/Ho0Pk4YYLLX3qRtb1sQeGtU+JhWBWaPZJHh5c
         nMDA==
X-Gm-Message-State: AC+VfDwFP+Isi8XqKK7yJRfXPLV1vPWObV8B/6P44vPr2mcwHGfGqke5
	Vn7z6lB6uQY/6UtH7pKFSebDiPFA9Dg=
X-Google-Smtp-Source: ACHHUZ6Rz0dinB31ryEJ/jyEhs5KDrYuduKvAjGJR+31WRgghMlI6+i6CCGRox3xA7Pf45yw0C2HDA==
X-Received: by 2002:a05:6214:130c:b0:5e9:429b:559f with SMTP id pn12-20020a056214130c00b005e9429b559fmr2515393qvb.13.1682978768979;
        Mon, 01 May 2023 15:06:08 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id u17-20020a0ca711000000b0061a4a93eeadsm445184qva.127.2023.05.01.15.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:06:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: fix reentrant FT wiphy radio work insertion
Date: Mon,  1 May 2023 15:06:04 -0700
Message-Id: <20230501220604.366100-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
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

