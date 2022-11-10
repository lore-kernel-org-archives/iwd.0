Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C562625
	for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 09:21:00 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13bef14ea06so1564572fac.3
        for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 01:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iorv7NL5kgDpmhiS/KJus/gI0Bua9EVgA/KEruBzYf4=;
        b=QQrSVpCxbCKfKQsCgWCtu5EN2mD9SH+ouC3ZrBJYsGVcVtTIw5F20K3fXpGVGL651L
         7j+bsB87LMU36FGvAZXv7oYEXc4vsM5weUjesMiDztVk515XBXG4u2cNj7yImx0eTDTJ
         HVvyhkeoBMwwCh2W5J9NOy2dENYO95xab2rbA3/wUZkpWLO6bofWktjoUiJAPBBKyHAs
         7LHCYlDr/BTUz6gI5tf1LdmBnhiWDvBNrtwzWb5acdhAKnzbpLjaGepOFn0+8+yrYTtr
         IoS1Czkcjie3aw3ilg2cX00izfVn9lEQevAhw3QNhRUbivR+wpkS6Wn0bTDv3oY8sk5C
         alWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iorv7NL5kgDpmhiS/KJus/gI0Bua9EVgA/KEruBzYf4=;
        b=Lgn80UkWFMmJccELUQoASo7PnhSg2rRv7sk7F+k7IVAk5EvOKcpFoldvqMBNmV6Y3W
         LSdE4IlH/G8licw3/JgzsppdenIkurKPYzsCOyj7QIBpTJiVnqY5oPFGGmiebSAFObe1
         8T9kOctfh6KchCFAXzVN6RwhPWG5VKNgruPzvFPfig/MdT6CPdqil+XRDvhsDxTN7qDS
         CtUet0925BbLFQh5bFrL6MRMMzMSIOtiDNkoYcnWL4aZSN6jUZkx91Lq0y1rY0rIbRU6
         dfx50rjNG9l+RGEb3p6uWPMznNE5N9puPT1OpqW+KuiecA7nLOSidy7DJdQa0OK64rvM
         DsPg==
X-Gm-Message-State: ACrzQf2Nx1XvPqXVxhshG1lEM7I53IL//LzWJ8K2S0KFdQKcVNVv8073
	ORluyJxfmm4LKlre9+rCuLoQvwd4z7u/vTbwq+KbH4pcDDk=
X-Google-Smtp-Source: AMsMyM78b552twwh1PxfUpzVUzSFApMvxz5D8s2oyY0VY25jsQXVFnsLgkTuzYBLZJqVK8X+IPt7nwK0Ms80sMHneB0=
X-Received: by 2002:a05:6870:5d91:b0:132:c8d7:c29f with SMTP id
 fu17-20020a0568705d9100b00132c8d7c29fmr1317601oab.7.1668072059151; Thu, 10
 Nov 2022 01:20:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACsRnHU1WkovQrSUFH91haGf7rJJppfBwCxkVT9eXejVk_CJ1w@mail.gmail.com>
 <e5a311c2-eb02-d31a-f9cf-b8101089018b@gmail.com>
In-Reply-To: <e5a311c2-eb02-d31a-f9cf-b8101089018b@gmail.com>
From: Michael Johnson <mjohnson459@gmail.com>
Date: Thu, 10 Nov 2022 09:20:48 +0000
Message-ID: <CACsRnHWoXyrmxvAaQg-5n3GOpokdk67rtDTuv=c7cTV8mgvazw@mail.gmail.com>
Subject: Re: Permanent disconnect when deauthenticated during a roam
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Thanks Denis,

I'll give the patch a try. When you specify 1.30 does that mean this
isn't likely to have an effect on 1.28?

Michael

