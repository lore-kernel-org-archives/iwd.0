Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1BA36AF1
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXHjUvh+"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-77891c236fcso348629585a.3
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698160790; x=1698765590; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6LZbJGilvOPC2JtasV/VsCXeELuJ7L3K+Vxi9wFIUQ=;
        b=FXHjUvh+DW0VvBerbxF2/r4Lz8KP3YG6xWBdLXz4aXZgg87Yp/ez5Gj5MmxMx+n0cg
         v7dF+RIgvUd+nBIRBWv/rPkGLR+ve+n9UzDO8iFPMyGPFfhpZWsoBUW4Wrt3BEQlhRsx
         qCPurK8UbZ/J75CxrBLj/JPZf1zykHZXbHWz+/CwOQUKO7BG8+Pb82+ku0zgNN+y245V
         wOkXuDXQIuNJsoND9or3EBssh/FgAgkffjPmOg1Snf3BoNi0ujEqaM4Bf1p4FjtFSZdP
         CmKeN3KVUoWTNpDmohoPnlyqTicmRNIZxrFMaZ4opYcq3JpbVHYTopPtFSxaoqwFISuz
         xi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698160790; x=1698765590;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6LZbJGilvOPC2JtasV/VsCXeELuJ7L3K+Vxi9wFIUQ=;
        b=Dn1hnq8L0kLqj4i6rJAQQYRojlwVb+evZkQCKMAcCZ/+6e//zwyrhENjcTJCq/1y5a
         ge/FBA7aixJ3oVofh7INE7wUNqUZOHzdJ7mBMa85BOz+OuT5SMnkIQjIEZTvZNVsJY/L
         cB9TK0ocvSOup8YDAxV7VJDiDjRGwlBEVBWKkmVOcsD+Fv6Dat/bADC91zc+2Vn1WCHI
         zS+JatwZodvsqPMmwVTP+1zaOzXo2inNjOOlTGyOd5bVkfxoJq57/JCynz7q7wa4mY3f
         zGNQAJWu2f/h/doUXO3legfMcJX6RNlfZSut1e83/eTyS1tcmiNY8mMYRiNpUh0lJACX
         o4Aw==
X-Gm-Message-State: AOJu0Yxb3wtWNKG5lH1E0Rgr19o1b8sHUY2BZk4/ICmxAz5QwCx6VDyv
	D3RoUuVMHhHE5rdxYKKac5YvlMrn1Vs=
X-Google-Smtp-Source: AGHT+IGlmV1O8TSU/f67vWazflx3dShsc3ttp7uIqhQWY2fo3AN6v9eKmLLDrsdciSYcZiLmpWYKYA==
X-Received: by 2002:a05:620a:2584:b0:779:dc90:ba1d with SMTP id x4-20020a05620a258400b00779dc90ba1dmr5931512qko.14.1698160789987;
        Tue, 24 Oct 2023 08:19:49 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id b1-20020a05620a118100b0077438383a07sm3508963qkk.80.2023.10.24.08.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 08:19:49 -0700 (PDT)
Message-ID: <05ce203b-78ed-4032-9d35-e5ef43dc6397@gmail.com>
Date: Tue, 24 Oct 2023 08:19:47 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] doc: PKEX support for DPP
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-12-prestwoj@gmail.com>
 <41078822-99da-466e-b612-91a8c223dbde@gmail.com>
 <0dd4a4a5-95aa-49c1-be77-e640862c3f82@gmail.com>
 <62d0c420-3bc5-45a8-80c6-c4c59db7ae2c@gmail.com>
 <d69dd453-95b8-49b0-9419-3ee0c7c98fe1@gmail.com>
 <a38fc175-3095-488d-a0ea-a70e7f148540@gmail.com>
 <035c5cb1-d5be-4c4b-a6f5-8c0941926225@gmail.com>
 <c8617f8d-0c7c-4e1c-ab0f-f356a121afe6@gmail.com>
 <ae7b807f-fb7b-4437-9e00-bc4f64ad6047@gmail.com>
 <d4fdadd8-dc2b-47b0-b1ac-114abed91f39@gmail.com>
 <7de9faab-5863-48f5-8de6-28e1b543d2b8@gmail.com>
 <f812bdcd-219e-4e0d-8816-46015bd7cdab@gmail.com>
 <f5d4ec5f-a7c2-4dc5-853d-d65ae1b72c93@gmail.com>
 <a34bf8b9-45aa-4466-aa63-7f85d3f1ad81@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <a34bf8b9-45aa-4466-aa63-7f85d3f1ad81@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/24/23 8:03 AM, Denis Kenzior wrote:
> Hi James,
> 
>>>
>>> Fair enough, lets explore whether we can provide this via some agent 
>>> API.
>>
>> Reading more about the identifier being used to distinguish a 
>> "plurality of devices" this is what I'm thinking as far as the agent 
>> interaction:
>>
>> It would make sense (on the configurator side) to query an agent 
>> _after_ the enrollee sends the PKEX exchange request. That way the 
>> configurator can look up the identifier/code, somewhat the same as 
>> RequestUserPassword.
> 
> Possible.  But isn't the main use case to share the code and initiate on 
> both sides independently?

That's kinda what I originally thought but the quote

"where a PKEX implementation may be provisioned to connect to a 
plurality of devices and needs to know which code to use to process a 
received PKEX frame"

Makes it seem like the implementation can lookup a code based on an 
identifier after receiving a frame. Like you mentioned, only a machine 
could do this while adhering to the spec so, eh? who knows what they 
intend here...

I'd prefer to support this because it allows a unique exchange 
per-device (assuming each device sends a unique ID). Obviously, also 
support the human case, maybe two configure APIs?

ConfigureEnrollee(code, identifier)
(Though we have to make the identifier optional, either via a{sv} or an 
empty string)

StartConfigurator(object agent_path)

> 
> So..
> ConfiguratorEnrollee(code, identifier)
> StartEnrollee(code, identifier)
> 
>>
>> I don't see much benefit of using an agent in StartEnrollee(), and 
>> would rather pass via the DBus arguments for simplicity. Adding an 
>> agent for this doesn't really gain us anything, it just adds 
>> complexity. The caller of the API can still change the code/id for 
>> each call it makes to StartEnrollee() as it sees fit.
> 
> Okay, sounds fair.
> 
>>
>> So something like:
>>
>> StartConfigurator()
>>      ... waits for PKEX exchange request ...
>>      -> RX PKEX exchange request
>>          if (id)
>>              Agent.RequestUserPassword(id)
>>          else
>>              Agent.RequestPassphrase()
>>
>> (And if we want "SharedCode" Agent APIs, that's fine, these just fit 
>> the need)
>>
>> The one caveat here is the timing since the PKEX exchange response 
>> must come within 200ms, which isn't possible for a human user. A human 
>> configurator would need to establish the code/id completely ahead of 
>> time.
> Well, that's why it says to retransmit 5 times.  But even then, that 
> isn't enough time for a human to process this.  Hence my point above, 
> that the use-case seems geared towards both sides entering the shared 
> code without any 'trigger' from the peer.
> 
> What you propose here is using the Agent, but only for as a way to 
> machine generated a response.  Sounds like maybe:
> 
> StartConfigurator(object shared_code_agent_path)?
> 
> Regards,
> -Denis
> 
