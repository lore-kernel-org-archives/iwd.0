Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DD717C228
	for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574327; cv=none; b=fADsT6I/R0io5hf96uNdy6mJOT+DeF6tsBfffwAFI770QXLh73K6YZ/EJ9wtoQPxZI34JZ9OJNRhn1ekE4fizdlaJi6P/vRrNqxaW28EFXLWs0M0Vab0FK3DmBJl7Jht7NPhWvHrchFrmZ33MhxlE41vCoVZXt02NS5+yPFPFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574327; c=relaxed/simple;
	bh=Q+MXG0mknicoXCtQcT4MGaYD0UTGcrkcw3ZmkrAYC6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZSF/ZIgWEBv6NwfohC4MiMXAbsnlVR6O9yk7JgJPaWxyD75yMZWCIGpbm7ZDBU8jsiO+744DFHtf83e7Ggf2UAZRCUGfMMxSw927bWOK+vM1D9aisYhPRwU+K82N0ka00iExC1t2fCxnjHvYjzuz7eAm7vkuZsP9E61I23OXsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l99kZX8u; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l99kZX8u"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-717cf9c6297so305148a34.1
        for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728574325; x=1729179125; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WROWIC1SXPamDUw9aEVvClXEcXmj1c2iVuA0Hz2y1RI=;
        b=l99kZX8uxpmQu3LtJMZpQUVVuEhkNvcuJ45NVyD3bP4I0tRLSnYgjD8XjBYgfjh0XK
         4tU3mLMk/6LABrfU1amKVbPI5InnMPw7fbSKGltiZfuHvLcttvKxaVNa4v/58y/pzuEb
         TAF1eHdiri1sb8ooIhiSKVqjboVJpC/t9gcOOxfODiBlOzvJqDAO/TouIE/AyG5aHqst
         xAC8ClI50WkNGebRIK0orNN6OlbAvT7XnPb+RqT8oDgjMSmHYm71w7BB3ToDGUi1Kd/n
         j/vk4KzPeI2PEjmp44tUlpfjUZIu1j/qVQNLU/a/wt3QOmyduDhONLdRep41A2KmjJGC
         72QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728574325; x=1729179125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WROWIC1SXPamDUw9aEVvClXEcXmj1c2iVuA0Hz2y1RI=;
        b=auFM8aLQx+Z4g5nNPPMJow1PcDvlL8zkEgzmuhcdcXNM+oj0vpLmJ1ejx3Lgb6z0WK
         3j4fUf16a4gfMsLY+kg68qQ0AZ58Yo5Y2IkkChu7WHC+fo8e4I2lVMuevP4q/g56IaWq
         ZT/+4/K5CUD9H8WFuSb0N06izCiqprj0AV4OEZ1tIKPxjh0k/QUYXeZ5WmY5x7nzIzdf
         AEzZJORMwkqAEBy1RbVrF1jf7Ihs4sf2fwbTGpcqzp2vApPERF8TidS8hQsn98v/MZJY
         bbpsQjqQ8fddtDI030KawSQdEX4JuYehoH5cvlss9y00zIqh1cOG5jrgQNUBWtrJPTfV
         J3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVQWXH9QrLQt9ea1WvwktG0GjKWr67dE71ABMgkQMcZKHgBp5852jgatK8WMI6V/VF30s=@lists.linux.dev
X-Gm-Message-State: AOJu0YynauG8M2gQp8jGWkS4PZ5yVzxuahdduSKZvmmfQq54M6MSJjMU
	NKiVZ089mXiPNsaHCaSy7FoNEDaZEFeRoClb2RPTIkAwWvLL1iup
X-Google-Smtp-Source: AGHT+IGBoyD4yVoIuGFrK2LsuC2uERzSo1OM+5wSiPwRpKcUOYPSb3oOyAEn5eF4+n1oOYIVBTLz6Q==
X-Received: by 2002:a05:6830:3153:b0:713:cd40:d036 with SMTP id 46e09a7af769-716a9f85d4amr4557653a34.15.1728574325366;
        Thu, 10 Oct 2024 08:32:05 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-717cff472absm216543a34.44.2024.10.10.08.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 08:32:04 -0700 (PDT)
Message-ID: <37712a7a-4e4b-413e-b458-ccd079edfe13@gmail.com>
Date: Thu, 10 Oct 2024 10:32:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: IWD 2.20 does not support Fast Roaming with NXP 88W9098
 chipset
To: James Prestwood <prestwoj@gmail.com>, Dierk.Modrow@sew-eurodrive.de,
 iwd@lists.linux.dev
References: <5c65040719764a49a48846ea11c535a7@sew-eurodrive.de>
 <c477b2d9-dcc7-4ea7-a6b1-47f6f84e4736@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <c477b2d9-dcc7-4ea7-a6b1-47f6f84e4736@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/10/24 9:23 AM, James Prestwood wrote:
> Hi Dierk,
> 
> On 10/10/24 6:49 AM, Dierk.Modrow@sew-eurodrive.de wrote:
>> Hello James,
>>
>> we tried to implement 802.11r roaming with IWD 2.20 using a NXP 88W9098 
>> chipset from H&D Wireless as client (using out of kernel tree driver of NXP 
>> moal/mlan -> FULLMAC) and failed.
> Are you sure its a fullmac card?

It is.  But they're likely doing something similar to this:
https://lore.kernel.org/all/20240704033001.603419-2-yu-hao.lin@nxp.com/

Perhaps the Marvell / NXP maintainers can be convinced to add support for 
CMD_FRAME path as well.

Regards,
-Denis

