Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF3EDE
	for <iwd@lists.linux.dev>; Fri,  2 Sep 2022 02:50:47 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id s206so809090pgs.3
        for <iwd@lists.linux.dev>; Thu, 01 Sep 2022 19:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hHZb2VmAcp/dKdI3MNEL5QNtDOaQfp8n9I/ce5MJXwQ=;
        b=kLCB4DWQ1YxOJvHwvS5JZc5x94sUi7uok6biuGP3mUTd9DkJYYu1zptl5mXhHaiVjg
         pQqFbptXQcfcS1wFVPyYk4F1OAiEgf8+YBLzLDPsyG9KGdk4qzxsAHBCyxjsLJX/wLP6
         uYt84pGMeiQXilI6ZEdcg9KpedVto2RVbL8RC9uw5eVGTrfim2oDsTkpqCi5sL0yGoLg
         y+j0zlInVDcIpGDSzs84itvx8gHuqmNIPYWhm82bFP/+6YuLUGHa+tAd9j1kkUrH8zzv
         ZTcCu0lI904jSawp7VOZs62RDmITmzJyhVdjYSYKxTL9G6Bho3R/PfKYyF5329XE76lO
         i1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hHZb2VmAcp/dKdI3MNEL5QNtDOaQfp8n9I/ce5MJXwQ=;
        b=lBlDZ9iHX7IboX/j5x0q56psNoHHg6eyNsuelwYnhR86Ktqce+pGy0f6/JSFOAmfPF
         31g93cbenx/XKRom5f3x3A4+38ZblvM+QodXg1+fiZrfINBzhAkcA/R6BBSrYPkl0W8z
         eaq9C8sUUIzm9Ta6oUugHBv+PjKsdm2cGTddeg8ZY3CZqi60GgDM6gcXHIf7XQlPl2hy
         8oPfJMSLFBhSx3F6ZAV6NpzVI6OKA9m9ZSZeArWbLLUjRwDa85WhFU4JpxkmmMgG+bWv
         xTL4op+IHYKp3/j88KYX7ln6mjfEkOGHxdf3Q0HnbCbkOARScwNa7DExHfh0XpuAEM7n
         ufGQ==
X-Gm-Message-State: ACgBeo1Gc5Vs7V36Zf7ECwPcVNKPfhvsOeQGnhrWMcg3jllIoDGO3yTp
	G1nlVy8Fa3o8M9+0Tj0B6RTB7x8UEQghJw==
X-Google-Smtp-Source: AA6agR7gYD9+uaiCY34BwRKSv8oPzny3D08rorE7lVy6I/0PIsqLDBi7QkdFm5koTA93Dx+myI/mTw==
X-Received: by 2002:a05:6a00:14c5:b0:536:7d2f:883e with SMTP id w5-20020a056a0014c500b005367d2f883emr33536624pfu.36.1662087046535;
        Thu, 01 Sep 2022 19:50:46 -0700 (PDT)
Received: from [192.168.5.98] (p200027.dc.mirai.ad.jp. [210.172.200.27])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b0016c1b178628sm289908pld.269.2022.09.01.19.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 19:50:45 -0700 (PDT)
Message-ID: <d007b616-5957-8010-bb01-bae8a5398add@gmail.com>
Date: Fri, 2 Sep 2022 11:50:43 +0900
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
 <7fc91799-e030-fe90-44e9-c6490fbb6bb8@gmail.com>
 <e5c70eecaa96e951176b6f99912822cb2ef5b3a9.camel@gmail.com>
From: Chang Liu <goduck777@gmail.com>
In-Reply-To: <e5c70eecaa96e951176b6f99912822cb2ef5b3a9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

On 9/1/22 1:04 AM, James Prestwood wrote:

> Then 3 seconds later the kernel sends STOP_AP...

Sorry for confusing you. The STOP_AP signal is caused by I pressing the 
Ctrl-C to stop the iwd process. If I don't stop it, then it will just do 
Start AP and then nothing.

Here is a log using iwd,

Wireless monitor ver 1.28
Created interface nlmon
< Request: Set Interface (0x06) len 16 [ack] 
1662086168.521206
     Interface Index: 3 (0x00000003)
     Interface Type: 3 (0x00000003)
 > Event: Set Interface (0x06) len 160 
