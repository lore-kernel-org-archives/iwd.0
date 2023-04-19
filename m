Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955FD2EA
	for <iwd@lists.linux.dev>; Wed, 19 Apr 2023 20:23:09 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-63b52ad6311so347944b3a.2
        for <iwd@lists.linux.dev>; Wed, 19 Apr 2023 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681935789; x=1684527789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFCR3QE7PuN6z0mObj+wuLDO/nuloaTNAflpH9nnpUg=;
        b=Jcgkssu/lJCxtmqETPcTzcv7Qsht2ymQjWRs/Qz5srBv2jl8MXTFcLlHpJOVHMFNEz
         5OTIitLS/vNi1L35+ldtiHLQ+tnew6uYBNqHe+QB8A4+GVAdv0vBezpoKRFi7URAZebE
         ZnjToJMLmnwC/S1WTKvGNb3XRMEQECfMIWU3R2/3HDCgFkK/SaAXlS4qF+m8Wc4REZkV
         diG9rjDZRyAG7hvH2UsJV7uQhQ2i7PhxZbJSBC9kebGbSmecbTSkqPHIPpOcxsC77uPn
         1Y7FyncC7kAdFNen0S+KVd9VkW57ZayQt2Bvvj+VxoQbBk/Xlo/eWTprbT37F/jhBbFy
         sP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681935789; x=1684527789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFCR3QE7PuN6z0mObj+wuLDO/nuloaTNAflpH9nnpUg=;
        b=hADrJfqhzNZkSfgAYXCtBTXNmdVzMAPZReARKWWp3e4EXc0E4jTFE3IIvSv0GeCt5v
         REzjTozE+pHUp+thGUGNF3tkhIHKZ7dwgmL8ezv7b0lWGWRJx1jcB+VOEUXmH3DTRdw9
         Ne2aFtLeRX1lRXO6NSyzGkr4doq07htLjKGCMCvrKaKGNo8rsbPBijsLlkBBgRdFFwCd
         CV2xbRdmZuKqid0K5RPUmVlDDC9PFEi3zpQKiUpKDTJdMkEDhrly3Bj8ox4sNTdKcxaC
         mkEJf/0yM58hY28C9PcvEJrKk8FmjawxB9zpT4wz4Kf4K669kybeObGYvVWjo5RvGoYr
         tvCg==
X-Gm-Message-State: AAQBX9f4p6hi9McRLdBGT/vn+wJorb33ccNTeRV7MYtFm6Owbd2rkTyc
	G2sx+AQm2EOp0PMCML8pWL9fRTWykws=
X-Google-Smtp-Source: AKy350apaI1xVOTbd1Ks1KTFmqHR0vyAz0n/bCVJDd7zcZj7mK4EyODe7A85CAdK0SyDKddUumNDKQ==
X-Received: by 2002:a05:6a00:14c2:b0:63d:4446:18ab with SMTP id w2-20020a056a0014c200b0063d444618abmr5926320pfu.23.1681935788631;
        Wed, 19 Apr 2023 13:23:08 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78756000000b0063799398eaesm11266149pfo.51.2023.04.19.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 13:23:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ft: fix double free when disconnecting mid-FT
Date: Wed, 19 Apr 2023 13:23:01 -0700
Message-Id: <20230419202301.23194-1-prestwoj@gmail.com>
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
double free afterwards. Knowning this, check the status of the
ft_info and only free if it has been parsed.

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
 src/ft.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/ft.c b/src/ft.c
index 8ae683a7..1fd5c09f 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1175,6 +1175,7 @@ static bool remove_ifindex(void *data, void *user_data)
 {
 	struct ft_info *info = data;
 	uint32_t ifindex = L_PTR_TO_UINT(user_data);
+	bool need_free = info->parsed;
 
 	if (info->ifindex != ifindex)
 		return false;
@@ -1183,7 +1184,15 @@ static bool remove_ifindex(void *data, void *user_data)
 		offchannel_cancel(netdev_get_wdev_id(netdev_find(ifindex)),
 					info->offchannel_id);
 
-	ft_info_destroy(info);
+	/*
+	 * If we hadn't yet got an authenticate response or there was something
+	 * wrong with parsing (i.e. !info->parsed) the offchannel destroy
+	 * callback will end up destroying the info. Otherwise we need to
+	 * destroy it here.
+	 */
+	if (need_free)
+		ft_info_destroy(info);
+
 	return true;
 }
 
-- 
2.25.1

