Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC0620
	for <iwd@lists.linux.dev>; Wed, 31 Aug 2022 01:18:15 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id 76so13024643pfy.3
        for <iwd@lists.linux.dev>; Tue, 30 Aug 2022 18:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6ZqYA5KKgGcbeeaQIK/1XVS/C7exTtVg9ljcYVkMmqU=;
        b=ElkE5T7LGnbk8pp4D7wkuIwFqTiR8/GEYPTkB8jCOnyda2ABfGNqmgedTkiY1qWOjb
         1SaAT2TjFx4o2ik1moh1+LjTA/RKZ6ZdnBRvh0nNP3L2FRPnNhxZzdMspmcpatacQN9e
         2Vx+gRNrJdNhxbSHpMkuMzHg8Oxfvu9Ne6LcFKFzxlbSHKP7tA2Hfsn1I/TTPsaIalla
         /FSMx6M1IfkGgbnywBwdMDFeJAiSNqN+iih54OPOpUjbx6lrvfbHJDmuNEv52DN28NWJ
         npLVOwP3HWQmI3jR5HOk5KmF0qQVh6quC+spHg4Xcr2Ez9XA4Yolo8+JSDYd4jpgQdoU
         3SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6ZqYA5KKgGcbeeaQIK/1XVS/C7exTtVg9ljcYVkMmqU=;
        b=vcc8bM8x44HBDBfpW991+zjEcH+2cxeNKlfPgdh7g5t+wxAEcUOEk835v5kUxspiiO
         6axjVlTwwyid8TDttJ5n/uIqeVxAuZsu1l5WqsErmCxRg9B/v3KfN1DMsRZ07s8qQA72
         PyeuuDtCp7ox06FgJZRr5RdCMh8e3H1iWwJPrYWjDVeD/yI8tOjgCEBXx7iGLWiY+AD9
         J5WTmJNyJmDPKARE9Mjq8aG1yikwCgUlVoVGZdiEyYqN2Cn4aRZU1BB1bYw2dRvhrFAv
         OsQJVaO+gFiSzu+sv9VkP+0KO6wwToSQMbwPS+XOmEihj8t4GuTCFhm9d8G53Ge+ZGPi
         tl8w==
X-Gm-Message-State: ACgBeo3flsQFW4S0pBzXFscQ+nXYJpW6F2POL8LF819fa9FPrBAjGP0j
	O7qDGdcvQyG+9/7xtgiswA2XQixkoLB49A==
X-Google-Smtp-Source: AA6agR7crBLg2/oE1H8qtcVFkynLWEmWEuO/pAUyQTPSnYh9ulXfT2E0FCu6AYxCuoSslOWgWg2bAg==
X-Received: by 2002:a65:46c4:0:b0:41d:e36b:1e59 with SMTP id n4-20020a6546c4000000b0041de36b1e59mr19802467pgr.494.1661908694251;
        Tue, 30 Aug 2022 18:18:14 -0700 (PDT)
Received: from [192.168.5.119] (p200027.dc.mirai.ad.jp. [210.172.200.27])
        by smtp.gmail.com with ESMTPSA id jf9-20020a170903268900b00174f43129fbsm4043120plb.47.2022.08.30.18.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 18:18:13 -0700 (PDT)
Message-ID: <7fc91799-e030-fe90-44e9-c6490fbb6bb8@gmail.com>
Date: Wed, 31 Aug 2022 10:18:10 +0900
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Cannot turn on AP mode without any error message
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <2031ff9c-0fff-18f7-2ad7-860e2b51ee22@gmail.com>
 <f66462932dacecb2231bf356770165309c49beab.camel@gmail.com>
From: Chang Liu <goduck777@gmail.com>
In-Reply-To: <f66462932dacecb2231bf356770165309c49beab.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/31/22 7:53 AM, James Prestwood wrote:
> 
> I would still post the debug logs here, and the AP profile (with the
> password redacted if you wish). If you have the iwmon logs too, might
> as well include those.

Sure. The profile file is like

[Security]
Passphrase=aa223344

[IPv4]
Address=192.168.250.1
Gateway=192.168.250.1
Netmask=255.255.255.0
DNSList=8.8.8.8

The iwd debug log is

Wireless daemon version 1.28
src/main.c:main() Using configuration directory /etc/iwd
Loaded configuration from /etc/iwd/main.conf
src/storage.c:storage_create_dirs() Using state directory /var/lib/iwd
src/main.c:nl80211_appeared() Found nl80211 interface
src/module.c:iwd_modules_init()
src/wsc.c:wsc_init()
src/eap.c:__eap_method_enable()
src/eap-wsc.c:eap_wsc_init()
src/eap-md5.c:eap_md5_init()
src/eap-tls.c:eap_tls_init()
src/eap-ttls.c:eap_ttls_init()
src/eap-mschapv2.c:eap_mschapv2_init()
src/eap-sim.c:eap_sim_init()
src/eap-aka.c:eap_aka_prime_init()
src/eap-aka.c:eap_aka_init()
src/eap-peap.c:eap_peap_init()
src/eap-gtc.c:eap_gtc_init()
src/eap-pwd.c:eap_pwd_init()
src/manager.c:manager_wiphy_dump_callback() New wiphy phy0 added (0)
src/agent.c:agent_register() agent register called
src/agent.c:agent_register() agent :1.64 path /agent/13702
src/manager.c:manager_wiphy_dump_done()
src/manager.c:manager_filtered_wiphy_dump_done()
Wiphy: 0, Name: phy0
	Permanent Address: 9c:b6:d0:9a:5f:b7
	2.4Ghz Band:
		Bitrates (non-HT):
			 1.0 Mbps
			 2.0 Mbps
			 5.5 Mbps
			11.0 Mbps
			 6.0 Mbps
			 9.0 Mbps
			12.0 Mbps
			18.0 Mbps
			24.0 Mbps
			36.0 Mbps
			48.0 Mbps
			54.0 Mbps
		HT Capabilities:
			HT40
			Short GI for 20Mhz
			Short GI for 40Mhz
		HT RX MCS indexes:
			0-15
	5Ghz Band:
		Bitrates (non-HT):
			 6.0 Mbps
			 9.0 Mbps
			12.0 Mbps
			18.0 Mbps
			24.0 Mbps
			36.0 Mbps
			48.0 Mbps
			54.0 Mbps
		HT Capabilities:
			HT40
			Short GI for 20Mhz
			Short GI for 40Mhz
		HT RX MCS indexes:
			0-15
		VHT Capabilities:
			Short GI for 80Mhz
			Max RX MCS: 0-9 for NSS: 2
			Max TX MCS: 0-9 for NSS: 2
	Ciphers: CCMP TKIP BIP
	Supported iftypes: ad-hoc station ap p2p-client p2p-go p2p-device
