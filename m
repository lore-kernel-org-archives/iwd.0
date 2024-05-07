Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F27E59F
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121089; cv=none; b=R/1UbOkdKNbnicFrLv3cTxepmztPCLL/MBL+e+sIbvEE1IlcyHlyWbIkQI0CjuU54dgOcM8nX+E+z/2lUs88SOmVIDVOgHcAtHjby79jeaVUAEx7g2vKx5ApxN0FVAK/xFTpUCd2Fw6im4duaeVA1e/8I2S9Abf81Hx3UZObn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121089; c=relaxed/simple;
	bh=738WxrGEc7mfavHoqaz4w5th737u+22re2tGI+O921A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDTqT68efbqdG08AdTqPsJySGhqDZrHwprdCc/etqQ2jE0KhP13VN9LNu4bsw6ErE5JoiY7FiMhWHhMMFt/nIeFte70Awl7WqxRB3tmts8DpxaX+3EE/XQyc0JWiA03ykutADF0xfnc4QEdsmODLUWJXsafLz4XEEoqi7rZk4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvEtqiUp; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvEtqiUp"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f0bb6dd3bfso123382a34.1
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715121086; x=1715725886; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JFi958w9pdJHdzoCYo7eLjq4dOiF5Fe/RaBuTCio6A=;
        b=EvEtqiUpGGgrWf2lGsr/QJB2IfcYJ54tYNx3onzIR1Rm86AfPJENKVPytOGg5iPUfB
         hwQPUocKLwZnCCJzWMDwY+Syx59uPupG4oG9FNX5twCuDABqPtQXlQrV9+eEiV7mUmTx
         /3os4e77RGKAGI3RrieJK7ugaB9PKGH+wh1+iWpzxhtihncoS/PWipZC6ITnlg46B8Ph
         ve3alzD0DPxLQuG71+6x4Bab5RZhaJdU6FfjANmbsHSkhnmip1qCeTNlufvtkdSqTLDD
         9fYK8NvWlNcPR/80NF7HWcq2HAn56+W812Uy8KYM7Advxz3WbFQm8jflQmlMUhZkL6+H
         P5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715121086; x=1715725886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JFi958w9pdJHdzoCYo7eLjq4dOiF5Fe/RaBuTCio6A=;
        b=tw5BIvrBRZ3Y0oc/+83ekOP/Z4BqZpikUMmlFfle385dUjxd+YQKNhx7j78SFvTH9o
         3I0/D/+0Vhrsin+YlbwLD5TObdYDqNUv3pMWJMShgaIucuEP5uJI+t6jmugvrBY++YPy
         f+aRmJG0WlilNwF15k0X1JQyCEHyXg2WZJzy8XarbGlUpyDmCzmWjKDcZvHC/WjggoUP
         svtDn0kTw/SqiR7BO4NvVE0r1FhAa5UivEdgYta03VrvwDq415vp2JZai4Ao9S8ft7KA
         HnPrxxY2aU7j5i6yJS7ReP8amy1kVGzq5o+xSj+tK3dKwC9pzsKB5j/QD2j0lYf0kmf5
         Te0g==
X-Forwarded-Encrypted: i=1; AJvYcCWgbdkXc+ZlibAan/ecLWJn1pg1nzu9CT1xNaJ/6uWzHAFzl+EQ96KpnxCbK5iUf2GN5oVOYu6gTwBOTw5G2rsKsvTm
X-Gm-Message-State: AOJu0Yzoyl716K0KSey5/S36qJGObPeggK4RVrlYNns3/2mGKi4wjqr+
	Sd13U5PukOsz9mnA227joAS0BIizzYsR6rJ6BQcF0h8+QD7QK+TD6U1Q+g==
X-Google-Smtp-Source: AGHT+IEaD6aDoCooE5+T7gehBqX/BoZUzbJeVlbV43i2nwscnU+FlHu4ZqgoDfin9OYwZMDtSHAC2w==
X-Received: by 2002:a9d:5d0d:0:b0:6f0:6bde:228a with SMTP id 46e09a7af769-6f0b7eacbc2mr836909a34.34.1715121085930;
        Tue, 07 May 2024 15:31:25 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x11-20020a056830278b00b006ebdbdd477csm2663218otu.11.2024.05.07.15.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 15:31:25 -0700 (PDT)
