Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2191879
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 05:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPh3y8/x"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d81580d696so901881a34.2
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 21:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701061246; x=1701666046; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mV4Hwfvcsf+EDasYAX1WaIf9Mimt0FqGog/rd7MxQ1k=;
        b=nPh3y8/xFK6hPH4j1KnU1+nhA4c8y6OSDkLtCrTPCNZaG8iXxECFoA27VwHDeA68zs
         vNcDfCti+kefbIpw8mFweuhLGnxO5HxFmKS38auikFP9JZnxayr1xP3uqaIXSE9uMvlw
         luilWw6zKo49YS6Vn+Td10/SLGu6xs8SfWkhpjXXhJknrGhiR5TAc7zo+BQ/0B7wgZSz
         qfqln5tBTWZX+N1kJUXAPtW1oWsdsFxGnvkJW8vAZS6QFofbqtmwuwM1LHIL2/cxiV+D
         ePIrTLo7yJVoJDZyAjpHFvQfMetPm3RkJJmp/69NakO80aiwnNvlshufiUeVqpCSiMzU
         kJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701061246; x=1701666046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mV4Hwfvcsf+EDasYAX1WaIf9Mimt0FqGog/rd7MxQ1k=;
        b=WmhejDuE5bv/GeWw3fDiIKwLEKexYqlT/jzxY2vJdSn08ItDAOUyJHv4o6Ovnnzpcv
         eKw34DAl5Z/HYJuZSkaEHse660sCuI10wyfov1B6CqKnqe7nTrwowkuZ2i/Dw1NwFvI5
         mNJ2DvbNJD1mjsq2VbJXMdqijaYPrrjn3uAyiNlHBy5k7EBCvDHhjew8y0qTNSZ6sF6S
         8y4JNA3UzXu1BygoX9NTvNZFRpau+uQqZM1XO60dkVc680P+vizw11oXKQqeFqvP3/bs
         RdOZY+CUVDFerAXcXr5O4tfBRhymqoUlnqNF8gOLlUeMbmKRGnT/I5W541vG8pgw9Hl+
         rvyw==
X-Gm-Message-State: AOJu0YxgqmWvWXEkJCs7/6vn9xYDtECqR2Phy8tzD6RKiDe/DmajMV5d
	uNG1JRv2NXARAEAc9I3TYvjNsdRps9k=
X-Google-Smtp-Source: AGHT+IHNuuZRAuoazWIqc8QxXRSEClk+fpcosNyu9NPDdhKkRltPpv6K8/gLZQMGl/UHCHe3hs58oQ==
X-Received: by 2002:a05:6871:e7c9:b0:1fa:306f:60d with SMTP id qc9-20020a056871e7c900b001fa306f060dmr7378009oac.4.1701061245945;
        Sun, 26 Nov 2023 21:00:45 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id qh14-20020a056870bf0e00b001eb79fedbb1sm2117718oab.17.2023.11.26.21.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 21:00:45 -0800 (PST)
Message-ID: <8212f44e-d7f1-4b5c-9ffb-043a01b4d16b@gmail.com>
Date: Sun, 26 Nov 2023 23:00:44 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: roaming issues on a residential LAN with multiple APs
Content-Language: en-US
To: Daniel Barter <danielbarter@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAJODeCBYQ3bwRjZjZoZ+AX+QG84U=VO_UEoa0AuWmFAqxunn4Q@mail.gmail.com>
 <0331a3f5-7d04-49d0-b569-3e5fa5b4514d@gmail.com>
 <CAJODeCDu-85P54m16FanJftz2mC-fVGN-PXrwk4q+yS8n6mwFQ@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAJODeCDu-85P54m16FanJftz2mC-fVGN-PXrwk4q+yS8n6mwFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 11/25/23 18:32, Daniel Barter wrote:
> here are my logs:
> https://gist.github.com/danielbarter/65ddf6aee78546a0e8f9e2d3af65308c
> 
> notice that this is a mix of iwd 2.4 (my distro default) and iwd 2.8.
> 
> Default roaming thresholds are in the 70s right? I am getting down to
> -90dBm without a roam happening.

Default thresholds are -70 db for 2.4 Ghz and -76 for 5Ghz.

I'm not seeing any CQM events in your log, except for this one:

Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify() MLME 
notification Notify CQM(64)
Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_cqm_event() Beacon lost event
Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify() MLME 
notification Notify CQM(64)
Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_cqm_event() Beacon lost event
Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_link_notify() event 16 on 
ifindex 3
Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify() MLME 
notification Del Station(20)
Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify() MLME 
notification Deauthenticate(39)
Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_deauthenticate_event()
Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_mlme_notify() MLME 
notification Disconnect(48)
Nov 24 16:34:15 jasper iwd[768]: src/netdev.c:netdev_disconnect_event()
Nov 24 16:34:15 jasper iwd[768]: Received Deauthentication event, reason: 4, 
from_ap: false
Nov 24 16:34:15 jasper iwd[768]: src/station.c:station_disconnect_event() 3
Nov 24 16:34:15 jasper iwd[768]: src/station.c:station_disassociated() 3
Nov 24 16:34:15 jasper iwd[768]: src/station.c:station_reset_connection_state() 3
Nov 24 16:34:15 jasper iwd[768]: src/station.c:station_roam_state_clear() 3
Nov 24 16:34:15 jasper iwd[768]: src/station.c:station_enter_state() Old State: 
connected, new state: disconnected

Basically a lost-beacon event comes in (twice for some reason) and we're 
disconnected almost instantly after that.  There's no other CQM events that 
would indicate low signal strength where iwd can actually take some action.  Try 
setting a more aggressive roam threshold and see if that helps?  man 5 
iwd.config, RoamThreshold and RoamThreshold5G.

> 
> kernel version is 6.6.0.
> 

It could also be the kernel folks made some change that broke this. For example, 
this looks to be touching the general area:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=37c20b2effe987b806c8de6d12978e4ffeff026f

Try reverting or using a version prior to that commit?

Regards,
-Denis
