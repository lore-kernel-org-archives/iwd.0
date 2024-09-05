Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE219EEA0
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548948; cv=none; b=G3+oXvpy3tfDNWS/wFgY5HkQF00yXelmYVoT1LE5lfPC0wvMlA5ezX4nFmPciXjbTEp/Lq9QPtRq40H80K3Az2Tz6/O4XpZPWbmigATtqKSEEc1TtKTO4zVy1Gkw0kwk0Eu5lhiYdxRw82rInAuNt2RWV27HQqM7G8mwaWP1hfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548948; c=relaxed/simple;
	bh=rnh0PROORrkODut16bHeyZN6ml0m8jI6AjH0nXKaGyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDOTZ3BgM9TwAQJW6eOMgr+aKQvNOuRVwBy7A8TF9rA/HIedoBWjOlYkCRnuEm/Ptz+3F/6Cp/O4CJ7SBrBRk54xwJJWKXZqgltdxERf0K8KBxxUsyRBr8e8qv/PT4XM8eDw5GPszflbZtGkoMWRykkhyC9r2rd2XtgoksKZrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa30x5+k; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa30x5+k"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a8160a710aso58315285a.1
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725548946; x=1726153746; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlRF3qIHQJfNIDsOODdFaxRoDNTuktMtrfNRmK4t1Kk=;
        b=Sa30x5+k3TEVwQgmackSJa3uBAQvk2VefKLLX0ilSyu4U/xaVzdiOM9oArlSp6hazc
         ql/2tTIjNe1/Sy9oU8dm+gdlHxfGwxpCWL1sGF9LwVYRAXiHbx/hup4DqVTUksAQF3r4
         hoCcisfY4kI4TXagaqm6fTBBqRxKd+XjINTBqDNFblhNWj3HjuiA36bmMblH37u2uosF
         SUJN6QlGOZ012+pkna20cKcK6DAoqo92NJQwaZkrPFlt+IGD51t4NRzJtAZX/TR0fJp7
         tuwLcdCoKi7td4ljQ85BT9DXRq3otUQI5kATlCK2JoeNjJ5sFkNSSiyhl2aNNw5/y+uP
         pu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725548946; x=1726153746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlRF3qIHQJfNIDsOODdFaxRoDNTuktMtrfNRmK4t1Kk=;
        b=EhbSOmqeL1yRfChLwzSNksY21XI9Vg5RauEPvCBpyA/t/uuLfIT6JO8YEWdXMGkEzO
         eTmtVAZZIJyfSFgQwr2pBmbbiNu6iHJZ4Yoc+yQ5KyMbgXgh6Xge/bbpjImudFSHp7tS
         c0D3HH3GvYEY8vld7TXrN4eRTsKGzl3TaQ37RPHCDO0X32rCRL1KCTqPVtz4XfPlJimh
         iZUjtYWiHl3ZUexhnzm6DaiJAzwtWdC6QeTncszynB5Ob8NFG4RUChD4YKP2IZ/xSXt1
         wL5ffBdPUgAjlNII4ti9ebX49sLWqflvQMX8DWhDiwhSwokVXbsCK14IRLsUd2/AMOff
         lBeg==
X-Forwarded-Encrypted: i=1; AJvYcCWLX8pri1YLc8H9CxMyJ0kfodwCBvVsigZxNjElo+Ng5enyDIttXcYV+7yPk0cXE1JfwJg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz307N/kUd7mAekcHHpzl1FcD2b9nNeMMsN508s0MX0ENw+2fl9
	D/UJrIXK6okN6jFo4dLJxVVwDmvBqWRaC1CbKZjuLzJ+aOdX8cd/
X-Google-Smtp-Source: AGHT+IG9hoJXOBDYYGmCG1RvDFbLijTV0bXOah2UzPLxPDjqL+ZQ9Aoo8KNMKOsfrjzw3GvTYC6i6Q==
X-Received: by 2002:a05:620a:1903:b0:79e:ffa3:d6a5 with SMTP id af79cd13be357-7a8ac3fbdb5mr1985091585a.64.1725548945889;
        Thu, 05 Sep 2024 08:09:05 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef380a2sm81995885a.31.2024.09.05.08.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 08:09:05 -0700 (PDT)
Message-ID: <e82acb54-3b2a-49cf-91c3-0adabfc574fc@gmail.com>
Date: Thu, 5 Sep 2024 08:09:03 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scan: check scan request in get_survey_done before
 deref
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Cc: Daniel Bond <danielbondno@gmail.com>
References: <20240905134315.374800-1-prestwoj@gmail.com>
 <fb4b3b86-e659-448b-bfb9-cfba35c2b87b@gmail.com>
 <1fc65fe7-3e6f-4953-973c-84bde72bb2d1@gmail.com>
 <4d66fa8f-7499-4d68-9087-6e3bf6aa876e@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <4d66fa8f-7499-4d68-9087-6e3bf6aa876e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 9/5/24 7:57 AM, Denis Kenzior wrote:
> Hi James,
>
>>> Do we know why external scans are happening?  I can understand a one 
>>> off because someone triggered iw scan, but from the bug report it 
>>> sounded like it was crashing iwd repeatedly?
>> NetworkManager? wpa_supplicant running? I really have no idea. Either 
>> way its out of our control.
>
> Would be good to know and fix that.
>
>>>
>>> I still don't understand why we're even bothering requesting a 
>>> survey for a scan we didn't trigger?  In other words, we shouldn't 
>>> even be in this function.
>> Because we still utilize external scan results for periodic scans. So 
>> if periodic scans are running we will still try and get the 
>> survey/results.
>
> Should we though?  I'm not really sure how surveys are implemented at 
> the driver level.  Are you sure this isn't introducing other timing 
> problems?

So looking at the nl80211 code it is actually making a driver call for 
surveys, versus GET_SCAN simply returns the list. I can't speak to the 
implementation but based on testing several cards it appears that 
GET_SURVEY was always gathering data from the last scan request. E.g. if 
you do a limited scan then survey it will only have updated results for 
those limited frequencies.

But anyways, if this seems sketchy to you I'm also fine skipping the 
survey and only doing GET_SCAN in the case of external scans. I guess 
without knowing what the driver is doing a survey could in theory take 
an excessive amount of time and cause unintended behavior, like if our 
own internal scan got issued during that.

Thanks,

James

>
> Regards,
> -Denis
