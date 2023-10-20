Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B88199BE
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av/Y5g/b"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b3ec45d6e9so615676b6e.0
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697813864; x=1698418664; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GmicSAr/R0fIaIxfN3+D+vvW5Y/Y/2mOAOWnsEGbzEc=;
        b=Av/Y5g/bpkHEOghAXQXYFrNRa7CiWuv3w0bAndyEPwvOK1lPJq8IASBFFSzEDQ72mU
         CGpD9DuFaAaLGCpOxefH5TNSRZAFSgoUl03kaLySGmgBQNWGZIwJ7w9PoxA9G6BgGy6q
         ArMC9XS3gtfTRwEm7leMZWw0Ws4E9UMgN15V30NTaES0qcT2NVaoktyRBxbvu8EyQdcO
         aKB8S/oCgYswr+2J0tjwgkrZnK0dQ8LsWp6x36xBsCNCIvbyrPBg3LcBzOlEEY9zmr2u
         vDI9nR6clEbWeYnsaRfomirRggWrMJ8Wqvq++2GfWooVFbmbIcTWM2iLTfOpAohFkoAK
         mUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697813864; x=1698418664;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GmicSAr/R0fIaIxfN3+D+vvW5Y/Y/2mOAOWnsEGbzEc=;
        b=B9kRL6L2Es9Dq4EwYMe4PlT+7LCtO+MRU8++FA5UUGg1DpnK2escYFLxE4U6xtGdtt
         GRa8CFUsN6T8D/7knwaeTq9hP2Xgn44SkGtbOjLgQvA4L0JZ9rnrP4EAXTQsMA7DGEsX
         2v5BwscbN1cqOFaf/H5RXKFsA/4C5Ef2EIlhnz9LujGpU+qd2T/zn1ZMf6/IeFNy0a+x
         YsVpi0+d1bZyL1Qgf0DL0YOad62YVk+b0B0IfqMo+7fgdMoBOhXz17/QQ+RPUevBgHao
         0JvXHdfNb+JwzXJyCJfCWxuXKPnBoZKyoqC7VHZ4yWmUZ2qoOTLbPBreRzf4FprB2bFK
         HXQw==
X-Gm-Message-State: AOJu0YwXaZIcPSYtEnKyI1hl1a2XnkE5hA9mCcFceW0Dh+HGa7C9BEn9
	z9qqzBjtscnN5uCRfdu2sJ4=
X-Google-Smtp-Source: AGHT+IFvqPAjLbqeSh3dJDOp40utaNAFLWduj3kSMSzW7zN8H6zaYs9drVqs0Z87BJCiogZHoo3ZKw==
X-Received: by 2002:a05:6808:189d:b0:3ad:f536:2f26 with SMTP id bi29-20020a056808189d00b003adf5362f26mr2633494oib.18.1697813864569;
        Fri, 20 Oct 2023 07:57:44 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a26-20020a05680802da00b003ae0e57874fsm358903oid.21.2023.10.20.07.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 07:57:44 -0700 (PDT)
Message-ID: <df0dd5a8-5171-497e-a764-5cfd32ed821e@gmail.com>
Date: Fri, 20 Oct 2023 09:57:42 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add AllowRoaming station property
Content-Language: en-US
To: =?UTF-8?Q?Pedro_Andr=C3=A9?= <PEDA@bang-olufsen.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20231018122534.33455-1-peda@bang-olufsen.dk>
 <cd9a73d3-8ed9-4c76-b44c-4c8af6250977@gmail.com>
 <b995959a-29a8-45cc-a785-065475a1d636@bang-olufsen.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <b995959a-29a8-45cc-a785-065475a1d636@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Pedro,

On 10/19/23 06:55, Pedro André wrote:
> Hi Denis,
> 
> First of all, thank you for your feedback.
> 

No worries, I'm a bit swamped these days so my responses are sometimes delayed. 
Just FYI.

> 
> There is a use case where a device can be connected to an infrastructure
> AP and hosting its own AP. In this specific case it would be ideal to
> disable roaming since swapping the infrastructure AP can lead to
> instability on devices connected to the AP being hosted. In this case,
> the device should act as if it is not able to roam, so I was under the
> impression it would be OK to not honor AP directed roaming.

So AP directed roaming is a bit of a unicorn.  I haven't really seen it used in 
practice.  However, when it is enabled, it is usually pretty aggressive.  If you 
don't honor the roam request you will likely get disconnected.  Don't know if 
this impacts your design.

> 
> This setting would also need to be dynamic (i.e. set during runtime),
> since roaming might be needed during the same session if the use case
> changes (i.e. we no longer need to host an AP).

Sure, that makes sense.  I do think we need the ability to track whether this 
feature is being actively used (i.e. by tracking the D-Bus client that set the 
property) and go back to the default behavior if the client crashes, etc. 
Here's an example of how this was handled in oFono:

https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/modem-api.txt#n42
https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/src/modem.c#n1022

> 
> If we are in the middle of a roam, I would say we can let it finish and
> only after do we start honoring the AllowRoaming setting.

Ok, fair enough.

> 
> Furthermore, you raise a very valid point in regards to checking if we
> should roam once the property goes back to default. I can add this logic
> to the next iteration of the patch if you think it is worth it.
> 

Yes, I think that would be nice.

> It does indeed overlap entirely with the "DisableRoamingScan" setting.
> The only difference is that "AllowRoaming" can be set during runtime
> trough D-Bus. Having a dynamic property is ideal for our use case as
> described above. If you think it is preferable, we can also merge the two.

DisableRoamingScan is something that isn't used very widely.  We don't even have 
auto tests for it for example.  My vote would be to combine the two and put 
DisableRoamingScan on a path to depreciation and eventual removal.

Regards,
-Denis

