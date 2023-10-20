Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0461EA91
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5CVjM+9"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-66d122f6294so6488976d6.0
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697819374; x=1698424174; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOAlfVNuuU4JekMHxzrgp1RcyYH1vjtb8+m93aWwj4w=;
        b=U5CVjM+97E9STJli0FWOgBVZmlBLJqHnaRQ10EYYL0n5XhKxkrHnqaWp8yjf1NyS6q
         NlybFzyUC+C7CHFp6KJaW/H03oOGFHx9S5qtvMN/Z1fj9E492S8idIBFdnj2BZegUGOJ
         6BT1gD6/7SLC9v4NkoORxdNj8cPL92w5wbDKS6rBAm3V+zVAjo/VD58VlelV0FH0Ty0P
         loiIFklcQIv1zgM5nK020KM79Yp4Y+qXmVxtdcqkrmigUWP89w0w1OUVI59TNqxbduyR
         uIgbNLNBUiyqKiF0+RL9IEfxbKXJvE2oBLkVWHl6uFJhJ3qIyVlPKdLZi1PNWBVoF9H1
         ZTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819374; x=1698424174;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOAlfVNuuU4JekMHxzrgp1RcyYH1vjtb8+m93aWwj4w=;
        b=RMbaV7uABOqbvWQX9Eq/Ci259ap3bUWdGkjX58/ScaASwA7UrfTLOkiRQNtEZHIbXZ
         fj/zo0dH50B4ysw1Z2FdLy1CSPsbeMByEW+VbWDuhzISlFr6pCTeLdBkwGrfGm6PY7Ug
         A3Ek+KXYWA96d2AEVg8Rdiowh8AMxQwzCZb37sntwwT+s5FPYBeZ2zjoTjmg7mO3GTN8
         YQpkP9j9J1HX2qKpj0nh6+5ek6q07QQd8SalrdeXr7m8mLKyoQdXBcsM539Yt8+TNnNo
         AA933qGzQMmLB0D+10phaRbvxteMuiofJybyrMhxnzvHhoV08CfxhZDa450nYy+9UIq+
         8vnA==
X-Gm-Message-State: AOJu0YwKtJtfHhz01iI+TSjXo/AXQQqDe+OsFRBRbWQ8EkcXxT5G861c
	c/TWouF07XQOERN0lPuZHw8=
X-Google-Smtp-Source: AGHT+IGHJ4zHfr5qD5NSvT1sOfna7XiPHSpk/wV+z1VQ0i/WcvVCeMYEgdnLl6ul9Waq1Sj2emaZvA==
X-Received: by 2002:a05:6214:d81:b0:66d:18ec:8e6f with SMTP id e1-20020a0562140d8100b0066d18ec8e6fmr2606169qve.39.1697819374060;
        Fri, 20 Oct 2023 09:29:34 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id oi1-20020a05621443c100b0066d0d3daa58sm795380qvb.24.2023.10.20.09.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 09:29:33 -0700 (PDT)
Message-ID: <582d06b7-1bc7-4e4b-a0e3-c068cd22a975@gmail.com>
Date: Fri, 20 Oct 2023 09:29:31 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add AllowRoaming station property
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, =?UTF-8?Q?Pedro_Andr=C3=A9?=
 <PEDA@bang-olufsen.dk>, "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20231018122534.33455-1-peda@bang-olufsen.dk>
 <cd9a73d3-8ed9-4c76-b44c-4c8af6250977@gmail.com>
 <b995959a-29a8-45cc-a785-065475a1d636@bang-olufsen.dk>
 <df0dd5a8-5171-497e-a764-5cfd32ed821e@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <df0dd5a8-5171-497e-a764-5cfd32ed821e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 10/20/23 7:57 AM, Denis Kenzior wrote:
> Hi Pedro,
> 
> On 10/19/23 06:55, Pedro André wrote:
>> Hi Denis,
>>
>> First of all, thank you for your feedback.
>>
> 
> No worries, I'm a bit swamped these days so my responses are sometimes 
> delayed. Just FYI.
> 
>>
>> There is a use case where a device can be connected to an infrastructure
>> AP and hosting its own AP. In this specific case it would be ideal to
>> disable roaming since swapping the infrastructure AP can lead to
>> instability on devices connected to the AP being hosted. In this case,
>> the device should act as if it is not able to roam, so I was under the
>> impression it would be OK to not honor AP directed roaming.
> 
> So AP directed roaming is a bit of a unicorn.  I haven't really seen it 
> used in practice.  However, when it is enabled, it is usually pretty 
> aggressive.  If you don't honor the roam request you will likely get 
> disconnected.  Don't know if this impacts your design.

Just my two cents. I do see it used in our deployments, but the APs 
never seem to set the "disassociation imminent" bits so IWD will still 
decide if it should roam or not.

Btw hostapd has 3 separate CLI commands for transition management: 
DISASSOC_IMMINENT, ESS_DISASSOC, and BSS_TM_REQ.

The BSS_TM_REQ won't set the imminent bits unless additional options are 
passed so it wouldn't surprise me if nearly all APs leave those bits 
unset :)

I think its very unclear what the intent is of the AP sending the 
transition request. It likely sends identical frames regardless of the 
circumstances whether its "I am a bit overloaded, please leave" or "I'm 
shutting down leave immediately".

Thanks,
James


