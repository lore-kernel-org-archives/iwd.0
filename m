Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32BE3BA239
	for <iwd@lists.linux.dev>; Mon, 23 Mar 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279734; cv=none; b=ShT7sJ5/CgvjNWgMevhV3X09Ikt0hLVU1R8PrRWDQ18WLTeErHJd2Qqd+ZucH+TJfyhifsgoAcOJ4HWuT6RFjdrAsj5kSsU1O/DAvVmR40EabT6cPRZ6WEt0IjtH3aeqgdHcrDc5UOp/8QUC58rSnBjYFzSMXzKM5vhmT6RZ5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279734; c=relaxed/simple;
	bh=bKEoJXEyMv2XYWCAfMIl6D2FUQOVj2JFK3SKwhVqEYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lFSc2wM5s/fgP29E/M5r5ich9qDl6jnFIlQB3LkXaZ2cFDrucO5Cznvn57Ta/UAE7DE0I1igO6/TbB7G0thv3XRDyqSrD8sXClFcLhPwzz9XDqQX65ljlhkr2JaoYRxmkShggyoPRyPiL9vragJqpTF2PyvwoXYWwxPYNN2OTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3WQWXjx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3WQWXjx"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8299f1ca894so2673077b3a.2
        for <iwd@lists.linux.dev>; Mon, 23 Mar 2026 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774279732; x=1774884532; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7iguK6Yn+iOR8TCYIzKixV/U3UlBOB1u0JmXVmLooY=;
        b=b3WQWXjxwsQBqHB1bEio174HFFiwTdipExpscPAaXYA/ScXyVnphxkztwQOpyaRDmq
         SOOZTQBCPn6Qu0OF89H2pZxXhXGHOfK9emeEQlnTNETVwfQymqj0EhvOzhkHA6W8htb+
         Y1B3Mm8XRSuWMb/F7fVThv2FedX9DqEsjCRMLKJ1rNZntGFtO4xOiz5TPHrFc0vX9T5p
         Augpj180a0O6qP2Ru2Vkh98vV4c7MVbh9QxoDkkGRQyE6FtQh2Ytwvi+JjNjb4Hk4PVp
         7djfBY3IJjTs84p0ipFRyNUNnfo9Tj6wbnFJaIt3jRxVwQXQJ0XTvm5cSZu2EwkcB40o
         ZkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279732; x=1774884532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7iguK6Yn+iOR8TCYIzKixV/U3UlBOB1u0JmXVmLooY=;
        b=X6pNguJURYzN5HWKJpxkA+HL0R5Jiel+wxA00tG2WyCHstieqHh9JDvUVYtp+6RH/R
         6cnWFQRdZIRVsFYJaSXbRu0fgNDs13K0XnC7d9JgrM1+ojjZFFuOER3qc0u1wrfWiTig
         M8/v8H0Sw2YgdBQHyqozXIxs9fcXlHyANM/tvTHVeN2aESrz/SPfifWXOuNGtYXkDiAx
         dNV7PaWaDDHC59pNxiZdozNNYA3XQOpU/x3vmru21YRuKe72W/2m+EP87OXRkh/b54pG
         xhU6Z9aJ6CN8RzTAvCZzmfoxaku3pS0wuu7v51HtRFr5Al/W/OFkoUTJHUCyD0E98hZX
         FoYw==
X-Forwarded-Encrypted: i=1; AJvYcCVwRIH5lCQcEdL2Y2HUoqzm7odFKpfmOUwv/zY0gM3MAzLW3qieJ3/Ag3mvWyLYrPfmplI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4oh4obcj5AalpoFnrG68K0O8WozGE9BfcG8TwfSv34EkMxJAT
	1vZXl2IHKVOhjfF5lpmj3vYzjepy0bp+lAqF+MBqg3COdPuPuYk8srxR
X-Gm-Gg: ATEYQzzeeIKRo0gGioU6mVFhguaKcD8DWZG2Udcnrb5lT7zzwaRcuQLU5nf67rIIrPz
	2NDFfRSAVO9AOamdzMg1fWcZgHTp6lDOyUpIftrgD2PueLVboCEBHkHJtiCmMyhsScQTgwcUioZ
	weM/TSypa+kgn7xYAndT1Xsm9PrpTuxbPPKMwPnmiqXfNsMUiTuv2ewxzTlNbS5cYY8eYbjdb/C
	LrgEEIzQMXNN7ks73e2YSMGoAz0ZLwY1A+nNgcBjcDgvdHBrkWb46r50anKNM7Msoq7Fbyn0gvQ
	xPG2FEhaDkPfXToHp8RGY9tp66do27N9SXyvhYZ/XcLIr7MwYu3vIJRFdgv3/WEnFhXX9nn4pCt
	ipHF/4W1ARNWO7GH9pACDzSHXN+DTaDrcBRDLl/A3p9Th+wfh95kjTN+yS75nBspYIuGfAVl12q
	7j379l7UpM0AVfFQGg66eys/peGVRehJbwmtpNkfZNhWasByYbjARx73z8hzg72Rf9rF+V
X-Received: by 2002:a05:6a00:9093:b0:829:6f7d:3093 with SMTP id d2e1a72fcca58-82a8c39da8amr9290056b3a.48.1774279732091;
        Mon, 23 Mar 2026 08:28:52 -0700 (PDT)
Received: from [10.100.121.202] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410a3c9sm11810780b3a.56.2026.03.23.08.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 08:28:51 -0700 (PDT)
Message-ID: <aeaeaf5a-a21b-48b5-bd5e-e3a1a8c17204@gmail.com>
Date: Mon, 23 Mar 2026 08:28:48 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] pmksa: add pmksa_cache_flush_ssid
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20260319180525.136095-1-prestwoj@gmail.com>
 <20260319180525.136095-2-prestwoj@gmail.com>
 <4b8f1537-70d0-4b19-a861-12fd23f1d75f@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <4b8f1537-70d0-4b19-a861-12fd23f1d75f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 3/23/26 8:14 AM, Denis Kenzior wrote:
> Hi James,
>
> On 3/19/26 1:05 PM, James Prestwood wrote:
>> Adds a new flushing method to remove all PMKSA entries for a given
>> SSID.
>> ---
>>   src/pmksa.c | 27 +++++++++++++++++++++++++++
>>   src/pmksa.h |  1 +
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/src/pmksa.c b/src/pmksa.c
>> index a50c8208..9b02d7e4 100644
>> --- a/src/pmksa.c
>> +++ b/src/pmksa.c
>> @@ -213,6 +213,33 @@ int pmksa_cache_flush(void)
>>       return 0;
>>   }
>>   +/*
>> + * Flushes all PMKSA entries that match an SSID
>> + */
>> +int pmksa_cache_flush_ssid(const char ssid[static 32])
>
> const char is confusing here.  Either you're passing in a string 
> (const char *) or you're passing in an array of bytes (uint8_t */[]).  
> pmksa_cache_get() uses const uint8_t *ssid, size_t ssid_len, so maybe 
> use that for consistency?  Or we can switch to uint8_t ssid[static 32] 
> everywhere.
Sure I'll pass the length as well.
>
> Also, just ssid is not enough, you need to supply the AKMs to delete.  
> If we're 'forgetting' a PSK network, lets make the effort not to clear 
> out a potential 802.1X network with the same SSID.

Good point, I forgot the AKM was also a factor.


>
> Regards,
> -Denis