1662086168.521322
     Interface Index: 3 (0x00000003)
     Interface Name: wlan0
     Wiphy: 0 (0x00000000)
     Interface Type: 3 (0x00000003)
     Wireless Device: 2 (0x0000000000000002)
     MAC Address 9C:B6:D0:9A:5F:B7
     Generation: 0 (0x00000000)
     4-Address: 0 (0x00)
     Wiphy TX Power Level: 0 (0x00000000)
     TXQ Stats: len 72
         08 00 01 00 00 00 00 00 08 00 02 00 00 00 00 00  ................
         08 00 03 00 00 00 00 00 08 00 04 00 00 00 00 00  ................
         08 00 05 00 00 00 00 00 08 00 06 00 00 00 00 00  ................
         08 00 08 00 00 00 00 00 08 00 09 00 00 00 00 00  ................
         08 00 0a 00 00 00 00 00                          ........
 > Response: Set Interface (0x06) len 4 [0x100] 
1662086168.521325
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1662086172.861106
     Wireless Device: 2 (0x0000000000000002)
     Frame Type: 0x0000
         Type: Management (0)
         Subtype: Association request (0)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1662086172.861118
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1662086172.861190
     Wireless Device: 2 (0x0000000000000002)
     Frame Type: 0x0020
         Type: Management (0)
         Subtype: Reassociation request (2)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1662086172.861194
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1662086172.861231
     Wireless Device: 2 (0x0000000000000002)
     Frame Type: 0x0040
         Type: Management (0)
         Subtype: Probe request (4)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1662086172.861234
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1662086172.861236
     Wireless Device: 2 (0x0000000000000002)
     Frame Type: 0x00a0
         Type: Management (0)
         Subtype: Disassociation (10)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1662086172.861237
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1662086172.861240
     Wireless Device: 2 (0x0000000000000002)
     Frame Type: 0x00b0
         Type: Management (0)
         Subtype: Authentication (11)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1662086172.861241
     Status: Success (0)
< Request: Register Frame (0x3a) len 24 [ack] 
1662086172.861243
     Wireless Device: 2 (0x0000000000000002)
     Frame Type: 0x00c0
         Type: Management (0)
         Subtype: Deauthentication (12)
     Frame Match: len 0
 > Response: Register Frame (0x3a) len 4 [0x100] 
1662086172.861244
     Status: Success (0)
< Request: Start AP (0x0f) len 224 [ack] 
1662086172.861246
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
     Interface Index: 3 (0x00000003)
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
1662086172.981437
     Status: Success (0)

> So the kernel, for whatever reason, stopped the AP. Are you able to try
> out hostapd (with iwmon running) and see if this works? That would tell
> us if its a kernel problem, or if IWD is doing something unexpected for
> this driver.

For comparison, I tried to use NetworkManager+wpa_supplicant to launch 
the hotspot. This time the hotspot can be seen by other devices. Here is 
the log of iwmon,

< Request: Del Station (0x14) len 8 [ack] 
1662086411.520089
     Interface Index: 2 (0x00000002)
 > Response: Del Station (0x14) len 4 [replace] 
1662086411.520092
     Status: Success (0)
< Request: Get Interface (0x05) len 8 [ack] 
1662086411.522906
     Interface Index: 2 (0x00000002)
 > Result: New Interface (0x07) len 160 
1662086411.522919
     Interface Index: 2 (0x00000002)
     Interface Name: wlan0
     Wiphy: 0 (0x00000000)
     Interface Type: 3 (0x00000003)
     Wireless Device: 1 (0x0000000000000001)
     MAC Address 9C:B6:D0:9A:5F:B7
     Generation: 5 (0x00000005)
     4-Address: 0 (0x00)
     Wiphy TX Power Level: 0 (0x00000000)
     TXQ Stats: len 72
         08 00 01 00 00 00 00 00 08 00 02 00 00 00 00 00  ................
         08 00 03 00 00 00 00 00 08 00 04 00 00 00 00 00  ................
         08 00 05 00 00 00 00 00 08 00 06 00 00 00 00 00  ................
         08 00 08 00 00 00 00 00 08 00 09 00 00 00 00 00  ................
         08 00 0a 00 00 00 00 00                          ........
 > Response: Get Interface (0x05) len 4 [0x100] 
