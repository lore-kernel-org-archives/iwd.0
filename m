Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B2033D5
	for <iwd@lists.linux.dev>; Wed, 17 May 2023 15:11:32 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7591797c638so51398585a.1
        for <iwd@lists.linux.dev>; Wed, 17 May 2023 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684336291; x=1686928291;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhw216pjXOdsvjQMgdol6a0YfWKzzvZj2zlrdKbO0us=;
        b=FmR7tQtRkJZdAiB1bjDaib9vxqpjH/oWbaDJJ2WBcvvTGQrLyw2+46Ycf9RI2UgyJU
         XTsRKI3/Kt/WY9h1BS2/olOsWqLpHh9teMvZJn+CK/4dRrErKYZ4bdgiOJCX/dAxiTpy
         4Am6e63m01o1z1bG9H/u+3xmlBvCRE5uERNCw9bM/8z0wZKflAgzcQDH0lfstgsWoiri
         54ubcU0CA67sQeA5HZf+GVQTbc1zug15XmsfRT9weZsBFKMQhF5hVy0rwcHWYVeaZONP
         yWDl2a484whNWSil4cLKxM28vqw8puo4ppSu9DL6XwHSB5Jkmbdx9vgywh1Kf3xnRD1r
         sYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684336291; x=1686928291;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhw216pjXOdsvjQMgdol6a0YfWKzzvZj2zlrdKbO0us=;
        b=BWZpQ5/7HPhJ52xVgFeFkQalgIq0ZhyR5aEiIcTISA/FUzmDH8elsyIb1gSfoTuDLD
         3H9pOINGPXXN4eo4vDYjzwAetx8rA7CaEsgwF+yGvZw87jWcr+BFEjVHsBj4AlUDEt4Q
         OQ41P2QsmL+7ohOqZdBpS0gr69H8XXccKcOtSgxqUstkEbGLrDlmo/V9wls4ZYvejy6D
         c5neqRdYtRXDBFFmkjzZvBkFasKs1+5kOstYCm3E1Le1xzgapONfiuhGthkaQxn+6B5b
         0upMVdvCJIsOpJXbOsVqYXata1Zn2G8XY9kmcxbpB8law2+rxCDr16ccR7nmmSH23e+H
         sjQg==
X-Gm-Message-State: AC+VfDxTCI9YxJrJZovmNp3ZiDZkKGKDjBlu+LuAxvAy/OHX63evonMu
	8PLdeCohP6bDrBMiS1AwO6xfUNnPvxk=
X-Google-Smtp-Source: ACHHUZ7d0boP+fw4pdGWzEYNznAk0vX+U0jTDLfEj98agZqjP9bEPBhI9Mr51gJlEgWZyqtkTEb8wg==
X-Received: by 2002:ad4:5d6a:0:b0:61a:ec71:ed9a with SMTP id fn10-20020ad45d6a000000b0061aec71ed9amr72912951qvb.30.1684336291102;
        Wed, 17 May 2023 08:11:31 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id g17-20020a0cf851000000b0061b7784b3basm5938502qvo.84.2023.05.17.08.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:11:30 -0700 (PDT)
Message-ID: <b7a3fbba-6715-d373-2190-ed2012e103a8@gmail.com>
Date: Wed, 17 May 2023 08:11:28 -0700
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <c144e8f9-90e9-bca2-745f-b25e596f5600@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 5/16/23 5:53 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 5/10/23 15:45, James Prestwood wrote:
>> Certain drivers change the regulatory domain when the client roams.
>> First XX, then the country the roam target is using. Depending on the
>> timing the second regdom event can come while the first is still
>> dumping. This was not handled gracefully/nicely in IWD and it would
>> just issue another dump (it tries to cancel but if the dump started
>> there isn't anything that can be done). AFAIK the kernel should be
>> able to handle this but based on the behavior we saw it seems to not
>> be able to, or at least not reliably.
> 
> Okay.  Might be useful to know what the kernel actually expects to 
> happen in case we send on a socket during an ongoing command.

I can try and get this to happen locally to investigate further, but so 
far its been a rare case. Maybe happening 1 time in a 24 hour period on 
20-30 clients. I'm thinking maybe a locking/race problem in 
nl80211_dump_wiphy(), but its just a guess.

> 
>>
>> When the second dump comes in and GET_WIPHY is issued the kernel
>> stops replying to any messages which obviously causes IWD to completely
>> hang up waiting for various acks (set_station, set_key, etc.).
>>
> 
> Sounds like genl isn't doing the right thing...
> 
>> Now if another dump is ongoing (and cant be safely canceled) a flag
>> will be set when another dump is needed. The first dump will be
>> waited for and only once completed will another start. This also
>> ensures there is at most 1 pending dump when before any number of
>> dumps could be queued which is pointless since only the last dump
>> request matters.
> 
> NAK.  Please stop right there.  genl is already a queue.  There's no 
> sense adding queuing on top of it in this particular case.  If 
> l_genl_family_cancel isn't doing the right thing, then fix that instead.

Well l_genl_family_cancel really cant do anything about it. Once the 
dump hits the kernel you cant cancel it (this is why we added 
l_genl_family_request_sent). So the only alternative I can think of, if 
we cant do it in IWD, would be to make l_genl queue dumps and not issue 
more dumps until the previous one finishes. This is obviously a 
significant behavioral change.

> 
>> ---
>>   src/wiphy.c | 103 +++++++++++++++++++++++++++-------------------------
>>   1 file changed, 54 insertions(+), 49 deletions(-)
>>
> 
> Regards,
> -Denis
