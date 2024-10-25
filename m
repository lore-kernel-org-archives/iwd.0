Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19381D54C7
	for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856268; cv=none; b=ByVmZ6wLtQjm0KuNUnYk3PXa27f3NAxGCsXPy4O5VJaCI4BY7ROgkWIm8f4eRwm+TA9mtpMJPWVfFUUAJnL/mQ7fXQVjp4OXD6coY9eld7P8/d5cyBjV0cov/ki5zBimYi/u40iqsUc4D5lCyDO0eITwWX73KjsPFgyinIjuqkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856268; c=relaxed/simple;
	bh=P5LRAyTxA3OJ7jkSDQSPPBlnHhAmliNdt6vsbYS6d6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Azgxo24dTEpri1KhDLSVOSY4oCYxJJALUFn30xr1eVE1VJEcn9MG67Y775Nwg3IfA2VJ5u43O5dsactSOWUymtDl9z0iY/0U6upxFXsR9dzdi1+odfeFgXrWExW5ncYy0w/RRD79FrlSQgaQ0OvCUUeEqT2nWEtOvcfmeeZemOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBvDtJp8; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBvDtJp8"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e2e2baf1087so2102751276.2
        for <iwd@lists.linux.dev>; Fri, 25 Oct 2024 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729856265; x=1730461065; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yG/jDUSZWn6LLCPUz+A0BYv6DedFE9QvW5u3bvR4Quw=;
        b=YBvDtJp8VA3I7IyRvVzpJM0+jQUknsvDDAuGHzkzxl0GzoDC6gnKhFu/y9vevQxh80
         ONK1TS5rq3FE8YxZtAF7XWglk5un4UYTfH8H3PUHL1UVCLJEXJx3hMgsVMxEIC4lg2th
         2lO8Ntb3lpkIzpHBN2pRsSuxsBOP+lpifd+wnXF2xLisY5HuoFfhXiJTy0DvC0+E8sYy
         2dwFXKdmH0g/TlXjgc/Rg/5OQhjtde0hgUl4GXe7D0UEQtUEzrykFEBc3RUGddhBb0D2
         bZ+kcN4qNZFKV/QCQjz0XtYTT+D7ytWh9bAX+xQZ9A5UQ5GqD9PslcLe0ijC/mumuADQ
         VjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729856265; x=1730461065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yG/jDUSZWn6LLCPUz+A0BYv6DedFE9QvW5u3bvR4Quw=;
        b=jyMPKNL7JqJ0Qkm/DKpGmtbN2RwfaXPgHnc0UONHOPYAFuJh9DfhAvyFF7LY5kszEw
         WzhYe/1SEP3bsjVzfKPR70LB0GUNX0UBTUdVK+3Vi44Ri7C65+YyCm7lmN/ODUUYozPx
         Tzj3aHW3MkKNH1WIowjd1E1Iyf8Yxy+J/VJFE8K48jjl1RurM4BS/lnekFYUtI0w7nJv
         YUk8YDitcbcbBY9XJdese/JToN4OsYHMKlW/UkqptcLaDgL/8UFlmZPI1kF8YphTfuNX
         GQoZLeuLKQLipbeo61WNQFK4okj3QIRDT9oyg9oQLFZxAdfHwiVw1AWk3ZbIiC/UzYAm
         e5qw==
X-Gm-Message-State: AOJu0YziVXU/abt/IMlHCs/FXzh0kf1CGflB14eUwhMtSfjUQTRcMMXd
	4XZLX1WiZTn4pthRO58flaWtN4zkmD3hNyOTratoVDGEtKBPH8tA0vBCgA==
X-Google-Smtp-Source: AGHT+IHKJBQEY8zY4vDmBxe5yrfB8XnONCdQZf6IPytLlCRUTm1YeebK+FW5KCaN4sTnO5q+QZFX1A==
X-Received: by 2002:a05:690c:6c0c:b0:6db:e280:a3ae with SMTP id 00721157ae682-6e7f0e44b1emr116910257b3.23.1729856265535;
        Fri, 25 Oct 2024 04:37:45 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798b764bsm4990296d6.44.2024.10.25.04.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 04:37:45 -0700 (PDT)