src/manager.c:manager_interface_dump_done()
src/manager.c:manager_create_interfaces() creating wlan0
src/manager.c:manager_create_interfaces() creating wlan0-p2p
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for 
phy0 is 99
src/manager.c:manager_config_notify() Notification of command New 
Interface(7)
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/manager.c:manager_new_station_interface_cb()
src/netdev.c:netdev_create_from_genl() Created interface wlan0[8 8]
src/manager.c:manager_config_notify() Notification of command New 
Interface(7)
src/manager.c:manager_new_p2p_interface_cb()
src/p2p.c:p2p_device_update_from_genl() Created P2P device 9
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/netdev.c:netdev_set_4addr() netdev: 8 use_4addr: 0
src/netdev.c:netdev_initial_up_cb() Interface 8 initialized
src/netconfig.c:netconfig_new() Starting netconfig for interface: 8
src/rrm.c:rrm_add_frame_watches()
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/manager.c:manager_config_notify() Notification of command Set 
Interface(6)
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/station.c:station_free()
src/netconfig.c:netconfig_destroy()
src/station.c:station_roam_state_clear() 8
src/netdev.c:netdev_set_interface_event() Interface type changed from 
station to ap
src/manager.c:manager_config_notify() Notification of command Set 
Interface(6)
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
Terminate
src/agent.c:release_agent() send Release to :1.64 /agent/13702
src/agent.c:agent_free() agent free 0x55b1ae22ab70
src/netdev.c:netdev_free() Freeing netdev wlan0[8]
src/device.c:device_free()
Removing scan context for wdev 8
src/scan.c:scan_context_free() sc: 0x55b1ae228e40
src/netdev.c:netdev_link_notify() event 16 on ifindex 8
src/netdev.c:netdev_mlme_notify() MLME notification Stop AP(16)
src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for 
(global) is XX

The output of iwmon is

Wireless monitor ver 1.28
Created interface nlmon
< Request: Get Wiphy (0x01) len 4 [ack,0x300] 
1661908449.681011
     Split Wiphy Dump: true
 > Result: New Wiphy (0x03) len 120 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Retry Short: 7 (0x07)
     Wiphy Retry Long: 4 (0x04)
     Wiphy Frag Threshold: 4294967295 (0xffffffff)
     Wiphy RTS Threshold: 4294967295 (0xffffffff)
     Wiphy Coverage Class: 0 (0x00)
     Max Number Scan SSIDs: 16 (0x10)
     Max Num Sched Scan SSIDs: 16 (0x10)
     Max Scan IE Length: 195 (0x00c3)
     Max Sched Scan IE Len: 256 (0x0100)
     Max Match Sets: 16 (0x10)
     Support IBSS RSN: true
     Support Mesh Auth: true
     Support AP UAPSD: true
 > Result: New Wiphy (0x03) len 116 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Cipher Suites:
         WEP-40 (00:0f:ac) suite  01
         WEP-104 (00:0f:ac) suite  05
         TKIP (00:0f:ac) suite  02
         CCMP (00:0f:ac) suite  04
         BIP (00:0f:ac) suite  06
         IEEE 802.11 (00:0f:ac) suite  0d (vendor specific)
         IEEE 802.11 (00:0f:ac) suite  0b (vendor specific)
         IEEE 802.11 (00:0f:ac) suite  0c (vendor specific)
     Max Number PMKIDs: 0 (0x00)
     Reserved: len 0
     Wiphy Antenna Avail TX: len 4
         03 00 00 00                                      ....
     Wiphy Antenna Avail RX: len 4
         03 00 00 00                                      ....
     Probe Response Offload: len 4
         07 00 00 00                                      ....
     Wiphy Antenna TX: 3 (0x00000003)
     Wiphy Antenna RX: 3 (0x00000003)
 > Result: New Wiphy (0x03) len 64 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Supported Interface Types: len 32
         Ad-hoc: true
         Station: true
         AP: true
         Monitor: true
         Mesh-point: true
         P2P-Client: true
         P2P-GO: true
         P2P-Device: true
 > Result: New Wiphy (0x03) len 240 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 208
         Band 0: len 204
             HT MCS Set: MCS 0
             HT MCS Set: MCS 1
             HT MCS Set: MCS 2
             HT MCS Set: MCS 3
             HT MCS Set: MCS 4
             HT MCS Set: MCS 5
             HT MCS Set: MCS 6
             HT MCS Set: MCS 7
             HT MCS Set: MCS 8
             HT MCS Set: MCS 9
             HT MCS Set: MCS 10
             HT MCS Set: MCS 11
             HT MCS Set: MCS 12
             HT MCS Set: MCS 13
             HT MCS Set: MCS 14
             HT MCS Set: MCS 15
             MCS Set: bit 96: Tx MCS set defined
             HT Capabilities Info: bit  0: LDPC Coding Capability
             HT Capabilities Info: bit  1: Supported Channel Width Set
             HT Capabilities Info: bits 2-3: Disabled
             HT Capabilities Info: bit  5: Short GI for 20Mhz
             HT Capabilities Info: bit  6: Short GI for 40Mhz
             HT Capabilities Info: bit  7: Tx STBC
             HT Capabilities Info: bits 8-9: One spatial stream
             HT Capabilities Info: bit 11: Maximum A-MSDU Length
             HT Capabilities Info: bit 12: DSSS/CCK Mode in 40Mhz
             AMPDU Factor: len 1
                 03                                               . 

             AMPDU Density: len 1
                 06                                               . 

             Rates: len 156
                 Bitrate 0: len 8
                     Bitrate (100kbps multiple): 10 (0x0000000a)
                 Bitrate 1: len 12
                     Bitrate (100kbps multiple): 20 (0x00000014)
                     2GHZ Short Preamble: true
                 Bitrate 2: len 12
                     Bitrate (100kbps multiple): 55 (0x00000037)
                     2GHZ Short Preamble: true
                 Bitrate 3: len 12
                     Bitrate (100kbps multiple): 110 (0x0000006e)
                     2GHZ Short Preamble: true
                 Bitrate 4: len 8
                     Bitrate (100kbps multiple): 60 (0x0000003c)
                 Bitrate 5: len 8
                     Bitrate (100kbps multiple): 90 (0x0000005a)
                 Bitrate 6: len 8
                     Bitrate (100kbps multiple): 120 (0x00000078)
                 Bitrate 7: len 8
                     Bitrate (100kbps multiple): 180 (0x000000b4)
                 Bitrate 8: len 8
                     Bitrate (100kbps multiple): 240 (0x000000f0)
                 Bitrate 9: len 8
                     Bitrate (100kbps multiple): 360 (0x00000168)
                 Bitrate 10: len 8
                     Bitrate (100kbps multiple): 480 (0x000001e0)
                 Bitrate 11: len 8
                     Bitrate (100kbps multiple): 540 (0x0000021c)
 > Result: New Wiphy (0x03) len 76 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 44
         Band 0: len 40
             Frequencies: len 36
                 Frequency 0: len 32
                     Frequency: 2412 (0x0000096c)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 76 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 44
         Band 0: len 40
             Frequencies: len 36
                 Frequency 1: len 32
                     Frequency: 2417 (0x00000971)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 76 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 44
         Band 0: len 40
             Frequencies: len 36
                 Frequency 2: len 32
                     Frequency: 2422 (0x00000976)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 76 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 44
         Band 0: len 40
             Frequencies: len 36
                 Frequency 3: len 32
                     Frequency: 2427 (0x0000097b)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 76 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 44
         Band 0: len 40
             Frequencies: len 36
                 Frequency 4: len 32
                     Frequency: 2432 (0x00000980)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 76 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 44
         Band 0: len 40
             Frequencies: len 36
                 Frequency 5: len 32
                     Frequency: 2437 (0x00000985)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 76 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 44
         Band 0: len 40
             Frequencies: len 36
                 Frequency 6: len 32
                     Frequency: 2442 (0x0000098a)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 76 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 44
         Band 0: len 40
             Frequencies: len 36
                 Frequency 7: len 32
                     Frequency: 2447 (0x0000098f)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 76 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 44
         Band 0: len 40
             Frequencies: len 36
                 Frequency 8: len 32
                     Frequency: 2452 (0x00000994)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 76 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 44
         Band 0: len 40
             Frequencies: len 36
                 Frequency 9: len 32
                     Frequency: 2457 (0x00000999)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 76 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 44
         Band 0: len 40
             Frequencies: len 36
                 Frequency 10: len 32
                     Frequency: 2462 (0x0000099e)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 84 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 52
         Band 0: len 48
             Frequencies: len 44
                 Frequency 11: len 40
                     Frequency: 2467 (0x000009a3)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 84 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 52
         Band 0: len 48
             Frequencies: len 44
                 Frequency 12: len 40
                     Frequency: 2472 (0x000009a8)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 80 Mhz: true
                     No 160 Mhz: true
                     Max TX Power: 2000 (0x000007d0)
 > Result: New Wiphy (0x03) len 72 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 40
         Band 0: len 36
             Frequencies: len 32
                 Frequency 13: len 28
                     Frequency: 2484 (0x000009b4)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     Disabled: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 40 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 8
         Band 0: len 4
             Frequencies: len 0
 > Result: New Wiphy (0x03) len 200 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 168
         Band 1: len 164
             HT MCS Set: MCS 0
             HT MCS Set: MCS 1
             HT MCS Set: MCS 2
             HT MCS Set: MCS 3
             HT MCS Set: MCS 4
             HT MCS Set: MCS 5
             HT MCS Set: MCS 6
             HT MCS Set: MCS 7
             HT MCS Set: MCS 8
             HT MCS Set: MCS 9
             HT MCS Set: MCS 10
             HT MCS Set: MCS 11
             HT MCS Set: MCS 12
             HT MCS Set: MCS 13
             HT MCS Set: MCS 14
             HT MCS Set: MCS 15
             MCS Set: bit 96: Tx MCS set defined
             HT Capabilities Info: bit  0: LDPC Coding Capability
             HT Capabilities Info: bit  1: Supported Channel Width Set
             HT Capabilities Info: bits 2-3: Disabled
             HT Capabilities Info: bit  5: Short GI for 20Mhz
             HT Capabilities Info: bit  6: Short GI for 40Mhz
             HT Capabilities Info: bit  7: Tx STBC
             HT Capabilities Info: bits 8-9: One spatial stream
             HT Capabilities Info: bit 11: Maximum A-MSDU Length
             HT Capabilities Info: bit 12: DSSS/CCK Mode in 40Mhz
             AMPDU Factor: len 1
                 03                                               . 

             AMPDU Density: len 1
                 06                                               . 

             VHT MCS Set: len 8
                 fa ff 00 00 fa ff 00 00 