1662086411.522922
     Status: Success (0)
< Request: Register Beacons (0x55) len 8 [ack] 
1662086411.522958
     Wiphy: 0 (0x00000000)
 > Response: Register Beacons (0x55) len 4 [0x100] 
1662086411.522964
     Status: Success (0)
< Request: Start AP (0x0f) len 620 [ack] 
1662086411.522975
     Interface Index: 2 (0x00000002)
     Beacon Head: len 62
         80 00 00 00 ff ff ff ff ff ff 9c b6 d0 9a 5f b7  .............._.
         9c b6 d0 9a 5f b7 00 00 00 00 00 00 00 00 00 00  ...._...........
         64 00 11 04 00 0b 32 50 4c 2d 68 6f 74 73 70 6f  d.....2PL-hotspo
         74 01 08 82 84 8b 96 0c 12 18 24 03 01 0b        t.........$...
     Beacon Tail: len 158
         2a 01 04 32 04 30 48 60 6c 30 1c 01 00 00 0f ac  *..2.0H`l0......
         04 01 00 00 0f ac 04 03 00 00 0f ac 02 00 0f ac  ................
         06 00 0f ac 08 0c 00 3b 02 51 00 2d 1a ec 09 1b  .......;.Q.-....
         ff ff 00 00 00 00 00 00 00 00 00 00 01 00 00 00  ................
         00 00 00 00 00 00 00 3d 16 0b 00 00 00 00 00 00  .......=........
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 7f  ................
         08 04 00 00 00 00 00 00 40 f4 01 20 dd 16 00 50  ........@.. ...P
         f2 01 01 00 00 50 f2 04 01 00 00 50 f2 04 01 00  .....P.....P....
         00 50 f2 02 dd 18 00 50 f2 02 01 01 01 00 03 a4  .P.....P........
         00 00 27 a4 00 00 42 43 5e 00 62 32 2f 00        ..'...BC^.b2/.
     Beacon Interval: 100 (0x00000064)
     DTIM Period: 2 (0x00000002)
     SSID: len 11
         32 50 4c 2d 68 6f 74 73 70 6f 74                 2PL-hotspot
     Probe Response: len 220
         50 00 00 00 00 00 00 00 00 00 9c b6 d0 9a 5f b7  P............._.
         9c b6 d0 9a 5f b7 00 00 00 00 00 00 00 00 00 00  ...._...........
         64 00 11 04 00 0b 32 50 4c 2d 68 6f 74 73 70 6f  d.....2PL-hotspo
         74 01 08 82 84 8b 96 0c 12 18 24 03 01 0b 2a 01  t.........$...*.
         04 32 04 30 48 60 6c 30 1c 01 00 00 0f ac 04 01  .2.0H`l0........
         00 00 0f ac 04 03 00 00 0f ac 02 00 0f ac 06 00  ................
         0f ac 08 0c 00 3b 02 51 00 2d 1a ec 09 1b ff ff  .....;.Q.-......
         00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00  ................
         00 00 00 00 00 3d 16 0b 00 00 00 00 00 00 00 00  .....=..........
         00 00 00 00 00 00 00 00 00 00 00 00 00 7f 08 04  ................
         00 00 00 00 00 00 40 f4 01 20 dd 16 00 50 f2 01  ......@.. ...P..
         01 00 00 50 f2 04 01 00 00 50 f2 04 01 00 00 50  ...P.....P.....P
         f2 02 dd 18 00 50 f2 02 01 01 01 00 03 a4 00 00  .....P..........
         27 a4 00 00 42 43 5e 00 62 32 2f 00              '...BC^.b2/.
     Hidden SSID: 0 (0x00000000)
     Privacy: true
     Auth Type: 0 (0x00000000)
     WPA Versions: 3 (0x00000003)
     Cipher Suites Pairwise:
         CCMP (00:0f:ac) suite  04
     Cipher Suite Group: CCMP (00:0f:ac) suite  04
     Information Elements: len 10
         Extended Capabilities: len 8
             Capability: bit  2: Extended channel switching
             Capability: bit 62: Opmode Notification
             04 00 00 00 00 00 00 40                          .......@ 

     IE Probe Response: len 10
         Extended Capabilities: len 8
             Capability: bit  2: Extended channel switching
             Capability: bit 62: Opmode Notification
             04 00 00 00 00 00 00 40                          .......@ 

     IE Assoc Response: len 13
         Extended Capabilities: len 8
             Capability: bit  2: Extended channel switching
             Capability: bit 62: Opmode Notification
             04 00 00 00 00 00 00 40                          .......@ 

         RSNX
             Field Size: 0
             SAE Hash-to-Element
             20 

     Reserved: len 1
         03                                               .
     Control Port over NL80211: true
     Socket Owns Interface/Connection: true
     Reserved: len 2
         8e 88                                            ..
     Reserved: len 0
 > Response: Start AP (0x0f) len 4 [0x100] 
