Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B01A8408
	for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306805; cv=none; b=ua1xkr/FDqPP+FTcPJIchZE0/TiC7MOPxV0u/aD4KRYJ6iCyI8I9HO0ALp6HCcmyB4Wm6o2t3Ljwx2zZ8XjLZTffeMAdfQTvVvFvbUtlB+N6clvXrpQVEcqp51KuKRUYrF3zEvg2hQur3+6L4LoI61YglEgjhWqYi/qoKqADGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306805; c=relaxed/simple;
	bh=SoNOxD6D5jHZhY8HHA3C0AaUZAyjA/+g1jR+YVHGHjs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KidFcvB+8DoKgrSlk+jbicaK3ub1/tsYfLmMrY0Ikj3pjeRCOKNx854rUMatyFpGXy6754XAe3ZmtIAhU1+JW2+GyL0liaxo3HU8VKWdQwovbUxcLMmIskLvUOV7kweALwXCwGsnbO9wX18+3WWoVpKJrWX6Hq6AaPS/yLQul2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIq6KmJC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIq6KmJC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c05c30e0aaso296600885a.3
        for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 12:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739306803; x=1739911603; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JBLZ0c+ezI3lg+Lelyx18dYLBqhPlhSqWo3VO2SHKLc=;
        b=aIq6KmJCsBZBLT6PXJI68Qz52vT1cBrG6LnIoMjGd7AUi2NnnmvQ40qRxN6a2+PvwK
         d5e+2Wy7JeCIq6Y8Xi8OLEllhsz5eHNvn5HTw4e9G4cGJuBVvGqDK/lTKAIkrTY/9SQE
         AXOK+pxqqLygz1lEDH3DjlsPiKEvdrsGDEv4u6M+8j/umAIv4VPMyAL0RlK3vZ4Mg1bA
         aiszTuZyiOHsyQTCvv3ZYsiQhvXS/zunC9r13pxmK9K9XVkmUElAzNDbPymO14KllaOn
         qiQDsKLArNg4pRLwiY9niUXs6g8yCTLcj5VGKtKeesLFEpeTvEjUEo/ImfWPxPLhp+86
         tXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739306803; x=1739911603;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBLZ0c+ezI3lg+Lelyx18dYLBqhPlhSqWo3VO2SHKLc=;
        b=tCIWuQcDf3KVK7pY56cTZUlSPAmO++KwxcX3S4cO7cGGSbhmJLb+afCfHfTKgqCC4I
         gXDxN1wTQZsj9kl/Us9rBfilJZ9SCzDMWodblGDX109ACxuXSJ35k/XpwFJBgNsaVIEU
         6mwEXwGoXOaD+uCM5Ss7CAEx+7EzwNnEtptD8PgtXexYam4LAix9+kgRvJKOiXXLTUtF
         JjEM8A34XbsWaX4Oz0IT/+pSsG4WdgPIcZsKC0Twcn2bNa7RJgJ/7Kj2VtczlJ4FSPww
         DOZwcGcE2IWPRoNuOuAqN6HacCn1yyDCvIq1uhbDIlJ/7AvQxcJuk6SgY9dgUCmvyZda
         FLWw==
X-Gm-Message-State: AOJu0YzxWUMEdTOTW+HzVvt4dbNCFxxmiDucFqau52OzsMh0hIRKITJA
	SEECFZu5cS7i5RXcFhQkh7RGFuyetzPnACT4ftfpAmOljb+6YZiG
X-Gm-Gg: ASbGncsImrmuMKQMnGqIU5KD5vd1gH6sdzf0j+7AuSTEkagUdNDbh49CTYyyrzEe7oq
	12Lovmd7NOyMDprGyBWqH40mwd3wWuIcuB0FtJ9GPVKDtoN9PbVh3E18MzlhoTDiqXeKLlfIi/l
	DObFTKhfyMZGUBSsPhzBiBGpwCXMxf1GdLOtBzjIKVW9VfvWXm3dTSab5gRChbhwm71Ul9S4Xx/
	ErJGrSqKQPbLUXQXH1wMUM+fUxxOADDS0qg3LrrnL/9wkhEPHK67w4ubIDV2rGCeXzMyQjorX2+
	Yqc/JmJCBR8R1TtncLs=
X-Google-Smtp-Source: AGHT+IFelrmqmsfTM82a7bciNckY6cY5CL6VmOGGm/CUscwNiPkxGp4YVTDUZK2yro5FaRrnWRh4Wg==
X-Received: by 2002:a05:620a:2989:b0:7c0:564b:61a3 with SMTP id af79cd13be357-7c06fcc8824mr106943985a.43.1739306802941;
        Tue, 11 Feb 2025 12:46:42 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05c197d53sm352630885a.17.2025.02.11.12.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 12:46:42 -0800 (PST)
