Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E923DFE5
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPg6nIMP"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e9d3cc6e7aso136333fac.2
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697751740; x=1698356540; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvPUYq3K3MiX3bQC9cvLVcQYbwILjzwkkPmh5Tjr+6E=;
        b=YPg6nIMPf1lEg+ZtzPPCU9xcJ49toonnNgwTkztHRDIPunvmb0Kq9Kc8Y5cR4f35if
         22zwUCHpkxNdkE2NkaE82i+JSL3KUSnZSci7u2qbxXV60cLpotcyGYd2UghCU8CD58gS
         Z9+69cLplKGIBIUvjorcff3ODDC/HsIiXJkzHqLIHYPhBrGD+vm4vQAgJ88VLpflf9Xu
         FebG754+cNfOytfoAKfWgQ9VLJ70p/OLtZP0Ce/0one9eZS4nCX+Uwrb32UWETjYUk0n
         aVCIcQSOmDlE5wkbYqTL7/cR/brhMT7Ucc+hIiB97zBF+awrr8PjX/ZtddkkAUr78NPO
         s9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697751740; x=1698356540;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvPUYq3K3MiX3bQC9cvLVcQYbwILjzwkkPmh5Tjr+6E=;
        b=bx0Oz7fgYhjIsmfcSo4hZaW2LrRZPvndo3qB6xEYZtbj0xafATaj8UIxf1I0odxFRH
         Q7X2CO7+knI3kIxyMgZduZMlLuwlavCcY6b5QR9w/xCqnHqWHOpeGhoUu3j77RVn1fEy
         lcbZSrYxe+5dpGvtdMGiT5z8YtXvIamp367ceQwjUYwBbE1ZH4qtQnRVsI+Iy0EHWjBz
         jP2KsA1e3e+g4hxx2mkmkE/RgT2wHbvAjzgaIA0L2/QGoiHyBc4ogD+BQHQMNJAI8gln
         L2uy3731rIq9o00bW3snnyL4jn9glG34V8uyFVpYNdSHbGCSza63P3CkaD+JnBS+jhmO
         gLAQ==
X-Gm-Message-State: AOJu0Yz6OkhEju+sDxfnAdPKPBd3W3ykXs4Th83HegEYCj11L84WToRD
	xk2vs4l6VU+6zOgFxW6YZuI=
X-Google-Smtp-Source: AGHT+IFVY+OS6rc4GK0yRoY8eApsYkj9OG1bBB2ii/KrSypXZDFvzSuo5B1EBdFRPuMJvjjkeiU9Cg==
X-Received: by 2002:a05:6870:1056:b0:1e9:9a86:2937 with SMTP id 22-20020a056870105600b001e99a862937mr138086oaj.51.1697751740606;
        Thu, 19 Oct 2023 14:42:20 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ni8-20020a056871348800b001e96eba5abdsm77197oac.26.2023.10.19.14.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 14:42:20 -0700 (PDT)
Message-ID: <e5ddaedf-b334-4d53-bd88-eff92d250efe@gmail.com>
Date: Thu, 19 Oct 2023 16:42:19 -0500
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
 <dda44204-e322-4802-b1dc-a2a61de83a3d@gmail.com>
 <6395c614-451b-42f5-8918-7fc3773c2134@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <6395c614-451b-42f5-8918-7fc3773c2134@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

> 
> It wouldn't hurt, but I think we were always under the assuming that the ack 
> would come before the event so I never bothered using a callback :)
>

My memory is fuzzy now, but I think brcmfmac was very weird in this area.  Which 
might explain why offchannel code is written the way it is.

>>
>>> src/offchannel.c:offchannel_mlme_notify() ROC cancel, cookie=1
>>>
>>> # Cancel ROC is correctly waited for before starting the next item
>>> src/wiphy.c:wiphy_radio_work_done() Work item 1 done
>>> src/wiphy.c:wiphy_radio_work_next() Starting work item 2
>>> src/offchannel.c:offchannel_work_ready() Issuing ROC
>>> src/netdev.c:netdev_mlme_notify() MLME notification Remain on Channel(55)
>>
>> This seems fishy?  What else is going offchannel?
> 
> No, this is the same event as below, just netdev printing it.

Ah, ok.

> 
>>
>>>
>>> # Then immediately we get a Remain on Channel event
>>> src/offchannel.c:offchannel_mlme_notify() ROC notify, cookie=3
>>> src/offchannel.c:offchannel_mlme_notify() ROC started prior to ACK, setting 
>>> cookie 3
>>> src/dpp.c:dpp_send_frame() Sending frame on frequency 2437
>>>
>>> # And finally the ack comes in
>>> src/offchannel.c:offchannel_roc_cb() cookie=3
>>
>> Yeah, why is the cookie 3?  Shouldn't it be 2?
> 
> 2 is the work item, 3 is the cookie above.

Yeah, I get that.  But shouldn't the cookie from the kernel be 2 and not 3?  Or 
is the cookie also being incremented by CMD_FRAME?

Regards,
-Denis
