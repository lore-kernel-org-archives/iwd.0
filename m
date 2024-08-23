Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95868191F6B
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451860; cv=none; b=WngsWZjoodYN7mLh1hf1JI1cbe5f3Lchpv0zB9QRMJiz6hbX33R7ql1BILDon2UYhl4sdMo6fhzsFikIW1XzEV1Sao1lNWiWrZZSIdkl3T+eIVIzzPozIq7sjtjVP2obvRBvxowG7PAbcgGWDDlt5VBfYx+q7uVJ2TOrRW/rA5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451860; c=relaxed/simple;
	bh=EQKjWB9c6rMiD0Hcu5EQs/D/3jKDl9sbtQ+JSBGSDB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tvm4E8vYlLGWKSFENvAAOJor+FavJJ4oGpGhLimg8Dq4W5qGkGg8AxkyIDLnAk2PJsQf3pCiEmzaZXjQ9gFc68+R2GNE7hJQMP1vmdrE87/3BS11SXwR1E+rXpUOle0lnUKbx8EgbPBomLhXxGDflQe6NVzLXNicjkVJTp5VSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opon2Vut; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opon2Vut"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6bd6f2c9d52so12030876d6.3
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724451857; x=1725056657; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmWIm5DeugPNTbIun2KiR8748EkAbKdXboWtPaf2ihc=;
        b=Opon2VutrNBo/L430ER4cg4FMkiHfnmHuK9gzjzTM11d4XNFmGSKqPg7XPrL77qWLZ
         0Zih4eM1EwFDe5TRwHUUMw+W3CgTxGv7X8X3/krWT6gxWI2IW360AgyrGDG9QgCO3aPp
         kTvFgpweB8iyDQYoJbQP6Y65IHS9RVfBmVrEl3LRb8f88W6RrClxOz1b5qL94wXMEGl4
         ypExiE2mSVVUfHzYPsFHhrAWo4mevhx1osySE1sCiuEUYg0LDFDwMClqcCKYyH4aXFLv
         lYEaWc4CVX+eQ5VnCX4NguHVA78JvHikZ/ny/tp/5sXEfo3IrPlCmfxpZyvrjSpLR8L+
         ju8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451857; x=1725056657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmWIm5DeugPNTbIun2KiR8748EkAbKdXboWtPaf2ihc=;
        b=UzGMgv+Y2pUcJ3BKbNB7sL7vXUXnWmRs0RwF0kwRvZkXGm6mQN17NpTYin+hh2JrU4
         EbRUuyXpohtqlYb6qHyN8uF2W1ubwSI4p6kgoHbLKX8KXim2S53s5aGhqfi3U67niDUZ
         +oqLIk3XUgzuzVAPdOrNT0PjHv8vllbTXaUD9JJDtnmFgThM+6YCV7J5OwBokAn6PkMF
         /YEIofa/9TLCTrKt6wDkVodN8OZZmgJhHtxOjzb5p2W6LSDjj9ZNSfoxkbMtLpqODHzQ
         QAFs1JfGZ4fftRW+4p0J8ex3iaGltk64+VWp+u3LUjcVbNs39/LwIjO/PMGLqY1neeoX
         hHgg==
X-Forwarded-Encrypted: i=1; AJvYcCXuBXLHkuxCat86EKmDruGxOORAusbBo1b4j2RABrCVC2TYotI1PVJX0VJHXlNlZxuQb58=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/aUOhogHOEdVvHkXzrDeuqD1V9yG76le8r7SqMRxuzoiKlB2R
	eINhyCKy5KTWz2C5bGnggPSxOEtfucOFYx7lbSCevtVzoojLpuwGnEcS0w==