Message-ID: <c6147c5c-6ad9-4f86-bd0c-4f49e67a1668@gmail.com>
Date: Tue, 11 Feb 2025 12:46:40 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wiphy: add driver quirk to disable SAE
From: James Prestwood <prestwoj@gmail.com>
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev
References: <20250211195855.85360-1-prestwoj@gmail.com>
 <CAG17S_NoY9QYnDEjTBCxfCzOdPY-qibxGdYGPMvhU3DQXBHyvQ@mail.gmail.com>
 <20eca928-06da-4ddc-844e-814973731365@gmail.com>
Content-Language: en-US
In-Reply-To: <20eca928-06da-4ddc-844e-814973731365@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 2/11/25 12:36 PM, James Prestwood wrote:
> Hi Keith,
>
> On 2/11/25 12:32 PM, KeithG wrote:
>> On Tue, Feb 11, 2025 at 1:59 PM James Prestwood <prestwoj@gmail.com> 
>> wrote:
>>> SAE/WPA3 is completely broken on brcmfmac, at least without a custom
>>> kernel patch which isn't included in many OS distributions. In order
>>> to help with this add a driver quirk so devices with brcmfmac can
>>> utilize WPA2 instead of WPA3 and at least connect to networks at
>>> this capacity until the fix is more widely distributed.
>>> ---
>>>   src/wiphy.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/wiphy.c b/src/wiphy.c
>>> index c7df648a..46f7a6d9 100644
>>> --- a/src/wiphy.c
>>> +++ b/src/wiphy.c
>>> @@ -74,6 +74,7 @@ enum driver_flag {
>>>          POWER_SAVE_DISABLE = 0x4,
>>>          OWE_DISABLE = 0x8,
>>>          MULTICAST_RX_DISABLE = 0x10,
>>> +       SAE_DISABLE = 0x20,
>>>   };
>>>
>>>   struct driver_flag_name {
>>> @@ -106,7 +107,8 @@ static const struct driver_flag_name 
>>> driver_flag_names[] = {
>>>          { "ForcePae",           FORCE_PAE },
>>>          { "PowerSaveDisable",   POWER_SAVE_DISABLE },
>>>          { "OweDisable",         OWE_DISABLE },
>>> -       { "MulticastRxDisable", MULTICAST_RX_DISABLE }
>>> +       { "MulticastRxDisable", MULTICAST_RX_DISABLE },
>>> +       { "SaeDisable",         SAE_DISABLE },
>>>   };
>>>
>>>   struct wiphy {
>>> @@ -202,6 +204,9 @@ uint16_t wiphy_get_supported_ciphers(struct 
>>> wiphy *wiphy, uint16_t mask)
>>>
>>>   static bool wiphy_can_connect_sae(struct wiphy *wiphy)
>>>   {
>>> +       if (wiphy->driver_flags & SAE_DISABLE)
>>> +               return false;
>>> +
>>>          /*
>>>           * WPA3 Specification version 3, Section 2.2:
>>>           * A STA shall not enable WEP and TKIP
>>> @@ -1368,6 +1373,9 @@ static void wiphy_print_basic_info(struct 
>>> wiphy *wiphy)
>>>                  if (wiphy->driver_flags & MULTICAST_RX_DISABLE)
>>>                          flags = l_strv_append(flags, 
>>> "MulticastRxDisable");
>>>
>>> +               if (wiphy->driver_flags & SAE_DISABLE)
>>> +                       flags = l_strv_append(flags, "SaeDisable");
>>> +
>>>                  joined = l_strjoinv(flags, ' ');
>>>
>>>                  l_info("\tDriver Flags: %s", joined);
>>> -- 
>>> 2.34.1
>>>
>>>
>> James,
>>
>> What should I do with this patch? Should I apply it? (I do not think I
>> should). I am trying to get the kernel patch in the 6.6 kernel. They,
>> RPiOS, just pushed a new kernel 6.6.74 and the one line patch is not
>> yet in there.
>>
>> I guess I do not really understand what you are proposing. The default
>> RPI kernel, with the patched version of IWD 3.3 (with the'[RFC]
>> netdev: avoid PMKSA for fullmac drivers') patch will connect properly
>> with wpa2 SSIDs when used with the un-patched kernel. The patched
>> kernel will also connect to WPA2 SSIDs with the bonus of connecting to
>> WPA3 as well.
>
> The issue I'm solving here is if you have a hybrid WPA2/WPA3 network. 
> IWD will always prefer WPA3, but any brcmfmac devices _without_ a 
> patched kernel will fail to connect and WPA2 is never tried. This 
> patch allows the user to set this new option, which will avoid WPA3 
> entirely. Basically, its gets brcmfmac "working" to some extent using 
> WPA2 vs completely non-functional for WPA3/WPA2 hybrid networks.
>
> Applying this patch won't have any effect unless you set the option in 
> main.conf.

Also by the way, that patch referenced in the earlier thread(s) with 
Arend doesn't seem to apply to the 6.6 rasbian kernel. Looks like that 
file has changed locations between 6.6 and upstream so its an easy 
modification, but that might be a reason the Raspi kernel folks wouldn't 
take it.
>
>>
>> Curious,
>>
>> Keith
