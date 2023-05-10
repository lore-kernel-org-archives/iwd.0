Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD448C1C
	for <iwd@lists.linux.dev>; Wed, 10 May 2023 20:43:53 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50b8d2eed3dso11810528a12.0
        for <iwd@lists.linux.dev>; Wed, 10 May 2023 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683751431; x=1686343431;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxgGZlXQK3l7vwCUTLtncrV7Fiqm3uOVLq2YYTFWs1E=;
        b=BuHJ9wvgTH5hSpoIxbXMilp2J3bfxIgZv5TvXexMt/1FnwBrCH1JZHWYZY2g30NUJQ
         Fj5svGULPsiExU43LHm5z6D54ybwcZDYk04uCI5DeBUfQm3Sgp+bdVf8Ydf0Cez5XGmK
         dZ3CkHiiLvqLdwNZtz8iZYyy1GN6ivRNQdb4K8hIipcqQ0xQZ966y1WPE7QtieVEu00b
         KGfOHbvtU6b63OFGck729GeXoULrzwwDRu+XLtMxygMPGFbv+nQ3P3F+oMjMe71tPpJ9
         cow4+Ilo3n+RmUDeUy4ucvJVAYW+YBMn//GyoDauLsnlvX3y9ZcQhlCSutWGxPqejWRH
         totw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751431; x=1686343431;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxgGZlXQK3l7vwCUTLtncrV7Fiqm3uOVLq2YYTFWs1E=;
        b=SAfSOW4S4sa7X28W+W0KAwKPEEhQh3xyprFunHxFYJ/k4bqmhKDs/IRK9ISxRpGTLK
         bGctUsG6bllf5+9AgmoLaQdjtobutn4ZEZPNnpsdgYaduUv2OdmcLSsRoj6I13EH1XVr
         YnHkpR3DggY3FVRqHDQP3USqduERNiOY307P1kxp3gPPny0o/1RL2P3GJj7TM7VQZt/A
         Ro82Vt3kilxoab6+EO3QDOgGJmzdqaFKtYvyap39KT+wv9Df/kUItCGVOHJSYxs5yDeZ
         jl4Uok9TACCzTPJdx/GemIelzOtLXmW9Uh82HAU6D6+Fk9/BWqDmYKam6xyiuR0EV0M1
         hLqA==
X-Gm-Message-State: AC+VfDwY4SL7MRphhTBDxRUon4vtXz0VOqUZhncshmgq3Al3p0x2Pytl
	pH3Xw/1bdpMiRU3LlK2olpYDVrn0QFY=
X-Google-Smtp-Source: ACHHUZ7TimMsdAbpm0H3DqxemdkIuAkhGHrNrlEVXRU2HF3wHvtYSeZ0Cu9HeaZ4/WwBIRWhxWo4Bg==
X-Received: by 2002:a17:907:3fa5:b0:966:180f:d10c with SMTP id hr37-20020a1709073fa500b00966180fd10cmr17205407ejc.33.1683751430891;
        Wed, 10 May 2023 13:43:50 -0700 (PDT)
Received: from [10.102.4.150] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id mc27-20020a170906eb5b00b00966330021e9sm3069747ejb.47.2023.05.10.13.43.49
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 13:43:50 -0700 (PDT)
Message-ID: <c11eed5d-2824-bfbd-745f-5849d5acdfbb@gmail.com>
Date: Wed, 10 May 2023 13:43:48 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/1] Fix wiphy regdom logic
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20230510204153.715304-1-prestwoj@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20230510204153.715304-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, something got screwed up and included additional patches. Please 
disregard.