On Wed, 9 Nov 2022 at 18:48, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Michael,
>
> On 11/9/22 10:42, Michael Johnson wrote:
> > Hey all,
> >
> > I've just had an issue with a client being permanently disconnected
> > after a failed roam. iwd detects the disconnect and prints a message
> > but doesn't seem to attempt to reconnect again. I don't see anything
> > about blacklists mentioned either.
> > Any idea why this isn't attempting to reconnect?
>
> Hmm, see if commit 8758cc89487b3 fixes this:
>
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/src?id=8758cc89487b3304e4b96179a464fff3201e690d
>
> >
> > ```
> > # Normal roam
> > Nov 08 17:59:41.880934 p3-3478 iwd[426]:
> > src/netdev.c:netdev_authenticate_event()
> > Nov 08 17:59:41.881248 p3-3478 kernel: wlan0: send auth to
> > ac:3a:67:5d:8b:2c (try 1/3)
> > Nov 08 17:59:41.881324 p3-3478 kernel: wlan0: authenticated
> > Nov 08 17:59:41.881374 p3-3478 iwd[426]:
> > src/netdev.c:netdev_get_oci_cb() Obtained OCI: freq: 5560, width: 1,
> > center1: 5560, center2: 0
> > Nov 08 17:59:41.889035 p3-3478 kernel: wlan0: associate with
> > ac:3a:67:5d:8b:2c (try 1/3)
> > Nov 08 17:59:41.889232 p3-3478 kernel: wlan0: RX ReassocResp from
> > ac:3a:67:5d:8b:2c (capab=0x1111 status=0 aid=10)
> > Nov 08 17:59:41.892719 p3-3478 iwd[426]:
> > src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
> > Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_associate_event()
> > Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_set_gtk() 5
> > Nov 08 17:59:41.892719 p3-3478 iwd[426]:
> > src/station.c:station_handshake_event() Setting keys
> > Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_set_tk() 5
> > Nov 08 17:59:41.892719 p3-3478 iwd[426]:
> > src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
> > Nov 08 17:59:41.892719 p3-3478 iwd[426]: src/netdev.c:netdev_connect_event()
> > Nov 08 17:59:41.893224 p3-3478 kernel: wlan0: associated
> > Nov 08 17:59:41.893271 p3-3478 kernel: ath: EEPROM regdomain: 0x8348
> > Nov 08 17:59:41.893307 p3-3478 kernel: ath: EEPROM indicates we should
> > expect a country code
> > Nov 08 17:59:41.893337 p3-3478 kernel: ath: doing EEPROM
> > country->regdmn map search
> > Nov 08 17:59:41.893363 p3-3478 kernel: ath: country maps to regdmn code: 0x3a
> > Nov 08 17:59:41.893390 p3-3478 kernel: ath: Country alpha2 being used: US
> > Nov 08 17:59:41.893416 p3-3478 kernel: ath: Regpair used: 0x3a
> > Nov 08 17:59:41.893457 p3-3478 kernel: ath: regdomain 0x8348
> > dynamically updated by country element
> > Nov 08 17:59:41.893483 p3-3478 kernel: wlan0: deauthenticated from
> > ac:3a:67:5d:8b:2c (Reason: 34=DISASSOC_LOW_ACK)
>
> Looks like we deauthenticate very shortly after associated where the roam is
> still in progress.
>
> > Nov 08 17:59:41.895990 p3-3478 iwd[426]:
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> > Nov 08 17:59:41.896099 p3-3478 iwd[426]:
> > src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> > Nov 08 17:59:41.896099 p3-3478 iwd[426]:
> > src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
> > (global) is US
> > Nov 08 17:59:41.896099 p3-3478 iwd[426]:
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> > src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> > src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> > src/netdev.c:netdev_deauthenticate_event()
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> > src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]: src/netdev.c:netdev_disconnect_event()
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]: Received Deauthentication
> > event, reason: 34, from_ap: true
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> > src/wiphy.c:wiphy_radio_work_done() Work item 493 done
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> > src/station.c:station_disconnect_event() 5
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]: Unexpected disconnect event
>
> And we erroneously think that such an event can't happen (in 1.30).
>
> > Nov 08 17:59:41.896282 p3-3478 iwd[426]:
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> > Nov 08 17:59:41.896867 p3-3478 iwd[426]:
> > src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> > Nov 08 17:59:41.896867 p3-3478 iwd[426]:
> > src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
> > (global) is XX
> > Nov 08 17:59:42.893123 p3-3478 iwd[426]:
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 5
> > # Doesn't reconnect and needs to be rebooted ...
> > ```
> >
>
> Regards,
> -Denis