Message-ID: <fcf84bf2-b483-4f45-af31-a1442923457a@gmail.com>
Date: Fri, 25 Oct 2024 04:37:42 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: check support for all sysfs settings
To: Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev
References: <20241024131628.152607-1-prestwoj@gmail.com>
 <91657cac-4009-42a0-89b4-865e443a671b@tavla.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <91657cac-4009-42a0-89b4-865e443a671b@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 10/25/24 4:14 AM, Martin Petzold wrote:
> Hi James,
>
> Am 24.10.24 um 15:16 schrieb James Prestwood:
>> If IPv6 is disabled or not supported at the kernel level writing the
>> sysfs settings will fail. A few of them had a support check but this
>> patch adds a supported bool to the remainder so we done get errors
>> like:
> I have IPv6 disabled. What is the impact of this issue without the 
> patches? Connection losses?
No functional impact, its just silencing warning that occur when IPv6 is 
disabled.
>> Unable to write drop_unsolicited_na to 
>> /proc/sys/net/ipv6/conf/wlan0/drop_unsolicited_na
>> ---
>>   src/station.c | 36 ++++++++++++++++++++++++++++--------
>>   1 file changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/src/station.c b/src/station.c
>> index cef6c66a..34537b26 100644
>> --- a/src/station.c
>> +++ b/src/station.c
>> @@ -74,6 +74,10 @@ static uint32_t roam_retry_interval;
>>   static bool anqp_disabled;
>>   static bool supports_arp_evict_nocarrier;
>>   static bool supports_ndisc_evict_nocarrier;
>> +static bool supports_drop_gratuitous_arp;
>> +static bool supports_drop_unsolicited_na;
>> +static bool supports_ipv4_drop_unicast_in_l2_multicast;
>> +static bool supports_ipv6_drop_unicast_in_l2_multicast;
>>   static struct watchlist event_watches;
>>   static uint32_t known_networks_watch;
>>   static uint32_t allowed_bands;
>> @@ -1641,10 +1645,13 @@ static void 
>> station_set_drop_neighbor_discovery(struct station *station,
>>   {
>>       char *v = value ? "1" : "0";
>>   - sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
>> -                "drop_gratuitous_arp", v);
>> - sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
>> -                "drop_unsolicited_na", v);
>> +    if (supports_drop_gratuitous_arp)
>> + sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
>> +                    "drop_gratuitous_arp", v);
>> +
>> +    if (supports_drop_unsolicited_na)
>> + sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
>> +                    "drop_unsolicited_na", v);
>>   }
>>     static void station_set_drop_unicast_l2_multicast(struct station 
>> *station,
>> @@ -1652,10 +1659,13 @@ static void 
>> station_set_drop_unicast_l2_multicast(struct station *station,
>>   {
>>       char *v = value ? "1" : "0";
>>   - sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
>> -                "drop_unicast_in_l2_multicast", v);
>> - sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
>> -                "drop_unicast_in_l2_multicast", v);
>> +    if (supports_ipv4_drop_unicast_in_l2_multicast)
>> + sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
>> +                    "drop_unicast_in_l2_multicast", v);
>> +
>> +    if (supports_ipv6_drop_unicast_in_l2_multicast)
>> + sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
>> +                    "drop_unicast_in_l2_multicast", v);
>>   }
>>     static void station_signal_agent_notify(struct station *station);
>> @@ -5813,6 +5823,16 @@ static int station_init(void)
>>                           "arp_evict_nocarrier");
>>       supports_ndisc_evict_nocarrier = 
>> sysfs_supports_ipv6_setting("all",
>>                           "ndisc_evict_nocarrier");
>> +    supports_drop_gratuitous_arp = sysfs_supports_ipv4_setting("all",
>> +                        "drop_gratuitous_arp");
>> +    supports_drop_unsolicited_na = sysfs_supports_ipv6_setting("all",
>> +                        "drop_unsolicited_na");
>> +    supports_ipv4_drop_unicast_in_l2_multicast =
>> +                    sysfs_supports_ipv4_setting("all",
>> +                    "drop_unicast_in_l2_multicast");
>> +    supports_ipv6_drop_unicast_in_l2_multicast =
>> +                    sysfs_supports_ipv6_setting("all",
>> +                    "drop_unicast_in_l2_multicast");
>>         watchlist_init(&event_watches, NULL);
>