On 5/10/23 1:41 PM, James Prestwood wrote:
> Below are some logs when this behavior was seen. IWD never
> transitions out of the ft-roaming state due to the key setting
> callbacks never being called. Its hard to know exactly what
> messages were sent/received since its coming from iwmon but
> netlink appears to completely lock up until a watchdog restarts
> the IWD service.
> 
> After the patch was applied there were zero instances of this
> behavior which seems to indicate the kernel is unable to handle
> multiple GET_WIPHY calls.
> 
> May 10 00:11:54 iwd[336880]: src/station.c:station_try_next_transition() 14, target aa:46:8d:1c:16:e6
> May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 14498
> May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 14499
> May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_done() Work item 14497 done
> May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_next() Starting work item 14498
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
> May 10 00:11:54 iwd[336880]: src/ft.c:ft_send_authenticate()
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
> May 10 00:11:54 kernel: wlan0: disconnect from AP aa:46:8d:1c:17:25 for new assoc to aa:46:8d:1c:16:e6
> May 10 00:11:54 locus[917]: State changed to roaming
> May 10 00:11:54 locus[917]: Start 10000ms timeout waiting for connected/roaming
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on Channel(56)
> May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_done() Work item 14498 done
> May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_radio_work_next() Starting work item 14499
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_cqm_rssi_update()
> May 10 00:11:54 iwd[336880]: src/station.c:station_enter_state() Old State: connected, new state: ft-roaming
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Frame Wait Cancel(67)
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_deauthenticate_event()
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_disconnect_event()
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
> May 10 00:11:54 kernel: wlan0: associate with aa:46:8d:1c:16:e6 (try 1/3)
> May 10 00:11:54 kernel: wlan0: RX ReassocResp from aa:46:8d:1c:16:e6 (capab=0x1511 status=0 aid=7)
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
> May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is XX
> May 10 00:11:54 systemd-networkd[393]: wlan0: Lost carrier
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_associate_event()
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_set_gtk() ifindex=14 key_idx=2
> May 10 00:11:54 iwd[336880]: src/station.c:station_handshake_event() Setting keys
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_set_tk() ifindex=14 key_idx=0
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_connect_event()
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_connect_event() aborting and ignore_connect_event not set, proceed
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_connect_event() expect_connect_failure not set, proceed
> May 10 00:11:54 iwd[336880]: src/netdev.c:parse_request_ies()
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_connect_event() Request / Response IEs parsed
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_get_oci()
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
> May 10 00:11:54 iwd[336880]: src/netdev.c:netdev_link_notify() event 16 on ifindex 14
> May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is US
> May 10 00:11:54 iwd[336880]: src/wiphy.c:wiphy_cancel_last_dump() Canceling pending regdom wiphy dump (global)
> May 10 00:11:54 kernel: wlan0: associated
> May 10 00:11:54 kernel: ath: EEPROM regdomain: 0x8348
> May 10 00:11:54 kernel: ath: EEPROM indicates we should expect a country code
> May 10 00:11:54 kernel: ath: doing EEPROM country->regdmn map search
> May 10 00:11:54 kernel: ath: country maps to regdmn code: 0x3a
> May 10 00:11:54 kernel: ath: Country alpha2 being used: US
> May 10 00:11:54 kernel: ath: Regpair used: 0x3a
> May 10 00:11:54 kernel: ath: regdomain 0x8348 dynamically updated by country element
> May 10 00:11:55 iwd[336880]: src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
> May 10 00:11:55 iwd[336880]: src/netdev.c:netdev_cqm_event() Signal change event (above=0 signal=-76)
> 
> --- Nothing here for 10 seconds, until the watchdog triggers ---
> 
> May 10 00:12:04 locus[917]: IWD watchdog triggered (reason=state)
> May 10 00:12:04 iwd[336880]: Terminate
> May 10 00:12:04 iwd[336880]: src/netdev.c:netdev_free() Freeing netdev wlan0[14]
> May 10 00:12:04 iwd[336880]: src/device.c:device_free()
> May 10 00:12:04 iwd[336880]: src/station.c:station_free()
> May 10 00:12:04 iwd[336880]: src/netconfig.c:netconfig_destroy()
> May 10 00:12:04 iwd[336880]: src/netconfig.c:netconfig_event_handler() l_netconfig event 2
> May 10 00:12:04 iwd[336880]: src/netconfig-commit.c:netconfig_commit_print_addrs() removing address: 10.193.158.118
> May 10 00:12:04 iwd[336880]: src/resolve.c:resolve_systemd_revert() ifindex: 14
> May 10 00:12:04 systemd[1]: Stopping Wireless service...
> 
> The iwmon logs are lengthy, but I've included the bit where the
> logs abruptly stop for 10 seconds until the watchdog kicks in.
> Prior there was no key setting or anything connection related
> after the connect event.
> 
> May 10 00:11:55:     Extended Capabilities: len 8
> May 10 00:11:55:         Capability: bit  2: Extended channel switching
> May 10 00:11:55:         Capability: bit 62: Opmode Notification
> May 10 00:11:55:     Extended Capabilities Mask: 170 len 8
> May 10 00:12:04:         04 00 00 00 00 00 00 40                          .......@
> May 10 00:12:04:     VHT Capability Mask: 176 len 12
> May 10 00:12:04:         f0 1f 80 33 ff ff 00 00 ff ff 00 00              ...3........
> May 10 00:12:04:     MAC Address 00:0E:8E:A3:02:FE
> May 10 00:12:04: > Result: New Wiphy (0x03) len 36 [multi]                     1683677515.942843
> May 10 00:12:04:     Wiphy: 0 (0x00000000)
> May 10 00:12:04:     Wiphy Name: phy0
> May 10 00:12:04:     Generation: 1 (0x00000001)
> May 10 00:12:04:     Max AP Assoc Station: 202 len 4
> May 10 00:12:04:         20 00 00 00
> 
> James Prestwood (1):
>    wiphy: fix regdom change wiphy dump logic
> 
>   src/wiphy.c | 103 +++++++++++++++++++++++++++-------------------------
>   1 file changed, 54 insertions(+), 49 deletions(-)
> 