........
             VHT Capabilities: len 4
                 b2 71 90 33                                      .q.3 

             Rates: len 96
                 Bitrate 0: len 8
                     Bitrate (100kbps multiple): 60 (0x0000003c)
                 Bitrate 1: len 8
                     Bitrate (100kbps multiple): 90 (0x0000005a)
                 Bitrate 2: len 8
                     Bitrate (100kbps multiple): 120 (0x00000078)
                 Bitrate 3: len 8
                     Bitrate (100kbps multiple): 180 (0x000000b4)
                 Bitrate 4: len 8
                     Bitrate (100kbps multiple): 240 (0x000000f0)
                 Bitrate 5: len 8
                     Bitrate (100kbps multiple): 360 (0x00000168)
                 Bitrate 6: len 8
                     Bitrate (100kbps multiple): 480 (0x000001e0)
                 Bitrate 7: len 8
                     Bitrate (100kbps multiple): 540 (0x0000021c)
 > Result: New Wiphy (0x03) len 80 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 48
         Band 1: len 44
             Frequencies: len 40
                 Frequency 0: len 36
                     Frequency: 5180 (0x0000143c)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 80 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 48
         Band 1: len 44
             Frequencies: len 40
                 Frequency 1: len 36
                     Frequency: 5200 (0x00001450)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 80 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 48
         Band 1: len 44
             Frequencies: len 40
                 Frequency 2: len 36
                     Frequency: 5220 (0x00001464)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 80 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 48
         Band 1: len 44
             Frequencies: len 40
                 Frequency 3: len 36
                     Frequency: 5240 (0x00001478)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 4: len 64
                     Frequency: 5260 (0x0000148c)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 5: len 64
                     Frequency: 5280 (0x000014a0)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 6: len 64
                     Frequency: 5300 (0x000014b4)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 7: len 64
                     Frequency: 5320 (0x000014c8)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 8: len 64
                     Frequency: 5500 (0x0000157c)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 9: len 64
                     Frequency: 5520 (0x00001590)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 10: len 64
                     Frequency: 5540 (0x000015a4)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 11: len 64
                     Frequency: 5560 (0x000015b8)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 12: len 64
                     Frequency: 5580 (0x000015cc)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 13: len 64
                     Frequency: 5600 (0x000015e0)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 14: len 64
                     Frequency: 5620 (0x000015f4)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 15: len 64
                     Frequency: 5640 (0x00001608)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 16: len 64
                     Frequency: 5660 (0x0000161c)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 17: len 64
                     Frequency: 5680 (0x00001630)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 108 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 76
         Band 1: len 72
             Frequencies: len 68
                 Frequency 18: len 64
                     Frequency: 5700 (0x00001644)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     Radar Detection: true
                     DFS State: 0 (0x00000000)
                     DFS Time: 676689 (0x000a5351)
                     DFS CAC Time: 0 (0x00000000)
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 80 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 48
         Band 1: len 44
             Frequencies: len 40
                 Frequency 19: len 36
                     Frequency: 5720 (0x00001658)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 80 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 48
         Band 1: len 44
             Frequencies: len 40
                 Frequency 20: len 36
                     Frequency: 5745 (0x00001671)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 80 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 48
         Band 1: len 44
             Frequencies: len 40
                 Frequency 21: len 36
                     Frequency: 5765 (0x00001685)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 80 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 48
         Band 1: len 44
             Frequencies: len 40
                 Frequency 22: len 36
                     Frequency: 5785 (0x00001699)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 80 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 48
         Band 1: len 44
             Frequencies: len 40
                 Frequency 23: len 36
                     Frequency: 5805 (0x000016ad)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 80 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 48
         Band 1: len 44
             Frequencies: len 40
                 Frequency 24: len 36
                     Frequency: 5825 (0x000016c1)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 80 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 48
         Band 1: len 44
             Frequencies: len 40
                 Frequency 25: len 36
                     Frequency: 5845 (0x000016d5)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     No IR: true
                     No IBSS: true
                     No 160 Mhz: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 72 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 40
         Band 1: len 36
             Frequencies: len 32
                 Frequency 26: len 28
                     Frequency: 5865 (0x000016e9)
                     Reserved: len 4
                         00 00 00 00 
  ....
                     Disabled: true
                     Max TX Power: 3000 (0x00000bb8)
 > Result: New Wiphy (0x03) len 40 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 8
         Band 1: len 4
             Frequencies: len 0
 > Result: New Wiphy (0x03) len 32 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Bands: len 0
 > Result: New Wiphy (0x03) len 280 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Supported Commands:
         New Interface [7]
         Set Interface [6]
         New Key [11]
         Start AP [15]
         New Station [19]
         New Mesh Path [23]
         Set Mesh Config [29]
         Set BSS [25]
         Authenticate [37]
         Associate [38]
         Deauthenticate [39]
         Disassociate [40]
         Join IBSS [43]
         Join Mesh [68]
         Remain on Channel [55]
         Set TX Bitrate Mask [57]
         Frame [59]
         Frame Wait Cancel [67]
         Set Wiphy Netns [49]
         Set Channel [65]
         Probe Client [84]
         Set NoAck Map [87]
         Register Beacons [85]
         Start P2P Device [89]
         Set Mcast Rate [92]
         Connect [46]
         Disconnect [48]
         Channel Switch [102]
         Set QoS Map [104]
         Set Multicast to Unicast [121]
         Unknown [140]
 > Result: New Wiphy (0x03) len 40 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Max Remain on Channel Duration : 5000 (0x00001388)
     Offchannel TX OK: true
 > Result: New Wiphy (0x03) len 68 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     WoWLAN Triggers Supported: len 36
         04 00 02 00 04 00 03 00 14 00 04 00 16 00 00 00  ................
         01 00 00 00 86 00 00 00 72 00 00 00 08 00 12 00  ........r.......
         10 00 00 00                                      ....
 > Result: New Wiphy (0x03) len 360 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Software Interface Types: len 4
         Monitor: true
     Interface Combinations: len 320
         70 00 01 00 4c 00 01 00 14 00 01 00 08 00 01 00  p...L...........
         02 00 00 00 08 00 02 00 04 00 02 00 20 00 02 00  ............ ...
         08 00 01 00 02 00 00 00 14 00 02 00 04 00 03 00  ................
         04 00 07 00 04 00 08 00 04 00 09 00 14 00 03 00  ................
         08 00 01 00 01 00 00 00 08 00 02 00 04 00 0a 00  ................
         08 00 04 00 01 00 00 00 08 00 02 00 04 00 00 00  ................
         08 00 05 00 00 00 00 00 08 00 06 00 00 00 00 00  ................
         80 00 02 00 5c 00 01 00 14 00 01 00 08 00 01 00  ....\...........
         02 00 00 00 08 00 02 00 04 00 02 00 14 00 02 00  ................
         08 00 01 00 02 00 00 00 08 00 02 00 04 00 08 00  ................
         1c 00 03 00 08 00 01 00 01 00 00 00 10 00 02 00  ................
         04 00 03 00 04 00 07 00 04 00 09 00 14 00 04 00  ................
         08 00 01 00 01 00 00 00 08 00 02 00 04 00 0a 00  ................
         08 00 04 00 02 00 00 00 08 00 02 00 04 00 00 00  ................
         08 00 05 00 00 00 00 00 08 00 06 00 00 00 00 00  ................
         50 00 03 00 2c 00 01 00 14 00 01 00 08 00 01 00  P...,...........
         01 00 00 00 08 00 02 00 04 00 02 00 14 00 02 00  ................
         08 00 01 00 01 00 00 00 08 00 02 00 04 00 01 00  ................
         08 00 04 00 01 00 00 00 08 00 02 00 02 00 00 00  ................
         08 00 05 00 00 00 00 00 08 00 06 00 00 00 00 00  ................
 > Result: New Wiphy (0x03) len 68 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Feature Flags: len 4
         a3 c3 05 a9                                      ....
     HT Capability Mask: len 26
         e3 4b 1f ff ff ff ff ff ff ff ff ff ff 00 00 00  .K..............
         00 00 00 00 00 00 00 00 00 00                    ..........
 > Result: New Wiphy (0x03) len 1520 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     TX Frame Types: len 1076
         Reserved: len 0
         Ad-hoc: len 128
             Frame Type: 0x0000
                 Type: Management (0)
                 Subtype: Association request (0)
             Frame Type: 0x0010
                 Type: Management (0)
                 Subtype: Association response (1)
             Frame Type: 0x0020
                 Type: Management (0)
                 Subtype: Reassociation request (2)
             Frame Type: 0x0030
                 Type: Management (0)
                 Subtype: Reassociation response (3)
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x0050
                 Type: Management (0)
                 Subtype: Probe response (5)
             Frame Type: 0x0060
                 Type: Management (0)
                 Subtype: Timing Advertisement (6)
             Frame Type: 0x0070
                 Type: Management (0)
                 Subtype: Reserved (7)
             Frame Type: 0x0080
                 Type: Management (0)
                 Subtype: Beacon (8)
             Frame Type: 0x0090
                 Type: Management (0)
                 Subtype: ATIM (9)
             Frame Type: 0x00a0
                 Type: Management (0)
                 Subtype: Disassociation (10)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
             Frame Type: 0x00e0
                 Type: Management (0)
                 Subtype: Action No Ack (14)
             Frame Type: 0x00f0
                 Type: Management (0)
                 Subtype: Reserved (15)
         Station: len 128
             Frame Type: 0x0000
                 Type: Management (0)
                 Subtype: Association request (0)
             Frame Type: 0x0010
                 Type: Management (0)
                 Subtype: Association response (1)
             Frame Type: 0x0020
                 Type: Management (0)
                 Subtype: Reassociation request (2)
             Frame Type: 0x0030
                 Type: Management (0)
                 Subtype: Reassociation response (3)
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x0050
                 Type: Management (0)
                 Subtype: Probe response (5)
             Frame Type: 0x0060
                 Type: Management (0)
                 Subtype: Timing Advertisement (6)
             Frame Type: 0x0070
                 Type: Management (0)
                 Subtype: Reserved (7)
             Frame Type: 0x0080
                 Type: Management (0)
                 Subtype: Beacon (8)
             Frame Type: 0x0090
                 Type: Management (0)
                 Subtype: ATIM (9)
             Frame Type: 0x00a0
                 Type: Management (0)
                 Subtype: Disassociation (10)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
             Frame Type: 0x00e0
                 Type: Management (0)
                 Subtype: Action No Ack (14)
             Frame Type: 0x00f0
                 Type: Management (0)
                 Subtype: Reserved (15)
         AP: len 128
             Frame Type: 0x0000
                 Type: Management (0)
                 Subtype: Association request (0)
             Frame Type: 0x0010
                 Type: Management (0)
                 Subtype: Association response (1)
             Frame Type: 0x0020
                 Type: Management (0)
                 Subtype: Reassociation request (2)
             Frame Type: 0x0030
                 Type: Management (0)
                 Subtype: Reassociation response (3)
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x0050
                 Type: Management (0)
                 Subtype: Probe response (5)
             Frame Type: 0x0060
                 Type: Management (0)
                 Subtype: Timing Advertisement (6)
             Frame Type: 0x0070
                 Type: Management (0)
                 Subtype: Reserved (7)
             Frame Type: 0x0080
                 Type: Management (0)
                 Subtype: Beacon (8)
             Frame Type: 0x0090
                 Type: Management (0)
                 Subtype: ATIM (9)
             Frame Type: 0x00a0
                 Type: Management (0)
                 Subtype: Disassociation (10)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
             Frame Type: 0x00e0
                 Type: Management (0)
                 Subtype: Action No Ack (14)
             Frame Type: 0x00f0
                 Type: Management (0)
                 Subtype: Reserved (15)
         AP-VLAN: len 128
             Frame Type: 0x0000
                 Type: Management (0)
                 Subtype: Association request (0)
             Frame Type: 0x0010
                 Type: Management (0)
                 Subtype: Association response (1)
             Frame Type: 0x0020
                 Type: Management (0)
                 Subtype: Reassociation request (2)
             Frame Type: 0x0030
                 Type: Management (0)
                 Subtype: Reassociation response (3)
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x0050
                 Type: Management (0)
                 Subtype: Probe response (5)
             Frame Type: 0x0060
                 Type: Management (0)
                 Subtype: Timing Advertisement (6)
             Frame Type: 0x0070
                 Type: Management (0)
                 Subtype: Reserved (7)
             Frame Type: 0x0080
                 Type: Management (0)
                 Subtype: Beacon (8)
             Frame Type: 0x0090
                 Type: Management (0)
                 Subtype: ATIM (9)
             Frame Type: 0x00a0
                 Type: Management (0)
                 Subtype: Disassociation (10)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
             Frame Type: 0x00e0
                 Type: Management (0)
                 Subtype: Action No Ack (14)
             Frame Type: 0x00f0
                 Type: Management (0)
                 Subtype: Reserved (15)
         WDS: len 0
         Monitor: len 0
         Mesh-point: len 128
             Frame Type: 0x0000
                 Type: Management (0)
                 Subtype: Association request (0)
             Frame Type: 0x0010
                 Type: Management (0)
                 Subtype: Association response (1)
             Frame Type: 0x0020
                 Type: Management (0)
                 Subtype: Reassociation request (2)
             Frame Type: 0x0030
                 Type: Management (0)
                 Subtype: Reassociation response (3)
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x0050
                 Type: Management (0)
                 Subtype: Probe response (5)
             Frame Type: 0x0060
                 Type: Management (0)
                 Subtype: Timing Advertisement (6)
             Frame Type: 0x0070
                 Type: Management (0)
                 Subtype: Reserved (7)
             Frame Type: 0x0080
                 Type: Management (0)
                 Subtype: Beacon (8)
             Frame Type: 0x0090
                 Type: Management (0)
                 Subtype: ATIM (9)
             Frame Type: 0x00a0
                 Type: Management (0)
                 Subtype: Disassociation (10)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
             Frame Type: 0x00e0
                 Type: Management (0)
                 Subtype: Action No Ack (14)
             Frame Type: 0x00f0
                 Type: Management (0)
                 Subtype: Reserved (15)
         P2P-Client: len 128
             Frame Type: 0x0000
                 Type: Management (0)
                 Subtype: Association request (0)
             Frame Type: 0x0010
                 Type: Management (0)
                 Subtype: Association response (1)
             Frame Type: 0x0020
                 Type: Management (0)
                 Subtype: Reassociation request (2)
             Frame Type: 0x0030
                 Type: Management (0)
                 Subtype: Reassociation response (3)
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x0050
                 Type: Management (0)
                 Subtype: Probe response (5)
             Frame Type: 0x0060
                 Type: Management (0)
                 Subtype: Timing Advertisement (6)
             Frame Type: 0x0070
                 Type: Management (0)
                 Subtype: Reserved (7)
             Frame Type: 0x0080
                 Type: Management (0)
                 Subtype: Beacon (8)
             Frame Type: 0x0090
                 Type: Management (0)
                 Subtype: ATIM (9)
             Frame Type: 0x00a0
                 Type: Management (0)
                 Subtype: Disassociation (10)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
             Frame Type: 0x00e0
                 Type: Management (0)
                 Subtype: Action No Ack (14)
             Frame Type: 0x00f0
                 Type: Management (0)
                 Subtype: Reserved (15)
         P2P-GO: len 128
             Frame Type: 0x0000
                 Type: Management (0)
                 Subtype: Association request (0)
             Frame Type: 0x0010
                 Type: Management (0)
                 Subtype: Association response (1)
             Frame Type: 0x0020
                 Type: Management (0)
                 Subtype: Reassociation request (2)
             Frame Type: 0x0030
                 Type: Management (0)
                 Subtype: Reassociation response (3)
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x0050
                 Type: Management (0)
                 Subtype: Probe response (5)
             Frame Type: 0x0060
                 Type: Management (0)
                 Subtype: Timing Advertisement (6)
             Frame Type: 0x0070
                 Type: Management (0)
                 Subtype: Reserved (7)
             Frame Type: 0x0080
                 Type: Management (0)
                 Subtype: Beacon (8)
             Frame Type: 0x0090
                 Type: Management (0)
                 Subtype: ATIM (9)
             Frame Type: 0x00a0
                 Type: Management (0)
                 Subtype: Disassociation (10)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
             Frame Type: 0x00e0
                 Type: Management (0)
                 Subtype: Action No Ack (14)
             Frame Type: 0x00f0
                 Type: Management (0)
                 Subtype: Reserved (15)
         P2P-Device: len 128
             Frame Type: 0x0000
                 Type: Management (0)
                 Subtype: Association request (0)
             Frame Type: 0x0010
                 Type: Management (0)
                 Subtype: Association response (1)
             Frame Type: 0x0020
                 Type: Management (0)
                 Subtype: Reassociation request (2)
             Frame Type: 0x0030
                 Type: Management (0)
                 Subtype: Reassociation response (3)
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x0050
                 Type: Management (0)
                 Subtype: Probe response (5)
             Frame Type: 0x0060
                 Type: Management (0)
                 Subtype: Timing Advertisement (6)
             Frame Type: 0x0070
                 Type: Management (0)
                 Subtype: Reserved (7)
             Frame Type: 0x0080
                 Type: Management (0)
                 Subtype: Beacon (8)
             Frame Type: 0x0090
                 Type: Management (0)
                 Subtype: ATIM (9)
             Frame Type: 0x00a0
                 Type: Management (0)
                 Subtype: Disassociation (10)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
             Frame Type: 0x00e0
                 Type: Management (0)
                 Subtype: Action No Ack (14)
             Frame Type: 0x00f0
                 Type: Management (0)
                 Subtype: Reserved (15)
         Reserved: len 0
         Reserved: len 0
     RX Frame Types: len 332
         Reserved: len 0
         Ad-hoc: len 32
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
         Station: len 24
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
         AP: len 56
             Frame Type: 0x0000
                 Type: Management (0)
                 Subtype: Association request (0)
             Frame Type: 0x0020
                 Type: Management (0)
                 Subtype: Reassociation request (2)
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x00a0
                 Type: Management (0)
                 Subtype: Disassociation (10)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
         AP-VLAN: len 56
             Frame Type: 0x0000
                 Type: Management (0)
                 Subtype: Association request (0)
             Frame Type: 0x0020
                 Type: Management (0)
                 Subtype: Reassociation request (2)
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x00a0
                 Type: Management (0)
                 Subtype: Disassociation (10)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
         WDS: len 0
         Monitor: len 0
         Mesh-point: len 24
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
         P2P-Client: len 16
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
         P2P-GO: len 56
             Frame Type: 0x0000
                 Type: Management (0)
                 Subtype: Association request (0)
             Frame Type: 0x0020
                 Type: Management (0)
                 Subtype: Reassociation request (2)
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x00a0
                 Type: Management (0)
                 Subtype: Disassociation (10)
             Frame Type: 0x00b0
                 Type: Management (0)
                 Subtype: Authentication (11)
             Frame Type: 0x00c0
                 Type: Management (0)
                 Subtype: Deauthentication (12)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
         P2P-Device: len 16
             Frame Type: 0x0040
                 Type: Management (0)
                 Subtype: Probe request (4)
             Frame Type: 0x00d0
                 Type: Management (0)
                 Subtype: Action (13)
         Reserved: len 0
         Reserved: len 0
     Reserved: len 4
         02 00 00 00                                      ....
     Reserved: len 4
         20 1c 00 00                                       ...
     Reserved: len 4
         64 00 00 00                                      d...
     Extended Capabilities: len 8
         Capability: bit  2: Extended channel switching
         Capability: bit 62: Opmode Notification
     Extended Capabilities Mask: len 8
         04 00 00 00 00 00 00 40                          .......@
     VHT Capability Mask: len 12
         f0 1f 80 33 ff ff 00 00 ff ff 00 00              ...3........
     MAC Address 9C:B6:D0:9A:5F:B7
 > Result: New Wiphy (0x03) len 36 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Max AP Assoc Station: len 4
         20 00 00 00                                       ...
 > Result: New Wiphy (0x03) len 28 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
 > Result: New Wiphy (0x03) len 48 [multi] 
