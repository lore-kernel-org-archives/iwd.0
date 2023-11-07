Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36063159C
	for <iwd@lists.linux.dev>; Tue,  7 Nov 2023 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpfH4MNZ"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2e330033fso3466568b6e.3
        for <iwd@lists.linux.dev>; Tue, 07 Nov 2023 07:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699371930; x=1699976730; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73vE/5/6/ZDKUdzzb9AjAJVNOAsEEiW0rRZJZ6NmzDo=;
        b=KpfH4MNZ35vbA0WUIuQNczxvE2Dln/+YWCna0O1AKpfLBgKLhPFw6B4Po8oNlF/OXy
         qiZRMUtFiJE0F5mZAynx5K4sh0fc69mk9OTSj5BXPqKqxrAvpJryQR2HtOz05/bdbfpy
         omhiblnXUpskaWxp7sEjj1/GSCp3S4/Ub9376ROxKmIyDQTf8MXjkKhcMfGBIcNyRQy1
         u5gQbtFHpcs6pWozpc8dO4WYsrs41E2U3M92dpXr2YvIcXzED0EWeGrDK9JDVv4Aeblk
         tSXRLoRLf0Go7z5+XVCiM9E2O1lxsZSqdJj3vwy4Bjh9tC0bm+4z31TfnSuWKdnUQA4D
         TrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699371930; x=1699976730;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73vE/5/6/ZDKUdzzb9AjAJVNOAsEEiW0rRZJZ6NmzDo=;
        b=n/DDQzD07TgnSQ7DUriRft2sWllY6PM5C1NZWIKw57w1Gxr45MQxsm5DBAWToGTg6c
         0HlrZemFPWwjpvTUMX8eMrC5qpOCsUTjp1Hp0eJoqsXB4fW6Oau1WLnjJBVbqRDs2S2e
         gRHurJiNnb29zAWxVM51ovaqeMKBra9nsmC+GVoXBy4of+bf/8HJksqFbH2bD5Dsxik+
         JR45DnnWJZoUqBxdNELrv6Fpvqz0lB5H7MDr8SLsuVkE2cTp7M+ynN1rf7c+SHVwG9O2
         PnCHMj4Nb9G0/ghR5qYJeBGsSO787k8n+GFEUPO8njJmVbKtIfo8MW8rO60t6cRYtbl6
         wr+w==
X-Gm-Message-State: AOJu0YwWm3/ZaWIhfj9h+dbq/x8mBz97A3LF2+BgCbEXLDTevN4yGj51
	t9/osOv1tYd1kyRai13bG3k=
X-Google-Smtp-Source: AGHT+IFRe1a0u40YwHzOGNyd3aT5lC0JjNtl94Lxkb+0DvbA5sqE7sqnAAnjRcAvJEiBp6/A1Oluzw==
X-Received: by 2002:a05:6808:649:b0:3b2:db24:6384 with SMTP id z9-20020a056808064900b003b2db246384mr32680627oih.38.1699371929884;
        Tue, 07 Nov 2023 07:45:29 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f13-20020a05680814cd00b003a78d196acasm1604361oiw.32.2023.11.07.07.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:45:29 -0800 (PST)
Message-ID: <ced2eb2b-187f-4d4e-bffa-b1e8b46233ca@gmail.com>
Date: Tue, 7 Nov 2023 09:45:27 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] station: start roam on beacon loss event
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231107141140.1706441-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231107141140.1706441-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/7/23 08:11, James Prestwood wrote:
> Beacon loss handling was removed in the past because it was
> determined that this even always resulted in a disconnect. This
> was short sighted and not always true. The default kernel behavior
> waits for 7 lost beacons before emitting this event, then sends
> either a few nullfuncs or probe requests to the BSS to determine
> if its really gone. If these come back successfully the connection
> will remain alive. This can give IWD some time to roam in some
> cases so we should be handling this event.
> 
> Since beacon loss indicates a very poor connection the roam scan
> is delayed by a few seconds in order to give the kernel a chance
> to send the nullfuncs/probes or receive more beacons. This may
> result in a disconnect, but it would have happened anyways.
> Attempting a roam mainly handles the case when the connection can
> be maintained after beacon loss, but is still poor.
> ---
>   src/netdev.h  |  1 +
>   src/station.c | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+)
> 
> v2:
>   * Delay the roam to give the kernel a chance to salvage the
>     connection
> 
> FYI, I did attempt to add back the beacon loss test without much
> luck. Blocking beacons with hwsim did not result in a beacon loss
> event which may have been one of the reasons it was removed in the
> first place. Even blocking _all_ frames doesn't result in an event
> but instead just a local disconnect.

Good info, thanks for doing this.  Guess we'll have to rely on manual testing 
for this feature. :(

> 
> After looking more into it I see that actually only a few drivers
> even use ieee80211_beacon_loss/ieee80211_connection_loss:
> 
> iwlwifi,wl1251,intersil,mt76,wfx,ath10/11k,wcn36xx
> 
> Every other driver likely disconnects rather than attempts to
> handle beacon loss. So probably for the majority of users this
> actually didn't matter, but for these drivers it does make sense
> to handle the event.
> 

All applied, thanks.

Regards,
-Denis

