Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254257CF18
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113125; cv=none; b=RMrQyewZQhZBScSzbE4+jgdIfljaPFFsciqg3h318Yq9hPlpWqkFErszz03aU4yqTVf/QrkBHLDZ99Y0Q7bD2YGJBSRMjXuZLQyFLp1YM8DvP0qU2PehCqnmv+ZDZoSvc8VslliUmW0zSQABPv7f2q+NxkP0/hVJgmrs9AtZDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113125; c=relaxed/simple;
	bh=KxhtKZJu7CTh3kCJDsZg0NZEmQ9cNVFpeV++rXamQJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtTQ8duTiP6MYUXDHZZjvqp81KS3zD435cpgrU/AuEGz/7ZUT+nLso8mxJaqqFzFyAVRAhFzY5mVJbPjEcOJBTIMc0s8ExkIw17WCB4rqjs2zMpFS0l5Eep9bCMTManAs1TuA3looMsiHhJCe315iY6Nyh9FinesdOpIogXk1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckgxZR6r; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckgxZR6r"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bda4bd14e2so4354752b6e.2
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706113123; x=1706717923; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOHqj1MsEqRCajS/bu8f8X6QA23ZVK3DxcrKy2sXvI0=;
        b=ckgxZR6rdzFf3YsqhtZeDTCoekBGYYhv/J8PSWdehToUP1wQ80WHQUwId0vzVPJxv+
         3SWbEeA1vKXGIpOEvYxnH3kSpbRMTJKpQSw+SLwavb0eAQXIu4OHOes8httSjKuu+QNI
         Sec1qR1/cOjMqOLMQoCNPFPylU1K91QOa7Fk8AOZd4FxgwTIIOJcZ21QX8eBM53I0kxZ
         8ooJZUgT5lfjRxTYRTf0UOZPiA32tDdLpeWPuHl+jf0xsrERoFGw9aH8WOt2Fz3pX+QO
         95lXrl98lnanH9acJ5+wIkT/Tifs3MWAXCTrLI36DsOp4/Uk5f/OFEoH9uSXw2Uq0EUP
         f4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706113123; x=1706717923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOHqj1MsEqRCajS/bu8f8X6QA23ZVK3DxcrKy2sXvI0=;
        b=uxXt7UyGyqgPas7REw8LdYoOg9+SkAzOhe50xIBfn1OEZykg4dDpbU5fMDMQqdI+qH
         vXKtB1/CkzNfhBu2inMAfe0Osu8Abhan4C9yLRfgUjjBMuOjNFBTq25jV4SCdWUA7LQR
         gqw26Ztiv4PomOasZgt2JdhCRU8s9Yka9VbyQLwFYZBR7atvUP75GJSdPM8R1d7hnV6e
         383murnRtWrbA1942pVH4aJJdVsn6UQIYMZqfw5zxaKm5at8yicVVg4xfto1Eljg9naB
         Asv496Y48oO8a1LbvMyB5b6T7F7FFslou0Gwd4nLhgtWZZczUk80FrflAfwxA49qrytO
         WGxA==
X-Gm-Message-State: AOJu0YwHTRo8GOfGkb/pOknVN8TNTIMjnCEO5QVi9goT0gnb+9xL4Iao
	u7qriC/MpM+Fibg8VYG0rvjn0ssFMoTTKKvV+SpCUa8M9yvXDyu5ajQCeN14
X-Google-Smtp-Source: AGHT+IE+nfcD4OqLfR1OcL3e6AUg1SZ46cBinf8kqsGdYeBd68Qvn3Mi7OCEHsHmsNF3dRAJjfNMIg==
X-Received: by 2002:a05:6808:1899:b0:3bd:cbf6:c02e with SMTP id bi25-20020a056808189900b003bdcbf6c02emr2207002oib.15.1706113123161;
        Wed, 24 Jan 2024 08:18:43 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bw11-20020a056808244b00b003bd9d23123asm2569917oib.46.2024.01.24.08.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 08:18:42 -0800 (PST)
Message-ID: <0bae4724-6d12-4e5e-9f6a-37f5e93ba40a@gmail.com>
Date: Wed, 24 Jan 2024 10:18:41 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to Autoconnect Two WiFi Cards?
Content-Language: en-US
To: Fabian Herb <fabian.herb@xtonomy.ai>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
 <e3e82ef7-941c-4dbb-9f1b-2d1579a12f74@gmail.com>
 <D88835CF-16B7-4658-8852-65C4C3767E9C@xtonomy.ai>
 <ef97ec13-8f6c-4198-bf19-ff50a3e596f1@gmail.com>
 <E8931256-9BC5-4563-8A26-6A346560F34A@xtonomy.ai>
 <69a80bff-f587-48da-a14e-8897586c93e9@gmail.com>
 <FAC36784-F498-481A-BD35-D3F24269EBD5@xtonomy.ai>
 <d3ccf10a-72a8-43b8-8f1c-b5e2a76214ac@gmail.com>
 <A3545185-22E7-4491-AD80-FFF9FEDCB8F1@xtonomy.ai>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <A3545185-22E7-4491-AD80-FFF9FEDCB8F1@xtonomy.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Fabian,

On 1/24/24 10:07, Fabian Herb wrote:
> Hi Denis,
> 
>>   - When considering a network, first check whether a network with the same SSID/security type is being connected to by other stations managed by iwd
>>   - This should be easy to do by looping of the station_list and checking connected_network / connected_bss members of struct station.
>>   - If the networks match, just skip it and continue on to the next autoconnect target.
>>   - This should result in each station object connecting to a different SSID. Once latched onto the SSID, station will try to roam only within that network.
> 
> Thanks for the hint! But wouldn’t that mean that it’s basically random which interface connects to which SSID? Right now I’m configuring IPs and routing via systemd-networkd for each

Yes, but if your cards are identical, does it matter?  If your cards have 
asymmetric capabilities, things are a bit trickier, but that would be the realm 
of defining a policy iwd can follow.

  interface, and that would stop working if the two interfaces are connected the 
wrong way

Make your policy smarter.  For example, have it consider the SSID instead of the 
interface name?

around. The approach also screams for race conditions :D.
Not really.  There would be corner cases of course, for example if there's only 
a single SSID to connect to the second card will never connect.

> 
> I was thinking about something like this:
> - Add a configuration option to the network file format which holds an interface name

interface names are made up by iwd itself, and are not static across things like 
hardware hotplug/unplug.  Yes you can beat iwd into honoring the name coming in 
from the kernel, or with some care, from udev renaming, but even those are not 
guaranteed to be static.  What you really want to take into account is the 
underlying hardware capabilities.

> - When iterating the list of networks to autoconnect to, skip the entries for which the interface name is set AND it does not match the current interface.

Yeah, NM does something similar.  But see above.

Regards,
-Denis