1661908449.681075
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Max CSA Counters: len 1
         02                                               .
     Extended Features:
         NL80211_EXT_FEATURE_VHT_IBSS
         NL80211_EXT_FEATURE_RRM
         NL80211_EXT_FEATURE_SET_SCAN_DWELL
         NL80211_EXT_FEATURE_FILS_STA
         NL80211_EXT_FEATURE_CQM_RSSI_LIST
         NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211
         NL80211_EXT_FEATURE_TXQS
         NL80211_EXT_FEATURE_AIRTIME_FAIRNESS
         NL80211_EXT_FEATURE_AQL
         NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH
         NL80211_EXT_FEATURE_DEL_IBSS_STA
         NL80211_EXT_FEATURE_SCAN_FREQ_KHZ
         NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS
 > Result: New Wiphy (0x03) len 112 [multi] 
1661908449.681160
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Reserved: len 4
         00 00 00 00                                      ....
     TXQ Stats: len 48
         08 00 01 00 00 00 00 00 08 00 02 00 00 00 00 00  ................
         08 00 06 00 00 00 00 00 08 00 07 00 00 00 00 00  ................
         08 00 08 00 00 00 00 00 08 00 0b 00 00 10 00 00  ................
     TXQ Limit: len 4
         00 20 00 00                                      . ..
     TXQ Memory Limit: len 4
         00 00 00 01                                      ....
     TXQ Quantum: len 4
         2c 01 00 00                                      ,...
 > Result: New Wiphy (0x03) len 28 [multi] 
