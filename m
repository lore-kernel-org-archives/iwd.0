Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C3883C
	for <iwd@lists.linux.dev>; Mon,  8 May 2023 18:24:20 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-54cb8d72c0bso2577620eaf.3
        for <iwd@lists.linux.dev>; Mon, 08 May 2023 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683570260; x=1686162260;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2lrvqvMuQSqPe6kMeJtUlQ3A0M8i70+ZcP87wP3Lkk=;
        b=WW9CqhoZdQcHnndvXXH3H8PUOt+dquHUydndbJ6MxP695cF5Nk2n2gJLTJD6FvQLxQ
         Z0CfxOEV2B7eZJl4ni0dcgRuSVnSvzfrRAYWf5p6L1g/63iB2oD/q/o8/DEzHvY1Y7us
         cVL3MhTa2IqfzAIghrgweyWNp6BpVRjlb4u058fwrMaGE7kmHyO/BwCIsGo304/aZlyo
         gDRxT6RlIvfnoKOlQ5VTHwRsrBXnQax/DZYFGq7Ef1vEewzLu5E0EhG0FaUO/Loh6AES
         5GJItNHvPMrTPSUGqB0+UvKlFjoaFN4s5YhSc4oZnsI9FuVdeg8pDk/B/lrafI//EFOX
         TN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683570260; x=1686162260;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2lrvqvMuQSqPe6kMeJtUlQ3A0M8i70+ZcP87wP3Lkk=;
        b=XLrlSMwPOSXUAnbLcoh3W1jI/WgsQ+tWAE3XlqpmwWKWL42IkxnVnd1UkRkGqcPZyq
         zQ6qosUIart8twFVhh3lxAeVF3SeQSdq4RWT/TEpoywZzk8KgsTF0HdCCPYwB+bWR778
         TbapcX5smnl+6dqW83SXgJfwiggmS2bQ63YV5bbV6Xtpfiv96ZYWzTt7eEJrrvlu+nsQ
         QSlCL6seYtluqszSaAxCt534WT0yx7Ho0LkRW7AC9d7pnOjvKz99YmgZofL70vJt1mPi
         AyscoEShalg8VrSZ4D0rCc/ZNJH4vFQugq12PYIsTF7BbJKt2/2zufEj8Vj9vKjUJZK8
         raMA==
X-Gm-Message-State: AC+VfDyrtv/p6lKeD5K/fUbhVV8ZsRJUeC0B73htheAylM6JT8Okydvu
	cpfZbBGTjL8Ltcf1qBxldCk=
X-Google-Smtp-Source: ACHHUZ4Fs9mEy/3D6l31Qo5ATeO54zoO5wAqAIRgk7GjZv3oruMZLXALHfvGP3e4qvhS2kh4RjX2CQ==
X-Received: by 2002:a4a:9c4d:0:b0:54f:629a:f581 with SMTP id c13-20020a4a9c4d000000b0054f629af581mr17282ook.7.1683570259843;
        Mon, 08 May 2023 11:24:19 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y25-20020a4ade19000000b0054f210d887dsm3943641oot.47.2023.05.08.11.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 11:24:19 -0700 (PDT)
Message-ID: <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
Date: Mon, 8 May 2023 13:05:31 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> Second, if we're passing unicast frames, and the unicast frame is addressed to 
>> a radio in a different namespace, how does that radio get the frame?  We don't 
>> have it in our radio_info queue?
> 
> The namespace bars hwsim from seeing radios in other namespaces via GET_WIPHY. 
> So yes, the radios are not in the radio_info queue. But since the radios are on 
> the same kernel any MAC the kernel knows about is accepted when sending a frame, 
> regardless of namespace.
> 

I get this part.  What bothers me is that the current dispatch code seems to be 
completely wrong?

>>
>> The comment for the code you're taking out makes it clear that the intent is 
>> for unicast frames to be sent only only to the radio with the target receiver 
>> address.  And the optimization is simply about not sending frames to radios 
>> with addresses we know do not have the target address.
>>
>> What you're doing here seems to indicate that our implementation (and the 
>> comment) is completely bogus.  And we can simply send any frame to any radio 
>> instance (once) and the frames will be forwarded automagically.  If so, then 
>> you might want to explain this better and fix the code to reflect this.
> 
> Maybe I described this badly, but I was trying to make 2 points:
> 
>   - Historically, before namespaces, hwsim should never be in a situation where 
> a frame is addressed to an unknown recipient. Hostapd won't do this and IWD 
> won't do this. So all that code was doing is looping through the radios. Maybe 
> there is some case I haven't thought of, in which case the kernel would drop the 
> frame anyways.

Sure.  To put it another way, hwsim works today by doing roughly the following:

Suppose we have a setup with a single namespace, with 3 radios.

Radio A with address aa
Radio B with address bb
Radio C with address cc

When a _unicast_ frame with target 'cc' is seen by hwsim, it loops over A, B, C 
and compares the addresses.  If the addresses do not match, then no 
HWSIM_CMD_FRAME is issued for that radio.  So we'd only issue HWSIM_CMD_FRAME 
with Radio C's HWSIM_ATTR_ADDR_RECEIVER.

What you're doing in this patch is to now issue the frame to each and every 
known radio.

So suppose you change this to 2 namespaces, with Radio A+B in namespace A, Radio 
C in namespace C, etc.  Are you running 2 instances of hwsim? One per namespace?

How does it help if namespace A receives a frame with target 'CC'? It doesn't 
know about Radio C, so how would radio C even receive the message? And if it 
somehow does anyway, then it would seem like the above dispatch logic is bogus 
in the first place?

> 
>   - Then with the introduction of namespaces we actually do hit this case of 
> having unknown destination addresses. Not because they are bogus, but because 
> hwsim simply cannot know about radios in other namespaces.
> 

Right, I get that.  But this is not what my question is about :)

Regards,
-Denis
