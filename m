Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6E83CC7
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635559; cv=none; b=PQxPEr+p3z90mVrXZfdGaji+DSyqu4ZJBzvtQLwc52m9BJSi6NEHam1gE3BqjxSr0/DuLD3I3iU09FTbrjy2JGxIokath+NatNHUxRsJHg+BXCtbbZeRPM9k8+BHKnx9Dbr4bLpSQAjk2ZImu7EZdBDGukbIiE/ksX9AWbXcBhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635559; c=relaxed/simple;
	bh=dmm8pxHcnUaWnpm/SeEL8e7t6rSc/vG3frSGOLvlaWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=crwLB0m4KqzxvKP/2ETKuEEDRUd/s0NXo43/1NDn894X8NgGoLwy7PoKR7exlTP+eh8ZD0DBmxtwWFyDH0HDvN/w/dYNnNjH9m3mecyVIeafK9lf5OHDoHQxlDEC9kVJFNWPzYfYlQn4bR1pdFddREifw2m+AQ1+2ufpyWwuSBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9Spyfhi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9Spyfhi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2266655b1so1420945ad.2
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711635557; x=1712240357; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPItD7zpUnfh8SIezG0qgqQp9iomBlPrsPnniQRaGww=;
        b=b9SpyfhiGnvvvz2YjtZnL7Zvj9bMsrzFxo1Lkce/IV16FwBJ9LFzjmyjHG4/IKn/OJ
         wNsg46dz7W91st7zSmjVaNEjatkPzaO9MEqud5j4d/MhmAzyocAo5TpFxb+hxX+a8Kjk
         EsbYndfj4QeY2gMIiqEsvDNWSjTFDalQH3Zc0huO6HCiLtHZITSX6cFOfZv3UnHcNf9S
         hNYRdE5FR6m4W01tRF73xLufLJJJd7af+QQQ4Z43QsOyctok0vVwpmOwZsprY3TcK6X9
         6jUamJnuyfibMDufncMDRRCgQcMmdAa3djF71LZhtIN15CPiscTpwo2LS9ZtgCIRgsuo
         HWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635557; x=1712240357;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPItD7zpUnfh8SIezG0qgqQp9iomBlPrsPnniQRaGww=;
        b=WKLQUQHZ3s67DhaYL0Pp7IBjrh0TbsWIOId0VJUeIf7WA15T77OBbuxHDvFF4d7tNj
         ci43bvm8zTrve/4S2Kmg640ICvCl30/1b2VxunHWgBj74xyG+RoxpzVHdpbDZGmRVIVl
         rH5imgFzPVzZ/7aH0WbtPugVySNDMTkpCAqaAHTW6K4Zu1HL0/TGuVnE+duQtKulDRRv
         2/9x80ilakh/aOqDI9JPPk/e3fY2CKhBmPHpR1bpK6/z5mH6tkmYKHSzZhEoeAJ9K5hh
         YKM9r6grqmFU3jjkvhn7hHJclycu/2YAz51hksbmau0pOIxTpnvcy5Aqa1JQIET+/ILv
         WK6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzAGqqo7jxFRuHR3DgrldfzaQA38BjeBG4ZG6OwLxESNdVBZMHFYaMfQbNwkx4qUCAMtqi+s+HELh/WUSpMBByFeJv
X-Gm-Message-State: AOJu0Yw+ErJK9UXfHTxQinQ91udRmWT61LLeuyh1TiMxNLIpJ3ck33Ep
	6otZoiJOPH8lwLOIUwYVVcdKykWynVf9GqQmLCYZqpQdZ5c2xuQV
X-Google-Smtp-Source: AGHT+IGEgMH8BJK+Wzk89lVRK7SSe48PuamTOY/tRDdinS/6pgl1cVi/4ML+GQOHsGtva0GVvqWeUQ==
X-Received: by 2002:a17:902:f608:b0:1e0:9ba5:7fc5 with SMTP id n8-20020a170902f60800b001e09ba57fc5mr3599091plg.14.1711635557142;
        Thu, 28 Mar 2024 07:19:17 -0700 (PDT)
Received: from [192.168.254.87] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id la5-20020a170902fa0500b001dede7dd3c7sm1615949plb.111.2024.03.28.07.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:19:16 -0700 (PDT)
Message-ID: <f2a442cf-ab51-405a-85a0-f7af80253304@gmail.com>
Date: Thu, 28 Mar 2024 07:19:16 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wiphy: add better handling for rate estimation errors
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240328134725.1484257-1-prestwoj@gmail.com>
 <20240328134725.1484257-2-prestwoj@gmail.com>
 <739e21d0-95c5-45ab-8023-d54a128a867a@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <739e21d0-95c5-45ab-8023-d54a128a867a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/28/24 7:15 AM, Denis Kenzior wrote:
> Hi James,
>
> On 3/28/24 08:47, James Prestwood wrote:
>> In most cases any failure here is likely just due to the AP not
>> supporting the feature, whether its HE/VHT/HE. This should result
>> in the estimation returning -ENOTSUP in which case we move down
>> the list. Any other non-zero return we will now warn to make it
>> clear the IEs did exist, but were not properly formatted.
>>
>> In addition HE specifically has an extra validation function which,
>> if failed, was bailing out of the estimation function entirely.
>> Instead this is now treated as if there was no HE capabilities and
>> the logic can move down to VHT, HT, or basic rates.
>> ---
>>   src/wiphy.c | 34 +++++++++++++++++++++++++---------
>>   1 file changed, 25 insertions(+), 9 deletions(-)
>>
>
> <snip>
>
>> @@ -1037,8 +1038,10 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
>>               vht_operation = iter.data - 2;
>>               break;
>>           case IE_TYPE_HE_CAPABILITIES:
>> -            if (!ie_validate_he_capabilities(iter.data, iter.len))
>> -                return -EBADMSG;
>> +            if (!ie_validate_he_capabilities(iter.data, iter.len)) {
>> +                l_warn("invalid HE capabilities");
>> +                continue;
>> +            }
>
> I guess you would want to treat all IEs this way?  Suppose VHT 
> Capabilities is somehow the wrong size?
Sure, that sounds good to me.
>
>>                 he_capabilities = iter.data;
>>               break;
>
> Regards,
> -Denis
>