1662086411.751037
     Status: Success (0)
< Request: Set BSS (0x19) len 56 [ack] 
1662086411.751160
     Interface Index: 2 (0x00000002)
     BSS CTS Protection: 0 (0x00)
     BSS Short Preamble: 0 (0x00)
     BSS Short Slot Time: 1 (0x01)
     BSS HT Operation Mode: 0 (0x0000)
     AP Isolate: 0 (0x00)
     BSS Basic Rates: len 4
         02 04 0b 16                                      ....
 > Response: Set BSS (0x19) len 4 [0x100] 
1662086411.751618
     Status: Success (0)
< Request: Set Multicast to Unicast (0x79) len 8 [ack] 
1662086411.751653
     Interface Index: 2 (0x00000002)
 > Response: Set Multicast to Unicast (0x79) len 4 [0x100] 
1662086411.751658
     Status: Success (0)
< Request: Frame (0x3b) len 48 [ack] 
1662086411.751671
     Interface Index: 2 (0x00000002)
     Wiphy Frequency: 2462 (0x0000099e)
     Frame: len 26
         Frame Type: 0x00c0
             Type: Management (0)
             Deauthentication:
                 Frame Control: protocol: 00 type: 00 subtype: 12 to: 00 
from: 00 more_frags: 00
                     retry: 00 power_mgmt: 00 more_data: 00 protected: 
00 order: 00
                 Duration: 0
                 Address 1 (RA): FF:FF:FF:FF:FF:FF
                 Address 2 (TA): 9C:B6:D0:9A:5F:B7
                 Address 3: 9C:B6:D0:9A:5F:B7
                 Fragment Number: 0
                 Sequence Number: 0
                 Reason code: 2
         c0 00 00 00 ff ff ff ff ff ff 9c b6 d0 9a 5f b7  .............._.
         9c b6 d0 9a 5f b7 00 00 02 00                    ...._.....
 > Result: Frame (0x3b) len 12 
1662086411.751680
     Cookie: 1 (0x0000000000000001)
 > Response: Frame (0x3b) len 4 [0x100] 
1662086411.751681
     Status: Success (0)
< Request: New Key (0x0b) len 48 [ack] 
1662086411.751797
     Interface Index: 2 (0x00000002)
     Key: len 36
         Key Data: len 16
             c6 84 5f 40 fb e2 74 6f 81 aa 50 5b d1 d3 73 d4 
