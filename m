Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938DA2638B1
	for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306218; cv=none; b=gb3aGoygHgN8uSW7r8i1qXowGQigwVlb8+soyjJoqRVGhF1tNxOv/gwVg/+szlYDuSEgRobwwwTcmvuD5Sm3Mi5LUz5o8+nHdcTe0Xb/PnDlielC7cW+Mk/KMoxhw0Vcquk1iE1aGqzJ8wOyR0NlOkWjlwNVluaYE/bZGWyYkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306218; c=relaxed/simple;
	bh=ivt0Rdy/p5GBo/hCLq720r/a6pp3OVacVcZ9LRTg3Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2iE6+3lMjhkSW1NfFG4H21+ODu0hx61yTHYvuD3dB7Duo+j+4WWy7DUyOi62NSUVuayLl8VUk8osqiUSZ85gWnkVVrjXQQnY5SCOmMOD63XtLHpx9sthhxGRjeIyoQHz5H+GZxCtipbgjlMOkLrXw8N3xfGSOZs+6NXwv04zkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOk29gD1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOk29gD1"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c05049e67aso190382785a.1
        for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 12:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739306215; x=1739911015; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ksAG/c25L+B5MTO47mUaQNSxL/75NvyWK26JL6TmlEQ=;
        b=aOk29gD1icrV27iITz/prufIwwE2naG4HpIh3FLHqtoDifU6cvo6md4qhoLXdZ1HKZ
         frCnXfcYsl+qgurgqZbKld3XjtEOOFdkmmzUrP9Ns3corJgZmTSopSD6GdMEXI2XYEzX
         +3dFGobXVQY4GSdfRnoRfrn2DT/yKj8CKFWPzaNwForO5Dx5T6tu8U+fjPYP2Igg6r/I
         ZYGxZ0i/ApOl99Z1gBSkLXhmJ/W4zBwXSEPKgiY/N0FWqILFPbCpw3XyiMtaYgHbuJDA
         xlTOZJkLX8U2j+4Tlhp7I1hFn78wfWowImGheuJ5/1tDNAwHMEUaYn4m0qOga0ge+Aj8
         zFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739306215; x=1739911015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksAG/c25L+B5MTO47mUaQNSxL/75NvyWK26JL6TmlEQ=;
        b=WEUroSa7fDP8wahY50cOMKZGuGP2wtHEm1djstFemcC8m+t5gO/iUMmYB5aQcX1Qrs
         MHM+urYwb1CGz80zEW/CLoPFLao2Huer7VWmWJSeAgT4DwRb646pMfQtbJNCidCcEzCq
         7mIcAMJBcusiH3kDGICgT+5bVCYO587Y7zJeh2KO1c0ZtYCvM/y/viYI7BsvIwrj+bjM
         F/M4/H7IRuW7P+9UdqRTQFLEGiMPGZbC3JLaJAMLBqttWFNxUQ4JZZTFb81BP8/5SkAt
         +5z50+DrjSU/3SEAkylXGB8eJ/ogeNCOXWxnFKNYXD/sEipztVIbTFNB4J2HOsVv3WT2
         Eh1Q==
X-Gm-Message-State: AOJu0YzBnbs0nig6aaUD4vl0jOHUZ1mPZAGF78OdXUeE4dNMOTsnE6jN
	B5VU3K/Xxtqd2eM0POHKo1Us0gETZ0lizoXkDSWcEziEarLhgIInwkXVaA==
X-Gm-Gg: ASbGncstEt4TSba+yK6J709HHc/1k+4VrOGWfPdZVG6NBUzk9MniNMLiSlPwU5zSu6v
	iHBmYCyEedr8H21mGQRJ7UEFCET7O5fqn0wwkfaOiLvSUW4EaK7EUXeyFZpr4S3gOQcIxsV1cjp
	cScVmUOiCMQshUQPLo7Rf4suEW21g1PDYh6Zji0+OuysTpaU3j1P8Vfi5ib2zygwAlApdvk0zeO
	SAYNORLYFBqf9ib8hIToaCHoNdy1OzN4ODx1uB8UxZNwX6e4WFBwMN5llk678MECMYO4S3e6dx+
	jpUy/SLyIGjgwCBpYJU=
X-Google-Smtp-Source: AGHT+IHkJ9uK8tjg4X2vcnP4GLnCoo+Sgwk9ynVmvtfSJXpRZAGNjAgCg4jpnVUUSauFRSZsOZHu0g==
X-Received: by 2002:a05:620a:3906:b0:7c0:6045:b8c4 with SMTP id af79cd13be357-7c06fc70e56mr114635685a.21.1739306215298;
        Tue, 11 Feb 2025 12:36:55 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9fa74sm718871885a.84.2025.02.11.12.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 12:36:54 -0800 (PST)