Message-ID: <bf11b479-5667-41ea-acc1-6ffed72e4440@gmail.com>
Date: Tue, 7 May 2024 17:31:23 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NetworkManager connection gets stuck in pending state when
 bringing up AP mode connection with IWD backend
To: James Hilliard <james.hilliard1@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev,
 Andrew Zaborowski <balrogg@googlemail.com>
References: <CADvTj4qmJm_Lyk5bR_WZE8TioVa5f0MHdtDghJdRX=9ZhivzjA@mail.gmail.com>
 <7fd93025-1bb2-46a9-aefc-3e74942164b9@gmail.com>
 <CADvTj4pHyYewHzSUF+546JPO6Y0Co+QfFcBbJEctNWQBNJmb=A@mail.gmail.com>
 <73d7295e-44e1-42ff-9d45-9effa65a0698@gmail.com>
 <CADvTj4oH4PjcD=0QXYT6BTEpQhtONr6QsT1mp+nmcG4Uc10c+g@mail.gmail.com>
 <3e5c8d35-b08c-4906-ae06-7a5d511d518a@gmail.com>
 <CADvTj4qvEniwLnox8dZeqsDRbrBZfiqbKoCPxgRRNVu8sDBWBA@mail.gmail.com>
 <82696cf2-9bad-4cc6-a302-f3797efc6d1e@gmail.com>
 <CADvTj4rOr3p80nTg3ACqQMzse6HFWfijFQYwKj+eonyCLz_V2Q@mail.gmail.com>
 <8b2156c0-7b98-4bc8-ab1a-5009389e5e83@gmail.com>
 <CADvTj4pYPBbvEDBoTnEZacE-Ah7S7wgCBYkJoonUMfac1o64ag@mail.gmail.com>
 <d1e641d8-5a7b-45f3-9505-164a92997b7b@gmail.com>
 <CADvTj4pZ4JV8Ji2YrnRFs2fxar2wF-xRdhLTFLndKd0i8D1x1Q@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CADvTj4pZ4JV8Ji2YrnRFs2fxar2wF-xRdhLTFLndKd0i8D1x1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 5/7/24 5:12 PM, James Hilliard wrote:
> On Tue, May 7, 2024 at 3:40 PM Denis Kenzior <denkenz@gmail.com> wrote:
>>
>> Hi James,
>>
>>>>
>>>> Should only be using the Start(ssid, psk) method. Its really that simple
>>>> so I don't see how it could really get anything wrong as far as being
>>>> notified. But again, I'm not too familiar with NM.
>>>
>>> Looking into this that doesn't appear to be entirely accurate, that method
>>> seems to be working fine but is not the only API NM uses to interface with
>>> IWD.
>>>
>>> It looks like NM is also using this for interface configuration:
>>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/agent-api.txt
>>
>> That is only relevant for Station interfaces (i.e. client mode) if you're
>> running iwd with EnableNetworkConfiguration=true.  The Access Point mode is not
>> setup to report network configuration details via this infrastructure.
> 
> The docs indicate that RegisterNetworkConfigurationAgent is relevant for:
> station-mode, AP-mode or P2P connection

Indeed.  But note that NetworkConfigurationAgent API is marked experimental and 
there's no infrastructure that would enable AP to invoke this agent at the 
moment.  It is only integrated with l_netconfig which is used for client side only.

It may be the intent was to add this functionality eventually, but it isn't 
there now.  I'm surprised NM tries to use it for AP mode actually.  Maybe Andrew 
(who wrote much of the code on both iwd and NM sides) would know.

> 
> If AP mode doesn't support this interface then how should the network
> configuration details be reported to NM when running in AP mode?

Well, I see two options:
   - If NM expects IP details from iwd even in AP mode, then teach iwd to do this
   - Make NM only use NetworkConfigurationAgent in station mode

Regards,
-Denis
