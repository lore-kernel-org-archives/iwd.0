Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D731597
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibk5wb/S"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6c4cbab83aaso5329241a34.1
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697729770; x=1698334570; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wW+TWIFW91krqd2PCCBD8uGg8QCw+v/lbMm+S/yPxfU=;
        b=ibk5wb/Sm1NZnaIsXJ4nQmAIjuw/Z4EzwLNx/OMw3oBQzxX1qyG7VdtGjM6BAejdmy
         GU+GMuWgAfiVkg+KMUFTvctWurddpz9h5X8gyJ0YR/31tMb4+ykqfLfUbM5WCnmSKsfF
         f+AZt3IjsYxxdg+GKswB0UR44PQr5SJ8qUkCbpuHYKC1BFvUR+9jPzoAjOse870lsptr
         TENn8jl+kuVsZw7wJ8AZCEOhBfNZHOE6rflGpnjVUW641NHTrm7D2OygixmOK7Fw0zCE
         0OJn5C/T4zwO+pyImZvHGCDHFgkCcl1fj68pduwz3h8p5zgZSOAdxxJ4nW9GI7cxNTq4
         wLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729770; x=1698334570;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wW+TWIFW91krqd2PCCBD8uGg8QCw+v/lbMm+S/yPxfU=;
        b=c3f6nnNGORFUEtnCS32Fz3R38djnqevQiP0pVLUVeqPJTJfLN31CjJTSrVG5oaOMUE
         LXAaGxyfsMsQFjSe992IKYWrwroVnnz3IL+CjuPTs3u37MMJptajkva90LLH7ZgDaOu7
         blrZqoewP2sPObJN3LFAeVcfDlBIIrBRqgURRR2ATH9nnoe/6IP2iDDKdzLkCFJ9FpuO
         +efrAArGxNWoeN8y7El01+P4TGPxl8L7X3kLgnWR+Y3MF9Nk3cNzREQsOHBpME4bugm5
         f4s76ENEOXueQcCVqSqnk3EWQ3A8LQvhw4ecXjjk73cI5P6bsy4sP0g8KS7+b4048ubx
         1jRQ==
X-Gm-Message-State: AOJu0YxRQy7aU41JJfs2e91ti/aAAa1Q+q74CT45888f4KOKvi98nW8m
	+ZeGBqPYmVL/OdPXn8DhMQbvxfFifaA=
X-Google-Smtp-Source: AGHT+IEr2mUDlbAFlY94hmPgrMnMGjMaE+Qt+xuAHigFza2L7HMUxM5B/4fVni1ncysiivRtRQWG7w==
X-Received: by 2002:a05:6830:1213:b0:6c4:da7d:c546 with SMTP id r19-20020a056830121300b006c4da7dc546mr2352107otp.27.1697729769888;
        Thu, 19 Oct 2023 08:36:09 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v11-20020a9d7d0b000000b006cd099bb052sm579323otn.1.2023.10.19.08.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 08:36:09 -0700 (PDT)
Message-ID: <62d0c420-3bc5-45a8-80c6-c4c59db7ae2c@gmail.com>
Date: Thu, 19 Oct 2023 10:36:08 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] doc: PKEX support for DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-12-prestwoj@gmail.com>
 <41078822-99da-466e-b612-91a8c223dbde@gmail.com>
 <0dd4a4a5-95aa-49c1-be77-e640862c3f82@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <0dd4a4a5-95aa-49c1-be77-e640862c3f82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> I would think [DeviceProvisioning] SharedCode and Identifier?
>>
>> But I do have to ask, this is used for PSK networks where profiles are rarely 
>> touched by the user.  Do you really expect someone to muck around in them?  I 
>> wonder if autogenerating such codes / identifiers or an Agent API is more 
>> appropriate?
> 
> Autogeneration really won't work since both peers have to match.
> 

WPS auto-generates a PIN, can we do the same here?

> For my needs the code/key is baked into the device image (i.e. a config file) so 
> putting it into the .psk file would work great mainly because IWD could encrypt 
> it (by adding "DeviceProvisioning" to the list of groups for profile encryption).
> 

Sure, and that's fine since we don't want to bug the user every time this 
happens.  But we have to provide some way for this to be provided outside of the 
user hacking the provisioning file.

> But for a human user the shared code does make sense to come from an agent, or 
> the StartConfigurator() API itself. The use case here that comes to mind is 
> sharing wifi credentials when your PSK is a very secure random string and you 
> don't want to have someone type that in.

Exactly.

> 
> Could we support both like how we do with PSKs already? If not in the config 
> file ask the agent?

Yes, that would be ideal.

Regards,
-Denis
