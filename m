Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C413064
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 17:06:53 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b699a2fe86so49432401fa.3
        for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687885611; x=1690477611;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8+ZD349w/YvyFvp1hhzrNEpnkjEwUBEQDVYkR+OqL0=;
        b=WZQ/y7tWHl5QQKjg8pLJA7hDocumMg9SdP0v++BavL1fexhzM7N7gYdblFwpWdk0Tr
         npWEdWguSY3nfW3UCSGc9VFMELcxiG7ABoMTzNOtUXdIwzgQoWhpxE19aOyj/UhWWx+h
         F9QLgTujml0mu5T1tcQKD2gbRC0QAGr+HjQ+Vk2cQcXdKFYtjzFX73N5Lyv8jBi5uPFx
         UxDyuKo+t4o2QYfgIDm3jZYmZ8WQNdlqqkvHOc0pM4xCKdOzn+PNdWEA2qFWa1y4HQd1
         Dx/X+ODGmW6qQageghRek+T2Hy7bvGN+lg0lVXMmaojdTV+5abwwp5KttZVT7o8U875O
         3hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687885611; x=1690477611;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8+ZD349w/YvyFvp1hhzrNEpnkjEwUBEQDVYkR+OqL0=;
        b=CbK/xYN9KbhsvhVF5USKnBLsSUZfsABkgtk6aV7aAQIYGYPNVI9oazEiTL6IgSv5KW
         QkjXpLmy7c4W31BKgt/NfvDM9E8UkXjmgVuGUULXcxZwXbtOLzpxzwle1z3aeLY7gjtW
         xBYkMF4LCZq5xoiEQ2qByDVT2ggGZmFe6HVPnqUj2lwa+4w5LAXunr7TgdPHyl20ZOEY
         OzJ2Y+eAAH75jvQk9L1tsh7XSkj1Yv1BWzHPicgDoHByDUve0Xqine+05UolNcZ/dEZY
         4088bgRobTdee9VquUMR0YKPIZIwqNaN8MH9SDAzuVaESXH9Lialq65n0+papvPqhkkb
         8Z0A==
X-Gm-Message-State: AC+VfDzZxc4gABoMHYGaSqhCkKQe8ABnOoA416ofc1m41OfSj8wAmKuv
	LyoeCNFhxcYPzeEhxzkGGSqiEDeHrAk=
X-Google-Smtp-Source: ACHHUZ6OFHfhXs6UbWcVzh2ood84BsQkEF2cSqOQQlOUNsPMBVK14B3TGwS1EQyrrb2grHxxdFyRXQ==
X-Received: by 2002:a2e:6e06:0:b0:2ac:82c1:5a3d with SMTP id j6-20020a2e6e06000000b002ac82c15a3dmr20815943ljc.23.1687885610901;
        Tue, 27 Jun 2023 10:06:50 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j23-20020a2eb3d7000000b002b4762882e4sm1819345lje.39.2023.06.27.10.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 10:06:50 -0700 (PDT)
Message-ID: <9d7f0362-67af-bbc4-2cc0-d4f8da123cd3@gmail.com>
Date: Tue, 27 Jun 2023 10:06:45 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: iwd forgets network
Content-Language: en-US
To: Martin Petzold <martin.petzold@tavla.de>, James Tavares
 <jtavares@kvh.com>, "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
 <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
 <85b9e54c-dea7-672e-ecad-9382c8f6a7e7@tavla.de>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <85b9e54c-dea7-672e-ecad-9382c8f6a7e7@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 6/27/23 9:58 AM, Martin Petzold wrote:
> Hi James,
> 
> Am 27.06.23 um 17:29 schrieb James Tavares:
>> Martin,
>> You mentioned a possible power loss in your testing. If iwd is not 
>> performing an fsync() after joining the network and writing the SSID 
>> configuration file, then there is a small window of time (between when 
>> the file is written and when the filesystem is next synced) when the 
>> file can easily go missing if power is lost.
>> If the file is newly created, then it could disappear entirely on 
>> power loss. If the files contents were overwritten, then it might 
>> revert to the old contents on power loss.
>> Perhaps this explains your issue.  I can’t tell you how many times I 
>> have been bitten by this in embedded Linux designs.
> 
> Thanks, we have also experience with this. ext4 is quite a good choice 
> here. In general we feel safe. Also I was talking about re-powering the 
> router.
> 
> Our device has seen a lot of power losses without any issue. But of 
> course it could be also something in this direction.
> 
> However, this configuration file was existing since two or three weeks 
> at this place. And then gone.
> 
> Does IWD change or write to the configuration files? Timestamps?

IWD will create a config if you explicitly ask to connect to an 
unprovisioned network. The agent will ask for a passphrase and once the 
connection is successful it will create a new profile and write to disk.

> 
> When does IWD decide to maybe (delete and) create the state directory?

It should never delete the state directory. It will create it though if 
it doesn't exist.

> 
> Could it be a race-condition with the bind-mounts?

I really have no idea. I've only ever tested bind mounts just today, and 
definitely no extensive long-running testing.

> 
> At the moment it is not easy for me to add debug code to the source, as 
> we use Debian packages and don't build these components from source...

Only other suggestion is to run strace on IWD and wait for it to happen. 
Then you could see if IWD made any suspicious syscalls. If not, its 
something external to IWD.

> 
> Thanks,
> 
> Martin
> 
