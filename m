Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C313CD16
	for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNC96TuR"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso55424a12.1
        for <iwd@lists.linux.dev>; Thu, 19 Oct 2023 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697745660; x=1698350460; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ciW8u57qjwjmaGcILMwNfgwJ7wPlYedgdV4Qj/oZBlo=;
        b=NNC96TuRC2kJj9yd13mVA+yMMguoMQKFtNoJjjslkPFjTDp/Fmy/WRTRzzawWDhFMQ
         h64jHS7ksRC/gLgEGCe5+JXRVjtRz0L5Lxtnv7MxB94RuwAe/NkNJp6SkwMAX856Y/51
         6c9hNBaxYgbUarOXLmgTtRkTmQQiGo2P2Espiro+HIuIs0rE0nEf6jcNzO+y9bsqNrpO
         iQ4Z8pLIE2Rujty4R4PAKQ1+vyQHHtEHC1w0KdZmIt1vIlP8w8UP9byY1nY38hq4pgdG
         /TFgwISdymJHHKM5MCSIH9d3NvKj7QnVr2MdgzkiFUdBgCaTFzyN470RZgP8l8YtOqQn
         nrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697745660; x=1698350460;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciW8u57qjwjmaGcILMwNfgwJ7wPlYedgdV4Qj/oZBlo=;
        b=fKmoX01YqBd/rp0Tmn8/QrI1oKOJKvczuqOTRQFEpwTuAnvBgEvuP6l3Cg6xc7abkw
         0hfMXPb6IO0rmKA5onmQ8PSCcRnZgn2V6XoXHEWb7ibbavqfT6rCUI74UtnZKdQe1Ujy
         cwq5exj5/ntKsit38ZatUfBEOUAvNGyz5vsnAzPwIw3zH6u/MLc5IJ62q1WaGbK1TFqS
         +mvXnza5RPeFjbWktBo8eURHZyXU5cHQkFcLI+lbNFKSt9G014yk1uKT153ZYQ5w7/Sd
         8Q5VC1smpb8p43OFm3jbXtQTKT6ok4yUqceB06FPLcWqVhzDgJxS1PuabQ+WZm/I1uWQ
         TnfA==
X-Gm-Message-State: AOJu0YxZylefK2gPlH6Obwy7AwCWNcObTSEQVmx9+GXtX1lVMAB4f3s/
	1fJPBguXlCb49KILz9NHTkA=
X-Google-Smtp-Source: AGHT+IEJjNsOlmXI1uls83IxSMTLHndBV8HwPqJ91ydQlEr4UY944QH5WC+Tl03uYmWkrPdzrKYVWA==
X-Received: by 2002:a17:90b:3b8c:b0:27d:3e90:9ee1 with SMTP id pc12-20020a17090b3b8c00b0027d3e909ee1mr3336452pjb.23.1697745659458;
        Thu, 19 Oct 2023 13:00:59 -0700 (PDT)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a1a5d00b002777001ee76sm2162709pjl.18.2023.10.19.13.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 13:00:59 -0700 (PDT)
Message-ID: <ae7b807f-fb7b-4437-9e00-bc4f64ad6047@gmail.com>
Date: Thu, 19 Oct 2023 13:00:58 -0700
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <c8617f8d-0c7c-4e1c-ab0f-f356a121afe6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/19/23 11:56 AM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> I guess my question is really how you communicate this to the enrollee.
>>
>> The use case for a human user really comes down to not wanting to type 
>> in a 64 character hex string :) So auto-generating a complex code 
>> doesn't make much sense in this regard.
> 
> Who said anything about a 64 character hex?  I'm thinking more about a 
> 10-12 character complex password like you see the web browser generate.  
> However, I'm pretty sure we need the ability to generate the code every 
> time:
> 
> "If both sides have a user interface, this technique can be used to 
> bootstrap trust by exchanging bootstrapping information including the 
> bootstrapping keys that are to be used for a DPP exchange requiring 
> mutual authentication. This bootstrapping technique shall use a fresh 
> code each time and the same code shall not be used with different Peers."
> 
> Correct me if I'm wrong, but PKEX is no different than regular DPP.  It 
> simply uses a code instead of a QR code for establishing the initial 
> trust channel (giving high degree of confidence to both parties that the 
> exchanged public keys are trusted).  The more complex the code, the 
> better the chance that the code can be trusted (i.e. it wasn't 
> guessed).  It still inherits the same basic attributes, roles, etc.

Yep, its purely a way to securely exchange bootstrapping keys.

> 
> 
>>
>> For a headless device auto-generation just won't work since the 
>> password is baked into the image. I considered generating a single 
>> bootstrapping key and 
> 
> Doesn't this run counter to what PKEX is about?

I don't think it runs counter, it just may not be _exactly_ what the 
spec intended it to be used for. Using the same code isn't any different 
than using the same PSK.

No matter what if your PSK or PKEX code gets compromised your stuck 
re-configuring all your devices. I don't see an issue using a secure but 
static PKEX code. Either way, this isn't really IWD's problem :)

> 
>> bake that into the image (no PKEX) but I question the possibility of 
>> offline 
> 
> With a strong password, probably eons, unless quantum computing is 
> involved.
> 
>> attacks. With PKEX the bootstrapping keys are changed upon each 
>> protocol run so 
> 
> But you're still sharing a PSK in the end?  Why go through all this 
> trouble?

This is a more dynamic way of configuration and allows devices to show 
up in a 'default' state and require zero manual configuration (for 
specific wifi networks). When your talking about 10, 20, 100 devices, 
manually configuring each one takes a lot of time. PKEX provided a 
"hands-off" way of doing it assuming you have other devices in the area 
with credentials.

> 
>> I think there is forward secrecy there. Plus PKEX uses mutual 
>> authentication to 
> 
> WPA3 has forward secrecy as well.  So what are you trying to achieve?

I was just comparing PKEX to using a static pre-shared bootstrapping key 
and fudging it to look like a QR code was scanned. This isn't a good 
idea, hence why I pursued PKEX.

> 
>> prevent someone from coming in and configuring the new devices who 
>> shouldn't be.
>>
> 
> The gold standard is still WPA-Enterprise with EAP-TLS.
> 
> Regards,
> -Denis
> 
