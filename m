Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47722305
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2zpEw9R"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-20503dc09adso250349fac.2
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 04:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704372842; x=1704977642; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BA/pNKW9Mo0THYfUoNHR7fRnE0Lb2zkKaLlyPxHRbEs=;
        b=J2zpEw9RN8MQHuOVeJWPLLM2ZCJA7fIWFiKGKKvQqoVIW8YGg+tJeHhgpB2gcZTpA1
         k41JlBIUs0tWXHy6yFvIfbPfkKtEho+khWbcT4P7QBZNRvLC7c6HtSZp0k8gfuVVaien
         aFZWduiWnjR3hAqw1ed9B/LgEUOO3EhP04DF0EZOgxCfVQ5MI4F2ZaqPCVn6EWYhYs56
         wdct6ZisrhEjBm7tFlYVJYPnbCuP1p1yg8AOC5XbmDu7g/DlJPLK7BwDAlzqIe6KFXe7
         zjhgVmotlIxotnaffCHSOC3Yqa7lKSIjdDs/tFgHQkzd3rRc59aNDoFU90S0ChwRUPQg
         /l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704372842; x=1704977642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BA/pNKW9Mo0THYfUoNHR7fRnE0Lb2zkKaLlyPxHRbEs=;
        b=Dfp8kBCm6RBD7M7VCa7RKqsIjMcDbXT63dQ/CVAzInvJsDOFHicSEjFB4XmADgWex/
         gJTvHbr2vo8QMYv2MY+mZIya6ktqmGvmcewWJR0RfbmwL2VQB+PlF/Z4VYxL7+BpXcFX
         Ov/JnVHOQ4jfHbg/ag2tI3woQHeX4mufp58QqsWJ5a4YvIo7X4hQyUbj1Y6cSlYjo603
         aB4GCRYQdYqEUXzxiqnEiAv/rUdyZ0gpyTN5w6itCoDsiZFpuSzpMHuHJF8dlW71SBtF
         O3k9yGBwaA75eGgI07aG4luXDByqdnFizPSrXRoe5IxRPolas3Nh9hz2FEydcYMkVF5K
         Tb9w==
X-Gm-Message-State: AOJu0YwtVsFUHlXCGcGfIJ5THJHDIqjmy37UTwWI+ARsFsTJIWwX2lLE
	N0miUUkqF32CihZfHWn51Og=
X-Google-Smtp-Source: AGHT+IEdsGo2GmQRzOgMj9LfisxakqHIoecl+9iivDel/gPcLSZdR2sCnVYPG0v5vGxyQuVvuS/dpw==
X-Received: by 2002:a05:6871:22c2:b0:203:f926:5b6c with SMTP id se2-20020a05687122c200b00203f9265b6cmr514008oab.39.1704372841763;
        Thu, 04 Jan 2024 04:54:01 -0800 (PST)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id t1-20020a63f341000000b005b529d633b7sm22580176pgj.14.2024.01.04.04.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 04:54:01 -0800 (PST)
Message-ID: <73226ddb-54bf-4d5a-ac1e-77895f3f2ff9@gmail.com>
Date: Thu, 4 Jan 2024 04:54:00 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scan: limit COLOCATED_6GHZ flag to 6ghz devices
Content-Language: en-US
To: KeithG <ys3al35l@gmail.com>
Cc: iwd@lists.linux.dev
References: <20240103125638.243820-1-prestwoj@gmail.com>
 <271dfdff-903d-4ff4-abe7-34526aec3580@gmail.com>
 <CAG17S_Pf2YeN8WMj8K6i5RfZTdFXy7S4Ry_zcqPYFdQQ57v52g@mail.gmail.com>
 <16330cf3-e6d3-4855-8b65-28b2fe8a905f@gmail.com>
 <CAG17S_M3xck1p5c3PAUUjrKX6svHwBvyS59ag6Jo_VOY+tdg9w@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_M3xck1p5c3PAUUjrKX6svHwBvyS59ag6Jo_VOY+tdg9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 1/3/24 6:42 PM, KeithG wrote:
