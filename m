Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3D21CD7
	for <iwd@lists.linux.dev>; Wed, 10 May 2023 20:45:18 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-50bc2feb320so12109709a12.3
        for <iwd@lists.linux.dev>; Wed, 10 May 2023 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683751516; x=1686343516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SoKXVCteWH56xEQn50QvWgmP+S+lHIbM6CyaT/64pjE=;
        b=gnWzNNPIUYRaWlEBOeaU23sE20xyo+KSPiS75RPN34u1R8gN5lX6awxtQT68uSppCa
         E73/IcpLDCG8KZ5xjDaKoUAifveKRtGd7CYj8YUzQOVlsg2aNvC7Ag9CQNRDGKLSgaOe
         neWBpMKqs5rJ0WlXk3mi21Uq9rsda74BvY3e6gHJVPvIJeA37ljCiNaf2FhggtCdXPo6
         4OVbKZEc8q4Pu1y/rzq7Jo95rEi8FvMPlpIg7cA5v9Igw24QzCBEDq8F6kIcSuJR03bm
         ZdY+akHcLW2a9scbbnRzkCi81yshtsTvXZY2zLHYCtDSVTRBbohw1YuncEot7d3UVxCF
         /nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751516; x=1686343516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoKXVCteWH56xEQn50QvWgmP+S+lHIbM6CyaT/64pjE=;
        b=Dx42o9fGX4kBqsMwDnwAtOY5CyWRmEmwm3ql8NOb66HbQvwsZWF4Dsqs9o/Qp8W1yQ
         rSEsG4ZiianlafzhVlEtFnHkm7XO6R+6vz1aMikTZ9Ki1mJB1WIv4PFEP3E9LjzosVmA
         bGAoVc6/tACaGK4041dWuNCA8y6cbJQ86dDTAVO4SYZ1Gvj4BM/YxGvBkuKb9U+dG+9z
         /3wKbENhzk6rA+TDPmteoSh71E4E0OCx56oPiTumEwu3qieQRDCSR0oOEx5uxrj3bTML
         lIvRnPLYhwmff//FQLEOzDIdD7pb4GHYkW2TWJTydnzVVqi/MIQ0vKwL14Y5aIj+lX6W
         JjgQ==
X-Gm-Message-State: AC+VfDxPQDFSJZeBwATuvtW7N2pXCIb7VUTdklI+yWIvxXl0UmGz+Ewc
	m1QKtn1Nzu2wVTQM4JGO5BWFXVecyPQ=
X-Google-Smtp-Source: ACHHUZ7nEIFked3MjP0hC8UpKGh24Tv9nuzghNzP2vvPwYhlgvk4hYO2/N6dc8ooEuuG8cOF45g6Hg==
X-Received: by 2002:a17:907:84d:b0:965:6a32:7de6 with SMTP id ww13-20020a170907084d00b009656a327de6mr16568147ejb.30.1683751515674;
        Wed, 10 May 2023 13:45:15 -0700 (PDT)
Received: from LOCLAP699.unipharma-middelburg.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id l23-20020aa7c3d7000000b004f9e6495f94sm2222427edr.50.2023.05.10.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:45:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 0/1] Fix wiphy regdom logic
Date: Wed, 10 May 2023 13:45:07 -0700
Message-Id: <20230510204508.715558-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below are some logs when this behavior was seen. IWD never
transitions out of the ft-roaming state due to the key setting
callbacks never being called. Its hard to know exactly what
messages were sent/received since its coming from iwmon but
netlink appears to completely lock up until a watchdog restarts
the IWD service.

After the patch was applied there were zero instances of this
behavior which seems to indicate the kernel is unable to handle
multiple GET_WIPHY calls.

