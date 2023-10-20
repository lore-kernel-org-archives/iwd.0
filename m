Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5045E208C2
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLToKDr1"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6b709048d8eso1014563b3a.2
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697829009; x=1698433809; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+FpgXQ78gFhOiFl2yCH0lpZRIQym93CEcUspHj7dTw=;
        b=bLToKDr1Az7ErYli41iub1BYuhyq6WJ8IOweysCFKUHMovhpcAmkE78qJDy40azvaN
         YKH/AFEGF7ateh8hbY/3gDLwnGUjK+6P6fjhbvqVfE0GtWNvKyzmAGgu0C1CwJih2TrS
         07P05fjKO0XMVLpfoQFWPo8vl5JPQo9gFcziXaI9b/GoGaoZmKxR/hGny6oTOBPzsa9K
         xEUzhB/R9pW2l+/Vc4z14ibwtJxfV4gab/iqBOawZAGxY+xSd18M4iwvAm7YXOfbOBGx
         VQCAZw09CLm0Foazgr8pdWJNtsWQMiS/gx8Qeu+AgcIV4yqFcf/ul88qXEcYhL/CjN2x
         +kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697829009; x=1698433809;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+FpgXQ78gFhOiFl2yCH0lpZRIQym93CEcUspHj7dTw=;
        b=cvj29MC8nEcQHcx/P0HjVcfIm1vVFGnEhDEQ6vSR876cDJjwUlyWx23Tvq2NZjmt+B
         rarFtlBH/99dMgy21zrA4bAKY5Myq6F+e2JKi39dlkEmRrqFTWPf280jrOTgw4W7A795
         DWyNY/+oHvwajVksQm5Rj/i6zunkMdFmthYUQIFX6xImRH/lBp27BeXWjmKjX9e5p7pY
         AdFozEwpqehytq1S2UDFjQjpr8+lwY7i1qWUkiJHxbtzN75GYUA7jI7zQ6f9VmhFJ2o4
         DA22zUFG3dDPNLA0sALvfwGNZQpGoMGmXFq6ipb0a2u1dXHKNV65YaCwHC9KG8VhvoJO
         kYyw==
X-Gm-Message-State: AOJu0YwtRK7UHA/PJXyBxdnpYKj5G4SbYOAMit8+ddmvvGH6KYu2TFJi
	MkPyXKC567a7wDMMBWGgvyfjlTUJB9U=
X-Google-Smtp-Source: AGHT+IGttDkKM6m/l+BtYjqVTW/q3S/VT4KaHgifjqZblfsUgL3cRq/WatPfAi2CGeTredvBsR25EA==
X-Received: by 2002:a05:6a20:1592:b0:12f:c0c1:d70 with SMTP id h18-20020a056a20159200b0012fc0c10d70mr3125851pzj.40.1697829009472;
        Fri, 20 Oct 2023 12:10:09 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id x1-20020aa78f01000000b00690ca67d429sm1890348pfr.100.2023.10.20.12.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 12:10:09 -0700 (PDT)
Message-ID: <50663f9c-b0fb-48d7-ac9d-71b84de30ec2@gmail.com>
Date: Fri, 20 Oct 2023 12:10:08 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] offchannel: add support to issue multiple
 offchannel requests
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-11-prestwoj@gmail.com>
 <9182f9f2-4752-4737-bbf7-d308136d47fd@gmail.com>
 <78efd011-8851-43fe-b1b7-adf42a23ff68@gmail.com>
 <dda44204-e322-4802-b1dc-a2a61de83a3d@gmail.com>
 <6395c614-451b-42f5-8918-7fc3773c2134@gmail.com>
 <e5ddaedf-b334-4d53-bd88-eff92d250efe@gmail.com>
 <832c2b23-f009-494d-b497-b1c4075f3caf@gmail.com>
In-Reply-To: <832c2b23-f009-494d-b497-b1c4075f3caf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/19/23 2:47 PM, James Prestwood wrote:
> Hi Denis,
> 
> On 10/19/23 2:42 PM, Denis Kenzior wrote:
>> Hi James,
>>
>>>
>>> It wouldn't hurt, but I think we were always under the assuming that 
>>> the ack would come before the event so I never bothered using a 
>>> callback :)
>>>
>>
>> My memory is fuzzy now, but I think brcmfmac was very weird in this 
>> area.  Which might explain why offchannel code is written the way it is.
> 
> I think Andrew sorted much of that out in frame-xchg, and I think there 
> are comments about similar behavior of acks arriving late. I can dig up 
> a brcmfmac card and play around with it.
> 
>>
>>>>
>>>>> src/offchannel.c:offchannel_mlme_notify() ROC cancel, cookie=1
>>>>>
>>>>> # Cancel ROC is correctly waited for before starting the next item
>>>>> src/wiphy.c:wiphy_radio_work_done() Work item 1 done
>>>>> src/wiphy.c:wiphy_radio_work_next() Starting work item 2
>>>>> src/offchannel.c:offchannel_work_ready() Issuing ROC
>>>>> src/netdev.c:netdev_mlme_notify() MLME notification Remain on 
>>>>> Channel(55)
>>>>
>>>> This seems fishy?  What else is going offchannel?
>>>
>>> No, this is the same event as below, just netdev printing it.
>>
>> Ah, ok.
>>
>>>
>>>>
>>>>>
>>>>> # Then immediately we get a Remain on Channel event
>>>>> src/offchannel.c:offchannel_mlme_notify() ROC notify, cookie=3
>>>>> src/offchannel.c:offchannel_mlme_notify() ROC started prior to ACK, 
>>>>> setting cookie 3
>>>>> src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
>>>>>
>>>>> # And finally the ack comes in
>>>>> src/offchannel.c:offchannel_roc_cb() cookie=3
>>>>
>>>> Yeah, why is the cookie 3?  Shouldn't it be 2?
>>>
>>> 2 is the work item, 3 is the cookie above.
>>
>> Yeah, I get that.  But shouldn't the cookie from the kernel be 2 and 
>> not 3?  Or is the cookie also being incremented by CMD_FRAME?
> 
> Oh I see, since it jumped from 1 to 3. I would need to verify, but I'd 
> guess yes the CMD_FRAME increments the same counter.

Maybe this is a scheduling thing. I see in the kernel 
(mac80211/offchannel.c) the next offchannel work gets started from 
within the cancel call (ieee80211_cancel_roc).

list_for_each_entry_safe(roc, tmp, &local->roc_list, list) {
	if (!roc->started)
		break;
	if (roc == found)
		found = NULL;
	ieee80211_roc_notify_destroy(roc);
}

/* that really must not happen - it was started */
WARN_ON(found);

ieee80211_start_next_roc(local);

There is a &local->mtx lock at the beginning so I'd think that would 
prevent anything from being shoved into roc_list, but maybe not? If IWD 
is able to start another ROC before ieee80211_start_next_roc is called 
that would explain it, but it seems unlikely, maybe only with UML.

Thanks,
James
> 
>>
>> Regards,
>> -Denis
