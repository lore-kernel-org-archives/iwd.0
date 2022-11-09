Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8C2101
	for <iwd@lists.linux.dev>; Wed,  9 Nov 2022 18:48:37 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13bd2aea61bso20688227fac.0
        for <iwd@lists.linux.dev>; Wed, 09 Nov 2022 10:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bY9p2eQEgt58gdjfSLPJkxvzyK9+eWeWhPeXdwQK/g=;
        b=Z9FbhJTcw6CthNY+1jkX9dA+Mv8dLHOdCdbjvyQQweWNQNTUMrXerW7YDbCz8yqL26
         aBM6Ms3BBlRoqiid+3mdXh8wihEyYrp8kfSUBEtX8wJqPA05Rg0G0709w2WnoytG9Mi7
         4I86pYE8QIh9kkVFSaZH9JUShiThhSzpdaHIKzi4+eiF5dcn0igVd2qKpjcsIQ7P0hDL
         BCciWwrGYdrLE8gzFx/wNduIMEkA/+nJHq5V3dk2A0l+jR1yj1Pz96egPKN9AdjJkaqX
         ewVyGHSy7hCu7DEvYpdpsOIsxk4Vjyh7ypC8TXcWeg+Dn3qLOk+YuKC6wHZCGK0r/ULz
         QTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bY9p2eQEgt58gdjfSLPJkxvzyK9+eWeWhPeXdwQK/g=;
        b=cJLndnW4ErGxxm7IjOKpdZ13NHLUBQ8tmQ1tzee7e31YKs9Aie40KncEa7v35ZJGQ7
         /1nx/K9+M6xXRHcoo6diRLmEy1Hkb3TkvZvC++calsHAu0EU/jWArzqQJM6RgrmIM/je
         Y88MGMf1/12Mrj2SvN9R7ueO58sKnoePLK+zA3uT/cMtzlDbfweGUpB4+otz8hmCC30o
         KXfQJYnlTlKkTtdS9K0W5LuotIKFLL0j/CgMdNxFzJZpvfW7MTTcsQ57DF4sppZMAAb7
         BFeC1AjowsKCxFUy/R5omfB5nTIzpvWPfriKXw/vVgKi58K/NzDSYvmKasMck2uLm4O+
         W6Ag==
X-Gm-Message-State: ACrzQf02KzudxFL6o9e15UxzCnoSjq0XJWUitIri5c4OFqcWL7+Pqs3H
	AyCN9tEvI2kITvhQYRXaI51vnqvkUgs=
X-Google-Smtp-Source: AMsMyM7wPzJDuxTdKa7I3aYAJIIxZwKHoeLkARQC19RRm1r4i2GAEU4Zcz2Qj78U/A9e5MffiSI2zA==
X-Received: by 2002:a05:6870:4798:b0:12c:fdf7:e948 with SMTP id c24-20020a056870479800b0012cfdf7e948mr35609171oaq.247.1668019717093;
        Wed, 09 Nov 2022 10:48:37 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h19-20020a9d6a53000000b0066aba96addbsm5588141otn.81.2022.11.09.10.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 10:48:35 -0800 (PST)
Message-ID: <e5a311c2-eb02-d31a-f9cf-b8101089018b@gmail.com>
Date: Wed, 9 Nov 2022 12:48:34 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Permanent disconnect when deauthenticated during a roam
Content-Language: en-US
To: Michael Johnson <mjohnson459@gmail.com>, iwd@lists.linux.dev
References: <CACsRnHU1WkovQrSUFH91haGf7rJJppfBwCxkVT9eXejVk_CJ1w@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CACsRnHU1WkovQrSUFH91haGf7rJJppfBwCxkVT9eXejVk_CJ1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 11/9/22 10:42, Michael Johnson wrote:
> Hey all,
> 
> I've just had an issue with a client being permanently disconnected
> after a failed roam. iwd detects the disconnect and prints a message
> but doesn't seem to attempt to reconnect again. I don't see anything
> about blacklists mentioned either.
> Any idea why this isn't attempting to reconnect?