1661908449.681160
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
 > Result: New Wiphy (0x03) len 28 [multi] 
1661908449.681160
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
 > Result: New Wiphy (0x03) len 84 [multi] 
1661908449.681160
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Reserved: len 52
         08 00 01 00 00 00 00 00 2c 00 02 80 14 00 01 80  ........,.......
         08 00 03 00 62 09 00 00 08 00 04 00 be 09 00 00  ....b...........
         14 00 02 80 08 00 03 00 32 14 00 00 08 00 04 00  ........2.......
         f3 16 00 00                                      ....
 > Complete: Get Wiphy (0x01) len 4 [multi] 
1661908449.681209
     Status: 0
< Request: Get Interface (0x05) len 0 [ack,0x300] 
1661908449.681465
 > Complete: Get Interface (0x05) len 4 [multi] 
1661908449.681468
     Status: 0
< Request: Get Reg (0x1f) len 8 [ack] 
1661908449.681504
     Wiphy: 0 (0x00000000)
 > Result: Get Reg (0x1f) len 260 
1661908449.681507
     Wiphy: 0 (0x00000000)
     Regulatory Alpha2: 99
     Regulatory Rules: len 240
         Rule 0: len 56
             Frequency Start: 2402 MHz
             Frequency End: 2472 MHz
             Frequency Range Max BW: 40 MHz
             Max Antenna Gain: 0 (0x00000000)
             Max EIRP: 2000 (0x000007d0)
             DFS CAC Time: 0 (0x00000000)
         Rule 1: len 56
             Flags: len 4
                 No IR
             Frequency Start: 2457 MHz
             Frequency End: 2482 MHz
             Frequency Range Max BW: 40 MHz
             Max Antenna Gain: 0 (0x00000000)
             Max EIRP: 2000 (0x000007d0)
             DFS CAC Time: 0 (0x00000000)
         Rule 2: len 56
             Flags: len 4
                 No IR
             Frequency Start: 5140 MHz
             Frequency End: 5360 MHz
             Frequency Range Max BW: 80 MHz
             Max Antenna Gain: 0 (0x00000000)
             Max EIRP: 3000 (0x00000bb8)
             DFS CAC Time: 0 (0x00000000)
         Rule 3: len 56
             Flags: len 4
                 No IR
             Frequency Start: 5460 MHz
             Frequency End: 5860 MHz
             Frequency Range Max BW: 80 MHz
             Max Antenna Gain: 0 (0x00000000)
             Max EIRP: 3000 (0x00000bb8)
             DFS CAC Time: 0 (0x00000000)
 > Response: Get Reg (0x1f) len 4 [0x100] 
