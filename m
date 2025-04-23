Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ACB28A1F4
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434240; cv=none; b=YLhSIFWy1QfSeNMbXeeBSo0jNvpiiKyEu3JTusP7+WYtFD7zcNjhr4GjtsjA3KL8AFGSz99JFvtYoIRCmimCUxmC0etYGoiDj59QmqW+/AkxZwLr6gV8u9UIx6NL1CeNDErJKifensYdddBL6SzuLq8iqFYBZwq8EPjFJZqMHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434240; c=relaxed/simple;
	bh=WGiinPEYeH5T/OWN47PKG4j4sNntklZrfr21CFmDoD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QB7wnfwi3XEUeUA+fNDSNvpO6PLjOf2MP1vdxBXi/dwJ4CrZbW8gDqT2/1DZQARMk6UiJ0Onp9g8HlHjVvcZoBId7ZfOGmX6nm/CtFWTsS00FkdywBp4OYbMnJsiBXg7aC14MFTC8yOSj3W1YZyd6uyOnEbn916DO43u4I1hRLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daKriVTG; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daKriVTG"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5568355ffso14944385a.0
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745434238; x=1746039038; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MGSXvxwaen/ev/TfpXec/Nle75VUkEt4VlUX2+9tgms=;
        b=daKriVTG93F8pyoppNE3+OSlyAbghzshWi6LbKFJZdE1CNu0xnJVEkUSbK+ateKP0u
         onF5YPFkyek//veRVA+CYoC2rwlayw2ov4lP6KyqXwM95igYA0N6RB1Xi5rD/Q2s+CQO
         m3CXPYK0HiW0NdkLOzd9/uTXXudLVQv1nzP6pLs3QkNWwGJZiT8zS6sDUtHje0zgJ1WY
         s18v07cuv7X7pKbPciv5b9wSrLPStv8lTHNxGJR+B2HQHj0z31ciQI9EJLvWUSrIlKeb
         W6uj+9OxGvOYEp579lK3c1SWOw8mMDWRKJJEpL+D3G0nJTsMKa2t5Z5oP80dSGtkg1kO
         zuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745434238; x=1746039038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGSXvxwaen/ev/TfpXec/Nle75VUkEt4VlUX2+9tgms=;
        b=KPF5k1ZZT0bsIhIBSzUwK5+ektph/mllHUQ5QHIZryUitaqQ7rdGQApmwfOW1I/qfi
         Ihx7n4NpWYbR1GAYyhSBSfiQPOQ2CDcoh2BlX7WZjhNrqt6LmQWa21eRgfb4CQV/0bPt
         ziauDCQNLGgho+cJqwIqnKqp5uVfmLJSAyk+7kcqXJxrz1HgasUyrlaErOGOt5muF3jV
         +ndAoycXf8O5CO39gZu6ecMH4Y4bW0Qw9qjNIfFAO8f+TZun2DBtSdVElahdxO536OOm
         uRtr7FaSGDyY4Dhq0uVI/RUIXilJX+YvrnsFf9WX/7LnRkp3NizJbyazNfaB2vgwCshQ
         Sk0w==
X-Forwarded-Encrypted: i=1; AJvYcCXCD49dCFeRjYx8vUNukM7PV87hO+rP9MZx9YMP6h30rdnYx7cDuf/GNnKwhtwZ8WB5/Ws=@lists.linux.dev
X-Gm-Message-State: AOJu0YzWUKhG483sxDmSSnp4v+idNBY7Wr3fjO1RJhGD7m9LMONcEbuy
	uRsX5tk/oPuRrJk6lxOa56cwxWJfekSbqPq900eLN4KmCMIMeVeV
X-Gm-Gg: ASbGncu9/+6t/zlmYyaMgI9ZE0pzcuOLz7nbPUc1bIoA1Luj5aIEV8Ux0bHsDvIaurg
	1kdWB4IV9Xg6mKjbYfoKPujtFOMZl4cOMOhJG7gyvQPz9Eog2l0YxM9xFuZZc/k1GZwUKPYQ5+O
	RZku1cGGqIOfVvSyD/r4W+w0H59l+K1f+On96/ygKSfMX37eW22LgogvakPrqe7/QHGPi3DNVh6
	rtZs2CMoqPZ5BYHTYaEUO6UMnnhWj/OYypNhCQogJDp5nnSVDCXhm/p2w2smy1I0QNJzrW3cbhA
	t8uYXwkYFB8KIs4WkU7ZiMkGaD+yD9huhsbZzBvC8vpP
X-Google-Smtp-Source: AGHT+IHUc2Tr4psI+avfOy7m3vN9e4FavjKyQRy+NSIBzHR7VkG4PROwXz3U7zSUgPVTfEPjZh6eSA==
X-Received: by 2002:a05:620a:319e:b0:7c5:50ab:de07 with SMTP id af79cd13be357-7c955daffadmr112316585a.21.1745434237780;
        Wed, 23 Apr 2025 11:50:37 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b699f2sm710476485a.92.2025.04.23.11.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 11:50:37 -0700 (PDT)
Message-ID: <bc27b295-4c9e-467d-a2c3-4c8d7043e0a7@gmail.com>
Date: Wed, 23 Apr 2025 14:50:36 -0400
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] station: update SignalStrength/Frequency for BSS
 interface
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20250423135458.11337-1-prestwoj@gmail.com>
 <20250423135458.11337-2-prestwoj@gmail.com>
 <dfd01b68-2955-4fff-9f71-2e130e745c16@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <dfd01b68-2955-4fff-9f71-2e130e745c16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/23/25 10:52 AM, Denis Kenzior wrote:
> Hi James,
>
> On 4/23/25 8:54 AM, James Prestwood wrote:
>> When the BSS's signal or frequency changes, update those properties
>> ---
>>   src/station.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/station.c b/src/station.c
>> index 14c93671..85ed2898 100644
>> --- a/src/station.c
>> +++ b/src/station.c
>> @@ -545,10 +545,21 @@ static bool station_register_bss(struct network 
>> *network, struct scan_bss *bss)
>>        * scan_bss pointer, as this one will be freed soon.
>>        */
>>       old = l_dbus_object_get_data(dbus_get_bus(), path, 
>> IWD_BSS_INTERFACE);
>> -    if (old)
>> -        return l_dbus_object_set_data(dbus_get_bus(), path,
>> +    if (old) {
>> +        l_dbus_object_set_data(dbus_get_bus(), path,
>>                           IWD_BSS_INTERFACE, bss);
>>   +        if (old->signal_strength != bss->signal_strength)
>> +            l_dbus_property_changed(dbus_get_bus(), path,
>> +                    IWD_BSS_INTERFACE, "SignalStrength");
>> +
>> +        if (old->frequency != bss->frequency)
>> +            l_dbus_property_changed(dbus_get_bus(), path,
>> +                    IWD_BSS_INTERFACE, "Frequency");
>> +
>> +        return true;
>
> nit: This return probably deserves its own commit + Fixes tag.

This specifically isn't fixing anything. I just needed to set the new 
BSS object prior to emitting the property changed signal. Technically 
this does change the function logic but we don't actually check the 
return of station_register_bss() anywhere, this could just be made into 
a void return I suppose if you'd like.

>
>> +    }
>> +
>>       if (!l_dbus_object_add_interface(dbus_get_bus(), path,
>>                           IWD_BSS_INTERFACE, bss))
>>           return false;
>
> Regards,
> -Denis
