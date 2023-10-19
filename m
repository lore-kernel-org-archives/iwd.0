Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88C72EAFF
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ancn2yXa"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1e993765c1bso66984fac.3
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697745342; x=1698350142; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYuDHJh7kTG1rjiM2VfgQ4wkP3H8y/Mw8/VXb5uK3xs=;
        b=Ancn2yXaCnKyWJsU9tcupG6t5iMJ+MPYfjPdWoJT122p0aSLuBqpIGmw8v4PIkztPk
         2waQtXqoEGd3fycvKi1NDCYdL9F9lxFsrFV8pMqAiUHamxQtHH+wnQv2VASKXSdTDO3c
         Lkcp8wEp5jqfs+dj7x7JpzaEMmrjqEQXZDuWhjdR+IWMViLRYySUcKha9rRiX/azzR1E
         DpxKPKMW0Uz2H5lIPgaHSUQ7K8crgOxxwhMjeyjeeLweM7GFg2p4JSPSZ25O42YRCCtC
         wsyBIv/L5KCHynuFSUKsaoUuKUBPn9rtO624Lk+JSbOm3NAgTWUwYtnwBuM05BpWFX0u
         EzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697745342; x=1698350142;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYuDHJh7kTG1rjiM2VfgQ4wkP3H8y/Mw8/VXb5uK3xs=;
        b=U3UQvpFH7n3axPfONgD6Iyotmsw6IQCmmyPdUs99aQTRr0UxxdxamQzCWrKIP0rpwy
         FnpiWmDIog7RdLjAoeCNB+XJmRLaFmXxAl8hZEOrGfqZ5k6pJDOD3VYBM1Nd+W2EK+Hk
         aGXRTd6mCRCaP5meJW5mg109POlpO5vhpEHLUw86F2nMgwYN7Z7Vy2EdeR5dJfL2P5K8
         558deQDZml1lS611hiaPwcK3HagXXxNrhyMxr/zCxxUGju+aYTZV/mGLpyORvSbKis3P
         mUUtfqtveXU13d0g63iF0E6SGFKB1LtMUSUmbN581F2ucRBWbjwV57czKRBFDqc7rA5d
         INkw==
X-Gm-Message-State: AOJu0YwfiNne408pQbz9CYHI9g2VHOKVps949H6S2AOMeXl4PDUA60aJ
	UtWMR0q0p09blJrfeHB7P7U=
X-Google-Smtp-Source: AGHT+IEZB9tzINq2nibGdRfG0IfZrkttlxqoz2vTZY7+mtM74N1rBYLZO1hZRJTmYJt6TR9r2XtJgw==
X-Received: by 2002:a05:6870:c18a:b0:1e9:c59b:a9ad with SMTP id h10-20020a056870c18a00b001e9c59ba9admr3387144oad.52.1697745341915;
        Thu, 19 Oct 2023 12:55:41 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h23-20020a9d3e57000000b006cd096949a5sm51641otg.16.2023.10.19.12.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 12:55:41 -0700 (PDT)
Message-ID: <dda44204-e322-4802-b1dc-a2a61de83a3d@gmail.com>
Date: Thu, 19 Oct 2023 14:55:40 -0500
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
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-11-prestwoj@gmail.com>
 <9182f9f2-4752-4737-bbf7-d308136d47fd@gmail.com>
 <78efd011-8851-43fe-b1b7-adf42a23ff68@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <78efd011-8851-43fe-b1b7-adf42a23ff68@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> So I'm not sure what exactly is going on here. I have yet to see this on actual 
> hardware, but it happens in hwsim frequently. You are right that the offchannel 
> module gates all the work items, and correctly waits for one to finish. So I was 
> wrong that it needed "fixing" in that regard. Here are some logs with the ack 
> coming out of order, maybe this is some UML scheduling thing, not sure:
> 
> src/dpp.c:dpp_start_pkex_enrollee() PKEX start enrollee (id=test)
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 1
> src/wiphy.c:wiphy_radio_work_next() Starting work item 1
> src/offchannel.c:offchannel_work_ready() Issuing ROC
> src/offchannel.c:offchannel_roc_cb() cookie=1
> src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
> src/offchannel.c:offchannel_mlme_notify() ROC notify, cookie=1
> src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
> src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
> src/dpp.c:dpp_handle_pkex_exchange_request() PKEX exchange request 
> 02:00:00:00:02:00
> src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
> src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
> src/dpp.c:dpp_handle_pkex_commit_reveal_request() PKEX commit-reveal request 
> 02:00:00:00:02:00
> src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
> src/netdev.c:netdev_unicast_notify() Unicast notification Frame(59)
> src/dpp.c:dpp_handle_pkex_exchange_response() PKEX response 02:00:00:00:03:00
> 
> # Got a response, so the prior offchannel work (1) was canceled, and a new item 
> inserted (2)
> 
> src/wiphy.c:wiphy_radio_work_insert() Inserting work item 2
> src/netdev.c:netdev_mlme_notify() MLME notification Cancel Remain on Channel(56)

So is this iwd sending a NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL?  Should we also 
wait for the ack of this one too?

> src/offchannel.c:offchannel_mlme_notify() ROC cancel, cookie=1
> 
> # Cancel ROC is correctly waited for before starting the next item
> src/wiphy.c:wiphy_radio_work_done() Work item 1 done
> src/wiphy.c:wiphy_radio_work_next() Starting work item 2
> src/offchannel.c:offchannel_work_ready() Issuing ROC
> src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)

This seems fishy?  What else is going offchannel?

> 
> # Then immediately we get a Remain on Channel event
> src/offchannel.c:offchannel_mlme_notify() ROC notify, cookie=3
> src/offchannel.c:offchannel_mlme_notify() ROC started prior to ACK, setting 
> cookie 3
> src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
> 
> # And finally the ack comes in
> src/offchannel.c:offchannel_roc_cb() cookie=3

Yeah, why is the cookie 3?  Shouldn't it be 2?

> 
> I need to look at the kernel a bit more to see how this can happen, but apart 
> from me removing some of the commit description I do think the patch is required 
> to handle this case.
> 

Regards,
-Denis