1661908449.681508
     Status: Success (0)
< Request: New Interface (0x07) len 40 [ack] 
1661908449.681518
     Wiphy: 0 (0x00000000)
     Interface Type: 2 (0x00000002)
     Interface Name: wlan0
     4-Address: 0 (0x00)
     Socket Owns Interface/Connection: true
 > Event: New Interface (0x07) len 160 
1661908449.681722
     Interface Index: 13 (0x0000000d)
     Interface Name: wlan0
     Wiphy: 0 (0x00000000)
     Interface Type: 2 (0x00000002)
     Wireless Device: 12 (0x000000000000000c)
     MAC Address 9C:B6:D0:9A:5F:B7
     Generation: 19 (0x00000013)
     4-Address: 0 (0x00)
     Wiphy TX Power Level: 0 (0x00000000)
     TXQ Stats: len 72
         08 00 01 00 00 00 00 00 08 00 02 00 00 00 00 00  ................
         08 00 03 00 00 00 00 00 08 00 04 00 00 00 00 00  ................
         08 00 05 00 00 00 00 00 08 00 06 00 00 00 00 00  ................
         08 00 08 00 00 00 00 00 08 00 09 00 00 00 00 00  ................
         08 00 0a 00 00 00 00 00                          ........
 > Result: New Interface (0x07) len 160 
