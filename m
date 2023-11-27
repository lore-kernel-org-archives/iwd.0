Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF811CBC
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwJ0D+nM"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-77d6f853ba0so322465785a.0
        for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 04:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701089392; x=1701694192; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QdX8oWhWH6c8eij+NzAifrkD//9ztmu6E/znFrH5N04=;
        b=iwJ0D+nMQiu4Z+VpRxZROnUnQUDRlVz+oOmPcFz1h6h+sSWV0ZfxnZeVtl4vkDxufp
         o30ESIUKPtLVRLD/fYeZPYTsXdEx+Quq/W9nj0+jjFJbBbxvc4bIAfbqrcunDXnZ1cq/
         iAn+pXPdVVJmzpgzWwYVB/zBRpXwcr0BpG/LM0JjUQVBMOzyqoeEGh1S1oDzAmepOXS5
         txj450chd5hsVCO5yLgjtns73Cw/IaZ3JaldXn7Oq5Alq5oKGhyln/eubTMini1h3hKm
         fAVY16jDxm9qlVXSWOuKdLU6+UMqhOGhoNxFZETL8ASq76DraA0YlpJVIz8GPM5S/kYd
         F2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089392; x=1701694192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdX8oWhWH6c8eij+NzAifrkD//9ztmu6E/znFrH5N04=;
        b=gEG3xQwdN3no/Qhuy+PtKHWTj+/YsqsM51a7UZisuUcQR78pLBP8dYA0V2QV4hzNo6
         75Lj+sPlzqVc602HD+CMuSzlQufmnB5Qz9omJQkvcNbGcCwIoCWQPNH8EnZtmZqNIGdW
         hE3Bu8YEGveXqFyGOe5dZxk7wbaE0hT34tbPJzIMqQIAbXDrRGEBbOjYOpcHe0OIlSV1
         csfi58+HrEAeZ5rd9hk7L4oc5NsudibJ40fmKcxWz0C0UEyQjP3Zis+z+XHtSne2xXdZ
         qpeBb2FHc1zm7D0Qjuwnr39Awo3gXdkmknzLgiXlGrEfkM6FUiGJ40r3XMXOQ7wHH5v2
         VQag==
X-Gm-Message-State: AOJu0Yzr9DpTtJ9JyloIZdPNszkHMJLKRGqozU4rJvufRL4ZymAUp/b6
	eXgKgUer3k+adHyO0/VWdDIuUN9F7v0=
X-Google-Smtp-Source: AGHT+IEQAVVL8fi/du3XlPPlfsx8pa+5TwlVVvclYb7w6xD6LWFibLAGrVQnO5/n0DzLG01GFoCddQ==
X-Received: by 2002:a05:620a:4802:b0:774:2470:6797 with SMTP id eb2-20020a05620a480200b0077424706797mr18113938qkb.21.1701089391784;
        Mon, 27 Nov 2023 04:49:51 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id vv3-20020a05620a562300b0077d664c2b16sm3609817qkn.135.2023.11.27.04.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:49:51 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: fix crash when deauth comes before FT work completes
Date: Mon, 27 Nov 2023 04:49:47 -0800
Message-Id: <20231127124947.273760-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the FT-Authenticate frame has been sent then a deauth is received
the work item for sending the FT-Associate frame is never canceled.
When this runs station->connected_network is NULL which causes a
crash:

src/station.c:station_try_next_transition() 7, target xx:xx:xx:xx:xx:xx
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5843
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5844
src/wiphy.c:wiphy_radio_work_done() Work item 5842 done
src/wiphy.c:wiphy_radio_work_next() Starting work item 5843
src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
src/ft.c:ft_send_authenticate()
src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
src/netdev.c:netdev_link_notify() event 16 on ifindex 7
src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
src/netdev.c:netdev_deauthenticate_event()
src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
src/netdev.c:netdev_disconnect_event()
Received Deauthentication event, reason: 7, from_ap: true
src/station.c:station_disconnect_event() 7
src/station.c:station_disassociated() 7
src/station.c:station_reset_connection_state() 7
src/station.c:station_roam_state_clear() 7
src/netconfig.c:netconfig_event_handler() l_netconfig event 2
src/netconfig-commit.c:netconfig_commit_print_addrs() removing address: yyy.yyy.yyy.yyy
src/resolve.c:resolve_systemd_revert() ifindex: 7
[DHCPv4] l_dhcp_client_stop:1264 Entering state: DHCP_STATE_INIT
src/station.c:station_enter_state() Old State: connected, new state: disconnected
src/station.c:station_enter_state() Old State: disconnected, new state: autoconnect_quick
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 5845
src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on Channel(56)
src/wiphy.c:wiphy_radio_work_done() Work item 5843 done
src/wiphy.c:wiphy_radio_work_next() Starting work item 5844

"Program terminated with signal SIGSEGV, Segmentation fault.",
"#0  0x0000565359ee3f54 in network_bss_find_by_addr ()",
"#0  0x0000565359ee3f54 in network_bss_find_by_addr ()",
"#1  0x0000565359ec9d23 in station_ft_work_ready ()",
"#2  0x0000565359ec0af0 in wiphy_radio_work_next ()",
"#3  0x0000565359f20080 in offchannel_mlme_notify ()",
"#4  0x0000565359f4416b in received_data ()",
"#5  0x0000565359f40d90 in io_callback ()",
"#6  0x0000565359f3ff4d in l_main_iterate ()",
"#7  0x0000565359f4001c in l_main_run ()",
"#8  0x0000565359f40240 in l_main_run_with_signal ()",
"#9  0x0000565359eb3888 in main ()"
---
 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/station.c b/src/station.c
index ff8a7466..49cad135 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1721,6 +1721,9 @@ static void station_roam_state_clear(struct station *station)
 	l_queue_clear(station->roam_bss_list, l_free);
 
 	ft_clear_authentications(netdev_get_ifindex(station->netdev));
+
+	if (station->ft_work.id)
+		wiphy_radio_work_done(station->wiphy, station->ft_work.id);
 }
 
 static void station_reset_connection_state(struct station *station)
-- 
2.34.1

