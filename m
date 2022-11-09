Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D217C2
	for <iwd@lists.linux.dev>; Wed,  9 Nov 2022 16:42:39 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id x196-20020a4a41cd000000b0049f064d2591so997376ooa.11
        for <iwd@lists.linux.dev>; Wed, 09 Nov 2022 08:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zWgboCrZgXZp9BlRmdCZojUqzssciD/lfpZOB3kEtto=;
        b=XD5WLbD49Xr61dyJjKZXE8bgQ6SvRlF50T+WBs4kHJ+oQ0hjMAfLJiS3R9xjEjzLjM
         Q916vHHwblra7Gr70/BgzyYNMpY8tKTpyJJfaiQRbcSSXhpHfXGff+sF1HABOHk5KcPI
         dP/xa6cj3lX+nN/rEzNfRWANfAmccjempWVyp3/AyxlsUcUbkA486N3k4bBOO/C0Vn3h
         YPzhEfEdOlh8irfzqGSnDU9p5fItaYiOq+a1bgkMP6OaMsjum40MoSdtVdYM7DEVNZne
         p67Jal8mgwgm9QC4NQvVtelobd7voENtI3fCKrvStWby1d8HNx5P8FwA9+cxQbd3ncWK
         jjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWgboCrZgXZp9BlRmdCZojUqzssciD/lfpZOB3kEtto=;
        b=x8pV8B8GcoHIWxGg41NqSvisAxbL6Gc2JlhLCD8UmpFEcuCilj3ahZXKZ8StjZVxf2
         tRhg20nTpHPtII9/8RMzv/x/Oc5J5u0T+ugtiUq/VCByV00a1bioh2buKfjr4HCvBboa
         76IocOX/m1DRoAckLwke1TdU3ltIw/M7Bc5Pk8aKgAGtU9Zb7o15da1wzSjG05ttuR8Y
         NqEuZIyxFczGp9NN0nSQcWNoMhPaYAGntaj6djysgSQF7uC2bxtVJ9YDSbMSl2XTvctN
         hNCOqDqObVrF/emdiecV4C779HXEAINzJYVjjhMl3dU0zLE3C0vRztONztTm97irFy3N
         qi/w==
X-Gm-Message-State: ACrzQf1URmW6wRwS7DEsZCNNYyrF/HgITNaUZXe6hS4p4c3Um5696R/w
	xRWP2vtoMIWaI0Pbfo6Jpe+NoAFl/U788Xog9tq/uMqIBIplgg==
X-Google-Smtp-Source: AMsMyM7b7biMdF60jZ4E4Z977UZ1hnjEOR4R+evF4LrgE+BnxFMlL+YYdhgCMq/ilHVMA7XXAni4L/UqvMTyOZrfpmk=
X-Received: by 2002:a4a:aeca:0:b0:480:2413:1edc with SMTP id
 v10-20020a4aaeca000000b0048024131edcmr25951072oon.96.1668012158725; Wed, 09
 Nov 2022 08:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Date: Wed, 9 Nov 2022 16:42:27 +0000
Message-ID: <CACsRnHU1WkovQrSUFH91haGf7rJJppfBwCxkVT9eXejVk_CJ1w@mail.gmail.com>
Subject: Permanent disconnect when deauthenticated during a roam
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hey all,

I've just had an issue with a client being permanently disconnected
after a failed roam. iwd detects the disconnect and prints a message
but doesn't seem to attempt to reconnect again. I don't see anything
about blacklists mentioned either.
Any idea why this isn't attempting to reconnect?