1661908449.681725
     Interface Index: 13 (0x0000000d)
     Interface Name: wlan0
     Wiphy: 0 (0x00000000)
     Interface Type: 2 (0x00000002)
     Wireless Device: 12 (0x000000000000000c)
     MAC Address 9C:B6:D0:9A:5F:B7
     Generation: 19 (0x00000013)
     4-Address: 0 (0x00)
     Wiphy TX Power Level: 0 (0x00000000)
     TXQ Stats: len 72
         08 00 01 00 00 00 00 00 08 00 02 00 00 00 00 00  ................
         08 00 03 00 00 00 00 00 08 00 04 00 00 00 00 00  ................
         08 00 05 00 00 00 00 00 08 00 06 00 00 00 00 00  ................
         08 00 08 00 00 00 00 00 08 00 09 00 00 00 00 00  ................
         08 00 0a 00 00 00 00 00                          ........
 > Response: New Interface (0x07) len 4 [0x100] 
1661908449.681727
     Status: Success (0)
< Request: New Interface (0x07) len 44 [ack] 
1661908449.681786
     Wiphy: 0 (0x00000000)
     Interface Type: 10 (0x0000000a)
     Interface Name: wlan0-p2p
     4-Address: 0 (0x00)
     Socket Owns Interface/Connection: true
 > Event: New Interface (0x07) len 64 
1661908449.681816
     Wiphy: 0 (0x00000000)
     Interface Type: 10 (0x0000000a)
     Wireless Device: 13 (0x000000000000000d)
     MAC Address 9C:B6:D0:9A:5F:B7
     Generation: 28 (0x0000001c)
     4-Address: 0 (0x00)
     Wiphy TX Power Level: 0 (0x00000000)
 > Result: New Interface (0x07) len 64 
1661908449.681818
     Wiphy: 0 (0x00000000)
     Interface Type: 10 (0x0000000a)
     Wireless Device: 13 (0x000000000000000d)
     MAC Address 9C:B6:D0:9A:5F:B7
     Generation: 28 (0x0000001c)
     4-Address: 0 (0x00)
     Wiphy TX Power Level: 0 (0x00000000)
 > Response: New Interface (0x07) len 4 [0x100] 
1661908449.681819
     Status: Success (0)
< Request: Register Frame (0x3a) len 28 [ack] 
1661908449.901469
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00d0
         Type: Management (0)
         Subtype: Action (13)
     Frame Match: len 2
         05 05                                            ..
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908449.901526
     Status: Success (0)
< Request: Register Frame (0x3a) len 28 [ack] 
1661908449.904130
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00d0
         Type: Management (0)
         Subtype: Action (13)
     Frame Match: len 2
         08 01                                            ..
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908449.904138
     Status: Success (0)
< Request: Register Frame (0x3a) len 28 [ack] 
1661908449.904205
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00d0
         Type: Management (0)
         Subtype: Action (13)
     Frame Match: len 2
         08 00                                            ..
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908449.904208
     Status: Success (0)
< Request: Register Frame (0x3a) len 28 [ack] 
1661908449.904214
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00d0
         Type: Management (0)
         Subtype: Action (13)
     Frame Match: len 2
         06 02                                            ..
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908449.904216
     Status: Success (0)
< Request: Register Frame (0x3a) len 28 [ack] 
1661908449.904220
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00d0
         Type: Management (0)
         Subtype: Action (13)
     Frame Match: len 2
         01 04                                            ..
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908449.904222
     Status: Success (0)
