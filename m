Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05651188CAD
	for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574829; cv=none; b=Up2a+WHW8E/Z1/PKoBoc8qSoIw7LEW1ay4As4OxZPPNxuEISGEhgwvpNHHJv+l9C4flXPIqK5OFrMwWg0WmWz+GqxZVcUjBTumVfyhcg0+c/xKpe7yLk7zRzGq/VrQTNBbBYFe+sGxu8/LIREIhC5Q5/OmikG4XQVxm2Jl4Mws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574829; c=relaxed/simple;
	bh=FTrXISFVYgAJu6K/pPtpXe7PX4/hKLOG08KSAqHyXyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EDTRzN3GDOk6sJXT+y6UkjEZoW+roRIyGYxQSk8upYCD6lluKDI4pQnHeVqaJjNC79e7j4E+Zq9jwKAIMFJAwEjm5K6IZ5s52nBo/FYNbIQGHWyCrd22/Gzyh0UQWsaFDhzJt4Q5B5RAiKWIanS1KWT2dAHnXiEF5Viutaq59wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRIMhsnc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRIMhsnc"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7afe994d519so89734285a.0
        for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728574827; x=1729179627; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LlZWXEMnEf+tslJvrnVW76DwqH9kMrTjpe4vLK8ax1c=;
        b=SRIMhsnczqPm2xapnwBaz+nBDZJeibo5tEpxfR9os9/cStHWtGosQIbs59S4YF/Rep
         9QtuUJ4DAi1QxfoGHXZjrQw513pIios0Q55ubaADToKYPSTTg1F196Ucd5kJ7lqI9t6u
         yix7dIfu0LRhaZY0/sm3v6vE/2fTfoAXFVxKmAs4GgniuTvZN/C+yFdPpzoaqNWbWW4s
         +cEtRU6JFuIWoHM6Cy1H8Z1f6dQHUkTMBHmqSjQueZVLDMFXLhL70VkmuWecTRB9kve0
         eE6pfpHmgdd2uHXNDaFkpIPKC84F+R1HMa0rKbrFnMJayEq+9WKOUhZUrJYSYk29VgyB
         2Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728574827; x=1729179627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlZWXEMnEf+tslJvrnVW76DwqH9kMrTjpe4vLK8ax1c=;
        b=RE0SO6tylbA3W+uh+yde5k4YaUy42Y0KP29RFrVRM/ejuqkhduEkhphcNT3x4u/G4m
         M0cY1frpfXxO7Vjj0yqgqC2IK+17Bd5fpBB4qiZxBtcpzFn5WYe4d5l+vNc8lFxdaUYk
         0XNU5vkkmJcBtrQVHMhNQhBNXs7mhPOQJE51N7pJeHdWP/3HqCZInO9q6z6OensB68Xz
         HFVJFHqvAYJzEJj8K1aNGXxNpiKs5i+kDB57+S1sOlhkwHdAFKp1H+tUTpiEsgeQ01AX
         FdHB4Q6so0cwAWiKsXthRbXYjU0P+09oD1T3JuyfDwpBcCnTy8tlqX+J0NR+6k6ptVg8
         XD+g==
X-Forwarded-Encrypted: i=1; AJvYcCWrKm8ExOoX0YuwGWiJrwQnxc9V0Aeq2b6dDYheYFzsZEHdFu+GGgu4bq/a3mbGLEb8a8k=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8oSU51T2ve7QRlMi2XlYNWQg5S/BAjBuVq79k4FTh2UblpLis
	jUCHvIb7b0qYDexh+08vSNCprGEFEROV0em1HhengYAOhvAkpOY0
X-Google-Smtp-Source: AGHT+IEV05rAJMGS975F1ZfyNir2jpHDfQ8NivWstzphbfyM+RkOD+Az9p+tc3APcLpM8jPljanrKQ==
X-Received: by 2002:a05:620a:40c5:b0:7a9:acd5:1b21 with SMTP id af79cd13be357-7b0795475edmr1090956785a.50.1728574826815;
        Thu, 10 Oct 2024 08:40:26 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148c7102sm56141485a.24.2024.10.10.08.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 08:40:26 -0700 (PDT)
Message-ID: <45d6f549-a28a-4779-bd87-62610c14251a@gmail.com>
Date: Thu, 10 Oct 2024 08:40:24 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: IWD 2.20 does not support Fast Roaming with NXP 88W9098
 chipset
To: Denis Kenzior <denkenz@gmail.com>, Dierk.Modrow@sew-eurodrive.de,
 iwd@lists.linux.dev
References: <5c65040719764a49a48846ea11c535a7@sew-eurodrive.de>
 <c477b2d9-dcc7-4ea7-a6b1-47f6f84e4736@gmail.com>
 <37712a7a-4e4b-413e-b458-ccd079edfe13@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <37712a7a-4e4b-413e-b458-ccd079edfe13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/24 8:32 AM, Denis Kenzior wrote:
> Hi James,
>
> On 10/10/24 9:23 AM, James Prestwood wrote:
>> Hi Dierk,
>>
>> On 10/10/24 6:49 AM, Dierk.Modrow@sew-eurodrive.de wrote:
>>> Hello James,
>>>
>>> we tried to implement 802.11r roaming with IWD 2.20 using a NXP 
>>> 88W9098 chipset from H&D Wireless as client (using out of kernel 
>>> tree driver of NXP moal/mlan -> FULLMAC) and failed.
>> Are you sure its a fullmac card?
>
> It is.  But they're likely doing something similar to this:
> https://lore.kernel.org/all/20240704033001.603419-2-yu-hao.lin@nxp.com/
Ugh, they just can't fully commit to being a "normal" driver, can they.
>
> Perhaps the Marvell / NXP maintainers can be convinced to add support 
> for CMD_FRAME path as well.
>
> Regards,
> -Denis
>