```
# Normal roam
Nov 08 17:59:41.880934 p3-3478 iwd[426]:
src/netdev.c:netdev_authenticate_event()
Nov 08 17:59:41.881248 p3-3478 kernel: wlan0: send auth to
ac:3a:67:5d:8b:2c (try 1/3)
Nov 08 17:59:41.881324 p3-3478 kernel: wlan0: authenticated
Nov 08 17:59:41.881374 p3-3478 iwd[426]:
src/netdev.c:netdev_get_oci_cb() Obtained OCI: freq: 5560, width: 1,
center1: 5560, center2: 0
Nov 08 17:59:41.889035 p3-3478 kernel: wlan0: associate with
ac:3a:67:5d:8b:2c (try 1/3)
Nov 08 17:59:41.889232 p3-3478 kernel: wlan0: RX ReassocResp from
ac:3a:67:5d:8b:2c (capab=0x1111 status=0 aid=10)
Nov 08 17:59:41.892719 p3-3478 iwd[426]:
src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_associate_event()
Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_set_gtk() 5
Nov 08 17:59:41.892719 p3-3478 iwd[426]:
src/station.c:station_handshake_event() Setting keys
Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_set_tk() 5
Nov 08 17:59:41.892719 p3-3478 iwd[426]:
src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_connect_event()
Nov 08 17:59:41.893224 p3-3478 kernel: wlan0: associated
Nov 08 17:59:41.893271 p3-3478 kernel: ath: EEPROM regdomain: 0x8348
Nov 08 17:59:41.893307 p3-3478 kernel: ath: EEPROM indicates we should
expect a country code
Nov 08 17:59:41.893337 p3-3478 kernel: ath: doing EEPROM
country->regdmn map search
Nov 08 17:59:41.893363 p3-3478 kernel: ath: country maps to regdmn code: 0x3a
Nov 08 17:59:41.893390 p3-3478 kernel: ath: Country alpha2 being used: US
Nov 08 17:59:41.893416 p3-3478 kernel: ath: Regpair used: 0x3a
Nov 08 17:59:41.893457 p3-3478 kernel: ath: regdomain 0x8348
dynamically updated by country element
Nov 08 17:59:41.893483 p3-3478 kernel: wlan0: deauthenticated from
ac:3a:67:5d:8b:2c (Reason: 34=DISASSOC_LOW_ACK)
Nov 08 17:59:41.895990 p3-3478 iwd[426]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
Nov 08 17:59:41.896099 p3-3478 iwd[426]:
src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
Nov 08 17:59:41.896099 p3-3478 iwd[426]:
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
(global) is US
Nov 08 17:59:41.896099 p3-3478 iwd[426]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
Nov 08 17:59:41.896282 p3-3478 iwd[426]:
src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
Nov 08 17:59:41.896282 p3-3478 iwd[426]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
Nov 08 17:59:41.896282 p3-3478 iwd[426]:
src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
Nov 08 17:59:41.896282 p3-3478 iwd[426]:
src/netdev.c:netdev_deauthenticate_event()
Nov 08 17:59:41.896282 p3-3478 iwd[426]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
Nov 08 17:59:41.896282 p3-3478 iwd[426]:
src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
Nov 08 17:59:41.896282 p3-3478 iwd[426]: src/netdev.c:netdev_disconnect_event()
Nov 08 17:59:41.896282 p3-3478 iwd[426]: Received Deauthentication
event, reason: 34, from_ap: true
Nov 08 17:59:41.896282 p3-3478 iwd[426]:
src/wiphy.c:wiphy_radio_work_done() Work item 493 done
Nov 08 17:59:41.896282 p3-3478 iwd[426]:
src/station.c:station_disconnect_event() 5
Nov 08 17:59:41.896282 p3-3478 iwd[426]: Unexpected disconnect event
Nov 08 17:59:41.896282 p3-3478 iwd[426]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
Nov 08 17:59:41.896867 p3-3478 iwd[426]:
src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
Nov 08 17:59:41.896867 p3-3478 iwd[426]:
src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
(global) is XX
Nov 08 17:59:42.893123 p3-3478 iwd[426]:
src/netdev.c:netdev_link_notify() event 16 on ifindex 5
# Doesn't reconnect and needs to be rebooted ...
```

Regards,
Michael
