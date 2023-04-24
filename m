Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA102108
	for <iwd@lists.linux.dev>; Mon, 24 Apr 2023 13:40:35 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-518d325b8a2so4640214a12.0
        for <iwd@lists.linux.dev>; Mon, 24 Apr 2023 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682343635; x=1684935635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=USm53wj19r7lTq4IbmpkorTy2hnTp5ATYuGTc/tPBEE=;
        b=Ib08tXf9Dm4RVAFulf2Cq5qWofS3d2VKscueXj+gEMsWjdEFU688v+3/aIqdeho+6w
         Z7/VzjVGp+nDSS2sh/Ow0yEAibcdLVfIbbLOawUZ+UJVZDgeZFpuvKS9DzZ6zfauyP6E
         ZwZMPMBNg89GkCpD/z9gnMKSV7I/2Lj0cGwkJ61xEdj/t8hFVGdbq3rq6Ezi2Sjyn6I8
         Tak2yVEreM2/InmiiL1x/RVkTTnUYC+Mv+zklHE91h9xAipL7TZXgzJfUdNysSU7ip9r
         HftzEf3AiXgvVZ86d/CCQ4+AqFcbB5e4nFMPLNe79Vr4tCjt1KOMsD+3KyQ9GeXqicri
         dngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682343635; x=1684935635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USm53wj19r7lTq4IbmpkorTy2hnTp5ATYuGTc/tPBEE=;
        b=EHol9xbWOBM/Eoxsi2fxqNGfYndLSr7leu3T/bkKZ62eZgDFefLXvwhNrzN/Qfy8G6
         pUzQU0hjzeIPiy5c2MMs5OVw6MHkYqq9DYz4BK8pCK9V1jPAZjHGyf6p/FBt5mC9mx3t
         1YrnwhSHh5dFeEpaRfHFN0hdeaWPQeFv4dA0RWn9wrs7OndN9VuyWK6BZLEWvzmCQi0D
         OfrTxr6iT57Ff6IFTPxn3GhVk1EfkRD92p1CohXgAw1AZxQuJcQrfkMbgPFXPTuzpIkk
         vd8yKAanyMfxLKIvWiCK1cQ4QGWWiJhexAdyQwWUzY9AN5Lg1h3hmFrgkiOjIY9hlbxY
         R5OA==
X-Gm-Message-State: AAQBX9fhsDrlrg1Lca73HATGr25nQ1KNP1d21fUhHjae83v5nY1SCdjd
	CZ5n/tW8hqNjjFbc7J0E9H3uhdPVM8jxPQ==
X-Google-Smtp-Source: AKy350ZcyIjKD0nZkVk32BoY5ixMkCgAOf2uEgBHAbvGEylK9X/Sp6oSIjvjP8kBintdPSow4Pr3Ug==
X-Received: by 2002:a05:6a21:8dc5:b0:f0:e3ed:469a with SMTP id ti5-20020a056a218dc500b000f0e3ed469amr12410598pzb.55.1682343634965;
        Mon, 24 Apr 2023 06:40:34 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id x4-20020aa784c4000000b0063d238b1e4bsm7433228pfn.160.2023.04.24.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:40:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3] ft: fix double free when disconnecting mid-FT
Date: Mon, 24 Apr 2023 06:40:33 -0700
Message-Id: <20230424134033.32916-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If IWD gets a disconnect during FT the roaming state will be
cleared, as well as any ft_info's during ft_clear_authentications.
This includes canceling the offchannel operation which also
destroys any pending ft_info's if !info->parsed. This causes a
double free afterwards. In addition the l_queue_remove inside the
foreach callback is not a safe operation either.

To fix this don't remove the ft_info inside the offchannel
destroy callback. The info will get freed by ft_associate regardless
of the outcome (parsed or !parsed). This is also consistent with
how the onchannel logic works.

Log and crash backtrace below:

iwd[488]: src/station.c:station_try_next_transition() 5, target aa:46:8d:37:7c:87
iwd[488]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 16668
iwd[488]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 16669
iwd[488]: src/wiphy.c:wiphy_radio_work_done() Work item 16667 done
iwd[488]: src/wiphy.c:wiphy_radio_work_next() Starting work item 16668
iwd[488]: src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
iwd[488]: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
iwd[488]: src/netdev.c:netdev_link_notify() event 16 on ifindex 5
iwd[488]: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
iwd[488]: src/netdev.c:netdev_deauthenticate_event()
iwd[488]: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
iwd[488]: src/netdev.c:netdev_disconnect_event()
iwd[488]: Received Deauthentication event, reason: 6, from_ap: true
iwd[488]: src/station.c:station_disconnect_event() 5
iwd[488]: src/station.c:station_disassociated() 5
iwd[488]: src/station.c:station_reset_connection_state() 5
iwd[488]: src/station.c:station_roam_state_clear() 5
iwd[488]: double free or corruption (fasttop)

5  0x0000555b3dbf44a4 in ft_info_destroy ()
6  0x0000555b3dbf45b3 in remove_ifindex ()
7  0x0000555b3dc4653c in l_queue_foreach_remove ()
8  0x0000555b3dbd0dd1 in station_reset_connection_state ()
9  0x0000555b3dbd37e5 in station_disassociated ()
10 0x0000555b3dbc8bb8 in netdev_mlme_notify ()
11 0x0000555b3dc4e80b in received_data ()
12 0x0000555b3dc4b430 in io_callback ()
13 0x0000555b3dc4a5ed in l_main_iterate ()
14 0x0000555b3dc4a6bc in l_main_run ()
15 0x0000555b3dc4a8e0 in l_main_run_with_signal ()
16 0x0000555b3dbbe888 in main ()
---
 src/ft.c | 5 -----
 1 file changed, 5 deletions(-)

v3:
 * Addressed Denis' comments about removing a list item during a foreach
   callback. This left a simpler option to not remove the item at all
   during the offchannel callback and left ft_associate() handle it.

diff --git a/src/ft.c b/src/ft.c
index 8ae683a7..62fb0ae5 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1060,11 +1060,6 @@ static void ft_authenticate_destroy(int error, void *user_data)
 	struct ft_info *info = user_data;
 
 	info->offchannel_id = 0;
-
-	if (!info->parsed) {
-		l_queue_remove(info_list, info);
-		ft_info_destroy(info);
-	}
 }
 
 /*
-- 
2.25.1

