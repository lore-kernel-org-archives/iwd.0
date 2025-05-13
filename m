Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1FF1A83E8
	for <iwd@lists.linux.dev>; Tue, 13 May 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148647; cv=none; b=j1khWMvfSgUInc7xBDNDgsXkRlxGzqsfRFFXeIIMI6rhBxJlgiZrDey+UNqw6rHGo3vO316Ia5QMccilzyHd50izGNEovwxww6+OD1fOs+Q+FjtuE18f6U5+Zrd939KmcTDJbEKjTaXuHcGjUC9hLjm4JtGEKEQv1NUVtbTLaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148647; c=relaxed/simple;
	bh=43xx++o4uTnjgHoQXQVkWznsuofhJZ4RXeG54guknOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfMoQ78O+9rrkm5b0qrNJkeWHZ+eT1Vfi+Ov70U7wAKDmErk8endbwLq6lY+IaFzqWqQwF5D0Hs0+gPgViE1QSqUEIBgVP5s5EQx13Xd20EVKkcsYeCDcJkAzoQwTLx7HLizpv9/XXD+mU93luLVREMdSChZunRJO2fHKl5JyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E19puYC5; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E19puYC5"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-606668f8d51so3534920eaf.0
        for <iwd@lists.linux.dev>; Tue, 13 May 2025 08:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747148645; x=1747753445; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OdMGtjLFIcrdrNv9jN6bRUk9RHa4iwKrLXSmFvBS+E=;
        b=E19puYC5A7mZpMU3st0UYXV8WO+I06WxaiMuh1zWquibJAFRDxcjVrE+ShvNaeEOeh
         w1mwgLYUgyWh3agfj9URimsTxdhj41oLwhlOnhgrx8FUGOElwbL3kxIZDs7iNW2h4fKO
         hVJ+lSfityqWhFi7KzK7c3WZXH9MU7EjeIX5QwWv81H6ZEtb2ttDTkViBH6vhQMnr2Hx
         8UJ3/+/zRJ36zAt+6cMxOU5GcGSncXqya/ni8AIOg8M290XtXl+LAThqn0ht9vSKBbDW
         K1eH5+Gc54FKekViBSQFHbHZA2EWlLevTNWBYl6AnX172bZG4oYxNbFqH2/95gaO9oOX
         HqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148645; x=1747753445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OdMGtjLFIcrdrNv9jN6bRUk9RHa4iwKrLXSmFvBS+E=;
        b=c7V4cJ8Um6RaqP2H9qecyLhCEWJPEwLlU4jGUf4LcDtuFszRjS3zNKscXVXYac35FM
         WfE/EO7GsTUXBMuCSqai9licfbidJtunji0cQeR1GCjdFaTLsZyvTVce7UeUtk4B53Uc
         +a5Sr4elF+GQMfEsV0LXJx1wVrwhXqak7TDUUSE4RdWvDhFc9CfGLaRoLw7EKSQfRq3k
         wIlVacgmT0b31SDaVwPU5AdKOd03m7bwoksYhuksVi2iuUrhynorKq5DXeOaka7D+S+K
         TyxIVj75TNOvRzorLD/1xMgcR+OXBkPVOAf27Phh/FARnvXoR8SJwQfaj4Bm2VxIk9ua
         YpFA==
X-Forwarded-Encrypted: i=1; AJvYcCVghpgKniJ5l8bFRCxvfWmTLGA9e+sg9nB/zzmypyJky0KvniSOE73fm7SSQ0AoQ1n3S1Q=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyygq0rTlYLF6/2c+pyS9a7+7P4hOfEGdHD2NYnyn/47H9C0XEK
	PaOjP1JcuLuNEtuDqzmXtzHivP14wV7dfA4CQ9qwHFjCHlvA/p8E