X-Google-Smtp-Source: AGHT+IE8IzJZrE7issL1sWcX2W6MiiXrBZ4wGNjoAajZpDlASF1iq8Fyr0MuKV0cuKvrIgW7Q47jMA==
X-Received: by 2002:a05:6214:5a02:b0:6c1:6add:d26e with SMTP id 6a1803df08f44-6c16dc24ec2mr42522396d6.11.1724451857470;
        Fri, 23 Aug 2024 15:24:17 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcd08fsm22687646d6.107.2024.08.23.15.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 15:24:17 -0700 (PDT)
Message-ID: <cbd19eb3-4bfb-43d5-8937-f1455bbf2671@gmail.com>
Date: Fri, 23 Aug 2024 15:24:14 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] netdev: define netdev settings in netdev.h
To: Ryan Smith <ryan.smith@density.io>, iwd@lists.linux.dev
References: <20240823180006.317353-1-prestwoj@gmail.com>
 <20240823180006.317353-2-prestwoj@gmail.com>
 <CAM7Wg-V7rGu1P666PFpVb2sHKbe+34r=GBZgRT6VePkjzmFEVA@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAM7Wg-V7rGu1P666PFpVb2sHKbe+34r=GBZgRT6VePkjzmFEVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ryan,

On 8/23/24 2:03 PM, Ryan Smith wrote:
> Hi,
> Just glancing through this...
>
> On Fri, Aug 23, 2024 at 12:00 PM James Prestwood <prestwoj@gmail.com> wrote:
>> Following knownnetworks, this moves the settings into a header file
>> which is easier to maintain/read.
>> ---
>>   src/netdev.c | 8 ++++----
>>   src/netdev.h | 5 +++++
>>   2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/netdev.c b/src/netdev.c
>> index 494e46a5..4d6aae6b 100644
>> --- a/src/netdev.c
>> +++ b/src/netdev.c
>> @@ -6264,16 +6264,16 @@ static int netdev_init(void)
>>                  goto fail_netlink;
>>          }
>>
>> -       if (!l_settings_get_int(settings, "General", "RoamThreshold",
>> +       if (!l_settings_get_int(settings, NETDEV_ROAM_THRESHOLD,
>>                                          &LOW_SIGNAL_THRESHOLD))
>>                  LOW_SIGNAL_THRESHOLD = -70;
>>
>> -       if (!l_settings_get_int(settings, "General", "RoamThreshold5G",
>> +       if (!l_settings_get_int(settings, NETDEV_ROAM_TRHESHOLD_5G,
>>                                          &LOW_SIGNAL_THRESHOLD_5GHZ))
>>                  LOW_SIGNAL_THRESHOLD_5GHZ = -76;
>>
>> -       rand_addr_str = l_settings_get_value(settings, "General",
>> -                                               "AddressRandomization");
>> +       rand_addr_str = l_settings_get_value(settings,
>> +                                               NETDEV_ADDRESS_RANDOMIZATION);
>>          if (rand_addr_str && !strcmp(rand_addr_str, "network"))
>>                  mac_per_ssid = true;
>>
>> diff --git a/src/netdev.h b/src/netdev.h
>> index db0440d0..d718fa6a 100644
>> --- a/src/netdev.h
>> +++ b/src/netdev.h
>> @@ -29,6 +29,11 @@ struct eapol_sm;
>>   struct mmpdu_header;
>>   struct diagnostic_station_info;
>>
>> +#define GENERAL "General"
>> +#define NETDEV_ADDRESS_RANDOMIZATION GENERAL, "AddressRandomization"
>> +#define NETDEV_ROAM_THRESHOLD GENERAL, "RoamTreshold"
> Spelling typo - RoamThreshold
>
>> +#define NETDEV_ROAM_TRHESHOLD_5G GENERAL, "RoamThreshold5G"
> Spelling typo - NETDEV_ROAM_THRESHOLD_5G
>
>> +
>>   enum netdev_result {
>>          NETDEV_RESULT_OK,
>>          NETDEV_RESULT_AUTHENTICATION_FAILED,
>> --
>> 2.34.1
>>
>>
Thanks, good catch!
