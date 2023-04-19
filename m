Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2A33EC
	for <iwd@lists.linux.dev>; Wed, 19 Apr 2023 20:30:39 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id fv6so503733qtb.9
        for <iwd@lists.linux.dev>; Wed, 19 Apr 2023 13:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681936238; x=1684528238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0WbjRONjI0sRaf3zPKiBScN0qcE4Ly8jjXPp0/txdw=;
        b=WA/lFhBcEgxPSl/LTKpP7TE09z2By8vHwN1CFtg2lxoYnj4VbxP0ewcD6iJMpGsQAN
         lHXWlRSP2kqhwN+QM270KYFMuAqCuSFhJ6kKelVw3w2Ruc2AZC8wLbg0fdhCpGUPMYyZ
         NVfZ8WnpAYUQE/EI1oPQaDReU6HjdENvtIcNLBl1JbpIyb6Dzj8GI/8/jXrPGcHKpu4K
         kIUG2g2bYuQLjwCNNKmzlGePAbXGEcmeD67bmndGgnjOpAcNzh5nFL4sSGyjYRr8TCvb
         ni0U3CRYQjy53aULv2VEHvadwdtHmCOvlKkOQY59RgIG9drBt3utM2W1U66PJifveMuV
         j3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681936238; x=1684528238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0WbjRONjI0sRaf3zPKiBScN0qcE4Ly8jjXPp0/txdw=;
        b=Z9YzoVDnrX07kf+ghdR9bjW9leX66Ax5nNbTj4QNtfEv8d5/BR9sV13kjBJEVrjBKp
         JoJpU4NRYGWUT+sQWNgjJh6fM4XxLGVjLPWzZgfWROWy7P69IeCcGTgqFpI8wSTOYtbJ
         dwu/s1Ty3GPdD0CDKqHrDEtrnGKpueN/A2Hgc6OLUDsydbkwJwb54Y8td6FtInR37HOd
         FvCBqKYZyOZ5dbc8MEO5zVSBqngA3w0uGohGBuEHh5LiROdfMOfQvFqwE1DNXdjSQfKh
         VsYmUiEWB71lv5AZ9MgitvxcZdEDpmpGhtke6EABeuq3RndawBJmmcitEpL6vPr4LNCp
         0lnA==
X-Gm-Message-State: AAQBX9cZiPg3sJkZwNFgfEKWjZj+adFQ1Bij7ArmDcgBeAkHVcDP4n/L
	tGIlukqzdki+crTTElsM/Ua+X/90z28=
X-Google-Smtp-Source: AKy350YA1lBEdmPCdDkW7Ym5nSbl1JF0KBGzrCP1wG98uJe24iGqOWPk2aZxNbl8UQxgiVIKb0govA==
X-Received: by 2002:a05:622a:1708:b0:3e4:e3cf:22d6 with SMTP id h8-20020a05622a170800b003e4e3cf22d6mr8150768qtk.54.1681936238300;
        Wed, 19 Apr 2023 13:30:38 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id i26-20020ac860da000000b003eddd355c37sm12923qtm.34.2023.04.19.13.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 13:30:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] ft: fix double free when disconnecting mid-FT
Date: Wed, 19 Apr 2023 13:30:33 -0700
Message-Id: <20230419203033.26365-1-prestwoj@gmail.com>
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

v2:
 * This was missing the check for the offchannel_id as well. If there is
   not a current offchannel operation the info needs to be freed as
   well (not only when info->parsed == true).

diff --git a/src/ft.c b/src/ft.c
index 8ae683a7..e7794bf5 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1175,6 +1175,7 @@ static bool remove_ifindex(void *data, void *user_data)
 {
 	struct ft_info *info = data;
 	uint32_t ifindex = L_PTR_TO_UINT(user_data);
+	bool need_free = info->parsed || !info->offchannel_id;
 
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

