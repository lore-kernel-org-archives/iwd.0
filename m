Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82DD13FED
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do+CJ882"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6cd1918afb2so2812815a34.0
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698159834; x=1698764634; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QW+eEMYikmHSnG3b9Rv5IckxVX5oJMqgmQ0+X5qOc74=;
        b=do+CJ882TWeitjVANYgSp2S7EQ7wh/S2i6QJyHHlx8Sx7UvJ+z6c16A888PrlbrzQQ
         uodzb5H6DLuuSUo8vbwsuA4knvXnN6eNusOJI1a+/xK7mDYEOwngOrn/7vn+SzbN0zWy
         6QR8SsssS4FYndOuGzzwruKeABQhyntGJVPtUK7v8CRkOf/GjOuWHi1o6D/Li4XtYFlo
         yO+W1ADQZWTxwu4IdzYOZOBvaKaxDVXVnRZilsmPHilHT3/SqjrW/wCHG7sRmMq8DJ/v
         dtendC3tTanu85nvJ4fV59SgSUKgN0LCvixmOPEA2hJJ46qMAMpQa4cUmEl7y9l8idd7
         aNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698159834; x=1698764634;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QW+eEMYikmHSnG3b9Rv5IckxVX5oJMqgmQ0+X5qOc74=;
        b=Utncd8LvtW023GSRt4c4u2WpPPKA/ksQEgxAnVr0sWtvvB0ULYrGWvLbLsgQYYn5j1
         q+BBCuOL1qdDSNTYKDsoDCqDTDaTem3SdQyrEmhch5ig1YWu0SD5Pi6nbwFi9icLFs3W
         Ozr3ZZxMuMmuLuUN94EQZTpl4xj75xM14ZZ7+PnFAjaYpi5ThHvxaDghgRTLGiFR4Dm3
         nN8dyzMadrvA4MD0W4IxmaeSIiMDDE7PcLTcaugceI2/uM1/GlsxqzL4+MPe4ofM4dHj
         hE2X8vKb1AY75L6itY45gGiIN9L8Wpm915QZlke8p0sn38mKlxTTFZPGmYLMDXDKtk6o
         8AKg==
X-Gm-Message-State: AOJu0Yz4SBe+qfWJJptoDR0VVc5bVGfEvSRAanf8tx6txmR6Pcr/MlxA
	M2FMuWnaE6ZibudYh4uBEuamnjiTEHw=
X-Google-Smtp-Source: AGHT+IHrQ/AmEcCGUkaYSvDj+5OAJT7CtlvoEvVWmSlFL4EWquK3booH3JEEHk5PMzoAQd0KEtGBOw==
X-Received: by 2002:a05:6870:659e:b0:1ea:3e3c:ec73 with SMTP id fp30-20020a056870659e00b001ea3e3cec73mr15882453oab.21.1698159833787;
        Tue, 24 Oct 2023 08:03:53 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id z2-20020a056870514200b001db36673d92sm2159979oak.41.2023.10.24.08.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 08:03:53 -0700 (PDT)
Message-ID: <a34bf8b9-45aa-4466-aa63-7f85d3f1ad81@gmail.com>
Date: Tue, 24 Oct 2023 10:03:51 -0500
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
 <d4fdadd8-dc2b-47b0-b1ac-114abed91f39@gmail.com>
 <7de9faab-5863-48f5-8de6-28e1b543d2b8@gmail.com>
 <f812bdcd-219e-4e0d-8816-46015bd7cdab@gmail.com>
 <f5d4ec5f-a7c2-4dc5-853d-d65ae1b72c93@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <f5d4ec5f-a7c2-4dc5-853d-d65ae1b72c93@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>>
>> Fair enough, lets explore whether we can provide this via some agent API.
> 
> Reading more about the identifier being used to distinguish a "plurality of 
> devices" this is what I'm thinking as far as the agent interaction:
> 
> It would make sense (on the configurator side) to query an agent _after_ the 
> enrollee sends the PKEX exchange request. That way the configurator can look up 
> the identifier/code, somewhat the same as RequestUserPassword.

Possible.  But isn't the main use case to share the code and initiate on both 
sides independently?

So..
ConfiguratorEnrollee(code, identifier)
StartEnrollee(code, identifier)

> 
> I don't see much benefit of using an agent in StartEnrollee(), and would rather 
> pass via the DBus arguments for simplicity. Adding an agent for this doesn't 
> really gain us anything, it just adds complexity. The caller of the API can 
> still change the code/id for each call it makes to StartEnrollee() as it sees fit.

Okay, sounds fair.

> 
> So something like:
> 
> StartConfigurator()
>      ... waits for PKEX exchange request ...
>      -> RX PKEX exchange request
>          if (id)
>              Agent.RequestUserPassword(id)
>          else
>              Agent.RequestPassphrase()
> 
> (And if we want "SharedCode" Agent APIs, that's fine, these just fit the need)
> 
> The one caveat here is the timing since the PKEX exchange response must come 
> within 200ms, which isn't possible for a human user. A human configurator would 
> need to establish the code/id completely ahead of time.
Well, that's why it says to retransmit 5 times.  But even then, that isn't 
enough time for a human to process this.  Hence my point above, that the 
use-case seems geared towards both sides entering the shared code without any 
'trigger' from the peer.

What you propose here is using the Agent, but only for as a way to machine 
generated a response.  Sounds like maybe:

StartConfigurator(object shared_code_agent_path)?

Regards,
-Denis

