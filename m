Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808E237B97
	for <iwd@lists.linux.dev>; Tue,  6 Jun 2023 16:11:34 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-62885649f6eso50529526d6.3
        for <iwd@lists.linux.dev>; Tue, 06 Jun 2023 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686067893; x=1688659893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gc9ot0MJ/sHru71xdGQqvggioNvzAc8aQcHmJ9uQcvE=;
        b=BtvEYgwKD3eAOZHrAlLf5390ppth20S4ZTu5RrRA97AqJ/3ZvBMfXOR2lHPzPsJ1Qa
         lzajKwcodZNRKB0yz4/XyfwDUAfh/kO9tmZY7FR0LiXCE9UCbEJK7LblfKOsv23PRNrM
         ntlbocbXyVkbTJriMEN0DmE8B7eiROvv1uYyf7rK1OX6zx/m68wAqB6gzXdiex94NMmz
         +ZJ3TBTLz4sEw9oAgrfekN82ZK9wLsKqx2RYph6y1e0nRNEIg8MNh1moZk4fuxJXXZSJ
         xd918hTcM7rYe1ZYd0m1NbSnixQKwpvnf2sjvTeVxBrkfXrr+UVgIcLw8QvI0Cb/gLjY
         N6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686067893; x=1688659893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gc9ot0MJ/sHru71xdGQqvggioNvzAc8aQcHmJ9uQcvE=;
        b=SLKeQkzsUUyJKXO33Ye9ijYfNAGq7ThzFfWd6h46kHkusuioza82JPiVQAm+5AE5lH
         l3Tp/lzZdiSjY/wuw4cjNO5e8zlpyz8eFkcKcVC+4ZqDg+gmu6P9No8Ed525MeRQ+/dr
         ZCB3HQnI6YNdFkpatvoEPzK4zb5Cz4qtTbpAr1DXp6OMz/riWNbK9ZYjS/k6Qc9kvyqS
         JI2Z40J4IDcQrOkofdPn4WpsJNPhlyPip9U0NN74JgT0LZEcVSVyDZftdmRvJbiT9JoN
         QeaKDs+38YCwgzTRP9/tz/tbgTX+Zr14OSNGYvwEMiuVQUESYJkFbL/PYNjfZMWBZgw4
         uZkg==
X-Gm-Message-State: AC+VfDy7Q74Y57RcBgDN0ylHP4K2ZvZytPZXZlrNI7OdXILJOPJSedMk
	zRHnRvyo2C87GQj/RAeagBWzB0l1mMk=
X-Google-Smtp-Source: ACHHUZ7xLRbLu8Dajxtop26F6Um7OjNjyRJAhRYct7fBZky6eJbLeFhkS/lQxmlmz35xJSyd0MP9cg==
X-Received: by 2002:a05:6214:130b:b0:62b:5081:46bf with SMTP id pn11-20020a056214130b00b0062b508146bfmr2856128qvb.27.1686067893055;
        Tue, 06 Jun 2023 09:11:33 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id el6-20020ad459c6000000b0062839fc6e36sm5448002qvb.70.2023.06.06.09.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:11:32 -0700 (PDT)
Message-ID: <4318c465-abde-2057-0974-007a504fdc16@gmail.com>
Date: Tue, 6 Jun 2023 09:11:30 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] ap: Remove opt-out DisableHT for opt-in EnableHT
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230602145812.22010-1-prestwoj@gmail.com>
 <5a290730-f50b-cb27-e488-3ed605aa831a@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <5a290730-f50b-cb27-e488-3ed605aa831a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/6/23 8:40 AM, Denis Kenzior wrote:
> Hi James,
> 
>> This deserves further investigation but its looking like more
>> often than not users need to add DisableHT. This isn't so bad
>> for AP profiles since the user has to create a profile anyways,
>> but for the Start command its best if it "just works". To error
>> on the side of caution DisableHT is being renamed to EnableHT
>> making it opt-in rather than opt-out.
> 
> Our philosophy has always been to have the user perform the least amount 
> of work for the best possible result.  Most modern hardware should 
> support HT these days, so the 'just works' approach is to enable HT 
> whenever possible and not make it 'opt-in'.  The current settings naming 
> is just fine in my opinion.
> 
> The ideal solution to the above problem would be to figure out why HT 
> isn't working on certain drivers and fix that.

I agree.

> 
> If not possible, the next best approach would be to create a list of 
> drivers we know do not work (or vice-versa) and do not attempt HT on the 
> problematic ones and print a warning to the log.
> 
> Do we know which drivers don't work by the way?  I might take a look 
> when / if I have time.

So far complaints have been with brcmfmac (raspi), mwifiex (NXP driver 
out of tree), and one other I'm not sure of (I'll ask).

I did dig into the NXP driver somewhat. Its out of tree so take with a 
grain of salt, but I was able to get it more or less working by first 
issuing NL80211_CMD_SET_WIPHY with the freq/channel width before 
START_AP (and leave both attributes out of START_AP). This is how 
hostapd behaves as well depending on the configuration file. Since this 
seemed like a one-off or maybe legacy behavior so I didn't even bother 
sending a patch, but maybe more investigation is needed.

I tested on iwlwifi, realtek and ath9k.

When I have some time I'll get my raspi set up and see if I can 
reproduce and compare with hostapd.

> 
> Regards,
> -Denis
