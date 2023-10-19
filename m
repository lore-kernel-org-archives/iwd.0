Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511236AE2
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPu8tNTt"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c8a1541232so256025ad.0
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697744106; x=1698348906; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=webF0x3Ai9fiAveXF61WGdWfkzsd6N3ZEmYesFfS1xU=;
        b=EPu8tNTtvlz5EF/x49GBXHoCffHDc5yxc9h3WSTVxbrXByu9v0sKU1EnZVFih2QkVO
         ums+YsJHJnD769jWutO47lMTbHpMq3gboHH4LNcD0Myh8gTzCXMd6I3Zc/zV/HJKQu1S
         Yrjx0C4p4SXtBX8+FDxLIG7/Wiw4P1QvfsKVjSG6wX4yj9lqiujtWiIMb0EB4uM3e7+y
         nGxxtj8fDVlr/BAvcPRc9XMSXQeqTaM+TOolHcY3IecqZi2yrw2HtYVlpilRYkhb2Yqx
         5KL1hycXZMNvUb39ZItTOc1XHJt5U/f41uBkZEda7F8FPN31c91RHze733zYO8IJE75Q
         hYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697744106; x=1698348906;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=webF0x3Ai9fiAveXF61WGdWfkzsd6N3ZEmYesFfS1xU=;
        b=R9tJ1ITFdLBQDMWquoAqx01r+J0Mar/vsdvvzKJeU6iCO1J6Q0nAVoW09sT0JQQMy4
         lBy478veXXJa6cHycO87EhsPz2cyUUPTzJnt4tojKI77w9RsYzS/2exTUsWLPDY7tnUt
         mjbpGkO7c59eihTWg+R56cqtaADDlruLj/U3/adY/MnEVGjMnQc8NrxGQ4piSyen8+J7
         SGUnIFuZoIOuk/gnfAcmRocZWY5z5nOyZSS6PYrLxY1WRw3eRB8L4L1819oxVI/okNsK
         hUsDgmzXzGPZSjG2EAJ6zkGHvOjmZUFiORejPlvlc4+gYl9Orc70iyNVfDEuM06Ric8k
         fEOA==
X-Gm-Message-State: AOJu0YwJClzQP79cgEmwUD/PNqFk5ed7j370uYdceKsV9MyNM4LTaFxF
	CND+x6mo95xTEYz8Q9BKr5sO6umSRSI=
X-Google-Smtp-Source: AGHT+IFue3xMUiP0GvG2Fa/Re3zw3k2tdf3EeIOZt4yAvfMYQfmoDuoOIIr1r4FfrE92YafVXuvp8Q==
X-Received: by 2002:a17:903:4305:b0:1c5:ee21:ce33 with SMTP id jz5-20020a170903430500b001c5ee21ce33mr3104294plb.23.1697744106068;
        Thu, 19 Oct 2023 12:35:06 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id jw4-20020a170903278400b001ca485b8515sm81422plb.91.2023.10.19.12.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 12:35:05 -0700 (PDT)
Message-ID: <78efd011-8851-43fe-b1b7-adf42a23ff68@gmail.com>
Date: Thu, 19 Oct 2023 12:35:04 -0700
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
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-11-prestwoj@gmail.com>
 <9182f9f2-4752-4737-bbf7-d308136d47fd@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <9182f9f2-4752-4737-bbf7-d308136d47fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/19/23 7:51 AM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/12/23 15:01, James Prestwood wrote:
>> There was nothing which prevented this, but due to the behavior of
>> some drivers multiple offchannel requests on the same channel
> 
> Isn't the point of offchannel API to serialize all such requests so this 
> does not happen?
> 
>> resulted in the second request never starting and eventually timing
>> out. This is because some drivers combine offchannel requests if
>> they are on the same channel and this ultimately results in the
>> netlink ACK coming after the ROC started event. This patch fixes
>> some logic to allow for this case.
> 
> Kernel ROC APIs have no enforcement of semantics at all.  Different 
> drivers just do whatever.  Have you tested that this works on brcmfmac 
> for example?  It might be better to explicitly wait for the ROC event to 
> be ended before starting a new one.
> 
>>
>> The motivation to support this is so modules can start offchannel
>> work items for short durations and wait for a response, if a frame
>> is received the offchannel request can be canceled/restarted for
>> a longer duration.
>>
>> This could also be done instead by using a long duration initially
>> and an extra timer to cancel, but its more convenient if offchannel
>> supports this natively. In addition, this driver quirk should be
>> supported regardless (e.g. if two IWD modules happen to issue ROC's
>> on the same channel).
> 
> Then shouldn't offchannel serialize such requests?
> 
>>
>> Furthermore, the offchannel module was only looking up requests by
>> wdev_id which could result in the wrong request being found.
>> Instead the request should be looked up by both wdev_id and cookie
>> (when possible), or the ID in the case of canceling.
> 
> This part makes sense and probably belongs in a separate patch.

So I'm not sure what exactly is going on here. I have yet to see this on 
actual hardware, but it happens in hwsim frequently. You are right that 
the offchannel module gates all the work items, and correctly waits for 
one to finish. So I was wrong that it needed "fixing" in that regard. 
Here are some logs with the ack coming out of order, maybe this is some 
UML scheduling thing, not sure:

src/dpp.c:dpp_start_pkex_enrollee() PKEX start enrollee (id=test)
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 1
src/wiphy.c:wiphy_radio_work_next() Starting work item 1
src/offchannel.c:offchannel_work_ready() Issuing ROC
src/offchannel.c:offchannel_roc_cb() cookie=1
src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
src/offchannel.c:offchannel_mlme_notify() ROC notify, cookie=1
src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
src/dpp.c:dpp_handle_pkex_exchange_request() PKEX exchange request 
02:00:00:00:02:00
src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
src/dpp.c:dpp_handle_pkex_commit_reveal_request() PKEX commit-reveal 
request 02:00:00:00:02:00
src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
src/dpp.c:dpp_handle_pkex_exchange_response() PKEX response 
02:00:00:00:03:00

# Got a response, so the prior offchannel work (1) was canceled, and a 
new item inserted (2)

src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on 
Channel(56)
src/offchannel.c:offchannel_mlme_notify() ROC cancel, cookie=1

# Cancel ROC is correctly waited for before starting the next item
src/wiphy.c:wiphy_radio_work_done() Work item 1 done
src/wiphy.c:wiphy_radio_work_next() Starting work item 2
src/offchannel.c:offchannel_work_ready() Issuing ROC
src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)

# Then immediately we get a Remain on Channel event
src/offchannel.c:offchannel_mlme_notify() ROC notify, cookie=3
src/offchannel.c:offchannel_mlme_notify() ROC started prior to ACK, 
setting cookie 3
src/dpp.c:dpp_send_frame() Sending frame on frequency 2437

# And finally the ack comes in
src/offchannel.c:offchannel_roc_cb() cookie=3

I need to look at the kernel a bit more to see how this can happen, but 
apart from me removing some of the commit description I do think the 
patch is required to handle this case.

Thanks,
James
