Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED205241
	for <iwd@lists.linux.dev>; Sun,  7 May 2023 23:37:23 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6a64b5bc7aaso3621372a34.1
        for <iwd@lists.linux.dev>; Sun, 07 May 2023 16:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683502642; x=1686094642;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOqamXevmQsQf/TwuLdDTmlrVb7ElecAQonEPt3pKhc=;
        b=MuIdcbEreJP7RairMw+IkX++IRzRd/GBAo5ugxj6WaccnCdXjdYlO2LEW37KvqnLh2
         twDDcxPDJp2f0gLN5AGL8l72n36Q7xfcuTYypYoJ/2mNuKj3e/iedoTnKR/4TutkpoZ8
         8Uc+34pyYyK+mcN+JIfAv40aFAKwQ1N+SywmrF2gFXLRfowraS1qkmPueBrGb2bo4xrG
         m+WqOoVF3pNFDF3IOmYK2Yt8xMdVva2wkI4/URU26RvW0MldVtYL7NpFjxNAiv9dotHZ
         U6jBZ1fVwY/9AhEyZ4hSGvKqPhoYto++ZnjHF/ljjhAWKshX6Vs9ByH6PJrocWKCKv0A
         XDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683502642; x=1686094642;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOqamXevmQsQf/TwuLdDTmlrVb7ElecAQonEPt3pKhc=;
        b=eo2uJXs3i8c4Xe9WAguZQwIyQPCxvaIXBpmo4Sy5JgSSeq3qitbromx6jA5gPLoshT
         2MzjWVvB1ci2W4tVI6bogMgac0swzdUlxYNhPhtiLW6wW+sjdwK+ybp5bX6gtAaoop4x
         +tkh8F6/HwI4ANWrKB2htSmgjm+ngWk2yUYjxIV/qAigOB5BC/KHO3uEQfSvbz+olhn5
         EBOrmOYE7JNXG/FbSAHV2cRNh/bEUCHivktGeV3gZWVWiN2IDSNUh8y8SGoi7UpGdc0w
         KNvh1/PW76C3O/hoFVGgLtBh6YDxnL+4i3uNIuFKycg8Kkpo/ebgF66pBYswoMThQz8l
         1IlA==
X-Gm-Message-State: AC+VfDz5nqEgTH/31eY670greEoNDZLmSripbEW9zVvjOKKeBTq++2tm
	9Ne53ZHpoSfU9r4RRP6DKJLXKRZ5mtE=
X-Google-Smtp-Source: ACHHUZ4Bq1NJrWC5JcJW2lhbSFSCh+MeHLJdwaCyPcum/QaNeQCQtEFQTwPYLqcO8EVgmEMKvVokMA==
X-Received: by 2002:a9d:560c:0:b0:6a6:4053:2089 with SMTP id e12-20020a9d560c000000b006a640532089mr3782190oti.14.1683502642316;
        Sun, 07 May 2023 16:37:22 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s4-20020a056830148400b006aaf4ed7e3asm1520741otq.17.2023.05.07.16.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 16:37:21 -0700 (PDT)
Message-ID: <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
Date: Sun, 7 May 2023 18:21:41 -0500
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
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230504215247.581443-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/4/23 16:52, James Prestwood wrote:
> Based on the comment hwsim would only send frames to known MACs
> which on its face seems reasonable. But in reality there shouldn't
> ever be frames going to unknown MACs, at least not unknown to the
> kernel. We can hit this case, though, when using network namespaces.
> Each namespace is siloed and hwsim instances only know about radios
> in that namespace.

First, can you explain what is the motivation behind this series?

Second, if we're passing unicast frames, and the unicast frame is addressed to a 
radio in a different namespace, how does that radio get the frame?  We don't 
have it in our radio_info queue?

The comment for the code you're taking out makes it clear that the intent is for 
unicast frames to be sent only only to the radio with the target receiver 
address.  And the optimization is simply about not sending frames to radios with 
addresses we know do not have the target address.

What you're doing here seems to indicate that our implementation (and the 
comment) is completely bogus.  And we can simply send any frame to any radio 
instance (once) and the frames will be forwarded automagically.  If so, then you 
might want to explain this better and fix the code to reflect this.

> 
> In order to support hwsim and namespaces, this restriction is
> being removed.
> ---
>   tools/hwsim.c | 33 ---------------------------------
>   1 file changed, 33 deletions(-)
> 

Regards,
-Denis
