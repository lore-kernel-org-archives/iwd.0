Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565A812E58
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z14hDT+q"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-66d03491a1eso5248306d6.2
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697816993; x=1698421793; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8kmL/el7n8JuZYvIqwqAnKtyEiCQyZGmx+4nO5+t5Jw=;
        b=Z14hDT+qblcwOQ0mzyrzERFoK4DLCjDsW1Wcb3mARdgyOCdXhV0OVN+wOEz86YEWUW
         xl6PM7nT7S6T2GEIeUpnIho/QWeHQQURCFlHqWVOMy6c7BpRnShOactVBnDvzaIqjgl3
         odUub+yI0eLdWq0tAHmb1a1FS0lq8Y/tdoYnbvaEncvUDAXE1y6PM0fLe0CcM1qddH9X
         Q4TEcAx8VKXSM6lrA89ex9SRCiZmu97dXUjzyL2ggUbO2mtmQye/g0KrxMSpuIZGOFOI
         4+E5KJ0AqAd1Ufh/SAjCVIaqWt8rThEAYwO6tB2x9zNxwOkaDAE9m5iI6NuUypR82Zqh
         8BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816993; x=1698421793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kmL/el7n8JuZYvIqwqAnKtyEiCQyZGmx+4nO5+t5Jw=;
        b=Kad8+h37HMlGU0Jb3cqR3kEOd90R82zaHtR7mlic1v5BTTttAeVb7oPbqNkazWCmsY
         KWoo4WmYSsLOxxD2bIAZhcGaiyu2ScBplkK8B9CvSH8OGqix0TkqCK+ktHNxoWpO2ZME
         OfOwK04mz5/xFo4/Rbg19LtTi156NrBCTNKhkqbi+CQph3iYFtbvcpwk/3kS9CswWsMC
         dXWyR/bMKyJV3VFxKh+H8L51xiRshkgFN/0uodpn5/D3AvFH4uvcOWk0x/3s1Xe8+kye
         Of4Piz+hjOpSc8Y8lF6gwyy5X/JofYsv+Mpc1bN+WrO8iME692TEWw12epC0afqf3yzj
         5oXg==
X-Gm-Message-State: AOJu0Yw0BSs8mluMP30oI4QweJgq5AKSlh5UAeg0bHzWJHD2QaJ4GpCF
	AbzYQPWtokHZ/oP70mghpXXVimh5f6c=
X-Google-Smtp-Source: AGHT+IGvVYfVA4/cjPlTtwBbJAtSDumhojVX9H6SK7SgT4Tblx3QBGn68cupD0gpucZX+N0XH/kClg==
X-Received: by 2002:a05:6214:20e6:b0:66d:1624:2200 with SMTP id 6-20020a05621420e600b0066d16242200mr2025592qvk.13.1697816993030;
        Fri, 20 Oct 2023 08:49:53 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id el14-20020ad459ce000000b0065cffe12ae9sm775883qvb.36.2023.10.20.08.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:49:52 -0700 (PDT)
Message-ID: <569b7682-e334-4f71-85a6-e49fc8934952@gmail.com>
Date: Fri, 20 Oct 2023 08:49:50 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: install iwd-decrypt-profile
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
References: <20231003192456.4038590-1-prestwoj@gmail.com>
 <F6D1FD48-E7AC-404B-936A-E4D5E3519FA2@holtmann.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <F6D1FD48-E7AC-404B-936A-E4D5E3519FA2@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 10/4/23 6:07 AM, Marcel Holtmann wrote:
> Hi James,
> 
>> If profile encryption is enabled its not out of the question that
>> somebody might need to decrypt it. This isn't a problem building
>> from source but IWD as a package likely won't include the decrypt
>> tool unless its specifically copied out. Add iwd-decrypt-profile
>> to the list of installed programs like iwctl, iwmon, etc
>>
>> This also fixes a minor bug in Makefile.am which was building both
>> iwd-profile-decrypt and probe-req if DAEMON was true. This should
>> be TOOLS.
>> ---
>> Makefile.am | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 2e962153..ebabcf1c 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -378,8 +378,9 @@ man_MANS += wired/ead.8
>> endif
>> endif
>>
>> -if DAEMON
>> -noinst_PROGRAMS += tools/probe-req tools/iwd-decrypt-profile
>> +if TOOLS
>> +noinst_PROGRAMS += tools/probe-req
>> +bin_PROGRAMS += tools/iwd-decrypt-profile
>>
>> tools_probe_req_SOURCES = tools/probe-req.c src/mpdu.h src/mpdu.c \
>> src/ie.h src/ie.c \
> 
> I really prefer not installing that tool. If someone shoots themselves in the foot and need to recover, they can install it from the source. In addition, I do not want distributions cluster packages with random tools. That is going to get messy. If we ever think such a recover is needed, then it be better suited to be included in iwctl.
> 
> I moved both tools in DAEMON since once you disable iwd binary, none of them should be build either.

This is fine, but it means --enable-tools has no function, just FYI.

If adding to iwctl is acceptable then I can go that route. This is a 
tool we need as far as debugging and potential recovery goes so I'd like 
it to be installed. I could also just keep this patch applied but I'd 
prefer upstreaming what I can.

I just wonder about the semantics using iwctl in this way. It doesn't 
seem like it would fit very well.

Thanks,
James

> 
> Regards
> 
> Marcel
> 
