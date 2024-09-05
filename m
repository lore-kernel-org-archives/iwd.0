Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940AC17BA5
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547492; cv=none; b=Aadf5Yy0kXA9wQAGZcyQ/EXSZJjrU1pcWcd1yVJWkjOeWczRy5cXYrYT3wrjNoaKjoQX4BaIstYd4SR1l3V5nuf8iYmQQ4Ug8Ps9HU5QAWw4VMzYGV9Mc6oyLUTJ45aTrA/VRVwyct/8xJ6WnmWHyzR/xKkAfK59N4kP/PEvSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547492; c=relaxed/simple;
	bh=L/T/fm1717tB+7H4knesZLHpZiQLUndr0acQW8eh9jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfeAnp9xkve8Q2tRW/2hURRg01u+k2qx/9+XYAHKEeCFVGI3FsnQAbQ7AjaFzp0Eq3B/t8yxJcNwz3os3FWkJASyuIrCi5NEkjTsw3XVI4wEf9E1Q8FTZkuXvcsB4uxXteZrCnH1/dwJ3maGn9omE4wP9nkEnuaKz2NM1UcgQv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPEWLlP+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPEWLlP+"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a7f94938fcso60120285a.1
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 07:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547489; x=1726152289; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0qJ+qhwK9ymVSFetjsM/3QYGLR+/aJX2XHY6vGQD8U=;
        b=DPEWLlP+b26zOMnf3TyFF5+dtZtBcwoC2zNbX0/LcXa/zbkC5uYita5Q5Q3ok0FzEl
         OP5EydO5OBftTQMv93eK0qrQaGdiA1nf8KXyGl04q/CWIuL833iApDif9Vqf6PBDvtdp
         x4/mrFNWrJD0QmYqr9JYG6O2RZT3w7IBGQ0v8W2qf03C9PDlTieCWFWwjhJtTovwIUZe
         M7D7MRARdz9haeu9Z2m7I3A3WUzol2kEQDrEWsSCtc9LzhLgrLTzU0RDZ0Ovw/sa+Gno
         DWQwaTjpmhSVbe4ruzLiyv94J17cck18s3ttPYH7bySD78rJ++ZMJg0QZ1gB2uOwNjaE
         CtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547489; x=1726152289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0qJ+qhwK9ymVSFetjsM/3QYGLR+/aJX2XHY6vGQD8U=;
        b=LuR4H24B54mFyVo6ks1ZPKqAn0lccRaU2laGxg2k6VGU/ZkwwJPiqnv2oqECS6ayrq
         sgXjpCpaO4qN0fQh0KgH/qKHqZLHiFfDiO6jIj7pjWM0YdTlOi6auiWNct5/fnSGEpwU
         dOCMArq3naV44zyIoqFtK1udh3oP1J2VIR8tFdWxM9ZTgyc+Mh2wrknw7bISJpKKrZ3O
         V0CNiXltaM5UwJkjCBfnYcohvIlAHvbYM3hLJF3yF0N7LYBODxeozWTIw7cy0TFZgKQb
         1aFlc4GH8NUUtWFPRVx1VgH/tLz1yFW3zL5Zcp8us7e8JQlG39kmDzNxhOQ7k89OmD9X
         sBnw==
X-Forwarded-Encrypted: i=1; AJvYcCWfLos/z0xK1Ef6UfYLZ8zEDlnLA0742/W0yTZu99DJ9bnskX+l2YJGolxq8RxlHOiMxT8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwzlUDNGiCelHQb8RDysmDpMru/XaZEruTYSuuecycsMONRQa8t
	uchhnCDydUy/iVXuYpTjydItdt9UrN3fqYvwIGF9xcvQ3Xv3MU2Y
X-Google-Smtp-Source: AGHT+IENyCr7FZ5H9gF9BcSw+1U13epCsRp5H0bRaS+n7zb1LdOXraPDZK8wZORqvkWjzAUFy5gqdA==
X-Received: by 2002:a05:620a:28cd:b0:7a1:e0dc:ef99 with SMTP id af79cd13be357-7a8041b295amr2957745585a.15.1725547489324;
        Thu, 05 Sep 2024 07:44:49 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef3d3acsm80195185a.42.2024.09.05.07.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 07:44:48 -0700 (PDT)
Message-ID: <1fc65fe7-3e6f-4953-973c-84bde72bb2d1@gmail.com>
Date: Thu, 5 Sep 2024 07:44:47 -0700
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
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <fb4b3b86-e659-448b-bfb9-cfba35c2b87b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 9/5/24 7:37 AM, Denis Kenzior wrote:
> Hi James,
>
> On 9/5/24 8:43 AM, James Prestwood wrote:
>> Due to the possibility of external scans the scan request pointer
>
> Do we know why external scans are happening?  I can understand a one 
> off because someone triggered iw scan, but from the bug report it 
> sounded like it was crashing iwd repeatedly?
NetworkManager? wpa_supplicant running? I really have no idea. Either 
way its out of our control.
>
>> could be NULL. Prior to surveys IWD would still get the results in
>> order for periodic scans to utilize them. This behavior can be
>> retained by checking both if we don't have a request or if the
>> request was canceled. This check is identical to the one in
>> get_scan_done.
>>
>> This fixes a crash when checking if the NULL scan request has been
>> canceled:
>>
>> 0x00005ffa6a0376de in get_survey_done (user_data=0x5ffa783a3f90) at 
>> src/scan.c:2059
>> 0x0000749646a29bbd in ?? () from /usr/lib/libell.so.0
>> 0x0000749646a243cb in ?? () from /usr/lib/libell.so.0
>> 0x0000749646a24655 in l_main_iterate () from /usr/lib/libell.so.0
>> 0x0000749646a24ace in l_main_run () from /usr/lib/libell.so.0
>> 0x0000749646a263a4 in l_main_run_with_signal () from 
>> /usr/lib/libell.so.0
>> 0x00005ffa6a00d642 in main (argc=<optimized out>, argv=<optimized 
>> out>) at src/main.c:614
>>
>> Reported-by: Daniel Bond <danielbondno@gmail.com>
>> ---
>>   src/scan.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/scan.c b/src/scan.c
>> index debdeb1f..205365cd 100644
>> --- a/src/scan.c
>> +++ b/src/scan.c
>> @@ -2056,7 +2056,7 @@ static void get_survey_done(void *user_data)
>>         sc->get_survey_cmd_id = 0;
>>   -    if (!results->sr->canceled)
>> +    if (!results->sr || !results->sr->canceled)
>
> I still don't understand why we're even bothering requesting a survey 
> for a scan we didn't trigger?  In other words, we shouldn't even be in 
> this function.
Because we still utilize external scan results for periodic scans. So if 
periodic scans are running we will still try and get the survey/results.
>
>>           get_results(results);
>>       else
>>           get_scan_done(user_data);
>
> Regards,
> -Denis
