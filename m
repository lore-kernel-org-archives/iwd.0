Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8953D382
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaHnVkaV"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5832ea25c7eso39269eaf.3
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697745912; x=1698350712; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pteIHYjHtmp1sJiAHWqmGoRclhN9Y5EugHpt080RRcE=;
        b=GaHnVkaVaeYrIYxL3z/T2o/oe+RO5//SQT5rpMG7LZX498AUhkQIp3IgQs/RFODezQ
         aXzdWGZcMff/MF6FPyFWXNCUARneT08sntIZSFEIQWLg3UuA/IGg73f1R1qaFNZ8vQhz
         jEdipg6KgICkVAivZ110dQVpkWx49dR4JpO09xSR/ifQtRp5zbQP9D257gy6kKohDuHD
         /G1cYGdptMGcbiSpuRIm/tlwyCO5bMGK4pQzU71kUVqSNLcBep6fDS/l+FEiSbY1vnIq
         QZ/VMqnDwGlVROThlEEwGhHb8lS7l2RjmeykpP9Ql0CNBN0aJDuhZ6qI+Y2ExIq9DSZd
         nLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697745912; x=1698350712;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pteIHYjHtmp1sJiAHWqmGoRclhN9Y5EugHpt080RRcE=;
        b=evY+6p9xTSj3J0ZGJTd+oGdC0+SEsyedAaJ0x2eZv3SOGTM0InnJMinqGamFGt07Qa
         YHH69cETXswow98+k3oFshGTSiNbGMatgTutzi12iPJlUHUj1xUAfxdEA/zyDWfe8c4v
         MyHa1jUEOenTpXO3advdYaW0NBbTTyOInAX2crmRa+AD6+s7FpaonOUE9DEDWekv1vbD
         tWQWNlVD0fqHE7cOLppeXPI4ahpt+8ZBFeXxdljHz6qFyQxqIe6xkkJdRNmyyMTVEjvJ
         SI+vqwMSs8j3TvQPjLNJWBZI1FmVZckJNzJLjpMwtF3wkj7EysRGVMrayFaOcoKWrBNn
         uvmQ==
X-Gm-Message-State: AOJu0YzNtRVz332uszb4lDD0CdbBlnbyvCdUejSHNTjnIgCmFVycJH6F
	wUGmP4r40As+9H3Uw1MIdTJUybW5q/U=
X-Google-Smtp-Source: AGHT+IFj94HmewTbw3ScmsqRxNOx/Z4pyWAZhW4oOHj0jbZRLHI1H9dlFOlkJnwnb2mRA19+7FaNLA==
X-Received: by 2002:a05:6358:611e:b0:142:d097:b14a with SMTP id 30-20020a056358611e00b00142d097b14amr1990143rws.13.1697745911958;
        Thu, 19 Oct 2023 13:05:11 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00008400b006be22fde07dsm176170pfj.106.2023.10.19.13.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 13:05:11 -0700 (PDT)
Message-ID: <6395c614-451b-42f5-8918-7fc3773c2134@gmail.com>
Date: Thu, 19 Oct 2023 13:05:11 -0700
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
 <78efd011-8851-43fe-b1b7-adf42a23ff68@gmail.com>
 <dda44204-e322-4802-b1dc-a2a61de83a3d@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <dda44204-e322-4802-b1dc-a2a61de83a3d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/19/23 12:55 PM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> So I'm not sure what exactly is going on here. I have yet to see this 
>> on actual hardware, but it happens in hwsim frequently. You are right 
>> that the offchannel module gates all the work items, and correctly 
>> waits for one to finish. So I was wrong that it needed "fixing" in 
>> that regard. Here are some logs with the ack coming out of order, 
>> maybe this is some UML scheduling thing, not sure:
>>
>> src/dpp.c:dpp_start_pkex_enrollee() PKEX start enrollee (id=test)
>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 1
>> src/wiphy.c:wiphy_radio_work_next() Starting work item 1
>> src/offchannel.c:offchannel_work_ready() Issuing ROC
>> src/offchannel.c:offchannel_roc_cb() cookie=1
>> src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
>> src/offchannel.c:offchannel_mlme_notify() ROC notify, cookie=1
>> src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
>> src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
>> src/dpp.c:dpp_handle_pkex_exchange_request() PKEX exchange request 
>> 02:00:00:00:02:00
>> src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
>> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
>> src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
>> src/dpp.c:dpp_handle_pkex_commit_reveal_request() PKEX commit-reveal 
>> request 02:00:00:00:02:00
>> src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
>> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
>> src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
>> src/dpp.c:dpp_handle_pkex_exchange_response() PKEX response 
>> 02:00:00:00:03:00
>>
>> # Got a response, so the prior offchannel work (1) was canceled, and a 
>> new item inserted (2)
>>
>> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
>> src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on 
>> Channel(56)
> 
> So is this iwd sending a NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL?  Should 
> we also wait for the ack of this one too?

It wouldn't hurt, but I think we were always under the assuming that the 
ack would come before the event so I never bothered using a callback :)

>
>> src/offchannel.c:offchannel_mlme_notify() ROC cancel, cookie=1
>>
>> # Cancel ROC is correctly waited for before starting the next item
>> src/wiphy.c:wiphy_radio_work_done() Work item 1 done
>> src/wiphy.c:wiphy_radio_work_next() Starting work item 2
>> src/offchannel.c:offchannel_work_ready() Issuing ROC
>> src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
> 
> This seems fishy?  What else is going offchannel?

No, this is the same event as below, just netdev printing it.

> 
>>
>> # Then immediately we get a Remain on Channel event
>> src/offchannel.c:offchannel_mlme_notify() ROC notify, cookie=3
>> src/offchannel.c:offchannel_mlme_notify() ROC started prior to ACK, 
>> setting cookie 3
>> src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
>>
>> # And finally the ack comes in
>> src/offchannel.c:offchannel_roc_cb() cookie=3
> 
> Yeah, why is the cookie 3?  Shouldn't it be 2?

2 is the work item, 3 is the cookie above.

> 
>>
>> I need to look at the kernel a bit more to see how this can happen, 
>> but apart from me removing some of the commit description I do think 
>> the patch is required to handle this case.
>>
> 
> Regards,
> -Denis
> 