> On Wed, Jan 3, 2024 at 9:01 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Keith,
>>
>> On 1/3/24 6:57 AM, KeithG wrote:
>>> On Wed, Jan 3, 2024 at 6:58 AM James Prestwood <prestwoj@gmail.com> wrote:
>>>> Hi Keith,
>>>>
>>>> On 1/3/24 4:56 AM, James Prestwood wrote:
>>>>> It was seen that this flag seems to cause issues when in AP mode on
>>>>> brcmfmac devices (e.g. the raspberry Pi 3). When in AP mode an a
>>>>> scan is issued clients will disconnect. After testing this behavior
>>>>> was isolated to the use of the COLOCATED_6GHZ flag.
>>>>>
>>>>> Besides working around the problem on this specific hardware the
>>>>> patch itself makes sense as a non-6GHz capable device shouldn't use
>>>>> this flag anyways.
>>>>>
>>>>> As stated in the patch comment, this isn't really a catch all
>>>>> workaround since the flag is still used for devices supporting 6GHz.
>>>>> If additional hardware exhibits this behavior we may need additional
>>>>> changes like a hardware blacklist or an explicit option to disable
>>>>> the flag.
>>>>>
>>>>> Reported-By: Keith G <ys3al35l@gmail.com>
>>>> Could you double check it still fixes the issue you were seeing on brcmfmac?
>>>>
>>>> Thanks,
>>>>
>>>> James
>>>>
>>>>> ---
>>>>>     src/scan.c | 15 ++++++++++++++-
>>>>>     1 file changed, 14 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/src/scan.c b/src/scan.c
>>>>> index f48ffdef..8c6fdc08 100644
>>>>> --- a/src/scan.c
>>>>> +++ b/src/scan.c
>>>>> @@ -394,7 +394,20 @@ static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
>>>>>         if (params->ap_scan)
>>>>>                 flags |= NL80211_SCAN_FLAG_AP;
>>>>>
>>>>> -     flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
>>>>> +     /*
>>>>> +      * TODO: This flag appears to cause some undesired behavior on brcmfmac
>>>>> +      *       when the device is in AP mode, or has a secondary AP interface
>>>>> +      *       running, causing clients to disconnect when a scan is issued.
>>>>> +      *
>>>>> +      *       Only using this flag for 6GHz capable devices will limit this
>>>>> +      *       behavior to only 6GHz devices and in reality makes sense
>>>>> +      *       because a non-6GHz device shouldn't use this flag anyways. If
>>>>> +      *       more issues still are seen related to this we may need an
>>>>> +      *       explicit workaround, either brcmfmac-specific or a disable
>>>>> +      *       option.
>>>>> +      */
>>>>> +     if (wiphy_band_is_disabled(sc->wiphy, BAND_FREQ_6_GHZ) != -ENOTSUP)
>>>>> +             flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
>>>>>
>>>>>         if (flags)
>>>>>                 l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);
>>> James,
>>>
>>> I will do this tonight. I was playing a lot with iwd that I had
>>> patched with your suggestion last night. I was trying to resolve a
>>> related problem and I did note that it was significantly more stable
>>> with this patch, but I was still getting disconnected periodically. I
>>> do not yet know if those disconnects were due to me or iwd and am
>>> still investigating. I will continue this investigation with this new
>>> patch applied. SHould this patch be against HEAD or can I safely patch
>>> 2.12?

So here is what I found. If I have just a single interface, AP mode, I 
can connect and scan (in AP mode) just fine without resulting in a 
disconnect. If I even create a secondary interface I can no longer 
connect what-so-ever. I see the SSID on my client (Android) device and 
try and connect but see no attempt on the AP side of things. This even 
happens if the second interface is left down, which is really odd to me. 
Could you include exactly how you're setting things up? What interfaces 
you create, etc.

Whats odd is the patch I gave you to privately simply commented out that 
flag and you said that worked, maybe spoke too soon? This patch would 
have no functional difference since the raspi doesn't support 6GHz.

Thanks,

James

