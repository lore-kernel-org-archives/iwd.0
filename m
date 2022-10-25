Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919687B
	for <iwd@lists.linux.dev>; Tue, 25 Oct 2022 15:32:10 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso16012979fac.6
        for <iwd@lists.linux.dev>; Tue, 25 Oct 2022 08:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVNgd4FQvZjd7oQoskfZJkJbiOyVPwHdLBFSLXgx/48=;
        b=p6OFfNTL9B60IYLB4w7snWurQW6uL4v6nTN8LhnwHjjTTvBm8Vf5rl7pAuJ0fbnA94
         1gTrmlG9iA1vY2jn9wxa4rUyRn7SFvX5mIG6MlDmotwP1aZVjt6VxcddsnEqzCsgMW5N
         Gkiw/RIkNv3/EK2fwKOT2DpXXFaYntfGxA5i68pz8ce+LsurohBWlPbeP6nG9xGdsYYG
         1Ead1VKwEBbDer7Gvv1bfDAVwj3YcbouoFAxFzvriLBnK9dP4M+SRBB1Q/qeik/4C1RM
         OIF8f1FYnxr/2FRLBwGXMAXmiqeer4qvHFJnqHGCPLRj/eFAD9LpakEYzyuazkM3hogO
         TQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVNgd4FQvZjd7oQoskfZJkJbiOyVPwHdLBFSLXgx/48=;
        b=D+dbfRV91pLZHXSIStEZRZEaMSZU5N/iKyOX0Jauc7HZMjqHpleGOPGDB3E2UFkZcX
         sngwW3Fm+wR0K86A1yMiMsOaVQXTwCVJDqUInMup1FWpaDzjPbvDJcBYrbz+Lzsf3YgZ
         DVFu7xEyNL7HyN4DZvn8ObIu79SRoomH4PPsOXWxScgOGQrFbtNNOwUFKg7frcuUMFJ8
         qECAFmnL9nNzg4kd0mC8qTVz3S5W3xpV0DUiQS7qJvBj3U9SI3hmoZT/QtOuXeSvZk0p
         SU1TKhV+OKA7PUZKnlrodRhCCpPkuc2ZQtpTQnpKn++omkpvSn/aMoBCRph80fSZ+xFD
         Loeg==
X-Gm-Message-State: ACrzQf3Vf16RA2cmbexGbPgEmOZ5Hcsg16pB0T9ElCYkBGHm9IrNVjHk
	7H7RzbOpjkiiWEgmy0KzLtM=
X-Google-Smtp-Source: AMsMyM7XpSFTy7OuaRQvrDkLOtzEPxRAPKpX99AuXc6s44gCgP30wqq+4cYtBof7CGYv2NJgLxXVWg==
X-Received: by 2002:a05:6871:687:b0:132:fd73:4551 with SMTP id l7-20020a056871068700b00132fd734551mr41122071oao.195.1666711929639;
        Tue, 25 Oct 2022 08:32:09 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w110-20020a9d3677000000b0066227572ee3sm1121409otb.52.2022.10.25.08.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 08:32:08 -0700 (PDT)
Message-ID: <afb76858-3db4-11c9-5d6b-d3cf6d451052@gmail.com>
Date: Tue, 25 Oct 2022 10:31:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: GCMP and other unknown ciphers
Content-Language: en-US
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: iwd@lists.linux.dev
References: <CACvgo52+1i7iZ-vzqf1RUpZvMa3-EgaDoid=Y9dch4=d_dq-5Q@mail.gmail.com>
 <772f09aa-fe9e-708e-2ec2-a89f8784d391@gmail.com>
 <CACvgo50aJHxkC-3E7OHDfjkyH5Rrp+Za+F-ATTCs8w-oX=dhcA@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CACvgo50aJHxkC-3E7OHDfjkyH5Rrp+Za+F-ATTCs8w-oX=dhcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Emil,


>>>
>>> Was my analysis correct - is GCMP supported? Are there any plans on doing so?
>>
>> No real plans, patches are always welcome.
>>
> Do you have a rough estimate of how much work that might be -  are we
> talking about weeks or months? How does one get access to the 802.11
> spec these days?
> 

There is a patchset on the mailing list that implements all ciphers listed in 
802.11, including GCMP.  Only tested in a synthetic environment since none of my 
commercial APs seem to support anything besides TKIP/CCMP.

As far as obtaining 802.11 spec, you would probably need to purchase it from IEEE.

Regards,
-Denis
