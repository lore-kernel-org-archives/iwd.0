Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982F322E
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 17:22:24 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-635f1c7412cso14093116d6.0
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687972943; x=1690564943;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+dq/NQaa+51mkDlUlezmJgWL+OWel9jsd0EN4/GYRc=;
        b=PnpsFvl0Sv1N6WT3YlvYIogyxiOVgBIYp0haY7rPK/7uH9cED2Uz3extrvpKDb8dpS
         H7K1Ru4NH8DZfM5pRsguinr6by19viX889q2OHogKGWhW3oUEpeTl/oVCJxkPFJ9VB5D
         7cO47b5yVP7R3G2zUWAQ/uQXf0Xxgo6HBYhy59C7U/K1bhKiMZYTSLcS7AzfgksJ7J0g
         OsegNao+rFTONTKB0Kq1QXEY1onsESXYhBo+NFoB/paNSPufDPPlDNoJA+ZvDXK+Dm3X
         oO25Z1Ao+5pYHB94CErhva6SOfdzh8AR4DEcer+JC8kdMubDlTpR5yZGf1qikZuzs8EX
         MJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687972943; x=1690564943;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+dq/NQaa+51mkDlUlezmJgWL+OWel9jsd0EN4/GYRc=;
        b=eX1Bmsh4roOPSCZQcmzVNFEVYEQ9YVlZU57oXAVMsW75I++n4AfqH2jbz8ZmWLibtP
         4PA2bUf9yp7hXu47V5DwIP1LD3jQkI55VmNQSC3KDtcARKkzKJUzFU4HdiJme1sVvN/L
         4orlZrRtWDf0uhy3tPL4UcQ0h/2VDRZMXVa0lrHd7n3COs/sayXbyVJF5j4iwm2vKFGH
         yz9VuN/BVD8CGOleFzUhK9qmB2YBybjFCIZ0iz73eC80tw/n1MYgZ0oSxtyzPUMGzzZC
         W/+sYwDsstlvbEXk5mp7I/ofyXq8kdU3WWjWSTSocpwG2lrv96nWJwLmLtHmgqpTirOG
         bPcw==
X-Gm-Message-State: AC+VfDyY4hgt4cR82G7pGEHKHXze6V/A3eTD9pXfGdLy8nX2MNxgtMtm
	J+hf94XWLWkw6ZB21kuvD7c=
X-Google-Smtp-Source: ACHHUZ43HfmZORqaOHaCbGhCkVpFHpKSXbLjwH8ThqjXuULHx1DafiiuH9gIujFjJd2XaXBg+TCd2g==
X-Received: by 2002:a0c:e50c:0:b0:635:f941:ddb5 with SMTP id l12-20020a0ce50c000000b00635f941ddb5mr3330063qvm.37.1687972943330;
        Wed, 28 Jun 2023 10:22:23 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id mz14-20020a0562142d0e00b006300e92ea02sm5957224qvb.121.2023.06.28.10.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 10:22:22 -0700 (PDT)
Message-ID: <587f150a-e05c-378d-862c-103d8fcaac2a@gmail.com>
Date: Wed, 28 Jun 2023 10:22:20 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
 <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
 <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com>
 <63162827-5b8b-3c70-7f6f-fc7b513f2b6d@gmail.com>
 <1742c6eb-bbd5-7883-5a72-53021a771ca6@gmail.com>
 <3790483a-442f-9602-03c9-b205376d9262@gmail.com>
 <280831cf-933a-95b0-3889-ddca6ca544cc@gmail.com>
 <24a0ae5c-529b-a061-0fb4-0ba8a66fe76b@gmail.com>
 <2c35a14a-3ed7-fefb-5a78-fb29199f0fd4@gmail.com>
 <82ba7228-441f-ebf1-22d2-890b00c676e2@gmail.com>
 <7c2ca71d-5cba-c067-04bf-75a9341f3db6@gmail.com>
 <6795644d-1ce8-6937-d8b8-4318f2720289@gmail.com>
 <5b044364-7a3d-7be0-ff18-bcba656e6172@gmail.com>
 <1069cde5-2ef9-657b-77a2-931615fb2104@gmail.com>
 <44b16fe4-064f-dcc1-88e8-3e238c74c4a5@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <44b16fe4-064f-dcc1-88e8-3e238c74c4a5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 6/28/23 9:57 AM, Denis Kenzior wrote:
> Hi James,
> 
>>> Then this may be a conversation you have to start on linux-wireless.  
>>> I would have thought that there should only be a single wmediumd 
>>> instance on a system regardless of namespaces, but maybe I'm wrong here.
>>
>> Yeah, I'll do that as well. This would simplify things if the 
>> namespaces didn't come into play.
> 
> Check
> 100cb9ff40e0 ("mac80211_hwsim: Allow managing radios from non-initial 
> namespaces")
> f21e4d8ed16b ("mac80211_hwsim: Allow wmediumd to attach to radios 
> created in its netns")

Yeah, the second one does mention frames specifically, which I am 
getting from radios outside the namespace. But I don't see a difference 
in how ADD/DEL_MAC_ADDR works. But yeah, this is something I'll look into.

> 
>  From those two commits I get the impression that the intent is to allow 
> a single wmediumd across namespaces.  If for some reason the 
> ADD_MAC_ADDR messages are not being sent, then I would look into fixing 
> that first.
> 
>>
>> Nevertheless, was the distributed hwsim concept something you'd be 
>> interested in accepting upstream? Like I said, I'm already doing it 
>> and I'm happy to re-use hwsim and extend to support this external 
>> socket concept.
> 
> I'm not against it, but as you point out, it sounds super complicated.  
> So I'd have to look into it more once you are ready to share something.

Ok fair enough.

> 
> Regards,
> -Denis
> 
