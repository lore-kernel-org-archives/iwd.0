Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561AA181BB5
	for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233997; cv=none; b=R+ZZZVwPOA8jED6cnqfTzzFlhKUICHg6Yd+sGi1f3X7HZtV2LsPHUPBj8l0pIpy67HRiVwI8gkJKZYSCyGYcvPgwM6IUYq+rgCZwfIakKWIxJFK9cxoIOtAOkYqXLOetLPU7UASgXhQSMdRl4zvElRrbkcdSX52OICik79Ds95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233997; c=relaxed/simple;
	bh=MY8Z3SFTmPoFkkNetUcOaoelvieWGFcsIeNfkMlYNqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OO/D/hGQPKlpuKendl4lR22FVsPGZtaCxpcCeBYQYx0lSuiYXQpk8Buo7KL5GxwDutXCrqKqss7kp4AplEQjCRjL1bXCvXan1Vd2wMFMe7SVhrNYGJPD35xmDpFC4Cd95/UgjAEBj6GFZdhXiHQH29vUh5I8Euc+j5QujPVUbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhyPsIea; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhyPsIea"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c1d2f7ab69so588031eaf.3
        for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721233995; x=1721838795; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5L4bLaP6MNZZtHb7YbONlFK7PorUwC9YTeeRHO5va/U=;
        b=OhyPsIea1TIpmB1jg+f4QISbZ44A1wKxqBPEbwsoCGWQbwZTT7EBt7cGUy0SmKeVOn
         AWiLAL5udjMI/LG5vMejWbbKvjCvU/nehRmV3yEgavDB3lJNXb9BV69I5f5zv94k2iqr
         iYKgbQHsrGDUCQokshKjb3yRNOrt4EAXY5Qk4ibryGsjDr6mAH3fDuxaSAPKSKPcssOy
         MqiL7lDLL8+znabNo1SJPtCXrV7VtAwFQX5GJM3r9MGlo7PztT7KI9V6TIGOZHuhlT2d
         l+Lcubs7jBMreGfJ1ljBpCEQaTPdMUMS36RQL7B91ZmjKuYWc0fCtYhZbLBLm8QBNeh2
         XFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233995; x=1721838795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5L4bLaP6MNZZtHb7YbONlFK7PorUwC9YTeeRHO5va/U=;
        b=Fx//4QSbYwGZU7zweuDmmoWsnPONjJqdAHuEjCMH89CRQ5/6cp//bBJNGdbaRyRqTx
         /aQaQbgfm8NFvDcNeLk5mtNYvS7JObCcsLKND1MKLOw6NyhbFRrp0Cu/QVhJGCcOLCqm
         qhJDIAPB+YeCpuiurAFnIIQKzOUWSF/WNfRalVIJLG8dIpFqIRAGsTZDX9Eo+AQa6AE4
         dGr0Q1rFPAGuEKGr2xvfleNB9aRxuId/L3vU5Te5rmYtzszZmvkJlCMxH5/erdPh6ort
         YKi0XxltW1PWh6knF+CMbHBaWjOsJ1PY4NHIw+L3WqvQIU25Bglvyab5/4rZMxxCzvuC
         5U/A==
X-Forwarded-Encrypted: i=1; AJvYcCWUScTvxjhCXS24Rsm7eUjZ1k041AETSsbmJRfDs6GfqWr1hMR824xmkb8G2Bzfny0xVXndxZ6Po1wl+chOFk1hox8J
X-Gm-Message-State: AOJu0Yyno80gDL0DqhDt9w//3iqbIWENmDsIHGhKBMM/t7+GOoy6ppdZ
	BcohNhF3nShwNhToOymasnPzWDTlBJLJJjb9Z3OBm04/r3aW9K02
X-Google-Smtp-Source: AGHT+IFJcqad0TW0c0vpxVlG4ph5Q+u6tJT54ucR+VMz468BWDQA1z5xulWpBekx1f/vSrPPH3ARPg==
X-Received: by 2002:a05:6820:88f:b0:5c4:396e:4217 with SMTP id 006d021491bc7-5d4165556d7mr2947725eaf.0.1721233995278;
        Wed, 17 Jul 2024 09:33:15 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5d3ca599c74sm333288eaf.13.2024.07.17.09.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 09:33:15 -0700 (PDT)
