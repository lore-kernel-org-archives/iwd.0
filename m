Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2213B7B7
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940543; cv=none; b=MdcChvYBJlfEQ0Q7RoKDaOvpRhK5zKO6UpTDacpq1c3dAzVFGgHNJ/97jnH/pf00k4rooA7zy+kG3BIz9b+YbG8cTZ216sgK3fGcGttZpm1+UIfa2pnvJ5+Vh8Ur2BEutVFaK8nayUsCF4Tq5BT+ysUrVZG9nXLl5fsZ4nX/YSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940543; c=relaxed/simple;
	bh=YTOxNI/hiuBRUV2L3iyW4urhPMPafQ2NS57SUStXIbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNCX0ApIzHG2j2g4nAimM/sxLlESpRc+RjU2KVW6TfYyEbx5PMJCqXeoLZi3Uy2DDrJR8ENlqUhvfwP28rz7hXbUwAqYvuREhgzB8xqqxQ+ew57uzOnVZSt16o+xglP5GAB3WauEqDs7z/0LNyljVNfqxcCTRkVOpWLg2A16l14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erJL07WX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erJL07WX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d8da50bffaso561015ad.2
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 11:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707940541; x=1708545341; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsaF/IHhsph2j+F12jp0QKBHflZblOX9nhPGTtvGcYU=;
        b=erJL07WX2e0T/RplQZtUgzxGmuXGLkeNECjAHx1e089kR7NousImWoAxmvbNOm9fI4
         FsOxvgfZLtJ1wM+37mwjtDEcx86rAHyDwYeg9AD15ALbKSrE0bhWtv4NuiXzBWHFZb5y
         fXQv/gw+7CadpWUxm42K7OOgwO99c4xKcElRDzzogycgldJprTL2oItMUjoqJA3jEFWq
         FU6fOsAgBYiwtBbLx7+9QB4URhtS6t7xOMeyTB0MO2AaBRHeyIx4GCp1LE4WDP+Qo67r
         rGpuRVVBjFTsD6Rvra6OVifNilxYm+DeVdBcvtmF95UU90q7hU8udyH/75iU94eavM1y
         XVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707940541; x=1708545341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsaF/IHhsph2j+F12jp0QKBHflZblOX9nhPGTtvGcYU=;
        b=e42Zrjv9GnUnEkCoE7bRTtxONosxxOEF3bAiRjd76cCIEax33AvErvJP2y3NdIC9jj
         0KzQcTeVCplDQEkcYU+2HuE3FCXN8Tx2w51hzFFoNs81lg0bHXL5hle8HsxT+Ri7oDGY
         /rIYvgBfOog8Xjk7X0MzYQOysoqY6jumWM8uBih35KP9+Cb+7oAhkaX7GytDMs4B/4UY
         R6JFPvTY5VKRo+PXXIYamGEu4kvb401mn2qSKxROsSTxZ7tBeWIIFoy7gAOPn356NhKb
         2iwrI/75c0kYefuvy14Qg5fJNR89rdHT4yq8a+kr3Dov+3T9XjgsQOLo2lkFiA4x74nc
         yoYg==
X-Gm-Message-State: AOJu0YyK6ujPQcahXprdGGX+pqnSBWj5GvsKZN0TYqGhQuJj8b+8KoSy
	4tEpartpRXddUmPq8aoXxhrWYD3KfxuZA5Pf68zh2hYJ84H3FNlGbNZeYYj/Rp0=
X-Google-Smtp-Source: AGHT+IGZXgUzMckrRTil0iCml0B2wtB19dX03f0WOxy+3TZjpWg2M3zV/KSZdxcZa50mFCU+zmrHvg==
X-Received: by 2002:a17:903:18f:b0:1da:240b:545 with SMTP id z15-20020a170903018f00b001da240b0545mr5251816plg.20.1707940541040;
        Wed, 14 Feb 2024 11:55:41 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902e04500b001db5753e8b8sm1666685plx.218.2024.02.14.11.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 11:55:40 -0800 (PST)
Message-ID: <d9a38d47-e188-4e24-a397-515c0f525e8d@gmail.com>
Date: Wed, 14 Feb 2024 11:55:38 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] doc: document use of l_log APIs
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
References: <20240214193743.963349-1-prestwoj@gmail.com>
 <20240214193743.963349-6-prestwoj@gmail.com>
 <1DB84D8A-74F6-43EC-9E27-A477FD343F0E@holtmann.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <1DB84D8A-74F6-43EC-9E27-A477FD343F0E@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 2/14/24 11:49 AM, Marcel Holtmann wrote:
> Hi James,
>
>> With the introduction of l_notice in IWD some guidelines need to be
>> set for l_info, l_warn, l_error, l_debug and l_notice.
>> ---
>> doc/coding-style.txt | 24 ++++++++++++++++++++++++
>> 1 file changed, 24 insertions(+)
>>
>> diff --git a/doc/coding-style.txt b/doc/coding-style.txt
>> index bf0535c5..fdd9e0e3 100644
>> --- a/doc/coding-style.txt
>> +++ b/doc/coding-style.txt
>> @@ -317,6 +317,30 @@ Functions that are static should not be forward-declared.  The only exception
>> to this rule is if a circular dependency condition exists, and the forward
>> declaration cannot be avoided.
>>
>> +M18: Use appropriate logging levels
>> +===================================
>> +An appropriate log level should be used depending on the type of message
>> +being logged. Logging is done using the l_log APIs in ELL:
>> +
>> +l_info    Information that is expected during normal operation. l_info's use
>> +          should be very limited so non-debug logs are concise
>> +l_warn    An unexpected, but non-fatal condition ocurred
>> +l_error   An unexpected condition ocurred. These are generally fatal to the
>> +          current connection/protocol that is running but not generally to IWD's
>> +          overall operation.
>> +l_debug   General debugging. These can be used relatively freely but should
>> +          provide some piece of useful information.
>> +l_notice  Reserved for specific event-type notifications about IWD's internal
>> +          state. These are logs that are mean to be both human-readable and
>> +          parsed by tooling so they are required to be of a certain syntax. They
>> +          should start with "event: <name>" followed by comma separated key
>> +          value pairs containing the data of interest. Event names and their
>> +          arguments should be consistent across the code base, i.e. two events
>> +          called in different locations should have the same arguments.
> and now they are not even in order of their log level. That confuses people.
You mean just the order they appear in this document or using l_notice 
for this purpose in general?
>
>> +
>> +          For example:
>> +
>> +          l_notice("event: mycondition, arg1: value1, arg2: value2, ...");
> Please no semantics for the freeform text. If you want that, then better build some proper iwd_log functionality that does that.
The intent was to use l_notice only for this purpose so I felt 
describing the specific semantics was appropriate. I can remove the 
example but since the intended use is very specific and has some syntax 
requirements I think describing those here is needed.
>
> Regards
>
> Marcel
>
