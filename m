Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C940011CA8
	for <iwd@lists.linux.dev>; Wed, 29 Nov 2023 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTBmJksK"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-423c944352fso16698311cf.3
        for <iwd@lists.linux.dev>; Wed, 29 Nov 2023 04:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701262155; x=1701866955; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p6DJBbJvxZbL8TLGIxhkM+dmy3ccSJqP3sBE/GWR1dM=;
        b=bTBmJksKva3sZqEZqyPoH9QRW9mJqahsPo8mT2xKzTog5qRSG1ktssirmE84fMWUQl
         uAyep1qWk0XaGzq+BvAdJeiOqcO6y4IlhQOawJm6U+3t2Th/uzJF5aROVJKEGKmkB6Bd
         VhEvpHp9xZ8Se8nKFnezmgK39KgU4TEw0OuSsyoI5Hkl1fiHzGChHFaUgEatL6ufldTV
         Cr63CK8HA9U5Ixe9FkEcUwu0gxel1GgvsYYNOn0cEqBMcypqipLVbmPVAClrwivR7OS+
         YM6iP3k6TRclP5/ERUl1NL5Mp1jbxiAKc3r2wN8qcSvd+ZblnBk6DGFYTHK6FJeEa8oA
         u4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701262155; x=1701866955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6DJBbJvxZbL8TLGIxhkM+dmy3ccSJqP3sBE/GWR1dM=;
        b=YLT52ODnoDztBKrST1Us0fghG8iLGtHW08TNS7vQ6TrMrFdOiNwWh0g6olN2i8ll6D
         JpHxIusjuyfZxfdwrxFqs5bboqPw99bRkh6qbaniEz8yyScTHjaA9B0ydna/rm5xcdqL
         8+LMLkGCTqFmPp25eHa7q4USvHY1YyHp251mHwRcO1LzW/0lILnKX7OAYBUj+f3yU3Zb
         xNEuKRhd4ngKdmt85Sh6IFstxgMj9I2p3ycWr5+4uoTwrclzrqwDgCBt+xR00mf+xT6c
         CK1Q/Epm4wE8TPa3r2ByCwNyuVWEdq6k2ELl4/D2PwgvK2B6DPqCCyZ4bM92go9mQxWC
         NbYA==
X-Gm-Message-State: AOJu0Ywo2/08o79HlXglgx4ynWBKGXL+ryy+xxgH4lDBzvnHKVEm/s7K
	iDBEnEqNVJE4h99Be03sLfkohQPeGb4=
X-Google-Smtp-Source: AGHT+IGTlakbuFFFtTCrKGKtKMW0E7QZltL8AGs/bx8PwbB5tL59zCx4WB/Lmgu/7HeLJwrMZVJfgg==
X-Received: by 2002:a05:622a:1ccb:b0:423:edbc:5c19 with SMTP id bc11-20020a05622a1ccb00b00423edbc5c19mr1087349qtb.39.1701262155624;
        Wed, 29 Nov 2023 04:49:15 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id d5-20020ac85345000000b00417f330026bsm5513852qto.49.2023.11.29.04.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:49:15 -0800 (PST)
Message-ID: <437c600a-3dad-4a78-883c-c2cc2939ba00@gmail.com>
Date: Wed, 29 Nov 2023 04:49:13 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: roaming issues on a residential LAN with multiple APs
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, Daniel Barter <danielbarter@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAJODeCBYQ3bwRjZjZoZ+AX+QG84U=VO_UEoa0AuWmFAqxunn4Q@mail.gmail.com>
 <0331a3f5-7d04-49d0-b569-3e5fa5b4514d@gmail.com>
 <CAJODeCDu-85P54m16FanJftz2mC-fVGN-PXrwk4q+yS8n6mwFQ@mail.gmail.com>
 <8212f44e-d7f1-4b5c-9ffb-043a01b4d16b@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <8212f44e-d7f1-4b5c-9ffb-043a01b4d16b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 11/26/23 21:00, Denis Kenzior wrote:
> Hi Daniel,
>
> On 11/25/23 18:32, Daniel Barter wrote:
>> here are my logs:
>> https://gist.github.com/danielbarter/65ddf6aee78546a0e8f9e2d3af65308c
>>
>> notice that this is a mix of iwd 2.4 (my distro default) and iwd 2.8.
>>
>> Default roaming thresholds are in the 70s right? I am getting down to
>> -90dBm without a roam happening.
>
> Default thresholds are -70 db for 2.4 Ghz and -76 for 5Ghz.
>
> I'm not seeing any CQM events in your log, except for this one:
>
> Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify() 
> MLME notification Notify CQM(64)
> Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_cqm_event() 
> Beacon lost event
> Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify() 
> MLME notification Notify CQM(64)
> Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_cqm_event() 
> Beacon lost event
> Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_link_notify() 
> event 16 on ifindex 3
> Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify() 
> MLME notification Del Station(20)
> Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify() 
> MLME notification Deauthenticate(39)
> Nov 24 16:34:15 jasper iwd[768]: 
> src/netdev.c:netdev_deauthenticate_event()
> Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify() 
> MLME notification Disconnect(48)
> Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_disconnect_event()
> Nov 24 16:34:15 jasper iwd[768]: Received Deauthentication event, 
> reason: 4, from_ap: false
> Nov 24 16:34:15 jasper iwd[768]: 
> src/station.c:station_disconnect_event() 3
> Nov 24 16:34:15 jasper iwd[768]: src/station.c:station_disassociated() 3
> Nov 24 16:34:15 jasper iwd[768]: 
> src/station.c:station_reset_connection_state() 3
> Nov 24 16:34:15 jasper iwd[768]: 
> src/station.c:station_roam_state_clear() 3
> Nov 24 16:34:15 jasper iwd[768]: src/station.c:station_enter_state() 
> Old State: connected, new state: disconnected
>
> Basically a lost-beacon event comes in (twice for some reason) and 
> we're disconnected almost instantly after that.  There's no other CQM 
> events that would indicate low signal strength where iwd can actually 
> take some action.  Try setting a more aggressive roam threshold and 
> see if that helps?  man 5 iwd.config, RoamThreshold and RoamThreshold5G.
>
>>
>> kernel version is 6.6.0.
>>
>
> It could also be the kernel folks made some change that broke this. 
> For example, this looks to be touching the general area:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=37c20b2effe987b806c8de6d12978e4ffeff026f 
>
>
> Try reverting or using a version prior to that commit?

It does appear _something_ is wrong with QCM notifications in the 
kernel. There was an RFC fix with one user commenting that roaming in 
wpa_supplicant is broken as of 6.1. I am able to roam fine on ath11k 
with a stock 6.2 Ubuntu kernel so not sure if its only some drivers or what.

https://lore.kernel.org/linux-wireless/20231106231715.3a506ac2dadb.Ie774b85b9d4ff934a1236e77096cb9c6c9fe6561@changeid/

Thanks,

James

