Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6043E00F
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFgXmOLi"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so153548fac.0
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697752041; x=1698356841; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9iaYKki+95k5UBc63mKFTxQPVSYrTOrt8owQLStiHKA=;
        b=AFgXmOLiVI6lcx43yFKnnE+yPNiBRnYpv7FM7Z1mNfG5aWomfYGa7/tANKd9n3EPCg
         Hdqx99ua9mQPObml16NphwRvo6tronBZHYu07X9NGK76Uj///ZpmvK9eKXFM+t25nT4l
         87srL/ZlLg6w+sb4l4Es7u1lsCgucNoz4yzxG/UzKVFCbfeNaCJue5u4uutOzLopOD/H
         ExUlX7ucbrW/nbMMmKxtbrHvfMCXmWCWg1TiVtIs+X+P7v+kUE8wQUdb5kBIMeT5dve5
         tzo/R01Id4Ncf20hq/hiU0fJXEL5O1YMm9Wuyn5IPMYug70EnvhAQNnNCIcmORy5henw
         8wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752041; x=1698356841;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iaYKki+95k5UBc63mKFTxQPVSYrTOrt8owQLStiHKA=;
        b=cdb76RP9UEL0vBpjCTvvrw2hliitZNgoYnbwCiSwzpfBueNwGJMXBq9ClWcrdDsEaX
         VhNdfAKsG+r194R8IoKUkQJCxcqMKL7wbnTdkxgkdFdCdJoMqQ1nCRCFhSr1629ZzGuE
         SeDMwgtMO1qnjTTqPkmXxsqEY+DOhOrDGYkS4v3PYH2L9PkPj3cov4r3EOXtrx/VOhpy
         pWu7VH/G/SrSJlqo3AyeiLt7kSLb4C3D15jJcq9sO0xHj4QFAZKPh7Lxi2eRQAtVTz0f
         P67nfLYBHYHBq2h/8mgC3H00r5bEnH7Ib4v694SjRvh3NAoq981zELXPbmSU3NXT5dM9
         MKPA==
X-Gm-Message-State: AOJu0YyVoR/IVt/ugUlaTvXmt2xYBcueGoR4B8bggQWG4bYGLwXIJQY/
	+J28/8zfDdscH100wOX3kVg=
X-Google-Smtp-Source: AGHT+IGolwGLmxrrc0swf9kTpomYx0NZDXj80O37rtpxCvGiiatQgI9POSYZf8KoppLryAjiqtec5Q==
X-Received: by 2002:a05:6870:1399:b0:1d6:65d1:7989 with SMTP id 25-20020a056870139900b001d665d17989mr131249oas.24.1697752041338;
        Thu, 19 Oct 2023 14:47:21 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v2-20020a056870e28200b001cd1a628c40sm75819oad.52.2023.10.19.14.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 14:47:20 -0700 (PDT)
Message-ID: <d4fdadd8-dc2b-47b0-b1ac-114abed91f39@gmail.com>
Date: Thu, 19 Oct 2023 16:47:19 -0500
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
 <62d0c420-3bc5-45a8-80c6-c4c59db7ae2c@gmail.com>
 <d69dd453-95b8-49b0-9419-3ee0c7c98fe1@gmail.com>
 <a38fc175-3095-488d-a0ea-a70e7f148540@gmail.com>
 <035c5cb1-d5be-4c4b-a6f5-8c0941926225@gmail.com>
 <c8617f8d-0c7c-4e1c-ab0f-f356a121afe6@gmail.com>
 <ae7b807f-fb7b-4437-9e00-bc4f64ad6047@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ae7b807f-fb7b-4437-9e00-bc4f64ad6047@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>>>
>>> For a headless device auto-generation just won't work since the password is 
>>> baked into the image. I considered generating a single bootstrapping key and 
>>
>> Doesn't this run counter to what PKEX is about?
> 
> I don't think it runs counter, it just may not be _exactly_ what the spec 
> intended it to be used for. Using the same code isn't any different than using 
> the same PSK.

I don't know if I'd agree...

https://datatracker.ietf.org/doc/html/draft-harkins-pkex-05:
"The only information exposed by an active attack is whether a
       single guess of the password is correct or not."

> 
> No matter what if your PSK or PKEX code gets compromised your stuck 
> re-configuring all your devices. I don't see an issue using a secure but static 
> PKEX code. Either way, this isn't really IWD's problem :)

Well, we have to design the API with the 'right' way of using it in mind.  I 
don't think what you propose fits that.

Regards,
-Denis
