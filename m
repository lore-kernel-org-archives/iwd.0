Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395C20691
	for <iwd@lists.linux.dev>; Thu, 18 May 2023 14:03:16 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-62387baa403so5962426d6.1
        for <iwd@lists.linux.dev>; Thu, 18 May 2023 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684418595; x=1687010595;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pppw+oiByxeC/D4toujmulo+QTWC+GfXytUkjmMB2Nc=;
        b=IvzAFbweS+yum0zQRO4ftlSKzP34jdiDW6gAZdI2EqnchwoHi+MnQALTedCts8ZiKp
         m+xnHo5hH5vabHqWXaW5l9KHpblE+F0Om5TnR603Yes0u2GnAt3+9uPQyIJYH0pbRgeG
         Tc5zzx8D8ZhC8SNkHtzL1njQpHQQQhCtcYCZiDS1Bi0Te2ckacHsETPvIhn6hp2Qhwui
         BgGC2oiaXZNLXTyY1ECoLht5rXs4v1ot35BURVDBLjuz4awTqVT+tbSjzo/T9MK/f1I7
         2TZxpmx0Z+IH6FbclTfm3SibYkW29zUSr7VFURcQwPJmBGjR/0qwR8RAJwX3ZoL4e0BY
         Z9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684418595; x=1687010595;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pppw+oiByxeC/D4toujmulo+QTWC+GfXytUkjmMB2Nc=;
        b=gXVXnbx9boayr9wEUOc0ocB/IpShrrttXq/fj5OgKT8vw8+kvULsZP0o1WPIW8yuB8
         Mt0fR8c67v/8t+IHvU0/AuD/ZPi1N4i/onxOAEkz7tpiyaWHGl3vllDEIhJzHfVlY+vQ
         lW2tByFX7IgoklGxs8BjMjcliJKkx+MxxygniNhnSgCErh7iOiyfVoe/PzW5ZIiug0Vx
         +ZunvWw43c+BwByZo9f2BtZl58twoo1h8aYZa9hb9BtFZZOOKw/Poh8DtnOXJB+wVXk4
         i3Gh4Y5n50cyJaTVv9WpfowTC03SkbbcMSFW7QyoAQkzZa5S/ycXN6z7wZvXwZqVXpGa
         eUyg==
X-Gm-Message-State: AC+VfDxAboVAkDnKJqTXKAos7rPUMKswtDe2BlykRCk3lWxwiOefIebr
	wUrxX2MUA5JuSEPTqCn3QemdnjsDvwQ=
X-Google-Smtp-Source: ACHHUZ54r8QhXTgsTgG8jRLoSkE94sZ0FZvUSapnI+J64Ax9jDSHRshIJjlUUURs7AsnzwL/ulW1ng==
X-Received: by 2002:a05:6214:2527:b0:56c:2344:a58b with SMTP id gg7-20020a056214252700b0056c2344a58bmr5819321qvb.12.1684418595124;
        Thu, 18 May 2023 07:03:15 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id p18-20020ad451d2000000b006215f334a18sm546043qvq.28.2023.05.18.07.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 07:03:14 -0700 (PDT)
Message-ID: <b93d00d8-8186-d59a-300c-9341d3aa1777@gmail.com>
Date: Thu, 18 May 2023 07:03:11 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/1] wiphy: fix regdom change wiphy dump logic
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230510204508.715558-1-prestwoj@gmail.com>
 <20230510204508.715558-2-prestwoj@gmail.com>
 <c144e8f9-90e9-bca2-745f-b25e596f5600@gmail.com>
 <b7a3fbba-6715-d373-2190-ed2012e103a8@gmail.com>
 <078eb5ea-ead1-1667-5801-6ca56ca39427@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <078eb5ea-ead1-1667-5801-6ca56ca39427@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 5/17/23 8:21 PM, Denis Kenzior wrote:
> Hi James,
> 
>>> NAK.  Please stop right there.  genl is already a queue.  There's no 
>>> sense adding queuing on top of it in this particular case.  If 
>>> l_genl_family_cancel isn't doing the right thing, then fix that instead.
>>
>> Well l_genl_family_cancel really cant do anything about it. Once the 
>> dump hits the kernel you cant cancel it (this is why we added 
>> l_genl_family_request_sent). 
> 
> This was done for a different reason.  In the case of 
> CMD_REMAIN_ON_CHANNEL we must wait for the ack to obtain the cookie.  We 
> can cancel the ROC only if we know the cookie.  Otherwise, even if we 
> call l_genl_family_cancel, the ROC would still go ahead.
> 
> What you have here is a different and simpler case.
> 
>> So the only alternative I can think of, if we cant do it in IWD, would 
>> be to make l_genl queue dumps and not issue more dumps until the 
>> previous one finishes. This is obviously a significant behavioral change.
> 
> I'm lost?  That is what is supposed to happen and happens already 
> today.  If you issue two dumps like:
> 
> l_genl_family_dump(..., msg1, ...);
> l_genl_family_dump(..., msg2, ...);
> 
> Then msg2 will not be sent to the kernel until NLMSG_DONE flagged 
> message is received.  So what exactly would be the behavioral change you 
> are referring to?

Ok this was not my understanding of how l_genl messaging worked. I 
thought you could have multiple in-flight messages. But looking at it 
you can't, the IO writer only sends a single message.

So I'll fix l_genl_family_cancel to not remove the message from the 
pending queue until we get NLMSG_DONE.

> 
> Anyway, looking at l_genl_family_cancel, it is doing the wrong thing, so 
> that should be fixed.
> 
> Regards,
> -Denis