Message-ID: <e006aeeb-9929-4787-864e-6f3a6993e62b@gmail.com>
Date: Wed, 17 Jul 2024 11:33:14 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: handle disconnect event during the 4-way
 handshake
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240717140009.2648885-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240717140009.2648885-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/17/24 9:00 AM, James Prestwood wrote:
> If a disconnect arrives during the 4-way handshake this would result
> in netdev sending a disconnect event to station. If this is a
> reassociation this case is unhandled in station and causes a hang as
> it expects any connection failure to be handled via the reassociation
> callback, not a random disconnect event.
> 
> To handle this case the disconnect event can check if there is a
> pending connect callback and call that instead of the event handler.
> 
> Below are logs showing the "Unexpected disconnect event" which
> prevents IWD from cleaning up its state and ultimately results in a
> hang:
> 
> Jul 16 18:16:13: src/station.c:station_transition_reassociate()
> Jul 16 18:16:13: event: state, old: connected, new: roaming
> Jul 16 18:16:13: src/wiphy.c:wiphy_radio_work_done() Work item 65 done
> Jul 16 18:16:13: src/wiphy.c:wiphy_radio_work_next() Starting work item 66
> Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> Jul 16 18:16:13: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
> Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> Jul 16 18:16:13: src/netdev.c:netdev_deauthenticate_event()
> Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
> Jul 16 18:16:13: src/station.c:station_netdev_event() Associating
> Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
> Jul 16 18:16:13: src/netdev.c:netdev_authenticate_event()
> Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
> Jul 16 18:16:13: src/netdev.c:netdev_associate_event()
> Jul 16 18:16:13: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
> Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
> Jul 16 18:16:13: src/netdev.c:netdev_connect_event()
> Jul 16 18:16:13: src/netdev.c:netdev_connect_event() aborting and ignore_connect_event not set, proceed
> Jul 16 18:16:13: src/netdev.c:netdev_connect_event() expect_connect_failure not set, proceed
> Jul 16 18:16:13: src/netdev.c:parse_request_ies()
> Jul 16 18:16:13: src/netdev.c:netdev_connect_event() Request / Response IEs parsed
> Jul 16 18:16:13: src/netdev.c:netdev_get_oci()
> Jul 16 18:16:13: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
> Jul 16 18:16:13: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
> Jul 16 18:16:13: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
> Jul 16 18:16:13: src/netdev.c:netdev_get_oci_cb() Obtained OCI: freq: 5220, width: 3, center1: 5210, center2: 0
> Jul 16 18:16:13: src/eapol.c:eapol_start()
> Jul 16 18:16:13: src/netdev.c:netdev_unicast_notify() Unicast notification Control Port Frame(129)
> Jul 16 18:16:13: src/netdev.c:netdev_control_port_frame_event()
> Jul 16 18:16:13: src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=6
> Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Control Port TX Status(139)
> Jul 16 18:16:14: src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
> Jul 16 18:16:14: src/netdev.c:netdev_cqm_event() Signal change event (above=1 signal=-60)
> Jul 16 18:16:17: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
> Jul 16 18:16:17: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> Jul 16 18:16:17: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
> Jul 16 18:16:17: src/netdev.c:netdev_deauthenticate_event()
> Jul 16 18:16:17: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> Jul 16 18:16:17: src/netdev.c:netdev_disconnect_event()
> Jul 16 18:16:17: Received Deauthentication event, reason: 15, from_ap: true
> Jul 16 18:16:17: src/wiphy.c:wiphy_radio_work_done() Work item 66 done
> Jul 16 18:16:17: src/station.c:station_disconnect_event() 6
> Jul 16 18:16:17: Unexpected disconnect event
> Jul 16 18:16:17: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
> Jul 16 18:16:17: src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> Jul 16 18:16:17: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is XX
> ---
>   src/netdev.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 

<snip>

> @@ -1310,9 +1312,20 @@ static void netdev_disconnect_event(struct l_genl_msg *msg,
>   
>   	event_filter = netdev->event_filter;
>   	event_data = netdev->user_data;
> +	connect_cb = netdev->connect_cb;
> +	user_data = netdev->user_data;
>   	netdev_connect_free(netdev);
>   
> -	if (!event_filter)
> +	/*
> +	 * If a deauth frame come in after the connect event during the 4-way
> +	 * handshake we need to handle this via the connect callback since its
> +	 * still effectively a connection failure.
> +	 */
> +	if (connect_cb) {
> +		connect_cb(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
> +				&reason_code, user_data);
> +		return;
> +	} else if (!event_filter)
>   		return;

Can we use netdev_disconnected() instead?

>   
>   	if (disconnect_by_ap)

Regards,
-Denis
