Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC643222
	for <iwd@lists.linux.dev>; Sun, 30 Apr 2023 18:13:22 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1924fa9620aso234549fac.0
        for <iwd@lists.linux.dev>; Sun, 30 Apr 2023 11:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682878401; x=1685470401;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRQGNF01mClWUDKwbRBW/KVY51h3a+eOBkL1JloWjO4=;
        b=ek/jl1FJPXV31bm3vAPgvOz6hrYiag+lGoqVuzIDs8iO7VTAkBwpb03zm/PghHM/cG
         WyR0FZmZPD2ZOhI9E+fn8nONk5epIaMWp67Gn1Iy+o7k6gqFQB3oZoB4ePyrTNwFCkAy
         NleKtZPlRcwK5gxUMfaOaNXv5ZSbW83jj+ClYZ8vphOUJGGpGsx99GlbXKz8mSwg99T7
         MEZug0gLVwGjuYafseV2Y4Z01XRtwq/EJBBS0i+3dLwcMXYxI3krWE9LxMgGT5vwNBun
         jiJaBEaz+QwA4kwoq6mARUYu79tZlxmmaXQivmCj6KwqB4gmEPpJm1IQrEIVWLu8IWmp
         OJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682878401; x=1685470401;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRQGNF01mClWUDKwbRBW/KVY51h3a+eOBkL1JloWjO4=;
        b=DVSViOd9EwGme266gVq7TSLm434r9AllorbKTJRUCkfwxlEgkJlw7In+BAABvtq4lY
         UfgOQea6uaUPDRKvkdT3UVs/amYp/odyaGf0IHBpiT+RJstcajKxtQoR1fEyDCkMo3n5
         cPGXaDN7vIVqvaC+1azHM2waECSnyDCjV16/mkb5rT/XU+a/atN1eQfpYB7WEFIu5Co0
         kNDxxXkwVbYaix+p6heyhFhhI9tF/BEE+WID0j+FF2HNNlGnXMqB8MtmFFii4B7E6Hbc
         mf4PeVwWeHHGiU4nb4eWNaubl9nw4hqMbBmDdB9Dwg1V7JvJ/Mv7ST8ZCVM4OeWSmNYG
         QtZQ==
X-Gm-Message-State: AC+VfDy8l4Smnyb/z3aKqIKtYawm011vmv/mhclBbP5Hs4tFpV05ITUd
	mXOo98Ruk7IfABVNfNDup8k=
X-Google-Smtp-Source: ACHHUZ77BNUkc9vMA2UqWfmm9LsENvxKs+ImhKeFGI8VygHe3SSigOnZf283JCI/pkynuGb3gqe4/g==
X-Received: by 2002:a05:6870:988e:b0:187:9f69:a474 with SMTP id eg14-20020a056870988e00b001879f69a474mr4941556oab.8.1682878401563;
        Sun, 30 Apr 2023 11:13:21 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n35-20020a056870822300b0018e96ef6e93sm7556993oae.54.2023.04.30.11.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 11:13:20 -0700 (PDT)
Message-ID: <f2011c90-0115-52dd-907f-48b72c24950e@gmail.com>
Date: Sun, 30 Apr 2023 13:07:41 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] station: delay roam until fully connected
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230417185457.1000642-1-prestwoj@gmail.com>
 <a87b28e8-b4c3-a7ae-e01f-9e48731f7d78@gmail.com>
 <03f26ded-afd0-9e01-739f-5798ebcd90dc@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <03f26ded-afd0-9e01-739f-5798ebcd90dc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> I'm not convinced this is the right approach.  If the signal is bad enough 
>> that DHCP is failing, then delaying the roam is probably the worst choice we 
>> can make, no?
> 
> It may not be that the connection quality caused DHCP to take a while, could be 
> the backend just was slow and not responding quickly.

Possible.  But I don't think this is a good reason to remain on a bad AP. 
Besides, what if iwd is not running DHCP and it is being done by some external 
app?  In that case iwd will happily roam off anyway and the external app will 
restart dhcp.  So remaining on the bad AP is asymmetrical to the 
EnableNetworkConfiguration=False situation.

> 
>>
>> I would think the better way to fix this would be to track netconfig state, 
>> and if it never reached a fully configured state prior to roaming, reset & 
>> reconfigure upon a successful "roam".  Note that since we haven't signaled 
>> "connected" just yet, we're really still just in the "connecting" phase.
> 
> The question is if the AP infrastructure could handle this. For example the 
> worst case being if DHCP started and we roamed right in the middle... That's why 
> I thinking the safest option was to complete DHCP, then roam. I never actually 
> saw this behavior happening, just noticed that IWD would get very confused if it 
> did happen.

Well, see above.  Infrastructure has to handle this possibility anyway.  But 
yes, this is certainly a corner case we are not handling right now.

Regards,
-Denis