X-Gm-Gg: ASbGncuHJIgDvXtD2hdm1wvamCtpSbq7/51J6q6VHzlfAyNN75t9TFJ57igLl1Jc7Cp
	YuA2IWw452TJV1M1Aa1nt1s5VeQTrRpJhskJOX8SxbGNlGElHiCm/7otaBbc98k2P9TlmlSZI2f
	tEmKGhQjgdAI+eq0F+23B0SMGL++4zh9h3cX5HC63tUea8LID/USAem+PPNbdrdGG98h8D0sAEC
	loeiNuMO2DsGkpCRmDcQBP5NA4HOasEZCXCIvuTlzrg2uq9rjHreFv50zNM0Kxp4BePO74ZmEBH
	sEtG2HEUBPMbzHZJqvgzB1LLMErWlyPycYo9CayrSYWEluSHiVLVZ+i2DaEKnki3amgX+ScvxRu
	v/rUjdb/kj8iP5Dlw
X-Google-Smtp-Source: AGHT+IFn6w77ozGG4F0ly97ZAaxGXJU3dRqw6wttJRWEMPmPnlsbu/Uvwz4gVMaM/S2DxGo7v2KOtg==
X-Received: by 2002:a05:6820:1f01:b0:600:5673:69ef with SMTP id 006d021491bc7-609d3082ebfmr2243716eaf.1.1747148644830;
        Tue, 13 May 2025 08:04:04 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b09865sm1946381eaf.32.2025.05.13.08.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 08:04:04 -0700 (PDT)
Message-ID: <f413e1d5-a10b-4317-86b0-2c1cb0dc3df7@gmail.com>
Date: Tue, 13 May 2025 10:04:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
To: Johannes Berg <johannes@sipsolutions.net>,
 Jan Hendrik Farr <kernel@jfarr.cc>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com> <aB4HC8Iaa6wR5dj7@archlinux>
 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com> <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
 <aCMtCCYtNNl4dL5Q@archlinux> <562c4ac5-088d-4bab-9883-1d4f8eca2b2a@gmail.com>
 <eb59751ab2a22adc6237c05cb0a5519657498613.camel@sipsolutions.net>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <eb59751ab2a22adc6237c05cb0a5519657498613.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

On 5/13/25 9:53 AM, Johannes Berg wrote:
> On Tue, 2025-05-13 at 09:03 -0500, Denis Kenzior wrote:
>> Hi Jan,
>>
>>   >
>>> There is a an SAE confirm sent by the AP. It's frame 170 in
>>> capture2.pcapng. It's also retried a number of times after that.
>>>
>>
>> What I also find interesting is that the kernel on the client side reports
>> sending the Authenticate-Confirm 3 times (according to dmesg and trace2.dat),
>> but only a single Confirm from the client is seen in the air trace.  I'm
>> guessing the retransmissions (attempt 2 & 3) are lost somehow?.
>>
>> [64414.164169] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 2/3)
>> [64415.063575] iwlwifi 0000:00:14.3: Not associated and the session protection
>> is over already...
>> [64415.063668] wlan0: Connection to AP 96:2a:6f:b6:d7:9f lost
>> [64416.215729] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 3/3)
>>
> 
> I think it's expecting a confirm in response, but that was already lost
> before.

Sorry, what is 'it' referring to here?

iwd sends the Commit and Confirm via CMD_AUTHENTICATE.  You can see that Commit 
frame from the AP was received and then iwd submits a Confirm to the kernel:

May 09 22:10:56 archlinux iwd[31729]: [SAE]: Sending Commit to 96:2a:6f:b6:d7:9f
May 09 22:10:56 archlinux iwd[31729]: [SAE]: Received frame transaction=1 
status=126 state=committed
May 09 22:10:56 archlinux iwd[31729]: [SAE]: Sending Confirm to 
96:2a:6f:b6:d7:9f sc=1

The kernel then transmits the Confirm three times, but attempt 2 and 3 somehow 
never make it out over the air.  I find that strange since they should still go 
out, regardless whether the Confirm from the AP was lost initially.

Regards,
-Denis
