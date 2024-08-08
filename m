Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844C19005A
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128303; cv=none; b=Q1a+7icQCjDR1IsaBsULFLrIvumXgdzux1CgwSlbmgQcnLM9ofM2Q0bcOzVa5wh6tAn7cN+hntYoYxxGwfZQTXufUMELqdHuaIXpijDX6XXotKWW59vz3rXJ+CM6MHUVWzjdgOc/HwjY7vJWCCwMslMk2o4uzZ66O/MWoL0aIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128303; c=relaxed/simple;
	bh=xdOoREoYviCz2QHmT1aIsYi2VoPBstK2YxVWzvSxWtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tf31S198Raw9+YtaMU1I7R5+piuBnzHE4tlc5O4jpE0gZI7zxt9W5Skx9GFLRGWA68YTNG4wq2rXK4zIIj5iLI6af9/dq3wAt2pjXAs9nLHFxFJW0pSl651Ov99ihR9IxC2ikJPVHyqucLtowW7KRt2ZX6vHBLKQZ49kUzwMeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIBO9/K+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIBO9/K+"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1dd2004e1so57851285a.3
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723128301; x=1723733101; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHUPnKmXNEvPWSbvfXheaFKZkSlxWuUJBIL7/Gw1UoM=;
        b=RIBO9/K+52EYRC0BzvmAdMSfNSUYeF2qWy/KNBgu26uyGuEL9T3yjnk2KlcfssD+++
         t0QuX3PQGBjT9z1kTe8hZrr5RQNtC/pRcJMYtVnOdMalchUNglCUHaUKTo8oCOFbkrUD
         pouidG+CUOtncG8eY6DnBfZu2Qp75b/IhB/anfyM/71yZWVsKchX57j1ak9v1cNtG7PZ
         NqajWfMbUOkKzXJJR/ZNKTyPRsnvZKhI4OB4ZidosOirL4v9cQcn15lt2lAfboONKM1i
         vrRIg6xA9DxfP4AHwNygCN7xjcrzc5OXEdmkkru4cXy70RyIlyB3waYw53VWehJqwZ+/
         JIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128301; x=1723733101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHUPnKmXNEvPWSbvfXheaFKZkSlxWuUJBIL7/Gw1UoM=;
        b=sZ9VyI/3ThHZSyv849/DPNsOrZZpgE6SFYD51eCOWUYwdCj9lfienWXqHgDDXu5oFo
         adEByTBWNzbRPXcASTvNoHEFfj57caIFNMG9ABJDJpXLgmYAE+GC3s0x7RxbOnWIKUFf
         7x1NbgxaYxkZB1LuUpYXY0IyoCiJMbBkjkfQ/JRs4OBgrncMGxXhmb1Fd7bYCe0irutR
         cor/NyGwJdzXIIAb5IEJ+cFTxTdlX6UrV0DBTSxcKsGWX2JmCImCa0CrBRPZOyT/x0DE
         dYtpZO3NoNSkWUVbc5H+fnQmYAo4JToaIQbTc8hGhdeFTzVk0py0/T9e/jhYNxKMaN/p
         PQLw==
X-Forwarded-Encrypted: i=1; AJvYcCW+x3+CSP6Is+ZU+snRpBUtoGeNb+QfM2MKwld/zS0CsxyNkqdx7RP3OxbGgIIwoNJnV5CioDB3nEnwex5U13g/r0YM
X-Gm-Message-State: AOJu0YyPa4A/V0qHQ9i92qiezMfZzPhqgiI1B7njfjP7JaHwKXucv5Mj
	C0T3fJOQ4cdG8EUpnCP6WKpYSLRNllHwnIUPwKefj3WxhcihVZjVuwvO1Q==
X-Google-Smtp-Source: AGHT+IGTFkQD/6Rl8F/wO+nItUIiVVPTDpvuVzIuKi/P1EqAr5ggDg2W7gKWHKjQ6kB6OEgRBCsRbw==
X-Received: by 2002:a05:620a:46aa:b0:7a3:5e6e:e8e3 with SMTP id af79cd13be357-7a3818a3bb2mr227087585a.53.1723128300782;
        Thu, 08 Aug 2024 07:45:00 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786c1cc5sm164770285a.104.2024.08.08.07.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 07:45:00 -0700 (PDT)
Message-ID: <85e33486-824f-4fb3-b864-e9a7be40476d@gmail.com>
Date: Thu, 8 Aug 2024 07:44:58 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] station: use network_bss_list_prune
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240807181427.170515-1-prestwoj@gmail.com>
 <20240807181427.170515-2-prestwoj@gmail.com>
 <fe42fb8d-b159-4988-924c-81cdfd2531df@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <fe42fb8d-b159-4988-924c-81cdfd2531df@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 8/8/24 7:29 AM, Denis Kenzior wrote:
> Hi James,
>
> On 8/7/24 1:14 PM, James Prestwood wrote:
>> Use this to clear only entires that were not found in the newest
>> scan results.
>> ---
>>   src/station.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/station.c b/src/station.c
>> index e373b03b..2c4d686b 100644
>> --- a/src/station.c
>> +++ b/src/station.c
>> @@ -943,7 +943,7 @@ void station_set_scan_results(struct station 
>> *station,
>>       l_queue_foreach_remove(new_bss_list, bss_free_if_ssid_not_utf8, 
>> NULL);
>>         while ((network = l_queue_pop_head(station->networks_sorted)))
>> -        network_bss_list_clear(network);
>> +        network_bss_list_prune(network, new_bss_list);
>
> You're sending the new list without vetting whether the SSID matches 
> the network.  That will likely come to haunt you later.

Yes, one of several problems with this. Its also ~O(N^2) so with v2 I'll 
be using a different approach. Slightly more optimized, and fixes the 
issue you mentioned.

>
>> l_queue_clear(station->hidden_bss_list_sorted, NULL);
> Regards,
> -Denis