Message-ID: <20eca928-06da-4ddc-844e-814973731365@gmail.com>
Date: Tue, 11 Feb 2025 12:36:52 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wiphy: add driver quirk to disable SAE
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev
References: <20250211195855.85360-1-prestwoj@gmail.com>
 <CAG17S_NoY9QYnDEjTBCxfCzOdPY-qibxGdYGPMvhU3DQXBHyvQ@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_NoY9QYnDEjTBCxfCzOdPY-qibxGdYGPMvhU3DQXBHyvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 2/11/25 12:32 PM, KeithG wrote:
> On Tue, Feb 11, 2025 at 1:59 PM James Prestwood <prestwoj@gmail.com> wrote:
>> SAE/WPA3 is completely broken on brcmfmac, at least without a custom
>> kernel patch which isn't included in many OS distributions. In order
>> to help with this add a driver quirk so devices with brcmfmac can
>> utilize WPA2 instead of WPA3 and at least connect to networks at
>> this capacity until the fix is more widely distributed.
>> ---
>>   src/wiphy.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/wiphy.c b/src/wiphy.c
>> index c7df648a..46f7a6d9 100644
>> --- a/src/wiphy.c
>> +++ b/src/wiphy.c
>> @@ -74,6 +74,7 @@ enum driver_flag {
>>          POWER_SAVE_DISABLE = 0x4,
>>          OWE_DISABLE = 0x8,
>>          MULTICAST_RX_DISABLE = 0x10,
>> +       SAE_DISABLE = 0x20,
>>   };
>>
>>   struct driver_flag_name {
>> @@ -106,7 +107,8 @@ static const struct driver_flag_name driver_flag_names[] = {
>>          { "ForcePae",           FORCE_PAE },
>>          { "PowerSaveDisable",   POWER_SAVE_DISABLE },
>>          { "OweDisable",         OWE_DISABLE },
>> -       { "MulticastRxDisable", MULTICAST_RX_DISABLE }
>> +       { "MulticastRxDisable", MULTICAST_RX_DISABLE },
>> +       { "SaeDisable",         SAE_DISABLE },
>>   };
>>
>>   struct wiphy {
>> @@ -202,6 +204,9 @@ uint16_t wiphy_get_supported_ciphers(struct wiphy *wiphy, uint16_t mask)
>>
>>   static bool wiphy_can_connect_sae(struct wiphy *wiphy)
>>   {
>> +       if (wiphy->driver_flags & SAE_DISABLE)
>> +               return false;
>> +
>>          /*
>>           * WPA3 Specification version 3, Section 2.2:
>>           * A STA shall not enable WEP and TKIP
>> @@ -1368,6 +1373,9 @@ static void wiphy_print_basic_info(struct wiphy *wiphy)
>>                  if (wiphy->driver_flags & MULTICAST_RX_DISABLE)
>>                          flags = l_strv_append(flags, "MulticastRxDisable");
>>
>> +               if (wiphy->driver_flags & SAE_DISABLE)
>> +                       flags = l_strv_append(flags, "SaeDisable");
>> +
>>                  joined = l_strjoinv(flags, ' ');
>>
>>                  l_info("\tDriver Flags: %s", joined);
>> --
>> 2.34.1
>>
>>
> James,
>
> What should I do with this patch? Should I apply it? (I do not think I
> should). I am trying to get the kernel patch in the 6.6 kernel. They,
> RPiOS, just pushed a new kernel 6.6.74 and the one line patch is not
> yet in there.
>
> I guess I do not really understand what you are proposing. The default
> RPI kernel, with the patched version of IWD 3.3 (with the'[RFC]
> netdev: avoid PMKSA for fullmac drivers') patch will connect properly
> with wpa2 SSIDs when used with the un-patched kernel. The patched
> kernel will also connect to WPA2 SSIDs with the bonus of connecting to
> WPA3 as well.

The issue I'm solving here is if you have a hybrid WPA2/WPA3 network. 
IWD will always prefer WPA3, but any brcmfmac devices _without_ a 
patched kernel will fail to connect and WPA2 is never tried. This patch 
allows the user to set this new option, which will avoid WPA3 entirely. 
Basically, its gets brcmfmac "working" to some extent using WPA2 vs 
completely non-functional for WPA3/WPA2 hybrid networks.

Applying this patch won't have any effect unless you set the option in 
main.conf.

>
> Curious,
>
> Keith
