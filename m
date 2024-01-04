Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70B1DFD6
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQcY8Jz4"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78117e97becso49816485a.3
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 12:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704400227; x=1705005027; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0YeSg9Dthf507ZTUeVFzc66nxd2t/RJPKdx6BCRn1Y=;
        b=LQcY8Jz46s0pDuzOQeL1EAX+qX6kkAw6JtW8O0xVFg8SMbCh/VClmmzwsadwyblbk4
         RTydGckKVUs2yquVBaa4ZOkd9AXsWSSor67Dhm/XhZBArwJuE0dGNe0GDcmA8jPwQwvJ
         l+6+VPU4kXjDsSfecPZ/JucCn5beJnZ9VFzryLOiD8Ys8eGGl0xhmrgBQsbK0CGy7CyP
         wyDtFoPMFLoGn2eigJOs7hBaefny2xlFHH9bqzEu061rH/mAYgeuQSMrOrJfpngAUE+I
         tN34KYQOU4MfBxbEy6G5AXAAbVR7ewIqa6YKEn5f8jyrpJEhUirTEHESIWvMv2qPpiMt
         1qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704400227; x=1705005027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0YeSg9Dthf507ZTUeVFzc66nxd2t/RJPKdx6BCRn1Y=;
        b=CSJhQxReG41SGHZTBS61tWTKc9ye//3WaeXUlAtK9fjZSmQOxpoKz0SHA/tJXHk1ef
         MENITrb/cB6lF7k0p/pC6F/IpuaeypTv1Da6hG4BzuWYwHctzfS4KHkd7jN7wXweT1T2
         tXaxSismS3JSvAPcgECuwxeE7bkNXJmfJMtwiSw+pYrnk0pFAXsfeGWYCtGpf4UWi7K3
         64JDroG5b4T6EjVwJku4ZiaSO8h9rnIWrxPiOU9e1ybAm1E8j6ilpP21j9t6tQGYZEMy
         hquPoot0xnhbnwxV3PbDcLAsOlNFgVi4anNc7HAJB0hqq2jzNwrQO7636cngpccbPmLH
         2aOg==
X-Gm-Message-State: AOJu0Yy1kqVtf/6K6dMQffxoWgZwbX4vUSl259ZToJoT1iVYyXPIlHe0
	Ck//EMHyEm1qGEIZF5SULWoOSAClR2A=
X-Google-Smtp-Source: AGHT+IFqCvgg3LracbDTlJFGjE+HBxPtHzuTOl02yBJlG0kiGj1s/ddV1/u09PP+Bcot5gAoRiXHCQ==
X-Received: by 2002:a05:620a:2009:b0:77f:8ded:960f with SMTP id c9-20020a05620a200900b0077f8ded960fmr1091196qka.63.1704400226853;
        Thu, 04 Jan 2024 12:30:26 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id m26-20020a05620a221a00b00781eb1e7779sm63910qkh.94.2024.01.04.12.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 12:30:26 -0800 (PST)
Message-ID: <d828bb81-8035-48c3-ae86-1d479bdc0fdc@gmail.com>
Date: Thu, 4 Jan 2024 12:30:24 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scan: limit COLOCATED_6GHZ flag to 6ghz devices
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Cc: Keith G <ys3al35l@gmail.com>
References: <20240103125638.243820-1-prestwoj@gmail.com>
 <4dcbc730-034a-4e3d-afb6-992cbc03a8ac@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <4dcbc730-034a-4e3d-afb6-992cbc03a8ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 1/4/24 10:17 AM, Denis Kenzior wrote:
> Hi James,
>
> On 1/3/24 06:56, James Prestwood wrote:
>> It was seen that this flag seems to cause issues when in AP mode on
>> brcmfmac devices (e.g. the raspberry Pi 3). When in AP mode an a
>
> Seriously?  Why would this flag do anything for non-6E devices?

No idea, I haven't had time, or the desire really to actually check the 
driver. But it was night and day in my testing. With the flag enabled a 
scan on the station interface would immediately disconnect all clients. 
Without the flag things were stable.

We can definitely hold off here, Keith is still doing some testing. Its 
not critical to anything I'm doing so I'd rather be sure it actually 
fixes the problem.

>
>> scan is issued clients will disconnect. After testing this behavior
>> was isolated to the use of the COLOCATED_6GHZ flag.
>>
>> Besides working around the problem on this specific hardware the
>> patch itself makes sense as a non-6GHz capable device shouldn't use
>> this flag anyways.
>
> I guess if you're super paranoid and don't trust the kernel to do the 
> right thing...
>
>>
>> As stated in the patch comment, this isn't really a catch all
>> workaround since the flag is still used for devices supporting 6GHz.
>> If additional hardware exhibits this behavior we may need additional
>> changes like a hardware blacklist or an explicit option to disable
>> the flag.
>>
>> Reported-By: Keith G <ys3al35l@gmail.com>
>> ---
>>   src/scan.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/scan.c b/src/scan.c
>> index f48ffdef..8c6fdc08 100644
>> --- a/src/scan.c
>> +++ b/src/scan.c
>> @@ -394,7 +394,20 @@ static struct l_genl_msg *scan_build_cmd(struct 
>> scan_context *sc,
>>       if (params->ap_scan)
>>           flags |= NL80211_SCAN_FLAG_AP;
>>   -    flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
>> +    /*
>> +     * TODO: This flag appears to cause some undesired behavior on 
>> brcmfmac
>> +     *       when the device is in AP mode, or has a secondary AP 
>> interface
>> +     *       running, causing clients to disconnect when a scan is 
>> issued.
>> +     *
>> +     *       Only using this flag for 6GHz capable devices will 
>> limit this
>> +     *       behavior to only 6GHz devices and in reality makes sense
>> +     *       because a non-6GHz device shouldn't use this flag 
>> anyways. If
>> +     *       more issues still are seen related to this we may need an
>> +     *       explicit workaround, either brcmfmac-specific or a disable
>> +     *       option.
>> +     */
>
> I'd just drop this comment entirely if you still think this is needed.
>
>> +    if (wiphy_band_is_disabled(sc->wiphy, BAND_FREQ_6_GHZ) != -ENOTSUP)
>> +        flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
>>         if (flags)
>>           l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, 
>> &flags);
>
> Regards,
> -Denis