.._@..to..P[..s.
         Key Cipher: CCMP (00:0f:ac) suite  04
         Key Index: 1 (0x01)
 > Event: Frame TX Status (0x3c) len 72 
1662086411.752303
     Wiphy: 0 (0x00000000)
     Interface Index: 2 (0x00000002)
     Wireless Device: 1 (0x0000000000000001)
     Frame: len 26
         Frame Type: 0x00c0
             Type: Management (0)
             Deauthentication:
                 Frame Control: protocol: 00 type: 00 subtype: 12 to: 00 
from: 00 more_frags: 00
                     retry: 00 power_mgmt: 00 more_data: 00 protected: 
00 order: 00
                 Duration: 0
                 Address 1 (RA): FF:FF:FF:FF:FF:FF
                 Address 2 (TA): 9C:B6:D0:9A:5F:B7
                 Address 3: 9C:B6:D0:9A:5F:B7
                 Fragment Number: 0
                 Sequence Number: 0
                 Reason code: 2
         c0 00 00 00 ff ff ff ff ff ff 9c b6 d0 9a 5f b7  .............._.
         9c b6 d0 9a 5f b7 00 00 02 00                    ...._.....
     Cookie: 1 (0x0000000000000001)
 > Response: New Key (0x0b) len 4 [0x100] 
1662086411.762349
     Status: Success (0)
< Request: Unknown (0x00) len 32 [ack] 
1662086411.762380
 > Response: Unknown (0x00) len 4 [0x100] 
1662086411.762390
     Status: Success (0)
< Request: Set Wiphy (0x02) len 56 [ack] 
1662086411.762446
     Interface Index: 2 (0x00000002)
     Wiphy TXQ Parameters: len 44
         2c 00 01 80 05 00 01 00 00 00 00 00 06 00 02 00  ,...............
         2f 00 00 00 06 00 03 00 03 00 00 00 06 00 04 00  /...............
         07 00 00 00 05 00 05 00 01 00 00 00              ............
 > Response: Set Wiphy (0x02) len 4 [0x100] 
1662086411.762455
     Status: Success (0)
< Request: Set Wiphy (0x02) len 56 [ack] 
1662086411.762462
     Interface Index: 2 (0x00000002)
     Wiphy TXQ Parameters: len 44
         2c 00 01 80 05 00 01 00 01 00 00 00 06 00 02 00  ,...............
         5e 00 00 00 06 00 03 00 07 00 00 00 06 00 04 00  ^...............
         0f 00 00 00 05 00 05 00 01 00 00 00              ............
 > Response: Set Wiphy (0x02) len 4 [0x100] 
1662086411.762466
     Status: Success (0)
< Request: Set Wiphy (0x02) len 56 [ack] 
1662086411.762471
     Interface Index: 2 (0x00000002)
     Wiphy TXQ Parameters: len 44
         2c 00 01 80 05 00 01 00 02 00 00 00 06 00 02 00  ,...............
         00 00 00 00 06 00 03 00 0f 00 00 00 06 00 04 00  ................
         3f 00 00 00 05 00 05 00 03 00 00 00              ?...........
 > Response: Set Wiphy (0x02) len 4 [0x100] 
1662086411.762603
     Status: Success (0)
< Request: Set Wiphy (0x02) len 56 [ack] 
1662086411.762611
     Interface Index: 2 (0x00000002)
     Wiphy TXQ Parameters: len 44
         2c 00 01 80 05 00 01 00 03 00 00 00 06 00 02 00  ,...............
         00 00 00 00 06 00 03 00 0f 00 00 00 06 00 04 00  ................
         ff 03 00 00 05 00 05 00 07 00 00 00              ............
 > Response: Set Wiphy (0x02) len 4 [0x100] 
1662086411.762741
     Status: Success (0)
< Request: Trigger Scan (0x21) len 52 [ack] 
1662086411.763150
     Interface Index: 2 (0x00000002)
     Scan SSIDs: len 4
         1: len 0
     Information Elements: len 22
         Extended Capabilities: len 11
             Capability: bit  2: Extended channel switching
             Capability: bit 17: WNM-Sleep mode
             Capability: bit 19: BSS transition
             Capability: bit 25: SSID list
             Capability: bit 32: QoS Map
             Capability: bit 46: WNM- Notification
             Capability: bit 54: SCS
             Capability: bit 62: Opmode Notification
             04 00 0a 02 01 40 40 40 00 01 20                 .....@@@.. 

         Vendor specific: len 7
             Wi-Fi Alliance (50:6f:9a) type: 16
             50 6f 9a 16 03 01 03                             Po..... 

     Scan Flags: Mask: 0x00000004 len 4
             AP

So I think wpa_supplicant did something more than iwd after start AP.

> Thanks,
> James
> 

Thanks,

Chang
