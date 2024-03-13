Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D3823CC
	for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350773; cv=none; b=IbrfpgcYgzi5r2uzBL0cTmZ52iDUNSgPyA27aJfln80KDncy0d6rpN/KIu9p3JAu/+/M7iNFtaXuYQ/d3vppn/GlXjhKoUo7W0B6kqOp/u+bJUZOrHApPfCV4V7gi8lDIwXmrHjAq09HeHK3knnm+E1pmHpYdrjCHDOLivjWtcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350773; c=relaxed/simple;
	bh=pHdBbxIGCsn6bga9ZUWJIdqQzQ/NGDwpmOuAP2belZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibx26gv1Mj/Xtquvv7wHvPBXz5wvd8YFw3V3kOrcyUFWvUaSNViukZ8tVe4T48raWir0bxeJI+57M6veZCmYC5WBpO2canfvevzHGlXwyTkRNg2Uux0DyZ9aPux8ChVDUYdyBYrm0CPLH+DF+TszTr2cXpYBCdJeUHHZ6pf3Yao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSGY+AXi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSGY+AXi"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78850ab4075so4100485a.1
        for <iwd@lists.linux.dev>; Wed, 13 Mar 2024 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710350770; x=1710955570; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xlPdDv6yvSDgUYLn/3ttkYWsR7atQ5kgTqz8H924Zg=;
        b=NSGY+AXiEYzkEty2qEK/QLKn4WYRbFi0AtKj+A/9pyOL8Lju6i70CoLZymzX9o1KDr
         fn/vL2S0jGa8L2LCjlgDXOaYfVLeqcoNWu6ysRe/WjSVA9711pwP5BzTDAwL5FHAO0ok
         6DOFx0e8VoLtMegKAInLRtWkfVrB/Xu0unB6eLBEdavyWku7OnPFKmINd3ShlKCANbQe
         ZAKRlb86fG6yVmjNnnCk+ZugO793ecQKqxFHVm2kWnox7+RjTlGJH0wKDdwY/NTa7jY2
         vOetD1Hk5RRy65b1MXsbDmEk38bz/NxPQcXImzqLq3o9T7vSHmcuUMsiUVhXpe9LWceV
         jZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710350770; x=1710955570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xlPdDv6yvSDgUYLn/3ttkYWsR7atQ5kgTqz8H924Zg=;
        b=EvckD0mZf3GPxG36v++gTBo+vjJ1PqiHP9PwbuWSXIDL1KI0dq0yRP8hH7TDj0CSCk
         08+bc6VBpgIAUg5qPSFXM7Mm21/TZU875njDLc9Myo2GqEl4eywpe3tvJ3cBTS87FGfp
         +GZro5tYOLVhtk1+TPgFPjhP5wM/kn9aUtdhPz3vz05nGEET0Y4dCvm709yLyP0NGQZN
         DJNObRvEfE4UXGgMB0CEzOL0ve6r+V8yxN1HssZI7iySPWrHPL+b/zzoqY/Y5P71IM+f
         WA0EFZPTnP9NXlRieJvLZ1/vwUd+xNS8xY0Lmr/MOqk5YAvOOgGC158kMrpkqd+29CFj
         Vpvg==
X-Forwarded-Encrypted: i=1; AJvYcCWgaXqbeNhcY0T1APidI+R4sqTK6Hk77XKQ1zj2RnN/vGDDq8LIu3fZ7wP/HqXobEm/ETv96J8D3ABcT0dA0H4MIF29
X-Gm-Message-State: AOJu0YzLsix7l55hvFK3Z8iQ1C+JnwEYDpKAEYy7e/Bo/quIMYg3pYIO
	msoKGBWWxCDAxfR4wRFF0+uu64kywHVUNdl2e6RejW8y8ZUVAXxl
X-Google-Smtp-Source: AGHT+IFyyiGiWin6XQHjnKeLqB0dBkLVo4kmfRKf8luDrrfr/cY3NN2DX7JZ46wiVXxtXIKQSkqJLg==
X-Received: by 2002:a05:620a:178e:b0:787:a83a:cfed with SMTP id ay14-20020a05620a178e00b00787a83acfedmr607731qkb.70.1710350770507;
        Wed, 13 Mar 2024 10:26:10 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id yf23-20020a05620a3bd700b007884b14b0b4sm4888800qkn.51.2024.03.13.10.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 10:26:10 -0700 (PDT)
Message-ID: <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>
Date: Wed, 13 Mar 2024 10:26:06 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
To: Johannes Berg <johannes@sipsolutions.net>, Karel Balej
 <balejk@matfyz.cz>, dimitri.ledkov@canonical.com
Cc: alexandre.torgue@foss.st.com, davem@davemloft.net, dhowells@redhat.com,
 herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcgrof@kernel.org,
 mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, iwd@lists.linux.dev
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
 <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/13/24 1:56 AM, Johannes Berg wrote:
> Not sure why you're CC'ing the world, but I guess adding a few more
> doesn't hurt ...
>
> On Wed, 2024-03-13 at 09:50 +0100, Karel Balej wrote:
>>   and I use iwd
> This is your problem, the wireless stack in the kernel doesn't use any
> kernel crypto code for 802.1X.

Yes, the wireless stack has zero bearing on the issue. I think that's 
what you meant by "problem".

IWD has used the kernel crypto API forever which was abruptly broken, 
that is the problem.

The original commit says it was to remove support for sha1 signed kernel 
modules, but it did more than that and broke the keyctl API.

>
> I suppose iwd wants to use the kernel infrastructure but has no
> fallbacks to other implementations.
> johannes
>