Hmm, see if commit 8758cc89487b3 fixes this:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/src?id=8758cc89487b3304e4b96179a464fff3201e690d

> 
> ```
> # Normal roam
> Nov 08 17:59:41.880934 p3-3478 iwd[426]:
> src/netdev.c:netdev_authenticate_event()
> Nov 08 17:59:41.881248 p3-3478 kernel: wlan0: send auth to
> ac:3a:67:5d:8b:2c (try 1/3)
> Nov 08 17:59:41.881324 p3-3478 kernel: wlan0: authenticated
> Nov 08 17:59:41.881374 p3-3478 iwd[426]:
> src/netdev.c:netdev_get_oci_cb() Obtained OCI: freq: 5560, width: 1,
> center1: 5560, center2: 0
> Nov 08 17:59:41.889035 p3-3478 kernel: wlan0: associate with
> ac:3a:67:5d:8b:2c (try 1/3)
> Nov 08 17:59:41.889232 p3-3478 kernel: wlan0: RX ReassocResp from
> ac:3a:67:5d:8b:2c (capab=0x1111 status=0 aid=10)
> Nov 08 17:59:41.892719 p3-3478 iwd[426]:
> src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
> Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_associate_event()
> Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_set_gtk() 5
> Nov 08 17:59:41.892719 p3-3478 iwd[426]:
> src/station.c:station_handshake_event() Setting keys
> Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_set_tk() 5
> Nov 08 17:59:41.892719 p3-3478 iwd[426]:
> src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
> Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_connect_event()
> Nov 08 17:59:41.893224 p3-3478 kernel: wlan0: associated
> Nov 08 17:59:41.893271 p3-3478 kernel: ath: EEPROM regdomain: 0x8348
> Nov 08 17:59:41.893307 p3-3478 kernel: ath: EEPROM indicates we should
> expect a country code
> Nov 08 17:59:41.893337 p3-3478 kernel: ath: doing EEPROM
> country->regdmn map search
> Nov 08 17:59:41.893363 p3-3478 kernel: ath: country maps to regdmn code: 0x3a
> Nov 08 17:59:41.893390 p3-3478 kernel: ath: Country alpha2 being used: US
> Nov 08 17:59:41.893416 p3-3478 kernel: ath: Regpair used: 0x3a
> Nov 08 17:59:41.893457 p3-3478 kernel: ath: regdomain 0x8348
> dynamically updated by country element
> Nov 08 17:59:41.893483 p3-3478 kernel: wlan0: deauthenticated from
> ac:3a:67:5d:8b:2c (Reason: 34=DISASSOC_LOW_ACK)

Looks like we deauthenticate very shortly after associated where the roam is 
still in progress.

> Nov 08 17:59:41.895990 p3-3478 iwd[426]:
> src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> Nov 08 17:59:41.896099 p3-3478 iwd[426]:
> src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> Nov 08 17:59:41.896099 p3-3478 iwd[426]:
> src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
> (global) is US
> Nov 08 17:59:41.896099 p3-3478 iwd[426]:
> src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> src/netdev.c:netdev_deauthenticate_event()
> Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> Nov 08 17:59:41.896282 p3-3478 iwd[426]: src/netdev.c:netdev_disconnect_event()
> Nov 08 17:59:41.896282 p3-3478 iwd[426]: Received Deauthentication
> event, reason: 34, from_ap: true
> Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> src/wiphy.c:wiphy_radio_work_done() Work item 493 done
> Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> src/station.c:station_disconnect_event() 5
> Nov 08 17:59:41.896282 p3-3478 iwd[426]: Unexpected disconnect event

And we erroneously think that such an event can't happen (in 1.30).

> Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> Nov 08 17:59:41.896867 p3-3478 iwd[426]:
> src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> Nov 08 17:59:41.896867 p3-3478 iwd[426]:
> src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
> (global) is XX
> Nov 08 17:59:42.893123 p3-3478 iwd[426]:
> src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> # Doesn't reconnect and needs to be rebooted ...
> ```
> 

Regards,
-Denis
