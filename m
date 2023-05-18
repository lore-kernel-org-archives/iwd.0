Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B419B
	for <iwd@lists.linux.dev>; Thu, 18 May 2023 03:21:50 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5527456ede6so668973eaf.3
        for <iwd@lists.linux.dev>; Wed, 17 May 2023 20:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684380110; x=1686972110;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bj/cEzWEgSm/bEKqId+nT9jIFvDpaRQh4v+u2/Iu5uY=;
        b=r1iFWAfzrDhG2Ao0Fkd7YSZqGLqDUok7SLQzAceds18X/b5fyIszmE+l5uYqfYc76n
         OBT6ZGYLHNv6HK9J1V6Owt6QnMO7EpClD5h4EcgAzoUVNpI0Bm7nO8HrOUpMF0Jtl4tj
         BRaGkTv5XGM0VzXWdYQy7d2pgLttS8VF4y3NAGHnnVg6YYEbob5rXk5Xc0Rqb/KgUAyZ
         Kmof4qyC7rKfnIdU9r2NVboUNJsYu56j66ZAAaG87oHjpPEqu1Tk+PdS/wTFDFdwHiJX
         /XRh04D4uz/VVfnPOhKiiBmhiFAijqqiBgmmQ9iysJlIsjTSQ7QCX+Vnd6ybG2RhonLj
         YdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684380110; x=1686972110;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bj/cEzWEgSm/bEKqId+nT9jIFvDpaRQh4v+u2/Iu5uY=;
        b=eLtuxZjiG0GtT9Fg8HXH+byDcmx450W5+BvvSeyZY9lbQ2p73Dyyv8VsDfEF6DiQ6U
         EaunEybU/J+0anDyAQS55PPJWBSTAsSkh/zxTEFbl+3ZWLFGwp59bqcUM7wJddBTLD60
         tPY3s2cUosdO4qXQ7w1OKDMnDxTJGUGeXBH+69WVpoDzdzBAWqFSdhVdyMSXw3WjzHhs
         m/yk+VpMW+H7Oy/BHYYlhwIKxBmxpkB2V7G5WcKro7PimC2bUJnV/s68zfgSzEwdD09o
         KM6CO9+vrbyFjzumxMiKTlGgHnRb62flbxpW/lmP5eGcGVZZYucJMRfCSJlGs7c87aLM
         h4Yg==
X-Gm-Message-State: AC+VfDyO7kTdEfypy+lpZxjrZQH5s2QvhNmGo9TXqsGXB1DylNVD7EbR
	manos29Ches8CM39UWELQ5M=
X-Google-Smtp-Source: ACHHUZ5Xfe6q2xpYw8vzWBIgybQwXTiMatLQXQNmk0bAe6YpzruNnxrc0S3PQcqilg5sHXxabngZaw==
X-Received: by 2002:a05:6808:1411:b0:392:593f:bb1c with SMTP id w17-20020a056808141100b00392593fbb1cmr697155oiv.20.1684380109779;
        Wed, 17 May 2023 20:21:49 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y26-20020a4ae7da000000b0054f9f229bddsm103146oov.15.2023.05.17.20.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 20:21:48 -0700 (PDT)
Message-ID: <078eb5ea-ead1-1667-5801-6ca56ca39427@gmail.com>
Date: Wed, 17 May 2023 22:21:44 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] wiphy: fix regdom change wiphy dump logic
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230510204508.715558-1-prestwoj@gmail.com>
 <20230510204508.715558-2-prestwoj@gmail.com>
 <c144e8f9-90e9-bca2-745f-b25e596f5600@gmail.com>
 <b7a3fbba-6715-d373-2190-ed2012e103a8@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <b7a3fbba-6715-d373-2190-ed2012e103a8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> NAK.  Please stop right there.  genl is already a queue.  There's no sense 
>> adding queuing on top of it in this particular case.  If l_genl_family_cancel 
>> isn't doing the right thing, then fix that instead.
> 
> Well l_genl_family_cancel really cant do anything about it. Once the dump hits 
> the kernel you cant cancel it (this is why we added l_genl_family_request_sent). 

This was done for a different reason.  In the case of CMD_REMAIN_ON_CHANNEL we 
must wait for the ack to obtain the cookie.  We can cancel the ROC only if we 
know the cookie.  Otherwise, even if we call l_genl_family_cancel, the ROC would 
still go ahead.

What you have here is a different and simpler case.

> So the only alternative I can think of, if we cant do it in IWD, would be to 
> make l_genl queue dumps and not issue more dumps until the previous one 
> finishes. This is obviously a significant behavioral change.

I'm lost?  That is what is supposed to happen and happens already today.  If you 
issue two dumps like:

l_genl_family_dump(..., msg1, ...);
l_genl_family_dump(..., msg2, ...);

Then msg2 will not be sent to the kernel until NLMSG_DONE flagged message is 
received.  So what exactly would be the behavioral change you are referring to?

Anyway, looking at l_genl_family_cancel, it is doing the wrong thing, so that 
should be fixed.

Regards,
-Denis