< Request: Set Interface (0x06) len 16 [ack] 
1661908449.904226
     Interface Index: 13 (0x0000000d)
     4-Address: 0 (0x00)
 > Event: Set Interface (0x06) len 160 
1661908449.904232
     Interface Index: 13 (0x0000000d)
     Interface Name: wlan0
     Wiphy: 0 (0x00000000)
     Interface Type: 2 (0x00000002)
     Wireless Device: 12 (0x000000000000000c)
     MAC Address 9C:B6:D0:9A:5F:B7
     Generation: 28 (0x0000001c)
     4-Address: 0 (0x00)
     Wiphy TX Power Level: 0 (0x00000000)
     TXQ Stats: len 72
         08 00 01 00 00 00 00 00 08 00 02 00 00 00 00 00  ................
         08 00 03 00 00 00 00 00 08 00 04 00 00 00 00 00  ................
         08 00 05 00 00 00 00 00 08 00 06 00 00 00 00 00  ................
         08 00 08 00 00 00 00 00 08 00 09 00 00 00 00 00  ................
         08 00 0a 00 00 00 00 00                          ........
 > Response: Set Interface (0x06) len 4 [0x100] 
1661908449.904233
     Status: Success (0)
< Request: Register Frame (0x3a) len 28 [ack] 
1661908449.904253
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00d0
         Type: Management (0)
         Subtype: Action (13)
     Frame Match: len 2
         0a 07                                            ..
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908449.904256
     Status: Success (0)
< Request: Register Frame (0x3a) len 28 [ack] 
1661908449.904259
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00d0
         Type: Management (0)
         Subtype: Action (13)
     Frame Match: len 2
         05 00                                            ..
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908449.904261
     Status: Success (0)
< Request: Register Frame (0x3a) len 32 [ack] 
1661908449.904264
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00d0
         Type: Management (0)
         Subtype: Action (13)
     Frame Match: len 7
         04 09 50 6f 9a 1a 01                             ..Po...
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908449.904266
     Status: Success (0)
< Request: Register Frame (0x3a) len 28 [ack] 
1661908449.904269
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00d0
         Type: Management (0)
         Subtype: Action (13)
     Frame Match: len 2
         04 0b                                            ..
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908449.904270
     Status: Success (0)
< Request: Register Frame (0x3a) len 28 [ack] 
1661908449.904273
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00d0
         Type: Management (0)
         Subtype: Action (13)
     Frame Match: len 2
         04 0a                                            ..
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908449.904274
     Status: Success (0)
< Request: Set Interface (0x06) len 16 [ack] 
1661908452.816568
     Interface Index: 13 (0x0000000d)
     Interface Type: 3 (0x00000003)
 > Event: Set Interface (0x06) len 160 
1661908452.816674
     Interface Index: 13 (0x0000000d)
     Interface Name: wlan0
     Wiphy: 0 (0x00000000)
     Interface Type: 3 (0x00000003)
     Wireless Device: 12 (0x000000000000000c)
     MAC Address 9C:B6:D0:9A:5F:B7
     Generation: 28 (0x0000001c)
     4-Address: 0 (0x00)
     Wiphy TX Power Level: 0 (0x00000000)
     TXQ Stats: len 72
         08 00 01 00 00 00 00 00 08 00 02 00 00 00 00 00  ................
         08 00 03 00 00 00 00 00 08 00 04 00 00 00 00 00  ................
         08 00 05 00 00 00 00 00 08 00 06 00 00 00 00 00  ................
         08 00 08 00 00 00 00 00 08 00 09 00 00 00 00 00  ................
         08 00 0a 00 00 00 00 00                          ........
 > Response: Set Interface (0x06) len 4 [0x100] 
1661908452.816676
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1661908454.347237
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x0000
         Type: Management (0)
         Subtype: Association request (0)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908454.347249
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1661908454.347326
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x0020
         Type: Management (0)
         Subtype: Reassociation request (2)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908454.347329
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1661908454.347340
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x0040
         Type: Management (0)
         Subtype: Probe request (4)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908454.347342
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1661908454.347345
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00a0
         Type: Management (0)
         Subtype: Disassociation (10)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908454.347346
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1661908454.347348
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00b0
         Type: Management (0)
         Subtype: Authentication (11)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908454.347349
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1661908454.347351
     Wireless Device: 12 (0x000000000000000c)
     Frame Type: 0x00c0
         Type: Management (0)
         Subtype: Deauthentication (12)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1661908454.347352
     Status: Success (0)
< Request: Start AP (0x0f) len 224 [ack] 
1661908454.347354
     Beacon Head: len 49
         80 00 00 00 ff ff ff ff ff ff 9c b6 d0 9a 5f b7  .............._.
         9c b6 d0 9a 5f b7 00 00 00 00 00 00 00 00 00 00  ...._...........
         64 00 11 00 00 03 32 50 4c 01 03 82 0b 16 03 01  d.....2PL.......
         06                                               .
     Beacon Tail: len 48
         30 14 01 00 00 0f ac 04 01 00 00 0f ac 04 01 00  0...............
         00 0f ac 02 00 00 dd 18 00 50 f2 04 10 4a 00 01  .........P...J..
         10 10 44 00 01 02 10 49 00 06 00 37 2a 00 01 20  ..D....I...7*..
     Information Elements: len 0
     IE Probe Response: len 0
     IE Assoc Response: len 0
     Beacon Interval: 100 (0x00000064)
     DTIM Period: 3 (0x00000003)
     Interface Index: 13 (0x0000000d)
     SSID: len 3
         32 50 4c                                         2PL
     Hidden SSID: 0 (0x00000000)
     Cipher Suites Pairwise:
         CCMP (00:0f:ac) suite  04
     Cipher Suite Group: CCMP (00:0f:ac) suite  04
     WPA Versions: 2 (0x00000002)
     AKM Suites:
         PSK; RSNA PSK (00:0f:ac) suite  02
     Auth Type: 0 (0x00000000)
     Wiphy Frequency: 2437 (0x00000985)
     Channel Width: 1 (0x00000001)
     Socket Owns Interface/Connection: true
     Control Port over NL80211: true
 > Response: Start AP (0x0f) len 4 [0x100] 
1661908454.437724
     Status: Success (0)
 > Event: Stop AP (0x10) len 28 
1661908457.014173
     Wiphy: 0 (0x00000000)
     Interface Index: 13 (0x0000000d)
     Wireless Device: 12 (0x000000000000000c)
 > Event: Reg Change (0x24) len 24 
1661908457.078355
     Regulatory Initiator: len 1
         00                                               .
     Regulatory Type: len 1
         01                                               .
     Wiphy: 0 (0x00000000)

Thank you.

Chang
> 
> Thanks,
> James