May 10 00:11:54 iwd[336880]: src/station.c:station_try_next_transition() 14, target aa:46:8d:1c:16:e6
May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 14498
May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 14499
May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_done() Work item 14497 done
May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_next() Starting work item 14498
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
May 10 00:11:54 iwd[336880]: src/ft.c:ft_send_authenticate()
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
May 10 00:11:54 kernel: wlan0: disconnect from AP aa:46:8d:1c:17:25 for new assoc to aa:46:8d:1c:16:e6
May 10 00:11:54 locus[917]: State changed to roaming
May 10 00:11:54 locus[917]: Start 10000ms timeout waiting for connected/roaming
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on Channel(56)
May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_done() Work item 14498 done
May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_next() Starting work item 14499
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_cqm_rssi_update()
May 10 00:11:54 iwd[336880]: src/station.c:station_enter_state() Old State: connected, new state: ft-roaming
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Frame Wait Cancel(67)
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_deauthenticate_event()
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_disconnect_event()
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
May 10 00:11:54 kernel: wlan0: associate with aa:46:8d:1c:16:e6 (try 1/3)
May 10 00:11:54 kernel: wlan0: RX ReassocResp from aa:46:8d:1c:16:e6 (capab=0x1511 status=0 aid=7)
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is XX
May 10 00:11:54 systemd-networkd[393]: wlan0: Lost carrier
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_associate_event()
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_set_gtk() ifindex=14 key_idx=2
May 10 00:11:54 iwd[336880]: src/station.c:station_handshake_event() Setting keys
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_set_tk() ifindex=14 key_idx=0
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_connect_event()
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_connect_event() aborting and ignore_connect_event not set, proceed
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_connect_event() expect_connect_failure not set, proceed
May 10 00:11:54 iwd[336880]: src/netdev.c:parse_request_ies()
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_connect_event() Request / Response IEs parsed
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_get_oci()
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is US
May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_cancel_last_dump() Canceling pending regdom wiphy dump (global)
May 10 00:11:54 kernel: wlan0: associated
May 10 00:11:54 kernel: ath: EEPROM regdomain: 0x8348
May 10 00:11:54 kernel: ath: EEPROM indicates we should expect a country code
May 10 00:11:54 kernel: ath: doing EEPROM country->regdmn map search
May 10 00:11:54 kernel: ath: country maps to regdmn code: 0x3a
May 10 00:11:54 kernel: ath: Country alpha2 being used: US
May 10 00:11:54 kernel: ath: Regpair used: 0x3a
May 10 00:11:54 kernel: ath: regdomain 0x8348 dynamically updated by country element
May 10 00:11:55 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
May 10 00:11:55 iwd[336880]: src/netdev.c:netdev_cqm_event() Signal change event (above=0 signal=-76)

--- Nothing here for 10 seconds, until the watchdog triggers ---

May 10 00:12:04 locus[917]: IWD watchdog triggered (reason=state)
May 10 00:12:04 iwd[336880]: Terminate
May 10 00:12:04 iwd[336880]: src/netdev.c:netdev_free() Freeing netdev wlan0[14]
May 10 00:12:04 iwd[336880]: src/device.c:device_free()
May 10 00:12:04 iwd[336880]: src/station.c:station_free()
May 10 00:12:04 iwd[336880]: src/netconfig.c:netconfig_destroy()
May 10 00:12:04 iwd[336880]: src/netconfig.c:netconfig_event_handler() l_netconfig event 2
May 10 00:12:04 iwd[336880]: src/netconfig-commit.c:netconfig_commit_print_addrs() removing address: 10.193.158.118
May 10 00:12:04 iwd[336880]: src/resolve.c:resolve_systemd_revert() ifindex: 14
May 10 00:12:04 systemd[1]: Stopping Wireless service...

The iwmon logs are lengthy, but I've included the bit where the
logs abruptly stop for 10 seconds until the watchdog kicks in.
Prior there was no key setting or anything connection related
after the connect event.

May 10 00:11:55:     Extended Capabilities: len 8
May 10 00:11:55:         Capability: bit  2: Extended channel switching
May 10 00:11:55:         Capability: bit 62: Opmode Notification
May 10 00:11:55:     Extended Capabilities Mask: 170 len 8
May 10 00:12:04:         04 00 00 00 00 00 00 40                          .......@
May 10 00:12:04:     VHT Capability Mask: 176 len 12
May 10 00:12:04:         f0 1f 80 33 ff ff 00 00 ff ff 00 00              ...3........
May 10 00:12:04:     MAC Address 00:0E:8E:A3:02:FE
May 10 00:12:04: > Result: New Wiphy (0x03) len 36 [multi]                     1683677515.942843
May 10 00:12:04:     Wiphy: 0 (0x00000000)
May 10 00:12:04:     Wiphy Name: phy0
May 10 00:12:04:     Generation: 1 (0x00000001)
May 10 00:12:04:     Max AP Assoc Station: 202 len 4
May 10 00:12:04:         20 00 00 00    

James Prestwood (1):
  wiphy: fix regdom change wiphy dump logic

 src/wiphy.c | 103 +++++++++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 49 deletions(-)

-- 
2.25.1

